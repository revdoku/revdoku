#!/usr/bin/env python3
"""Build quick-publish example ZIPs and preview images.

Editable source sites live in sources/<example>/.
Built assets are copied into the Rails app image. Public R2 is an optional
delivery override, not the canonical source location.

Requires macOS `sips` and `cwebp` when --image-dir is used.
"""

from __future__ import annotations

import argparse
import filecmp
import json
import os
import re
import shutil
import subprocess
import zipfile
from html.parser import HTMLParser
from pathlib import Path
from urllib.parse import unquote, urlsplit


ROOT = Path(__file__).resolve().parent
REPO_ROOT = next((path for path in (ROOT, *ROOT.parents) if (path / ".git").exists()), ROOT)
SOURCE_ROOT = ROOT / "sources"
PREVIEW_ROOT = ROOT / "previews"
APP_ASSET_ROOT = (
    REPO_ROOT / "apps/web/app/assets/quick_publish_examples"
    if (REPO_ROOT / "apps/web").is_dir()
    else None
)
METADATA_FILE = ROOT / "metadata.json"
SIPS = "/usr/bin/sips"
CWEBP = shutil.which("cwebp")
ZIP_TIMESTAMP = (2020, 1, 1, 0, 0, 0)
CHROME_CANDIDATES = [
    Path(os.environ["CHROME_PATH"]) if os.environ.get("CHROME_PATH") else None,
    Path("/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"),
    Path("/Applications/Chromium.app/Contents/MacOS/Chromium"),
    Path("/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge"),
]

EXAMPLES = [
    "client-proposal",
    "client-portal",
    "prototype-review",
    "investor-deal-room",
    "report-dashboard",
    "marketing-performance-report",
    "portfolio",
    "launch-page",
    "pitch-deck",
    "ai-shared-workspace",
    "event-page",
    "product-catalogue",
    "property-listing",
    "press-kit",
    "resume-profile",
    "digital-library",
    "course-resource-hub",
    "restaurant-menu",
    "job-opening",
    "product-documentation",
]

IMAGE_FILES = {
    "landing": "landing-app-hero.png",
    "resume": "resume-headshot.png",
    "coming": "coming-soon-product-launch.png",
    "portfolio_mobile": "portfolio-mobile-app.png",
    "portfolio_brand": "portfolio-brand-system.png",
    "portfolio_studio": "portfolio-creative-studio.png",
    "portfolio_web": "portfolio-responsive-web.png",
}

ASSET_REFRESH = {
    "portfolio": {
        "assets/portfolio-creative-studio.jpg": ("portfolio_studio", 1100),
        "assets/portfolio-mobile-app.jpg": ("portfolio_mobile", 1000),
        "assets/portfolio-brand-system.jpg": ("portfolio_brand", 1000),
        "assets/portfolio-responsive-web.jpg": ("portfolio_web", 1000),
    },
    "launch-page": {"assets/saas-dashboard.jpg": ("landing", 1200)},
    "prototype-review": {"assets/mobile-prototype.jpg": ("portfolio_mobile", 1200)},
    "client-proposal": {"assets/proposal-cover.jpg": ("portfolio_web", 1200)},
}

PREVIEW_SOURCES = {
    "portfolio": "portfolio_studio",
    "launch-page": "landing",
    "prototype-review": "portfolio_mobile",
    "client-proposal": "portfolio_web",
    "ai-shared-workspace": "coming",
}

PDF_SOURCES = {
    "client-proposal": {"_source/proposal.html": "proposal.pdf"},
}


def example_source(example: str) -> Path:
    return SOURCE_ROOT / example


def run(args: list[str]) -> None:
    completed = subprocess.run(args, text=True, capture_output=True)
    if completed.returncode != 0:
        detail = completed.stderr.strip() or completed.stdout.strip() or "command failed"
        raise SystemExit(f"{Path(args[0]).name}: {detail}")


def resize_jpeg(src: Path, dst: Path, width: int = 1200, quality: int = 74) -> None:
    dst.parent.mkdir(parents=True, exist_ok=True)
    run([SIPS, "-s", "format", "jpeg", "-s", "formatOptions", str(quality), "--resampleWidth", str(width), str(src), "--out", str(dst)])


def resize_webp(src: Path, dst: Path, width: int = 480, quality: int = 76) -> None:
    if not CWEBP:
        raise SystemExit("Could not find cwebp. Install WebP tools before refreshing previews.")
    dst.parent.mkdir(parents=True, exist_ok=True)
    run([CWEBP, "-quiet", "-q", str(quality), "-resize", str(width), "0", "-metadata", "none", str(src), "-o", str(dst)])


