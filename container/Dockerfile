FROM docker.io/centos:7

COPY fix_repos.sh .

# qemu-system requires pixman-devel.
# Install python-devel to support python in gdb.

RUN ./fix_repos.sh && \
    yum -y update && \
    yum -y install \
        centos-release-scl \
        https://repo.ius.io/ius-release-el7.rpm \
        https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    ./fix_repos.sh && \
    yum -y install \
        autoconf automake python3 libmpc-devel mpfr-devel gmp-devel gawk \
        bison flex texinfo patchutils zlib-devel expat-devel \
        pixman-devel python-devel \
        ninja-build dtc glib2-devel \
        devtoolset-11-gcc devtoolset-11-gcc-c++ devtoolset-11-make \
        git236-core rh-python38 && \
    curl -Lo cmake.sh https://github.com/Kitware/CMake/releases/download/v3.29.6/cmake-3.29.6-linux-x86_64.sh && \
    chmod +x cmake.sh && \
    ./cmake.sh --skip-license --prefix=/usr/local && \
    rm -f cmake.sh fix_repos.sh && \
    yum clean all && \
    rm -rf /var/cache/yum

COPY entrypoint.sh build_script.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/build_script.sh"]

ENV SRC=/ext_src PREFIX=/opt/riscv
