FROM docker:19.03.2 as runtime
LABEL "repository"="https://github.com/elgohr/Publish-Docker-Github-Action"
LABEL "maintainer"="Lars Gohr"

RUN apk update \
  && apk upgrade \
  && apk add --no-cache git curl

ADD entrypoint.sh /entrypoint.sh
RUN mkdir -p /etc/docker/certs.d/10.8.0.102\:443 && curl https://gist.githubusercontent.com/dayjaby/90254453e399c42eaa6f878db027e481/raw/623eea99ab7ec4db32791fc537c8a70657c0c1cf/domain.crt -o /etc/docker/certs.d/10.8.0.102\:443/ca.crt
ENTRYPOINT ["/entrypoint.sh"]

# FROM runtime as testEnv
# RUN apk add --no-cache coreutils bats ncurses
# ADD test.bats /test.bats
# ADD mock.sh /usr/local/bin/docker
# ADD mock.sh /usr/bin/date
# RUN /test.bats

FROM runtime
