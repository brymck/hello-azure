package main

import (
	"github.com/brymck/hello-azure/homepage"
	"github.com/brymck/hello-azure/server"
	"log"
	"net/http"
	"os"
)

const (
	ServerAddress = ":8080"
)

func main() {
	logger := log.New(os.Stdout, "helloazure ", log.LstdFlags|log.Lshortfile)

	h := homepage.NewHandlers(logger)

	mux := http.NewServeMux()
	h.SetupRoutes(mux)

	srv := server.New(mux, ServerAddress)

	logger.Println("server starting")
	err := srv.ListenAndServe()
	if err != nil {
		logger.Fatalf("server failed to start: %v", err)
	}
}
