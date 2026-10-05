package main

import (
	"context"
	"encoding/json"
	revdoku "github.com/revdoku/revdoku-go"
	"log"
	"os"
)

func main() {
	key, mailbox := os.Getenv("REVDOKU_API_KEY"), os.Getenv("REVDOKU_BUCKET_ID")
	if key == "" || mailbox == "" {
		log.Fatal("Set REVDOKU_API_KEY and REVDOKU_BUCKET_ID")
	}
	account := os.Getenv("REVDOKU_ACCOUNT_ID")
	config := revdoku.NewConfiguration()
	config.AddDefaultHeader("Authorization", "Bearer "+key)
	api := revdoku.NewAPIClient(config)
	cursor := ""
	seen := map[string]bool{}
	for {
		request := api.DefaultAPI.ListEmails(context.Background(), mailbox).Limit(100).Order("asc").Read(false)
		if account != "" {
			request = request.AccountId(account)
		}
		if cursor != "" {
			request = request.Cursor(cursor)
		}
		result, _, err := request.Execute()
		if err != nil {
			log.Fatal(err)
		}
		for _, summary := range result.Data.Emails {
			detail := api.DefaultAPI.GetEmail(context.Background(), mailbox, summary.Id)
			if account != "" {
				detail = detail.AccountId(account)
			}
			response, _, err := detail.Execute()
			if err != nil {
				log.Fatal(err)
			}
			if err := json.NewEncoder(os.Stdout).Encode(response.Data.Email); err != nil {
				log.Fatal(err)
			}
		}
		if !result.Data.Pagination.HasMore {
			break
		}
		cursor = result.Data.Pagination.NextCursor
		if cursor == "" || seen[cursor] {
			log.Fatal("Email pagination did not advance")
		}
		seen[cursor] = true
	}
	// Reading does not change shared read/unread status.
}
