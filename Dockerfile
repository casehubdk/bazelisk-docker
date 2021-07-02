FROM ubuntu:20.04

RUN apt-get update && \
  apt-get install -y curl && \
  curl https://github.com/bazelbuild/bazelisk/releases/download/v1.9.0/bazelisk-linux-amd64 -o /bin/bazel -L && \
  chmod +x /bin/bazel

# Prepopulate cache
RUN USE_BAZEL_VERSION=3.5.0 bazel


