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
	var offset int32
	for {
		request := api.DefaultAPI.ListMailboxes(context.Background()).Status("active").Limit(100).Offset(offset)
		if account := os.Getenv("REVDOKU_ACCOUNT_ID"); account != "" {
			request = request.AccountId(account)
		}
		result, _, err := request.Execute()
		if err != nil { log.Fatal(err) }
		for _, mailbox := range result.Data.Mailboxes {
			email := mailbox.GetEmail()
			fmt.Println(mailbox.GetId(), email.GetAddress())
		}
		if !result.Data.Pagination.HasMore { break }
		next := result.Data.Pagination.NextOffset.Get()
		if next == nil || *next <= offset { log.Fatal("Mailbox pagination did not advance") }
		offset = *next
	}
}
