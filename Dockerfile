FROM ubuntu:20.04

RUN apt-get update && \
  apt-get install -y curl build-essential && \
  curl https://github.com/bazelbuild/bazelisk/releases/download/v1.9.0/bazelisk-linux-amd64 -o /bin/bazel -L && \
  chmod +x /bin/bazel

RUN curl https://git.io/coursier-cli-"$(uname | tr LD ld)" -o /bin/coursier -L && \
  chmod +x /bin/coursier

RUN apt-get install -y openjdk-8-jdk-headless

# Prepopulate cache
RUN USE_BAZEL_VERSION=3.5.0 bazel

RUN mkdir /workspace

WORKDIR /workspace

ENTRYPOINT ["/bin/bazel"]
