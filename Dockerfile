FROM caddy:2
ADD https://github.com/just-containers/s6-overlay/releases/download/v1.22.1.0/s6-overlay-amd64.tar.gz /tmp/
RUN tar xzvf /tmp/s6-overlay-amd64.tar.gz -C /  \
 && mv /bin/s6-svscan /bin/s6-svscan-orig
ADD s6-svscan /bin/s6-svscan
ADD SIGTERM SIGHUP SIGQUIT SIGINT SIGUSR1 /etc/s6/services/.s6-svscan/
ADD SIGTERM SIGHUP SIGQUIT SIGINT /run/s6/services/.s6-svscan/
ENTRYPOINT ["/init"]
ENV CADDYFILE /etc/caddy/Caddyfile
CMD [ \
    "importas", "-i", "CADDYFILE", "CADDYFILE", \
    "caddy", "run", "--config", "$CADDYFILE", "--adapter", "caddyfile"]
