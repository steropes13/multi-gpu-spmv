src/spmvGPU.cu(28): warning #177-D: variable "globalThread" was declared but never referenced
      int globalThread = blockIdx.x * blockDim.x + threadIdx.x;
          ^

Remark: The warnings can be suppressed with "-diag-suppress <warning-number>"

src/spmvGPU.cu(43): warning #177-D: variable "offset" was declared but never referenced
   int j,offset;
         ^

[edu02:190318:0:190318] Caught signal 7 (Bus error: nonexistent physical address)
[edu02:190319:0:190319] Caught signal 7 (Bus error: nonexistent physical address)
[edu02:190320:0:190320] Caught signal 7 (Bus error: nonexistent physical address)
[edu02:190317:0:190317] Caught signal 7 (Bus error: nonexistent physical address)
==== backtrace (tid: 190318) ====
 0 0x000000000003e730 __GI___sigaction()  :0
 1 0x00000000000295d0 __libc_start_call_main()  ???:0
 2 0x0000000000029680 __libc_start_main_alias_2()  :0
=================================
==== backtrace (tid: 190320) ====
 0 0x000000000003e730 __GI___sigaction()  :0
 1 0x00000000000295d0 __libc_start_call_main()  ???:0
==== backtrace (tid: 190319) ====
 0 0x000000000003e730 __GI___sigaction()  :0
 1 0x00000000000295d0 __libc_start_call_main()  ???:0
 2 0x0000000000029680 __libc_start_main_alias_2()  :0
 2 0x0000000000029680 __libc_start_main_alias_2()  :0
=================================
=================================
==== backtrace (tid: 190317) ====
 0 0x000000000003e730 __GI___sigaction()  :0
 1 0x00000000000295d0 __libc_start_call_main()  ???:0
 2 0x0000000000029680 __libc_start_main_alias_2()  :0
=================================
[edu02:190320] *** Process received signal ***
[edu02:190319] *** Process received signal ***
[edu02:190319] Signal: Bus error (7)
[edu02:190319] Signal code:  (-6)
[edu02:190319] Failing at address: 0x448680002e76f
[edu02:190318] *** Process received signal ***
[edu02:190317] *** Process received signal ***
[edu02:190317] Signal: Bus error (7)
[edu02:190317] Signal code:  (-6)
[edu02:190317] Failing at address: 0x448680002e76d
[edu02:190318] Signal: Bus error (7)
[edu02:190318] Signal code:  (-6)
[edu02:190318] Failing at address: 0x448680002e76e
[edu02:190318] [ 0] [edu02:190319] [ 0] [edu02:190317] [ 0] /lib64/libc.so.6(+0x3e730)[0x7fc8a023e730]
[edu02:190319] [ 1] /lib64/libc.so.6(+0x3e730)[0x7f0bdf43e730]
[edu02:190317] [ 1] /home/titienjacques.marie/del-2/multi-gpu-spmv/bin/main[0x473680]
/home/titienjacques.marie/del-2/multi-gpu-spmv/bin/main[0x473680]
[edu02:190319] [ 2] /home/titienjacques.marie/del-2/multi-gpu-spmv/bin/main[0x405b58]
[edu02:190319] /lib64/libc.so.6(+0x3e730)[0x7f199ec3e730]
[edu02:190318] [ 1] /home/titienjacques.marie/del-2/multi-gpu-spmv/bin/main[0x473680]
[edu02:190318] [ 2] [edu02:190317] [ 2] /home/titienjacques.marie/del-2/multi-gpu-spmv/bin/main[0x405b58]
[edu02:190317] [ 3] /home/titienjacques.marie/del-2/multi-gpu-spmv/bin/main[0x405b58]
[edu02:190318] [ 3] [ 3] /lib64/libc.so.6(+0x295d0)[0x7fc8a02295d0]
[edu02:190319] [ 4] /lib64/libc.so.6(+0x295d0)[0x7f199ec295d0]
[edu02:190318] [ 4] /lib64/libc.so.6(+0x295d0)[0x7f0bdf4295d0]
[edu02:190317] [ 4] /lib64/libc.so.6(__libc_start_main+0x80)[0x7fc8a0229680]
[edu02:190319] [ 5] /home/titienjacques.marie/del-2/multi-gpu-spmv/bin/main[0x404d35]
[edu02:190319] *** End of error message ***
/lib64/libc.so.6(__libc_start_main+0x80)[0x7f0bdf429680]
[edu02:190317] [ 5] /home/titienjacques.marie/del-2/multi-gpu-spmv/bin/main[0x404d35]
[edu02:190317] *** End of error message ***
[edu02:190320] Signal: Bus error (7)
[edu02:190320] Signal code:  (-6)
[edu02:190320] Failing at address: 0x448680002e770
/lib64/libc.so.6(__libc_start_main+0x80)[0x7f199ec29680]
[edu02:190320] [ 0] /lib64/libc.so.6(+0x3e730)[0x7fb05263e730]
[edu02:190318] [ 5] /home/titienjacques.marie/del-2/multi-gpu-spmv/bin/main[0x404d35]
[edu02:190318] *** End of error message ***
[edu02:190320] [ 1] /home/titienjacques.marie/del-2/multi-gpu-spmv/bin/main[0x473680]
[edu02:190320] [ 2] /home/titienjacques.marie/del-2/multi-gpu-spmv/bin/main[0x405b58]
[edu02:190320] [ 3] /lib64/libc.so.6(+0x295d0)[0x7fb0526295d0]
[edu02:190320] [ 4] /lib64/libc.so.6(__libc_start_main+0x80)[0x7fb052629680]
[edu02:190320] [ 5] /home/titienjacques.marie/del-2/multi-gpu-spmv/bin/main[0x404d35]
[edu02:190320] *** End of error message ***
--------------------------------------------------------------------------
Primary job  terminated normally, but 1 process returned
a non-zero exit code. Per user-direction, the job has been aborted.
--------------------------------------------------------------------------
--------------------------------------------------------------------------
mpirun noticed that process rank 3 with PID 190320 on node edu02 exited on signal 7 (Bus error).
--------------------------------------------------------------------------
