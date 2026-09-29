import { execFileSync } from 'node:child_process';
import { mkdtempSync, readFileSync, readdirSync, rmSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { join } from 'node:path';
import { fileURLToPath } from 'node:url';

const root = fileURLToPath(new URL('../', import.meta.url));
const temporary = mkdtempSync(join(tmpdir(), 'revdoku-examples-'));
try {
  execFileSync(process.execPath, [join(root, 'node_modules/typescript/bin/tsc'), '-p', join(root, 'typescript/tsconfig.json'), '--outDir', temporary], { stdio: 'inherit' });
  const generated = readdirSync(temporary).filter(p => p.endsWith('.js')).sort();
  const checkedIn = readdirSync(join(root, 'javascript')).filter(p => p.endsWith('.js')).sort();
  if (JSON.stringify(generated) !== JSON.stringify(checkedIn)) throw new Error('JavaScript file list differs from TypeScript output.');
  for (const file of generated) {
    if (!readFileSync(join(temporary, file)).equals(readFileSync(join(root, 'javascript', file)))) throw new Error(`Stale JavaScript: ${file}. Run npm run build.`);
  }
  console.log('TypeScript and generated JavaScript match.');
} finally { rmSync(temporary, { recursive: true, force: true }); }
