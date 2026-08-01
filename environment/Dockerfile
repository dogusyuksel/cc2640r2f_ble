FROM ubuntu:22.04
ARG DEBIAN_FRONTEND=noninteractive

USER root

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y --no-install-recommends install \
        build-essential \
        cmake \
        gcc-multilib \
        g++-multilib \
        default-jre \
        default-jdk \
        python3 \
        unzip && \
    apt-get -y clean

CMD ["/bin/bash"]

WORKDIR /workspace/
