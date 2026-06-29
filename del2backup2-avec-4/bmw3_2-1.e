src/spmvGPU.cu(28): warning #177-D: variable "globalThread" was declared but never referenced
      int globalThread = blockIdx.x * blockDim.x + threadIdx.x;
          ^

Remark: The warnings can be suppressed with "-diag-suppress <warning-number>"

src/spmvGPU.cu(43): warning #177-D: variable "offset" was declared but never referenced
   int j,offset;
         ^

[edu02:189462:0:189462] Caught signal 7 (Bus error: nonexistent physical address)
[edu02:189464:0:189464] Caught signal 7 (Bus error: nonexistent physical address)
[edu02:189458:0:189458] Caught signal 7 (Bus error: nonexistent physical address)
[edu02:189461:0:189461] Caught signal 7 (Bus error: nonexistent physical address)
--------------------------------------------------------------------------
Primary job  terminated normally, but 1 process returned
a non-zero exit code. Per user-direction, the job has been aborted.
--------------------------------------------------------------------------
--------------------------------------------------------------------------
mpirun noticed that process rank 3 with PID 189464 on node edu02 exited on signal 7 (Bus error).
--------------------------------------------------------------------------
