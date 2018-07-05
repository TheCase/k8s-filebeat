FROM alpine:3.7

RUN apk update && apk add supervisor ca-certificates wget tar && update-ca-certificates
RUN wget "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.21-r2/glibc-2.21-r2.apk" \
         "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.21-r2/glibc-bin-2.21-r2.apk" && \
         apk add --allow-untrusted glibc-2.21-r2.apk glibc-bin-2.21-r2.apk && \
         /usr/glibc/usr/bin/ldconfig /lib /usr/glibc/usr/lib && \
        rm -rf *.apk

ENV DOCKERGEN_VERSION=0.7.3
RUN wget https://github.com/jwilder/docker-gen/releases/download/${DOCKERGEN_VERSION}/docker-gen-linux-amd64-${DOCKERGEN_VERSION}.tar.gz -O- | \
    tar xvz -C /usr/local/bin/ docker-gen

ENV FILEBEAT_VERSION=6.3.1
RUN wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz -O- | \
    tar xvz -C /usr/local/bin/ --strip-components 1 filebeat-${FILEBEAT_VERSION}-linux-x86_64/filebeat

ADD supervisord.conf /etc/supervisord.conf

RUN mkdir /etc/beats

CMD ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]

