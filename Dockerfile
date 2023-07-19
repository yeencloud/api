FROM golang:1.20

WORKDIR /app

COPY go.mod .
COPY go.sum .

ARG GITHUB_SHA
RUN echo $GITHUB_SHA
RUN echo ${GITHUB_SHA}

RUN go mod download
RUN go mod tidy

COPY . .


RUN go build ./cmd/main.go

WORKDIR /app
ENV GITHUB_SHA=${GITHUB_SHA}
ENTRYPOINT ["./main", "-commit", "${GITHUB_SHA}", "2", "${GITHUB_SHA}", "$GITHUB_SHA"]