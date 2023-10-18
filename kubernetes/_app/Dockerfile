FROM golang:1.15-alpine

COPY . .

# Build the Go app
RUN go build server.go

# This container exposes port 8080 to the outside world
EXPOSE 8080

# Run the binary program produced by `go install`
CMD ["./server"]
