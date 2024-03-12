ROOT_DIR=$(shell pwd)

sub_dir=helloworld kfree_skb

all:
	@for sub in ${sub_dir}; \
	do \
		echo "dir_name=$$sub"; \
		make -C ${ROOT_DIR}/$$sub; \
	done 
clean:
	@for sub in ${sub_dir}; \
	do \
		echo "dir_name=$$sub"; \
		make -C ${ROOT_DIR}/$$sub clean; \
	done 
