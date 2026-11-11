---
title: Import your data
description: Bring your existing data into Acme from a CSV file.
---

You can import a CSV file of up to 10,000 rows.

1. Open the project.
2. Select **Import**, then choose your CSV file.
3. Match each column of the file to a field.
4. Select **Start import**.

Acme shows the number of imported rows and the rows that it skipped.

## File format

| Column | Required | Example |
| --- | --- | --- |
| `name` | Yes | `Monstera` |
| `price` | No | `24.90` |
| `tags` | No | `indoor;large` |

The first row has the column names. Use UTF-8.

## If rows are skipped

Download the list of skipped rows, correct them, and import that file again.
See [Troubleshooting](/troubleshooting) for common causes.
