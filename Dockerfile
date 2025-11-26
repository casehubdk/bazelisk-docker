FROM ubuntu:20.04

RUN apt-get update && \
  apt-get install -y curl build-essential git && \
  curl https://github.com/bazelbuild/bazelisk/releases/download/v1.9.0/bazelisk-linux-amd64 -o /bin/bazel -L && \
  chmod +x /bin/bazel 

RUN curl https://git.io/coursier-cli-"$(uname | tr LD ld)" -o /bin/coursier -L && \
  chmod +x /bin/coursier

RUN apt-get install -y openjdk-8-jdk-headless unzip

# Prepopulate cache
RUN USE_BAZEL_VERSION=3.5.0 bazel

RUN \
   apt-get -y update && \
   apt-get -y install ca-certificates curl docker.io && \
   rm -rf /var/lib/apt/lists/* && \
   curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
   chmod +x /usr/local/bin/docker-compose

RUN coursier install scalafmt && \
    ln ~/.local/share/coursier/bin/scalafmt /bin/scalafmt && \
    scalafmt --version

RUN curl -Os https://uploader.codecov.io/latest/linux/codecov && \
    chmod +x codecov && \
    mv codecov /bin/codecov && \
    codecov -h

RUN mkdir /workspace

WORKDIR /workspace

ENTRYPOINT ["/bin/bazel"]
