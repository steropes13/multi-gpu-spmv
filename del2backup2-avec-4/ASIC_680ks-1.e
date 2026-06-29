src/spmvGPU.cu(28): warning #177-D: variable "globalThread" was declared but never referenced
      int globalThread = blockIdx.x * blockDim.x + threadIdx.x;
          ^

Remark: The warnings can be suppressed with "-diag-suppress <warning-number>"

src/spmvGPU.cu(43): warning #177-D: variable "offset" was declared but never referenced
   int j,offset;
         ^

[edu02:188335:0:188335] Caught signal 7 (Bus error: nonexistent physical address)
[edu02:188336:0:188336] Caught signal 7 (Bus error: nonexistent physical address)
[edu02:188337:0:188337] Caught signal 7 (Bus error: nonexistent physical address)
[edu02:188334:0:188334] Caught signal 7 (Bus error: nonexistent physical address)
--------------------------------------------------------------------------
Primary job  terminated normally, but 1 process returned
a non-zero exit code. Per user-direction, the job has been aborted.
--------------------------------------------------------------------------
--------------------------------------------------------------------------
mpirun noticed that process rank 0 with PID 188334 on node edu02 exited on signal 7 (Bus error).
--------------------------------------------------------------------------
