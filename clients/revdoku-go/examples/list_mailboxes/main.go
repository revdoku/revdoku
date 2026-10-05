package main

import (
	"context"
	"fmt"
	revdoku "github.com/revdoku/revdoku-go"
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
	request := api.DefaultAPI.ListMailboxes(context.Background())
	if account := os.Getenv("REVDOKU_ACCOUNT_ID"); account != "" {
		request = request.AccountId(account)
	}
	result, _, err := request.Execute()
	if err != nil {
		log.Fatal(err)
	}
	for _, mailbox := range result.Data.Mailboxes {
		email := mailbox.GetEmail()
		fmt.Println(mailbox.GetId(), email.GetAddress())
	}
}
