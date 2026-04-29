import { useCallback, useEffect, useMemo, useState } from 'react';
import { Ban, Copy, ExternalLink, Link2, RefreshCw } from 'lucide-react';
import { ApiClient, type IReportShareLink } from '@/lib/api-client';
import { showToast } from '@/lib/toast';
import { Button } from '@/components/ui/button';
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from '@/components/ui/card';

function formatDateTime(value: string | null): string {
  if (!value) return 'Never';
  const date = new Date(value);
  if (Number.isNaN(date.getTime())) return value;
  return new Intl.DateTimeFormat(undefined, { dateStyle: 'medium', timeStyle: 'short' }).format(date);
}

function daysUntil(value: string): number {
  const date = new Date(value);
  if (Number.isNaN(date.getTime())) return 0;
  return Math.max(0, Math.ceil((date.getTime() - Date.now()) / 86_400_000));
}

export default function AccountReportSharesPage() {
  const [shares, setShares] = useState<IReportShareLink[]>([]);
  const [loading, setLoading] = useState(true);
  const [refreshing, setRefreshing] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [copiedId, setCopiedId] = useState<string | null>(null);
  const [defaultExpiration, setDefaultExpiration] = useState(30);
  const [sharingEnabled, setSharingEnabled] = useState(true);

  const loadShares = useCallback(async (isRefresh = false) => {
    if (isRefresh) setRefreshing(true);
    else setLoading(true);

    try {
      const response = await ApiClient.listReportShares();
      setShares(response.report_shares);
      setDefaultExpiration(response.default_share_link_expiration || 30);
      setSharingEnabled(response.share_report_enabled);
      setError(null);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to load report shares');
    } finally {
      setLoading(false);
      setRefreshing(false);
    }
  }, []);

  useEffect(() => { loadShares(); }, [loadShares]);

  const activeShares = useMemo(() => shares.filter((share) => share.active), [shares]);

  const copyShare = async (share: IReportShareLink) => {
    if (!share.url) return;
    await navigator.clipboard.writeText(share.url);
    setCopiedId(share.id);
    const days = daysUntil(share.expired_at);
    showToast(`Share link copied. Warning: it expires in ${days} ${days === 1 ? 'day' : 'days'}.`, 'info', 6000);
    setTimeout(() => setCopiedId(null), 2000);
  };

  const expireShare = async (share: IReportShareLink) => {
    if (!share.active) return;
    if (!confirm('Expire this shared report link now? People with the link will lose access immediately.')) return;

    const response = await ApiClient.revokeReportShare(share.id);
    setShares((items) => items.map((item) => item.id === share.id ? response.report_share : item));
  };

  return (
    <div className="space-y-6">
      <Card>
        <CardHeader>
          <CardTitle className="flex items-center gap-2 text-base">
            <Link2 className="h-5 w-5" /> Report Shares
          </CardTitle>
          <CardDescription>
            Manage public report snapshots created from encrypted documents. New links expire after {defaultExpiration} days by default.
          </CardDescription>
        </CardHeader>
        <CardContent className="flex flex-wrap items-center gap-3 text-sm">
          <div className="rounded-md border bg-background px-3 py-2">
            <span className="font-semibold">{activeShares.length}</span> active
          </div>
          <div className="rounded-md border bg-background px-3 py-2">
            <span className="font-semibold">{shares.length}</span> total
          </div>
          <div className={`rounded-md border px-3 py-2 ${sharingEnabled ? 'bg-green-50 text-green-800 border-green-200' : 'bg-amber-50 text-amber-800 border-amber-200'}`}>
            Sharing {sharingEnabled ? 'enabled' : 'disabled'}
          </div>
          <Button
            type="button"
            variant="outline"
            size="sm"
            className="ml-auto"
            onClick={() => loadShares(true)}
            disabled={refreshing}
          >
            <RefreshCw className={`mr-2 h-4 w-4 ${refreshing ? 'animate-spin' : ''}`} />
            Refresh
          </Button>
        </CardContent>
      </Card>

      <Card>
        <CardHeader>
          <CardTitle className="text-base">Shared report links</CardTitle>
          <CardDescription>Expire links that should no longer be externally accessible.</CardDescription>
        </CardHeader>
        <CardContent>
          {loading ? (
            <div className="h-24 animate-pulse rounded-md bg-muted" />
          ) : error ? (
            <div className="rounded-md bg-destructive/10 p-4 text-sm text-destructive">{error}</div>
          ) : shares.length === 0 ? (
            <div className="rounded-md border border-dashed p-8 text-center text-sm text-muted-foreground">
              No shared report links yet.
            </div>
          ) : (
            <div className="overflow-x-auto rounded-md border">
              <table className="w-full text-sm">
                <thead className="bg-muted/50 text-left text-xs uppercase tracking-wide text-muted-foreground">
                  <tr>
                    <th className="px-3 py-2 font-medium">Report</th>
                    <th className="px-3 py-2 font-medium">Status</th>
                    <th className="px-3 py-2 font-medium">Expires</th>
                    <th className="px-3 py-2 font-medium">Views</th>
                    <th className="px-3 py-2 font-medium">Created</th>
                    <th className="px-3 py-2 font-medium text-right">Actions</th>
                  </tr>
                </thead>
                <tbody>
                  {shares.map((share) => (
                    <tr key={share.id} className="border-t">
                      <td className="max-w-[260px] px-3 py-3">
                        <div className="truncate font-medium text-foreground">{share.title || 'Shared report'}</div>
                        <div className="truncate text-xs text-muted-foreground">{share.report_id}</div>
                      </td>
                      <td className="px-3 py-3">
                        <span className={`rounded-full px-2 py-1 text-xs font-medium ${share.active ? 'bg-green-100 text-green-700' : 'bg-slate-100 text-slate-500'}`}>
                          {share.active ? 'Active' : 'Expired'}
                        </span>
                      </td>
                      <td className="px-3 py-3 text-muted-foreground">
                        <div>{formatDateTime(share.expired_at)}</div>
                        {share.active && <div className="text-xs">{daysUntil(share.expired_at)} days left</div>}
                      </td>
                      <td className="px-3 py-3 text-muted-foreground">
                        <div>{share.view_count}</div>
                        <div className="text-xs">Last {formatDateTime(share.last_viewed_at)}</div>
                      </td>
                      <td className="px-3 py-3 text-muted-foreground">
                        <div>{formatDateTime(share.created_at)}</div>
                        <div className="text-xs">{share.created_by_name || 'Unknown user'}</div>
                      </td>
                      <td className="px-3 py-3">
                        <div className="flex justify-end gap-2">
                          <Button
                            type="button"
                            variant="outline"
                            size="sm"
                            disabled={!share.url}
                            onClick={() => copyShare(share)}
                            title="Copy shared link"
                          >
                            <Copy className="mr-1.5 h-4 w-4" />
                            {copiedId === share.id ? 'Copied' : 'Copy'}
                          </Button>
                          {share.url && (
                            <Button type="button" variant="outline" size="sm" asChild>
                              <a href={share.url} target="_blank" rel="noreferrer">
                                <ExternalLink className="mr-1.5 h-4 w-4" />
                                Open
                              </a>
                            </Button>
                          )}
                          <Button
                            type="button"
                            variant="destructive"
                            size="sm"
                            disabled={!share.active}
                            onClick={() => expireShare(share)}
                          >
                            <Ban className="mr-1.5 h-4 w-4" />
                            Expire
                          </Button>
                        </div>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}
        </CardContent>
      </Card>
    </div>
  );
}
