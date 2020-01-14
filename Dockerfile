FROM alpine:3.7

MAINTAINER vigneshnatarajan <vigneshnatarajan01@gmail.com>

WORKDIR /usr/apps/hello-docker/

RUN apk add --update bash

#RUN apk add nodejs

COPY common/stack-fix.c /lib/

RUN set -ex \
    && apk add --no-cache  --virtual .build-deps build-base \
    && gcc  -shared -fPIC /lib/stack-fix.c -o /lib/stack-fix.so \
    && apk del .build-deps

ENV LD_PRELOAD /lib/stack-fix.so

RUN apk add --update nodejs nodejs-npm

#RUN ln -s /usr/bin/nodejs /usr/bin/node

RUN npm install -g http-server

ADD . /usr/apps/hello-docker/

ADD index.html /usr/apps/hello-docker/index.html

CMD ["http-server", "-s"]
