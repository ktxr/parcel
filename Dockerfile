FROM golang:1.23-alpine AS builder

WORKDIR /app
COPY . .
ENV CGO_ENBLED=0 GOOS=linux GOARCH=amd64
RUN go mod tidy && go build -o parcel . && chmod +x parcel

FROM scratch
COPY --from=builder /app/parcel /app/tracker.db ./
CMD ["./parcel"]