src/spmvGPU.cu(28): warning #177-D: variable "globalThread" was declared but never referenced
      int globalThread = blockIdx.x * blockDim.x + threadIdx.x;
          ^

Remark: The warnings can be suppressed with "-diag-suppress <warning-number>"

src/spmvGPU.cu(43): warning #177-D: variable "offset" was declared but never referenced
   int j,offset;
         ^

[edu02:194356:0:194356] Caught signal 7 (Bus error: nonexistent physical address)
[edu02:194357:0:194357] Caught signal 7 (Bus error: nonexistent physical address)
[edu02:194358:0:194358] Caught signal 7 (Bus error: nonexistent physical address)
[edu02:194359:0:194359] Caught signal 7 (Bus error: nonexistent physical address)
--------------------------------------------------------------------------
Primary job  terminated normally, but 1 process returned
a non-zero exit code. Per user-direction, the job has been aborted.
--------------------------------------------------------------------------
--------------------------------------------------------------------------
mpirun noticed that process rank 2 with PID 194358 on node edu02 exited on signal 7 (Bus error).
--------------------------------------------------------------------------
