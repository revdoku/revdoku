---
title: Authentication
description: Send your API key with every request.
---

# Authentication

Send your API key in the `Authorization` header:

```http
Authorization: Bearer YOUR_API_KEY
```

> [!WARNING]
> Never put an API key in client-side code or in a public repository.

A request without a valid key gets `401 Unauthorized`.
