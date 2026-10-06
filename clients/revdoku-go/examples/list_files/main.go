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
	var offset int32
	for {
		request := api.DefaultAPI.ListMailboxFiles(context.Background(), mailbox).Limit(100).Offset(offset)
		if account := os.Getenv("REVDOKU_ACCOUNT_ID"); account != "" {
			request = request.AccountId(account)
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
		next := result.Data.Pagination.NextOffset.Get()
		if next == nil || *next <= offset {
			log.Fatal("File pagination did not advance")
		}
		offset = *next
	}
}
