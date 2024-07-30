.PHONY: all build-image

all:
	mkdir -p out
	podman run -it --rm --net host --log-driver none -v $$PWD/riscv-gnu-toolchain:/ext_src:O -v $$PWD/out:/opt/riscv tienntran/centos7-rv-toolchain-build-env

build-image:
	$(MAKE) -C build-env