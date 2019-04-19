FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
    curl \
    nginx \
    supervisor \
    wget

RUN cd /tmp && wget https://dl.google.com/go/go1.12.linux-amd64.tar.gz && \
    tar -xvf go1.12.linux-amd64.tar.gz && \
    mv go /usr/local && \
    ln -sf /usr/local/go/bin/go /usr/bin/go

ENV GOROOT=/usr/local/go
ENV GOPATH=/go

WORKDIR /go

RUN mkdir /go/bin && curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

COPY conf/site.conf /etc/nginx/conf.d/default.conf
COPY conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord"]