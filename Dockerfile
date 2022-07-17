FROM debian:stable-slim

EXPOSE 8000

# Your Property
ARG USER=user
ARG USER_ID=1000
ARG GROUP_ID=1000

RUN apt-get update && apt-get install -y --no-install-recommends wget ca-certificates sudo \
    && wget -O- https://aka.ms/install-vscode-server/setup.sh | sh \
    && apt-get remove -y --autoremove --purge wget && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && groupadd -g ${GROUP_ID} ${USER} \
    && useradd -u ${USER_ID} -m -s /bin/bash -g ${USER} -G sudo ${USER} \
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers 

USER ${USER}

CMD [ "code-server","serve-local","--accept-server-license-terms","--disable-telemetry","--host","0.0.0.0" ]