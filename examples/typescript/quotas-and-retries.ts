import { createClient, run } from './client.js';

await run(async () => {
  const client = createClient();
  const data = await client.api<{ profile: { current_account: { plan_contract: {
    plan: { name: string }; limits: Record<string, unknown>;
    bucket_creation_usage: { monthly_limit: number; used: number; remaining: number; resets_at: string };
  } } } }>('/v1/account/profile');
  const contract = data.profile.current_account.plan_contract;
  console.log(JSON.stringify({ plan: contract.plan.name, creations: contract.bucket_creation_usage,
    active_bucket_limit: contract.limits.max_buckets,
    api_requests_per_minute: contract.limits.api_rate_limit_requests_per_minute }, null, 2));
  console.log('Temporary rate limits use Retry-After and bounded retries in client.js.');
  console.log('Creation quotas stop immediately and report resets_at; deletion does not refund them.');
});
