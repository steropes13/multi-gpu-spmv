#ifndef __GPUSPMV__CUH
#define __GPUSPMV__CUH
#include <cusparse.h> 
#include <stdio.h>
#include <stdlib.h> 

__global__ 
void computeSpmvCSRWarpGPU(float * res, int * rows_array, int * cols_array, float * vals_array , float * vect, int nnz, int rows, int * row_ptr);

__global__ void gatherXValues(float *toSend, float *xLocal, int *colsToServe, int n, int commSize);

__global__ void scatterXValues(float *xForKernel, float *xGhost, int *flatRequest, int n); 

#endif


