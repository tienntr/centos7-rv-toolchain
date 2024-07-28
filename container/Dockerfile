FROM docker.io/centos:7

COPY fix_repos.sh .

# Running test suite requires `expect` and `pyelftools` (installed with correct pip
# or with package manager, depends on the python binary used when running the tests).
# The tests take so long to run so we skip them.
# spike needs boost-devel to enable socket interface, but CentOS 7 boost-devel casuses
# compile error.
# Install ncurses-devel to enable TUI in GDB.
# For some reason we can't enable Python support in GDB even if python[3]-devel is
# installed and GDB is build with system's python or rh-python38.
# Install pixman-devel to build qemu-system.
# Install gtk3-devel, SDL2-devel and vte291-devel to enable QEMU GUI.

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
        ninja-build dtc glib2-devel \
        devtoolset-11-gcc devtoolset-11-gcc-c++ devtoolset-11-make \
        git236-core rh-python38 \
        gtk3-devel ncurses-devel pixman-devel SDL2-devel vte291-devel && \
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
