FROM debian:stable-slim

EXPOSE 8000

# Your Property
ARG USER=user
ARG USER_ID=1000
ARG GROUP_ID=1000

ENV DONT_PROMPT_WSL_INSTALL=1

RUN apt-get update && apt-get install -y --no-install-recommends curl gpg apt-transport-https ca-certificates sudo \
    && curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg \
    && install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/ \
    && echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list \
    && apt-get update && apt-get install -y --no-install-recommends code \
    && apt-get remove -y --autoremove --purge curl gpg apt-transport-https \
    && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && groupadd -g ${GROUP_ID} ${USER} \
    && useradd -u ${USER_ID} -m -s /bin/bash -g ${USER} -G sudo ${USER} \
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER ${USER}

CMD [ "code","serve-web","--host","0.0.0.0" ]