package main

import (
	"fmt"
	"net/http"
	"os"
	"time"
)

func greet(w http.ResponseWriter, r *http.Request) {
	dateReq := time.Now()
	fmt.Println("receive request: ", dateReq, os.Getenv("HOSTNAME"))
	fmt.Fprintf(w, "Hello World! %s | %s", dateReq, os.Getenv("HOSTNAME"))
}

func main() {
	http.HandleFunc("/", greet)
	http.ListenAndServe(":8080", nil)
}
