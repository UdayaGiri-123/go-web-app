FROM golang:1.23 as build

WORKDIR /app

COPY go.mod .

RUN go mod download

COPY . . 

RUN go build -o main .

# final stage - distroless image
FROM gcr.io/distroless/base

COPY --from=build /app/main .

COPY --from=build /app/static ./static

EXPOSE 8080

CMD [ "./main" ]