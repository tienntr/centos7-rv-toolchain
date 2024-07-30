FROM docker.io/ubuntu:24.04

COPY out/ubuntu/ /opt/riscv

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends \
        autoconf automake python3-dev python3-pip libmpc3 libmpfr6 libtool \
        libexpat1 git ninja-build cmake libglib2.0 \
        device-tree-compiler libslirp0 \
        libboost-regex1.83.0 libboost-system1.83.0 libsource-highlight4t64 \
        libgtk-3-0t64 libpixman-1-0 libsdl2-dev libvte-2.91-0 \
        patch make python3-venv python-is-python3 \
        wget python3-setuptools python3-tk python3-wheel xz-utils file libmagic1 \
        man-db \
    && rm -rf /var/lib/apt/lists/*