def zip_dir(source: Path, target: Path) -> None:
    if target.exists():
        target.unlink()
    with zipfile.ZipFile(target, "w", compression=zipfile.ZIP_DEFLATED, compresslevel=9) as archive:
        for file in sorted(source.rglob("*")):
            relative = file.relative_to(source)
            if file.is_file() and should_package(relative):
                # Git does not preserve source mtimes. A fixed ZIP timestamp and
                # mode keep rebuilds byte-for-byte stable across checkouts.
                info = zipfile.ZipInfo(relative.as_posix(), date_time=ZIP_TIMESTAMP)
                info.create_system = 3
                info.external_attr = 0o100644 << 16
                info.compress_type = zipfile.ZIP_DEFLATED
                archive.writestr(info, file.read_bytes(), compress_type=zipfile.ZIP_DEFLATED, compresslevel=9)


def should_package(relative: Path) -> bool:
    return not any(part.startswith(".") or part == "_source" or part == "__pycache__" for part in relative.parts)


class ReferenceParser(HTMLParser):
    REFERENCE_ATTRIBUTES = {"src", "href", "poster"}

    def __init__(self) -> None:
        super().__init__(convert_charrefs=True)
        self.references: list[str] = []

    def handle_starttag(self, _tag: str, attrs: list[tuple[str, str | None]]) -> None:
        self._collect(attrs)

    def handle_startendtag(self, _tag: str, attrs: list[tuple[str, str | None]]) -> None:
        self._collect(attrs)

    def _collect(self, attrs: list[tuple[str, str | None]]) -> None:
        for name, value in attrs:
            if not value:
                continue
            if name in self.REFERENCE_ATTRIBUTES:
                self.references.append(value)
            elif name == "srcset":
                self.references.extend(part.strip().split()[0] for part in value.split(",") if part.strip())


CSS_URL_PATTERN = re.compile(r"url\(\s*(['\"]?)([^)'\"]+)\1\s*\)", re.IGNORECASE)
FORBIDDEN_PUBLISHED_HTML = {
    "mailto:": "contact actions must use the Revdoku floating form",
    "{{revdoku_form": "examples must use the floating form instead of an inline marker",
    "use this example": "examples must read as finished sites, not author instructions",
    "starter /": "examples must not expose internal starter metadata",
    "built for quick publishing": "examples must not describe the publishing template",
    "static prototype": "examples must present the product instead of template status",
}


def local_reference_target(source_root: Path, html_path: Path, reference: str) -> Path | None:
    value = reference.strip()
    if not value or value.startswith(("#", "//")):
        return None
    parsed = urlsplit(value)
    if parsed.scheme or parsed.netloc or not parsed.path:
        return None
    path = unquote(parsed.path)
    if path.startswith("/_revdoku/"):
        return None
    target = (source_root / path.lstrip("/")) if path.startswith("/") else (html_path.parent / path)
    target = target.resolve()
    root = source_root.resolve()
    if target != root and root not in target.parents:
        raise ValueError(f"reference escapes example source: {reference}")
    return target


def validate_html_references(source_root: Path, html_path: Path) -> list[str]:
    text = html_path.read_text(encoding="utf-8")
    parser = ReferenceParser()
    parser.feed(text)
    references = parser.references + [match.group(2) for match in CSS_URL_PATTERN.finditer(text)]
    errors = []
    for reference in references:
        try:
            target = local_reference_target(source_root, html_path, reference)
        except ValueError as error:
            errors.append(f"{html_path}: {error}")
            continue
        if target is not None and not (target.is_file() or (target.is_dir() and (target / "index.html").is_file())):
            errors.append(f"{html_path}: missing local reference {reference}")
    if should_package(html_path.relative_to(source_root)):
        lowered = text.lower()
        for needle, reason in FORBIDDEN_PUBLISHED_HTML.items():
            if needle in lowered:
                errors.append(f"{html_path}: {reason}")
        if re.search(r"<form\b", lowered):
            errors.append(f"{html_path}: embedded forms must use the Revdoku floating form")
        if source_root.name == "prototype-review" and re.search(r"<script\b", lowered):
            errors.append(f"{html_path}: the mobile prototype must use linked static screens without JavaScript")
    return errors


