.PHONY: all build-image

all:
	mkdir -p gcc
	podman run -it --rm --net host --log-driver none -v $$PWD/riscv-gnu-toolchain:/ext_src:O -v $$PWD/gcc:/opt/riscv tienntran/centos7-rv-toolchain-build-env

build-image:
	$(MAKE) -C container