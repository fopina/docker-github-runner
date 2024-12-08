FROM ghcr.io/actions/actions-runner:2.321.0

ENV RUNNER_NAME=""
ENV RUNNER_WORK_DIRECTORY="_work"
ENV RUNNER_TOKEN=""
ENV RUNNER_REPOSITORY_URL=""
ENV RUNNER_LABELS=""
ENV RUNNER_ALLOW_RUNASROOT=true
ENV GITHUB_ACCESS_TOKEN=""
ENV AGENT_TOOLSDIRECTORY=/opt/hostedtoolcache

USER root

# Labels.
LABEL maintainer="me@tcardonne.fr" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.name="tcardonne/github-runner" \
    org.label-schema.description="Dockerized GitHub Actions runner." \
    org.label-schema.url="https://github.com/tcardonne/docker-github-runner" \
    org.label-schema.vcs-url="https://github.com/tcardonne/docker-github-runner" \
    org.label-schema.vendor="Thomas Cardonne" \
    org.label-schema.docker.cmd="docker run -it tcardonne/github-runner:latest" \
    org.label-schema.runner.version="${GH_RUNNER_VERSION}" \
    org.label-schema.compose.version="${DOCKER_COMPOSE_VERSION}"

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
 && apt-get install -y --no-install-recommends \
        docker-compose-v2 \
 && rm -rf /var/lib/apt/lists/* && \
    apt-get clean

RUN mkdir -p /home/runner ${AGENT_TOOLSDIRECTORY}

WORKDIR /home/runner

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER runner

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/home/runner/bin/runsvc.sh"]
