src/spmvGPU.cu(28): warning #177-D: variable "globalThread" was declared but never referenced
      int globalThread = blockIdx.x * blockDim.x + threadIdx.x;
          ^

Remark: The warnings can be suppressed with "-diag-suppress <warning-number>"

src/spmvGPU.cu(43): warning #177-D: variable "offset" was declared but never referenced
   int j,offset;
         ^

[edu02:192938:0:192938] Caught signal 7 (Bus error: nonexistent physical address)
[edu02:192939:0:192939] Caught signal 7 (Bus error: nonexistent physical address)
[edu02:192937:0:192937] Caught signal 7 (Bus error: nonexistent physical address)
[edu02:192940:0:192940] Caught signal 7 (Bus error: nonexistent physical address)
==== backtrace (tid: 192937) ====
 0 0x000000000003e730 __GI___sigaction()  :0
 1 0x00000000000295d0 __libc_start_call_main()  ???:0
 2 0x0000000000029680 __libc_start_main_alias_2()  :0
=================================
==== backtrace (tid: 192938) ====
==== backtrace (tid: 192939) ====
 0 0x000000000003e730 __GI___sigaction()  :0
 1 0x00000000000295d0 __libc_start_call_main()  ???:0
 2 0x0000000000029680 __libc_start_main_alias_2()  :0
=================================
==== backtrace (tid: 192940) ====
 0 0x000000000003e730 __GI___sigaction()  :0
 1 0x00000000000295d0 __libc_start_call_main()  ???:0
 2 0x0000000000029680 __libc_start_main_alias_2()  :0
=================================
[edu02:192939] *** Process received signal ***
[edu02:192939] Signal: Bus error (7)
[edu02:192939] Signal code:  (-6)
[edu02:192939] Failing at address: 0x448680002f1ab
[edu02:192937] *** Process received signal ***
[edu02:192937] Signal: Bus error (7)
[edu02:192937] Signal code:  (-6)
[edu02:192937] Failing at address: 0x448680002f1a9
[edu02:192940] *** Process received signal ***
[edu02:192940] Signal: Bus error (7)
[edu02:192940] Signal code:  (-6)
[edu02:192940] Failing at address: 0x448680002f1ac
[edu02:192937] [ 0] [edu02:192940] [ 0] /lib64/libc.so.6(+0x3e730)[0x7f348ce3e730]
[edu02:192940] [ 1] /lib64/libc.so.6(+0x3e730)[0x7f580b23e730]
[edu02:192937] [ 1] /home/titienjacques.marie/del-2/multi-gpu-spmv/bin/main[0x473680]
[edu02:192937] [ 2] /home/titienjacques.marie/del-2/multi-gpu-spmv/bin/main[0x405b58]
[edu02:192937] [ 3] [edu02:192939] [ 0] /lib64/libc.so.6(+0x3e730)[0x7f56ffc3e730]
[edu02:192939] [ 1] /home/titienjacques.marie/del-2/multi-gpu-spmv/bin/main[0x473680]
[edu02:192939] [ 2] /home/titienjacques.marie/del-2/multi-gpu-spmv/bin/main[0x405b58]
[edu02:192939] [ 3] /home/titienjacques.marie/del-2/multi-gpu-spmv/bin/main[0x473680]
[edu02:192940] [ 2] /home/titienjacques.marie/del-2/multi-gpu-spmv/bin/main[0x405b58]
[edu02:192940] [ 3] /lib64/libc.so.6(+0x295d0)[0x7f580b2295d0]
[edu02:192937] [ 4] /lib64/libc.so.6(+0x295d0)[0x7f56ffc295d0]
[edu02:192939] [ 4] /lib64/libc.so.6(+0x295d0)[0x7f348ce295d0]
[edu02:192940] [ 4] /lib64/libc.so.6(__libc_start_main+0x80)[0x7f580b229680]
[edu02:192937] [ 5] /home/titienjacques.marie/del-2/multi-gpu-spmv/bin/main[0x404d35]
[edu02:192937] *** End of error message ***
/lib64/libc.so.6(__libc_start_main+0x80)[0x7f348ce29680]
[edu02:192940] [ 5] /lib64/libc.so.6(__libc_start_main+0x80)[0x7f56ffc29680]
[edu02:192939] [ 5] /home/titienjacques.marie/del-2/multi-gpu-spmv/bin/main[0x404d35]
/home/titienjacques.marie/del-2/multi-gpu-spmv/bin/main[0x404d35]
[edu02:192940] *** End of error message ***
[edu02:192939] *** End of error message ***
 0 0x000000000003e730 __GI___sigaction()  :0
 1 0x00000000000295d0 __libc_start_call_main()  ???:0
 2 0x0000000000029680 __libc_start_main_alias_2()  :0
=================================
[edu02:192938] *** Process received signal ***
[edu02:192938] Signal: Bus error (7)
[edu02:192938] Signal code:  (-6)
[edu02:192938] Failing at address: 0x448680002f1aa
[edu02:192938] [ 0] /lib64/libc.so.6(+0x3e730)[0x7f3e3cc3e730]
[edu02:192938] [ 1] /home/titienjacques.marie/del-2/multi-gpu-spmv/bin/main[0x473680]
[edu02:192938] [ 2] /home/titienjacques.marie/del-2/multi-gpu-spmv/bin/main[0x405b58]
[edu02:192938] [ 3] /lib64/libc.so.6(+0x295d0)[0x7f3e3cc295d0]
[edu02:192938] [ 4] /lib64/libc.so.6(__libc_start_main+0x80)[0x7f3e3cc29680]
[edu02:192938] [ 5] /home/titienjacques.marie/del-2/multi-gpu-spmv/bin/main[0x404d35]
[edu02:192938] *** End of error message ***
--------------------------------------------------------------------------
Primary job  terminated normally, but 1 process returned
a non-zero exit code. Per user-direction, the job has been aborted.
--------------------------------------------------------------------------
--------------------------------------------------------------------------
mpirun noticed that process rank 1 with PID 192938 on node edu02 exited on signal 7 (Bus error).
--------------------------------------------------------------------------
