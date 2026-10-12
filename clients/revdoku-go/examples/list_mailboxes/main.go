package main

import (
	"context"
	"fmt"
	revdoku "github.com/revdoku/revdoku-go/v2"
	"log"
	"os"
)

func main() {
	key := os.Getenv("REVDOKU_API_KEY")
	if key == "" {
		log.Fatal("Set REVDOKU_API_KEY")
	}
	config := revdoku.NewConfiguration()
	config.AddDefaultHeader("Authorization", "Bearer "+key)
	api := revdoku.NewAPIClient(config)
	cursor := ""
	seen := map[string]bool{}
	for {
		request := api.DefaultAPI.ListMailboxes(context.Background()).Status("active").Limit(100)
		if account := os.Getenv("REVDOKU_ACCOUNT_ID"); account != "" {
			request = request.AccountId(account)
		}
		if cursor != "" {
			request = request.Cursor(cursor)
		}
		result, _, err := request.Execute()
		if err != nil { log.Fatal(err) }
		for _, mailbox := range result.Data.Mailboxes {
			email := mailbox.GetEmail()
			fmt.Println(mailbox.GetId(), email.GetAddress())
		}
		if !result.Data.Pagination.HasMore { break }
		cursor = result.Data.Pagination.GetNextCursor()
		if cursor == "" || seen[cursor] { log.Fatal("Mailbox pagination did not advance") }
		seen[cursor] = true
	}
}
