FROM ubuntu:20.04

RUN apt-get update && \
  apt-get install -y curl && \
  curl https://github.com/bazelbuild/bazel-watcher/releases/download/v0.15.10/ibazel_linux_amd64 -o /ibazel -L && \
  chmod +x /ibazel


