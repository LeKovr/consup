
# Get local standalone compiled copy

DOCKER_BUCKET=get.docker.com
DOCKER_VERSION=1.10.3
DOCKER_SHA256=d0df512afa109006a450f41873634951e19ddabf8c7bd419caeb5a526032d86d

# todo: https://get.docker.com/builds/Linux/x86_64/docker-1.12.2.tgz

curl -fSL "https://${DOCKER_BUCKET}/builds/Linux/x86_64/docker-$DOCKER_VERSION" -o /usr/local/bin/docker \
    && echo "${DOCKER_SHA256}  /usr/local/bin/docker" | sha256sum -c - \
    && chmod +x /usr/local/bin/docker