FROM alpine:latest AS Secret

ARG USER=user
ARG PASSWORD=Passw0rd!

RUN apk update && apk add --no-cache apache2-utils \
    && echo ${PASSWORD} | htpasswd -ic .htpasswd ${USER}

FROM nginx:alpine AS Proxy

EXPOSE 80

ENV vscode="http://vscode-server:8000"
ENV vscode_map="/"

COPY --from=Secret .htpasswd /etc/nginx/.htpasswd

COPY ./default.conf.template /etc/nginx/templates/default.conf.template