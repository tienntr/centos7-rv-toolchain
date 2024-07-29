FROM docker.io/ubuntu:24.04

# The tests take so long to run so we skip them.
# spike needs libboost-system-dev to enable socket interface. It also needs
# libboost-regex-dev for unknown additional features.
# Install libncurses-dev and libsource-highlight-dev to enable TUI and syntax-coloring in GDB.
# Install python3-dev (recommended package for python3) to enable Python support in GDB.
# Install libpixman-1-dev to build qemu-system.
# Install libgtk-3-dev, libsdl2-dev and libvte-dev to enable QEMU GUI.

RUN dpkg --add-architecture i386 && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y autoconf automake autotools-dev curl python3 python3-pip libmpc-dev libmpfr-dev \
        libgmp-dev gawk build-essential bison flex texinfo gperf libtool \
        patchutils bc zlib1g-dev libexpat-dev git ninja-build cmake libglib2.0-dev expect \
        device-tree-compiler python3-pyelftools libslirp-dev && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends \
        libboost-regex-dev libboost-system-dev libncurses-dev libsource-highlight-dev \
        libgtk-3-dev libpixman-1-dev libsdl2-dev libvte-dev

COPY build_script.sh /
CMD ["/build_script.sh"]

ENV SRC=/ext_src PREFIX=/opt/riscv
