FROM golang:1.22-alpine as builder

WORKDIR /app
COPY go.mod .
COPY go.sum .

RUN go mod download

COPY . .

RUN go build -o /bin/secret-example .

FROM alpine

RUN apk update && apk add --no-cache openssl

WORKDIR /app
COPY --from=builder /bin/secret-example /bin/secret-example

COPY ./entrypoint.sh ./entrypoint.sh
RUN chmod +x ./entrypoint.sh

ENTRYPOINT ["sh","./entrypoint.sh"]
CMD [ "/bin/secret-example" ]
