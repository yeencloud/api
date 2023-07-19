FROM golang:1.20

WORKDIR /app

COPY go.mod .
COPY go.sum .

ARG GIT_SHA
RUN echo $GIT_SHA
RUN echo ${GIT_SHA}

ARG GOARCH
RUN echo GOARCH
RUN echo ${GOARCH}

ARG opts
RUN echo $opts
RUN echo ${opts}

RUN env ${opts} go mod download
RUN env ${opts} go mod tidy

COPY . .


RUN env ${opts} go build ./cmd/main.go

WORKDIR /app
ENV SHA=${GIT_SHA}
ENTRYPOINT ["./main", "-commit", "${opts}", "2", "${GIT_SHA}", "$GIT_SHA"]