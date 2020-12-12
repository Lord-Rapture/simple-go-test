################# STEP 1 - Build the Binary ##################
FROM golang:alpine AS builder

# Installing Git.
RUN apk update && apk add --no-cache git

# Coping files
WORKDIR $GOPATH/src/
COPY ../../simple-go-git/simple-go .

# Build the Binary
RUN go build -o /go/bin/hello


################# STEP 2 - Build the small image #############
FROM scratch

# Copying the made binary
COPY --from=builder /go/bin/hello go/bin/hello

# Run the binary
ENTRYPOINT ["/go/bin/hello"]