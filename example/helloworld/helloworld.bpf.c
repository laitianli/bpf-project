#include <linux/bpf.h>
#include <bpf/bpf_helpers.h>

/* /sys/kernel/debug/tracing/events/syscalls */
//SEC("tracepoint/syscalls/sys_enter_open")
//SEC("kprobe/__get_xps_queue_idx")
SEC("kprobe/kfree_skb")
int bpf_prog(void *ctx) {
  char msg[] = "kfree_skb Hello, World!";
  bpf_printk("invoke bpf_prog: %s\n", msg);
  return 0;
}

char LICENSE[] SEC("license") = "Dual BSD/GPL";