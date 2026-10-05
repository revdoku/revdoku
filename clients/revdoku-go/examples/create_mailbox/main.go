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
	mailbox := revdoku.NewCreateMailboxRequestMailbox()
	mailbox.SetTitle("Example mailbox")
	body := revdoku.NewCreateMailboxRequest(*mailbox)
	if account := os.Getenv("REVDOKU_ACCOUNT_ID"); account != "" {
		body.SetAccountId(account)
	}
	result, response, err := api.DefaultAPI.CreateMailbox(context.Background()).CreateMailboxRequest(*body).Execute()
	if err != nil {
		if response != nil {
			fmt.Fprintln(os.Stderr, "HTTP", response.StatusCode)
			if delay := response.Header.Get("Retry-After"); delay != "" {
				fmt.Fprintln(os.Stderr, "Retry-After:", delay)
			}
		}
		if apiError, ok := err.(*revdoku.GenericOpenAPIError); ok {
			fmt.Fprintln(os.Stderr, string(apiError.Body()))
		}
		log.Fatal("Creation was not confirmed. Check existing mailboxes before another creation attempt.")
	}
	created := result.Data.GetMailbox()
	email := created.GetEmail()
	fmt.Println(created.GetId(), email.GetAddress())
}
