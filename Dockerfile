FROM alpine AS build

RUN apk update && apk add --no-cache git go
RUN git clone https://github.com/XTLS/Xray-core.git
WORKDIR /Xray-core
RUN go mod download && \
    CGO_ENABLED=0 go build -o xray -trimpath \
    -ldflags "-s -w -buildid=" ./main


FROM alpine:latest

WORKDIR /root/ 
COPY --from=build /Xray-core/xray /root/xray
COPY config.temp.json /etc/xray/config.json
RUN mkdir /var/log/xray && \
    touch /var/log/xray/error.log
RUN chmod +x /root/xray

CMD ["/root/xray", "run", "-config", "/etc/xray/config.json"]