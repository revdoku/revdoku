package main

import (
	"context"
	"fmt"
	revdoku "github.com/revdoku/revdoku-go/v2"
	"io"
	"log"
	"net/http"
	"net/url"
	"os"
	"time"
)

func main() {
	names := []string{"REVDOKU_API_KEY", "REVDOKU_BUCKET_ID", "REVDOKU_EMAIL_ID", "REVDOKU_ATTACHMENT_ID", "REVDOKU_DOWNLOAD_PATH"}
	for _, name := range names {
		if os.Getenv(name) == "" {
			log.Fatal("Set " + name)
		}
	}
	config := revdoku.NewConfiguration()
	config.AddDefaultHeader("Authorization", "Bearer "+os.Getenv("REVDOKU_API_KEY"))
	api := revdoku.NewAPIClient(config)
	request := api.DefaultAPI.GetEmailAttachmentDownloadUrl(context.Background(), os.Getenv("REVDOKU_BUCKET_ID"), os.Getenv("REVDOKU_EMAIL_ID"), os.Getenv("REVDOKU_ATTACHMENT_ID"))
	if account := os.Getenv("REVDOKU_ACCOUNT_ID"); account != "" {
		request = request.AccountId(account)
	}
	result, _, err := request.Execute()
	if err != nil {
		log.Fatal(err)
	}
	download := result.Data.Download
	uri, err := url.Parse(download.Url)
	if err != nil || uri.Scheme != "https" || uri.Hostname() == "" || uri.User != nil || download.Authentication != "none" {
		log.Fatal("Expected an HTTPS download without API authentication")
	}
	// This separate client sends no bearer token and follows no redirects.
	httpClient := &http.Client{Timeout: 60 * time.Second, CheckRedirect: func(*http.Request, []*http.Request) error { return http.ErrUseLastResponse }}
	response, err := httpClient.Get(uri.String())
	if err != nil {
		log.Fatal(err)
	}
	defer response.Body.Close()
	if response.StatusCode != 200 {
		log.Fatalf("Download failed: HTTP %d", response.StatusCode)
	}
	bytes, err := io.ReadAll(response.Body)
	if err != nil {
		log.Fatal(err)
	}
	file, err := os.OpenFile(os.Getenv("REVDOKU_DOWNLOAD_PATH"), os.O_WRONLY|os.O_CREATE|os.O_EXCL, 0600)
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()
	if _, err = file.Write(bytes); err != nil {
		log.Fatal(err)
	}
	fmt.Println(os.Getenv("REVDOKU_DOWNLOAD_PATH"))
}