def validate_package(source: Path, target: Path) -> None:
    expected = sorted(
        file.relative_to(source).as_posix()
        for file in source.rglob("*")
        if file.is_file() and should_package(file.relative_to(source))
    )
    with zipfile.ZipFile(target) as archive:
        actual = sorted(archive.namelist())
        if actual != expected:
            raise SystemExit(f"Package contents differ from source: {target}")
        bad = archive.testzip()
        if bad:
            raise SystemExit(f"Corrupt ZIP member {bad}: {target}")


def chrome_path() -> Path:
    for candidate in CHROME_CANDIDATES:
        if candidate and candidate.is_file():
            return candidate
    raise SystemExit("Could not find Chrome. Set CHROME_PATH or skip --render-pdfs.")


def render_pdfs() -> None:
    chrome = chrome_path()
    for example, sources in PDF_SOURCES.items():
        for source, target in sources.items():
            html = example_source(example) / source
            pdf = example_source(example) / target
            if not html.is_file():
                raise SystemExit(f"Missing PDF source: {html}")
            pdf.parent.mkdir(parents=True, exist_ok=True)
            run([
                str(chrome),
                "--headless=new",
                "--disable-gpu",
                "--no-pdf-header-footer",
                f"--print-to-pdf={pdf}",
                html.resolve().as_uri(),
            ])


def render_previews() -> None:
    chrome = chrome_path()
    PREVIEW_ROOT.mkdir(exist_ok=True)
    render_root = ROOT / ".preview-renders"
    render_root.mkdir(exist_ok=True)
    try:
        for example in EXAMPLES:
            source = SOURCE_ROOT / example
            entrypoint = source / ("README.md" if example == "ai-shared-workspace" else "index.html")
            screenshot = render_root / f"{example}.png"
            if entrypoint.suffix == ".html":
                run([
                    str(chrome),
                    "--headless=new",
                    "--disable-gpu",
                    "--hide-scrollbars",
                    "--window-size=1440,900",
                    f"--screenshot={screenshot}",
                    entrypoint.resolve().as_uri(),
                ])
            else:
                # Private file workspaces have no published entrypoint. Render a
                # tiny local card that represents the source file collection.
                preview_html = render_root / f"{example}.html"
                preview_html.write_text(
                    "<!doctype html><style>body{margin:0;background:#101828;color:#fff;"
                    "font:28px Inter,system-ui;padding:70px}small{color:#84adff}"
                    ".card{margin-top:50px;background:#1d2939;border:1px solid #475467;"
                    "border-radius:22px;padding:34px;max-width:720px}b{display:block;"
                    "font-size:54px;margin:12px 0}</style><small>PRIVATE WORKSPACE</small>"
                    "<b>AI Shared Workspace</b><div class=card>README.md<br><br>"
                    "project-brief.md<br>sales-pipeline.csv<br>sales-by-quarter.csv</div>",
                    encoding="utf-8",
                )
                run([
                    str(chrome), "--headless=new", "--disable-gpu", "--hide-scrollbars",
                    "--window-size=1440,900", f"--screenshot={screenshot}", preview_html.resolve().as_uri(),
                ])
            resize_webp(screenshot, PREVIEW_ROOT / f"{example}.webp", width=480, quality=78)
    finally:
        shutil.rmtree(render_root, ignore_errors=True)


def refresh_images(image_dir: Path) -> None:
    missing = [name for name in IMAGE_FILES.values() if not (image_dir / name).is_file()]
    if missing:
        raise SystemExit("Missing source images: " + ", ".join(missing))

    for example, assets in ASSET_REFRESH.items():
        for target, (source_key, width) in assets.items():
            resize_jpeg(image_dir / IMAGE_FILES[source_key], example_source(example) / target, width=width)

    PREVIEW_ROOT.mkdir(exist_ok=True)
    for example, source_key in PREVIEW_SOURCES.items():
        resize_webp(image_dir / IMAGE_FILES[source_key], PREVIEW_ROOT / f"{example}.webp", width=480)
    for legacy_preview in PREVIEW_ROOT.glob("*.png"):
        legacy_preview.unlink()


def validate_sources() -> None:
    errors = []
    for example in EXAMPLES:
        source = example_source(example)
        entrypoint = source / ("README.md" if example == "ai-shared-workspace" else "index.html")
        if not entrypoint.is_file():
            errors.append(f"missing {entrypoint}")
        preview = PREVIEW_ROOT / f"{example}.webp"
        if not preview.is_file() or preview.stat().st_size == 0:
            errors.append(f"missing {preview}")
        for html_path in source.rglob("*.html"):
            errors.extend(validate_html_references(source, html_path))
    if errors:
        raise SystemExit("Invalid example sources:\n- " + "\n- ".join(errors))


