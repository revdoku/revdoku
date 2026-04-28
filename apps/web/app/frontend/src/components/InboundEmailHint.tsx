import { useEffect, useState } from 'react';
import { Mail, Copy, Check } from 'lucide-react';
import { ApiClient } from '@/lib/api-client';
import { Button } from '@/components/ui/button';

// Two states:
//   • configured + address  → full hint with copy button ("Or send PDFs to …")
//   • not configured        → tiny muted one-liner pointing operators at the
//                             env config; nothing to copy yet.
// While the profile fetch is in flight or it errors, render nothing so the
// dropzone doesn't flash.
type InboundState = { address: string | null; configured: boolean; loaded: boolean };
let cached: InboundState | undefined;
let inflight: Promise<InboundState> | null = null;

function useInboundEmail(): InboundState {
  const [state, setState] = useState<InboundState>(cached ?? { address: null, configured: false, loaded: false });

  useEffect(() => {
    if (cached !== undefined) return;
    let cancelled = false;
    (inflight ??= ApiClient.getAccountProfile()
      .then((r) => {
        const next: InboundState = {
          address: r?.profile?.current_account?.inbound_email_address ?? null,
          configured: r?.profile?.current_account?.inbound_email_ingress_configured ?? false,
          loaded: true,
        };
        cached = next;
        return next;
      })
      .catch(() => {
        const next: InboundState = { address: null, configured: false, loaded: true };
        cached = next;
        return next;
      })
      .finally(() => {
        inflight = null;
      }))
      .then((next) => {
        if (!cancelled) setState(next);
      });
    return () => {
      cancelled = true;
    };
  }, []);

  return state;
}

export function InboundEmailHint() {
  const { address: inboundEmail, configured, loaded } = useInboundEmail();
  const [copied, setCopied] = useState(false);

  const handleCopy = async () => {
    if (!inboundEmail) return;
    try {
      await navigator.clipboard.writeText(inboundEmail);
      setCopied(true);
      window.setTimeout(() => setCopied(false), 2000);
    } catch {
      /* ignore */
    }
  };

  if (!loaded) return null;

  if (!inboundEmail || !configured) {
    return (
      <p className="mt-4 text-[11px] text-muted-foreground/70 text-center px-4">
        To upload via email, configure inbound email first.
      </p>
    );
  }

  return (
    <div className="mt-6 inline-flex flex-col items-stretch border-t border-border pt-4 max-w-full">
      <div className="flex items-center justify-center gap-1.5 text-sm text-muted-foreground mb-3">
        <Mail className="h-4 w-4" />
        <span>Or send PDFs to the email below:</span>
      </div>
      <p
        className="font-semibold text-foreground text-center select-all mb-3 break-all px-2"
        style={{ fontFamily: '"Courier New", Courier, monospace' }}
        aria-label="Inbound email address"
      >
        {inboundEmail}
      </p>
      <Button
        type="button"
        onClick={handleCopy}
        variant="secondary"
        aria-label={copied ? 'Copied email address' : 'Copy email address'}
      >
        {copied ? (
          <>
            <Check className="h-4 w-4 mr-2" />
            Copied
          </>
        ) : (
          <>
            <Copy className="h-4 w-4 mr-2" />
            Copy Email Address
          </>
        )}
      </Button>
    </div>
  );
}
