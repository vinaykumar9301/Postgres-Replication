FROM alpine

RUN apk add --no-cache keepalived
COPY keepalived.conf /etc/keepalived/keepalived.conf
COPY start-keepalived.sh /usr/local/bin/start-keepalived.sh

RUN chmod +x /usr/local/bin/start-keepalived.sh

CMD ["/usr/local/bin/start-keepalived.sh"]
