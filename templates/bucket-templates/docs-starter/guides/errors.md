---
title: Errors
description: Status codes and error bodies.
---

# Errors

Every error has a JSON body with a stable `code` and a readable `message`:

```json
{ "error": { "code": "NOT_FOUND", "message": "Plant not found" } }
```

| Status | Meaning |
| --- | --- |
| 400 | The request is not valid. |
| 401 | The API key is missing or wrong. |
| 404 | The resource does not exist. |
| 429 | Too many requests. Wait and try again. |
