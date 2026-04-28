import { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { Mail, Check, Copy } from 'lucide-react';
import { ApiClient } from '@/lib/api-client';
import { Card, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';

export default function InboundEmailCard() {
  const [address, setAddress] = useState<string | null>(null);
<<<<<<< Updated upstream
  const [configured, setConfigured] = useState<boolean | null>(null);
  const [loaded, setLoaded] = useState(false);
=======
>>>>>>> Stashed changes
  const [copied, setCopied] = useState(false);

  useEffect(() => {
    let cancelled = false;
    ApiClient.getAccountProfile()
<<<<<<< Updated upstream
      .then((r) => {
        if (cancelled) return;
        setAddress(r?.profile?.current_account?.inbound_email_address ?? null);
        setConfigured(r?.profile?.current_account?.inbound_email_ingress_configured ?? false);
        setLoaded(true);
      })
      .catch(() => { if (!cancelled) setLoaded(true); });
=======
      .then((r) => { if (!cancelled) setAddress(r?.profile?.current_account?.inbound_email_address ?? null); })
      .catch(() => {});
>>>>>>> Stashed changes
    return () => { cancelled = true; };
  }, []);

  const handleCopy = async () => {
    if (!address) return;
    try {
      await navigator.clipboard.writeText(address);
      setCopied(true);
      window.setTimeout(() => setCopied(false), 2000);
    } catch {
      /* ignore */
    }
  };

<<<<<<< Updated upstream
  if (!loaded) return null;

  const isConfigured = configured === true && !!address;
  const hasAddress = !!address;
=======
  if (!address) return null;
>>>>>>> Stashed changes

  return (
    <Card>
      <CardContent className="py-3 space-y-2">
        <div className="flex items-center gap-2 flex-wrap">
          <Mail className="h-4 w-4 text-muted-foreground shrink-0" />
          <span className="text-sm font-medium">Upload via Email</span>
<<<<<<< Updated upstream
          {isConfigured ? (
            <span className="text-xs text-muted-foreground">— forward a PDF, we'll create an envelope.</span>
          ) : (
            <span className="text-xs px-1.5 py-0.5 rounded bg-muted text-muted-foreground border border-border">
              Not configured
            </span>
          )}
        </div>
        {hasAddress && (
          <div className="flex items-center gap-2">
            <div
              role="textbox"
              aria-readonly="true"
              aria-label="Inbound email address"
              tabIndex={0}
              className={`font-mono text-sm min-w-0 flex-1 py-1.5 px-3 border border-input rounded-md bg-background break-all select-all cursor-text ${
                isConfigured ? 'text-foreground' : 'text-muted-foreground opacity-60'
              }`}
            >
              {address}
            </div>
            <Button
              onClick={handleCopy}
              variant="secondary"
              size="icon"
              className="shrink-0"
              title={copied ? 'Copied' : 'Copy address'}
              aria-label={copied ? 'Copied' : 'Copy address'}
            >
              {copied ? <Check className="h-4 w-4" /> : <Copy className="h-4 w-4" />}
            </Button>
            {isConfigured && (
              <Link
                to="/logs?category=email_upload"
                className="text-xs text-primary hover:underline whitespace-nowrap"
              >
                View activity →
              </Link>
            )}
          </div>
        )}
        {!isConfigured && (
          <p className="text-xs text-muted-foreground">
            {hasAddress ? (
              <>Set <code className="font-mono">INBOUND_EMAIL_INGRESS</code> in <code className="font-mono">.env.local</code> to enable.</>
            ) : (
              <>Set <code className="font-mono">INBOUND_EMAIL_INGRESS</code> and <code className="font-mono">INBOUND_EMAIL_DOMAIN</code> in <code className="font-mono">.env.local</code> to enable.</>
            )}
          </p>
        )}
=======
          <span className="text-xs text-muted-foreground">— forward a PDF, we'll create an envelope.</span>
        </div>
        <div className="flex items-center gap-2">
          <div
            role="textbox"
            aria-readonly="true"
            aria-label="Inbound email address"
            tabIndex={0}
            className="font-mono text-sm min-w-0 flex-1 py-1.5 px-3 border border-input rounded-md bg-background text-foreground break-all select-all cursor-text"
          >
            {address}
          </div>
          <Button
            onClick={handleCopy}
            variant="secondary"
            size="icon"
            className="shrink-0"
            title={copied ? 'Copied' : 'Copy address'}
            aria-label={copied ? 'Copied' : 'Copy address'}
          >
            {copied ? <Check className="h-4 w-4" /> : <Copy className="h-4 w-4" />}
          </Button>
          <Link
            to="/logs?category=email_upload"
            className="text-xs text-primary hover:underline whitespace-nowrap"
          >
            View activity →
          </Link>
        </div>
>>>>>>> Stashed changes
      </CardContent>
    </Card>
  );
}
