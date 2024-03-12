ROOT_DIR=$(shell pwd)
CLANG ?= /opt/clang+llvm-10.0.0-x86_64-linux-gnu-ubuntu-18.04/bin/clang

ARCH := $(shell uname -m | sed 's/x86_64/x86/' | sed 's/aarch64/arm64/' | sed 's/ppc64le/powerpc/' | sed 's/mips.*/mips/')
BPFTOOL ?= $(ROOT_DIR)/../../bpftool/src/bpftool

LIBBPF_TOP = $(ROOT_DIR)/../../libbpf/install_bin

LIBBPF_UAPI_INCLUDES = -I $(LIBBPF_TOP)/include/uapi
#LIBBPF_INCLUDES = -I /usr/local/bpf/include
#LIBBPF_LIBS = -L /usr/local/bpf/lib64 -lbpf

LIBBPF_INCLUDES = -I $(LIBBPF_TOP)/include
LIBBPF_LIBS = -L $(LIBBPF_TOP)/lib64 -lbpf
INCLUDES=$(LIBBPF_UAPI_INCLUDES) $(LIBBPF_INCLUDES)

CLANG_BPF_SYS_INCLUDES = $(shell $(CLANG) -v -E - </dev/null 2>&1 | sed -n '/<...> search starts here:/,/End of search list./{ s| \(/.*\)|-idirafter \1|p }')

all: build

build: kfree_skb

kfree_skb.bpf.o: kfree_skb.bpf.c
	$(CLANG)  -g -O2 -target bpf -D__TARGET_ARCH_$(ARCH) $(INCLUDES) $(CLANG_BPF_SYS_INCLUDES) -c kfree_skb.bpf.c 

kfree_skb.skel.h: kfree_skb.bpf.o
	$(BPFTOOL) gen skeleton kfree_skb.bpf.o > kfree_skb.skel.h

kfree_skb: kfree_skb.skel.h kfree_skb.c
	$(CLANG)  -g -O2 -D__TARGET_ARCH_$(ARCH) $(INCLUDES) $(CLANG_BPF_SYS_INCLUDES) -o kfree_skb kfree_skb.c $(LIBBPF_LIBS) -lbpf -lelf -lz


clean:
	rm -rf kfree_skb.skel.h kfree_skb.bpf.o kfree_skb
