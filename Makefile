
ROOT_DIR=$(shell pwd)
LIBBPF_DIR=$(ROOT_DIR)/libbpf
BPFTOOL_DIR=$(ROOT_DIR)/bpftool
EXAMPLE_DIR=$(ROOT_DIR)/example

all: libbpf bpftool example

#https://gitee.com/laitianli/libbpf_1.git
libbpf:
	echo "LIBBPF_DIR=$(LIBBPF_DIR)"
	cd $(LIBBPF_DIR)/src && NO_PKG_CONFIG=1 make
	cd $(LIBBPF_DIR)/src && BUILD_STATIC_ONYL=1 NO_PKG_CONFIG=1 PREFIX=$(pwd)/../install_bin/ make install

#https://gitee.com/laitianli/bpftool.git
bpftool:
	cd $(BPFTOOL_DIR)/src && make

example:
	make -C $(EXAMPLE_DIR) 

libbpf_clean:
	cd $(LIBBPF_DIR)/src && make clean

bpftoole_clean:
	cd $(BPFTOOL_DIR)/src && make clean

example_clean:
	make -C $(EXAMPLE_DIR) clean


clean: example_clean bpftoole_clean libbpf_clean


.PHONY: libbpf bpftool example libbpf_clean bpftoole_clean example_clean clean
