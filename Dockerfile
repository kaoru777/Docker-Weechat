FROM debian:buster
MAINTAINER Kaoru Steinboeck, kaoru@steinboeck.dev

ENV TERM xterm-256color
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LANG=C.UTF-8
ENV TIMEZONE Europe/Vienna
ENV UID=1000
ENV GID=1000

RUN apt-get update && apt install -y dirmngr gpg-agent apt-transport-https ca-certificates wget
RUN apt-key adv --keyserver hkps://keys.openpgp.org --recv-keys 11E9DE8848F2B65222AA75B8D1820DB22A11534E
RUN echo "deb https://weechat.org/debian buster main" | tee /etc/apt/sources.list.d/weechat.list
RUN echo "deb-src https://weechat.org/debian buster main" | tee -a /etc/apt/sources.list.d/weechat.list
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
        weechat-curses weechat-plugins weechat-python weechat-perl \
    && useradd -m -s /bin/bash xyz \
    && ln -fs /usr/share/zoneinfo/$TIMEZONE /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata
RUN chown -R xyz:xyz /home/xyz

VOLUME /home/xyz
WORKDIR /home/xyz
EXPOSE 9001

USER xyz

CMD ["weechat"]
