src/spmvGPU.cu(28): warning #177-D: variable "globalThread" was declared but never referenced
      int globalThread = blockIdx.x * blockDim.x + threadIdx.x;
          ^

Remark: The warnings can be suppressed with "-diag-suppress <warning-number>"

src/spmvGPU.cu(43): warning #177-D: variable "offset" was declared but never referenced
   int j,offset;
         ^

[edu02:189920:0:189920] Caught signal 7 (Bus error: nonexistent physical address)
[edu02:189921:0:189921] Caught signal 7 (Bus error: nonexistent physical address)
[edu02:189922:0:189922] Caught signal 7 (Bus error: nonexistent physical address)
[edu02:189919:0:189919] Caught signal 7 (Bus error: nonexistent physical address)
--------------------------------------------------------------------------
Primary job  terminated normally, but 1 process returned
a non-zero exit code. Per user-direction, the job has been aborted.
--------------------------------------------------------------------------
--------------------------------------------------------------------------
mpirun noticed that process rank 0 with PID 189919 on node edu02 exited on signal 7 (Bus error).
--------------------------------------------------------------------------