def sync_app_assets() -> None:
    if APP_ASSET_ROOT is None:
        return

    (APP_ASSET_ROOT / "previews").mkdir(parents=True, exist_ok=True)
    for example in EXAMPLES:
        shutil.copy2(ROOT / f"{example}.zip", APP_ASSET_ROOT / f"{example}.zip")
        shutil.copy2(PREVIEW_ROOT / f"{example}.webp", APP_ASSET_ROOT / "previews" / f"{example}.webp")
    shutil.copy2(METADATA_FILE, APP_ASSET_ROOT / METADATA_FILE.name)


def package_metadata() -> dict[str, object]:
    examples = {}
    for example in EXAMPLES:
        package = ROOT / f"{example}.zip"
        with zipfile.ZipFile(package) as archive:
            files = [entry for entry in archive.infolist() if not entry.is_dir()]
        examples[example] = {
            "archive_bytes": package.stat().st_size,
            "file_count": len(files),
            "total_bytes": sum(entry.file_size for entry in files),
        }
    return {"examples": examples}


def write_metadata() -> None:
    METADATA_FILE.write_text(json.dumps(package_metadata(), indent=2, sort_keys=True) + "\n", encoding="utf-8")


def check_metadata() -> None:
    if not METADATA_FILE.is_file():
        raise SystemExit(f"Missing generated metadata: {METADATA_FILE}")
    actual = json.loads(METADATA_FILE.read_text(encoding="utf-8"))
    expected = package_metadata()
    if actual != expected:
        raise SystemExit(f"Generated metadata is stale: {METADATA_FILE}")


def check_app_assets() -> None:
    if APP_ASSET_ROOT is None:
        return

    errors = []
    for example in EXAMPLES:
        pairs = [
            (ROOT / f"{example}.zip", APP_ASSET_ROOT / f"{example}.zip"),
            (PREVIEW_ROOT / f"{example}.webp", APP_ASSET_ROOT / "previews" / f"{example}.webp"),
        ]
        for source, deployed in pairs:
            if not source.is_file():
                errors.append(f"missing built asset {source}")
            elif not deployed.is_file():
                errors.append(f"missing app asset {deployed}")
            elif not filecmp.cmp(source, deployed, shallow=False):
                errors.append(f"app asset is stale: {deployed}")
    app_metadata = APP_ASSET_ROOT / METADATA_FILE.name
    if not app_metadata.is_file():
        errors.append(f"missing app asset {app_metadata}")
    elif not filecmp.cmp(METADATA_FILE, app_metadata, shallow=False):
        errors.append(f"app asset is stale: {app_metadata}")
    if errors:
        raise SystemExit("Quick-publish app assets are not synchronized:\n- " + "\n- ".join(errors))


def build(image_dir: Path | None, render_pdf_sources: bool, render_preview_sources: bool) -> None:
    if image_dir:
        refresh_images(image_dir)

    if render_pdf_sources:
        render_pdfs()

    if render_preview_sources:
        render_previews()

    validate_sources()
    for example in EXAMPLES:
        source = example_source(example)
        target = ROOT / f"{example}.zip"
        zip_dir(source, target)
        validate_package(source, target)
    write_metadata()
    sync_app_assets()


def check() -> None:
    validate_sources()
    for example in EXAMPLES:
        validate_package(example_source(example), ROOT / f"{example}.zip")
    check_metadata()
    check_app_assets()


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--image-dir", type=Path, help="Refresh optimized assets and previews from the original image folder.")
    parser.add_argument("--render-pdfs", action="store_true", help="Render proposal/deck PDFs from their _source HTML files.")
    parser.add_argument("--render-previews", action="store_true", help="Render every preview from its source site with headless Chrome.")
    parser.add_argument("--check", action="store_true", help="Verify built and app-image assets are valid and synchronized without writing files.")
    args = parser.parse_args()
    if args.check:
        if args.image_dir or args.render_pdfs or args.render_previews:
            parser.error("--check cannot be combined with build options")
        check()
        return
    build(args.image_dir.expanduser().resolve() if args.image_dir else None, args.render_pdfs, args.render_previews)


if __name__ == "__main__":
    main()
