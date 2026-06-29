src/spmvGPU.cu(28): warning #177-D: variable "globalThread" was declared but never referenced
      int globalThread = blockIdx.x * blockDim.x + threadIdx.x;
          ^

Remark: The warnings can be suppressed with "-diag-suppress <warning-number>"

src/spmvGPU.cu(43): warning #177-D: variable "offset" was declared but never referenced
   int j,offset;
         ^

[edu02:193957:0:193957] Caught signal 7 (Bus error: nonexistent physical address)
[edu02:193958:0:193958] Caught signal 7 (Bus error: nonexistent physical address)
[edu02:193959:0:193959] Caught signal 7 (Bus error: nonexistent physical address)
[edu02:193960:0:193960] Caught signal 7 (Bus error: nonexistent physical address)
--------------------------------------------------------------------------
Primary job  terminated normally, but 1 process returned
a non-zero exit code. Per user-direction, the job has been aborted.
--------------------------------------------------------------------------
--------------------------------------------------------------------------
mpirun noticed that process rank 1 with PID 193958 on node edu02 exited on signal 7 (Bus error).
--------------------------------------------------------------------------
