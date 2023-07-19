FROM golang:1.20

WORKDIR /app

COPY go.mod .
COPY go.sum .

ARG opts
RUN env ${opts} go mod download
RUN env ${opts} go mod tidy

COPY . .


RUN env ${opts} go build ./cmd/main.go

WORKDIR /app
ENV SHA ${opts.GITHUB_SHA}
ENTRYPOINT ["./main", "-commit", "${opts}"]