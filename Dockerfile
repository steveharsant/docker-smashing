FROM ruby:2.6

RUN apt-get update && \
    apt-get upgrade -yq && \
    apt-get install nodejs -y && \
    mkdir /smashing

COPY entrypoint.sh /usr/bin/
WORKDIR /smashing

RUN gem install bundler && \
    gem install smashing && \
    smashing new dashboard && \
    cd dashboard && \
    bundle && \
    \
    apt autoclean && \
    apt clean && \
    apt autoremove --purge && \
    rm -rf /tmp/* && \
    chmod +x /usr/bin/entrypoint.sh

EXPOSE 3030
ENTRYPOINT ["entrypoint.sh"]
