package main

import (
	"context"
	"encoding/json"
	revdoku "github.com/revdoku/revdoku-go/v2"
	"log"
	"os"
)

func main() {
	key, mailbox := os.Getenv("REVDOKU_API_KEY"), os.Getenv("REVDOKU_BUCKET_ID")
	if key == "" || mailbox == "" {
		log.Fatal("Set REVDOKU_API_KEY and REVDOKU_BUCKET_ID")
	}
	config := revdoku.NewConfiguration()
	config.AddDefaultHeader("Authorization", "Bearer "+key)
	api := revdoku.NewAPIClient(config)
	cursor := ""
	seen := map[string]bool{}
	for {
		request := api.DefaultAPI.ListFiles(context.Background(), mailbox).Limit(100)
		if account := os.Getenv("REVDOKU_ACCOUNT_ID"); account != "" {
			request = request.AccountId(account)
		}
		if cursor != "" {
			request = request.Cursor(cursor)
		}
		result, _, err := request.Execute()
		if err != nil {
			log.Fatal(err)
		}
		for _, file := range result.Data.Files {
			if err := json.NewEncoder(os.Stdout).Encode(file); err != nil {
				log.Fatal(err)
			}
		}
		if !result.Data.Pagination.HasMore {
			break
		}
		cursor = result.Data.Pagination.GetNextCursor()
		if cursor == "" || seen[cursor] {
			log.Fatal("File pagination did not advance")
		}
		seen[cursor] = true
	}
}
