src/spmvGPU.cu(28): warning #177-D: variable "globalThread" was declared but never referenced
      int globalThread = blockIdx.x * blockDim.x + threadIdx.x;
          ^

Remark: The warnings can be suppressed with "-diag-suppress <warning-number>"

src/spmvGPU.cu(43): warning #177-D: variable "offset" was declared but never referenced
   int j,offset;
         ^

[edu02:192145:0:192145] Caught signal 7 (Bus error: nonexistent physical address)
[edu02:192146:0:192146] Caught signal 7 (Bus error: nonexistent physical address)
[edu02:192147:0:192147] Caught signal 7 (Bus error: nonexistent physical address)
[edu02:192148:0:192148] Caught signal 7 (Bus error: nonexistent physical address)
==== backtrace (tid: 192145) ====
==== backtrace (tid: 192146) ====
 0 0x000000000003e730 __GI___sigaction()  :0
 1 0x00000000000295d0 __libc_start_call_main()  ???:0
 2 0x0000000000029680 __libc_start_main_alias_2()  :0
=================================
==== backtrace (tid: 192147) ====
 0 0x000000000003e730 __GI___sigaction()  :0
 1 0x00000000000295d0 __libc_start_call_main()  ???:0
 2 0x0000000000029680 __libc_start_main_alias_2()  :0
=================================
==== backtrace (tid: 192148) ====
 0 0x000000000003e730 __GI___sigaction()  :0
 1 0x00000000000295d0 __libc_start_call_main()  ???:0
 2 0x0000000000029680 __libc_start_main_alias_2()  :0
=================================
[edu02:192147] *** Process received signal ***
[edu02:192147] Signal: Bus error (7)
[edu02:192147] Signal code:  (-6)
[edu02:192147] Failing at address: 0x448680002ee93
[edu02:192146] *** Process received signal ***
[edu02:192146] Signal: Bus error (7)
[edu02:192146] Signal code:  (-6)
[edu02:192146] Failing at address: 0x448680002ee92
[edu02:192148] *** Process received signal ***
[edu02:192148] Signal: Bus error (7)
[edu02:192148] Signal code:  (-6)
[edu02:192148] Failing at address: 0x448680002ee94
[edu02:192146] [ 0] [edu02:192148] [ 0] [edu02:192147] [ 0]  0 0x000000000003e730 __GI___sigaction()  :0
/lib64/libc.so.6(+0x3e730)[0x7f52fa03e730]
[edu02:192147] [ 1] /lib64/libc.so.6(+0x3e730)[0x7f68d4a3e730]
[edu02:192146] [ 1] /home/titienjacques.marie/del-2/multi-gpu-spmv/bin/main[0x473680]
[edu02:192146] [ 2] /lib64/libc.so.6(+0x3e730)[0x7f233623e730]
[edu02:192148] [ 1] /home/titienjacques.marie/del-2/multi-gpu-spmv/bin/main[0x473680]
[edu02:192148] [ 2] /home/titienjacques.marie/del-2/multi-gpu-spmv/bin/main[0x405b58]
[edu02:192148] /home/titienjacques.marie/del-2/multi-gpu-spmv/bin/main[0x473680]
[edu02:192147] [ 2] /home/titienjacques.marie/del-2/multi-gpu-spmv/bin/main[0x405b58]
[edu02:192147] [ 3] /home/titienjacques.marie/del-2/multi-gpu-spmv/bin/main[0x405b58]
[edu02:192146] [ 3] /lib64/libc.so.6(+0x295d0)[0x7f52fa0295d0]
[edu02:192147] [ 4] [ 3] /lib64/libc.so.6(+0x295d0)[0x7f68d4a295d0]
[edu02:192146] /lib64/libc.so.6(+0x295d0)[0x7f23362295d0]
[edu02:192148] [ 4] [ 4] /lib64/libc.so.6(__libc_start_main+0x80)[0x7f52fa029680]
[edu02:192147] [ 5] /home/titienjacques.marie/del-2/multi-gpu-spmv/bin/main[0x404d35]
[edu02:192147] *** End of error message ***
/lib64/libc.so.6(__libc_start_main+0x80)[0x7f68d4a29680]
[edu02:192146] [ 5] /home/titienjacques.marie/del-2/multi-gpu-spmv/bin/main[0x404d35]
/lib64/libc.so.6(__libc_start_main+0x80)[0x7f2336229680]
[edu02:192148] [ 5] /home/titienjacques.marie/del-2/multi-gpu-spmv/bin/main[0x404d35]
[edu02:192148] *** End of error message ***
[edu02:192146] *** End of error message ***
 1 0x00000000000295d0 __libc_start_call_main()  ???:0
 2 0x0000000000029680 __libc_start_main_alias_2()  :0
=================================
[edu02:192145] *** Process received signal ***
[edu02:192145] Signal: Bus error (7)
[edu02:192145] Signal code:  (-6)
[edu02:192145] Failing at address: 0x448680002ee91
[edu02:192145] [ 0] /lib64/libc.so.6(+0x3e730)[0x7f1c0f83e730]
[edu02:192145] [ 1] /home/titienjacques.marie/del-2/multi-gpu-spmv/bin/main[0x473680]
[edu02:192145] [ 2] /home/titienjacques.marie/del-2/multi-gpu-spmv/bin/main[0x405b58]
[edu02:192145] [ 3] /lib64/libc.so.6(+0x295d0)[0x7f1c0f8295d0]
[edu02:192145] [ 4] /lib64/libc.so.6(__libc_start_main+0x80)[0x7f1c0f829680]
[edu02:192145] [ 5] /home/titienjacques.marie/del-2/multi-gpu-spmv/bin/main[0x404d35]
[edu02:192145] *** End of error message ***
--------------------------------------------------------------------------
Primary job  terminated normally, but 1 process returned
a non-zero exit code. Per user-direction, the job has been aborted.
--------------------------------------------------------------------------
--------------------------------------------------------------------------
mpirun noticed that process rank 1 with PID 192146 on node edu02 exited on signal 7 (Bus error).
--------------------------------------------------------------------------
