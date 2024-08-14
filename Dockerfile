FROM golang AS build-env

WORKDIR /app

COPY go.* ./
RUN go mod download
COPY . ./
RUN ls -a
RUN go mod tidy
RUN cd cmd
RUN ls -a
RUN go build -v -o pingtunnel

FROM debian
COPY --from=build-env /app/pingtunnel .
COPY GeoLite2-Country.mmdb .
WORKDIR ./
