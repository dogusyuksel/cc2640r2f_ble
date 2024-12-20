FROM ubuntu:22.04
ARG DEBIAN_FRONTEND=noninteractive

USER root

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y --no-install-recommends install \
        build-essential \
        git \
        git-core \
        git-lfs \
        python3-dbg \
        python3-dev \
        python3-pip \
        python3-pexpect \
        python3-git \
        python3-jinja2 \
        python3-subunit \
        vim \
        cmake \
        gcc-multilib \
        g++-multilib \
        software-properties-common \
        language-pack-en-base \
        wget \
        clang-format \
        unzip && \
    apt-get -y clean

RUN git config --global --add safe.directory /workspace

RUN cd / && mkdir thirdparty && \
    git clone https://github.com/dogusyuksel/embedded_linting.git /thirdparty/linting && \
    git clone https://github.com/STMicroelectronics/OpenOCD.git /thirdparty/openocd && \
    git clone https://github.com/dogusyuksel/ti_cc2640r2f_sdk.git /thirdparty/ti_cc2640r2f_sdk

CMD ["/bin/bash"]

WORKDIR /workspace/
