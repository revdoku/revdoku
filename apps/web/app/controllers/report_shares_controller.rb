# frozen_string_literal: true

class ReportSharesController < ActionController::Base
  before_action :set_public_report_base_headers

  def show
    share = ReportShare.find_by_token(params[:token])
    return render_unavailable(status: share ? :gone : :not_found) unless share&.available?

    html = share.html_file.download
    nonce = nil
    if html.include?('id="revdoku-share-script-payload"')
      nonce = SecureRandom.base64(18)
      html = inject_shared_report_runner(html, nonce)
    end

    set_public_report_content_security_policy(script_nonce: nonce)
    share.record_view!
    send_data(
      html,
      filename: share.html_file.filename.to_s,
      type: "text/html; charset=utf-8",
      disposition: "inline"
    )
  rescue ActiveStorage::FileNotFoundError
    render_unavailable(status: :gone)
  end

  private

  def render_unavailable(status: :not_found)
    set_public_report_content_security_policy
    render plain: "Report share is unavailable.", status: status
  end

  def set_public_report_base_headers
    response.set_header("Cache-Control", "private, no-store")
    response.set_header("Referrer-Policy", "no-referrer")
    response.set_header("X-Content-Type-Options", "nosniff")
    response.set_header("X-Frame-Options", "DENY")
    # Belt-and-braces with the <meta name="robots"> in the snapshot HTML — the
    # header covers crawlers that read response headers but not body markup.
    response.set_header("X-Robots-Tag", "noindex, nofollow, noarchive, nosnippet")
  end

  def set_public_report_content_security_policy(script_nonce: nil)
    script_src = script_nonce ? "script-src 'nonce-#{script_nonce}' 'unsafe-inline' 'unsafe-eval'" : "script-src 'none'"
    response.set_header(
      "Content-Security-Policy",
      [
        "default-src 'none'",
        script_src,
        "object-src 'none'",
        "img-src data: blob:",
        "style-src 'unsafe-inline'",
        "font-src data:",
        "frame-src 'self' data: blob:",
        "child-src 'self' data: blob:",
        "base-uri 'none'",
        "form-action 'none'",
        "frame-ancestors 'none'"
      ].join("; ")
    )
  end

  def inject_shared_report_runner(html, nonce)
    runner = <<~HTML
      <script nonce="#{ERB::Util.html_escape(nonce)}">
      (() => {
        const payloadNode = document.getElementById('revdoku-share-script-payload');
        const runButton = document.getElementById('revdoku-run-shared-script');
        const statusNode = document.getElementById('revdoku-shared-script-status');
        const outputNode = document.getElementById('revdoku-shared-script-output');
        if (!payloadNode || !runButton || !statusNode || !outputNode) return;

        const resolve = (obj, path) => path.split('.').reduce((o, k) => o && o[k], obj);
        const renderSection = (template, data) => {
          let result = template;
          result = result.replace(/\\{\\{#each\\s+(\\w[\\w.]*)\\}\\}([\\s\\S]*?)\\{\\{\\/each\\}\\}/g, (_, key, inner) => {
            const arr = resolve(data, key);
            if (!Array.isArray(arr)) return '';
            return arr.map((item) => renderSection(inner, typeof item === 'object' && item !== null ? { ...data, ...item } : { ...data, '.': item })).join('');
          });
          result = result.replace(/\\{\\{#if\\s+(\\w[\\w.]*)\\}\\}([\\s\\S]*?)(?:\\{\\{else\\}\\}([\\s\\S]*?))?\\{\\{\\/if\\}\\}/g, (_, key, ifBlock, elseBlock) => renderSection(resolve(data, key) ? ifBlock : (elseBlock || ''), data));
          return result.replace(/\\{\\{(\\w[\\w.]*)\\}\\}/g, (_, key) => {
            const val = resolve(data, key);
            return val == null ? '' : String(val);
          });
        };
        const extractTemplate = (code) => {
          const backtick = code.match(/^(?:(?:const|let|var)\\s+)?script_template\\s*=\\s*`([\\s\\S]*?)`\\s*;?\\s*$/m);
          if (backtick) return backtick[1];
          const quoted = code.match(/^(?:(?:const|let|var)\\s+)?script_template\\s*=\\s*(['"])([\\s\\S]*?)\\1\\s*;?\\s*$/m);
          return quoted ? quoted[2] : '';
        };
        const stripTemplate = (code) => code
          .replace(/^(?:(?:const|let|var)\\s+)?script_template\\s*=\\s*`[\\s\\S]*?`\\s*;?\\s*$/m, '')
          .replace(/^(?:(?:const|let|var)\\s+)?script_template\\s*=\\s*(['"])[\\s\\S]*?\\1\\s*;?\\s*$/m, '');

        runButton.addEventListener('click', () => {
          let payload;
          try {
            payload = JSON.parse(payloadNode.textContent || '{}');
          } catch (error) {
            statusNode.textContent = 'Invalid script payload';
            return;
          }

          const executionFrame = document.createElement('iframe');
          executionFrame.setAttribute('sandbox', 'allow-scripts');
          executionFrame.style.display = 'none';
          executionFrame.srcdoc = `<!doctype html><meta http-equiv="Content-Security-Policy" content="default-src 'none'; script-src 'unsafe-inline' 'unsafe-eval'; connect-src 'none'; img-src data:; style-src 'unsafe-inline';"><script>
            window.addEventListener('message', (event) => {
              try {
                const fn = new Function('checks', event.data.code);
                const result = fn(Array.isArray(event.data.checks) ? event.data.checks : []);
                parent.postMessage({ type: 'revdoku-shared-script-result', data: result && result.data ? result.data : {} }, '*');
              } catch (error) {
                parent.postMessage({ type: 'revdoku-shared-script-error', message: error && error.message ? error.message : String(error) }, '*');
              }
            });
          <\\/script>`;

          const onMessage = (event) => {
            if (event.source !== executionFrame.contentWindow) return;
            window.removeEventListener('message', onMessage);
            executionFrame.remove();

            if (event.data && event.data.type === 'revdoku-shared-script-error') {
              statusNode.textContent = 'Script error';
              outputNode.textContent = event.data.message || 'Script failed';
              return;
            }

            const data = event.data && event.data.data ? event.data.data : {};
            const template = extractTemplate(payload.code || '');
            const rendered = template.trim() ? renderSection(template, data) : '<p>No output template.</p>';
            const outputFrame = document.createElement('iframe');
            outputFrame.setAttribute('sandbox', '');
            outputFrame.style.width = '100%';
            outputFrame.style.minHeight = '120px';
            outputFrame.style.border = '0';
            outputFrame.srcdoc = `<!doctype html><meta charset="utf-8"><style>body{font-family:Arial, sans-serif;margin:0;color:#1f2937;background:#fffbe6;font-size:13px;line-height:1.45}</style>${rendered}`;
            outputNode.replaceChildren(outputFrame);
            statusNode.textContent = 'Script finished';
          };

          window.addEventListener('message', onMessage);
          document.body.appendChild(executionFrame);
          statusNode.textContent = 'Running script...';
          executionFrame.addEventListener('load', () => {
            executionFrame.contentWindow?.postMessage({ code: stripTemplate(payload.code || ''), checks: payload.checks || [] }, '*');
          }, { once: true });
        });
      })();
      </script>
    HTML

    ReportShare.inject_before_body_end(html, runner)
  end
end
