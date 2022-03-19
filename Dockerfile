FROM node:16.14.0-buster

LABEL version="0.0.1"
LABEL repository="https://github.com/qualle-admin/zapier-action"
LABEL homepage="https://github.com/qualle-admin/zapier-action"
LABEL maintainer="Qualle <admin@qualle.co>"

LABEL com.github.actions.name="GitHub Action for Zapier"
LABEL com.github.actions.description="Wraps the zapier-platform-cli CLI to enable common commands."
LABEL com.github.actions.icon="package"
LABEL com.github.actions.color="gray-dark"

RUN wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add -
RUN apt update && apt install -y software-properties-common
RUN add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/
RUN apt update && apt install -y jq adoptopenjdk-8-hotspot-jre git && apt autoremove --purge -y && apt clean -y

RUN npm i -g npm@8.5.5
RUN npm i -g zapier-platform-cli@11.3.2

WORKDIR /app

COPY LICENSE README.md /app/
COPY entrypoint.sh package.json /app/

RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["--help"]
