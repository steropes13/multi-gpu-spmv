#ifndef __GPUSPMV__CUH
#define __GPUSPMV__CUH
#include <cusparse.h> 
#include <stdio.h>
#include <stdlib.h> 
#include "../include/spmvGPU.cuh"



__global__  
void computeSpmvCSRWarpGPU(float * res, int * rows_array, int * cols_array, float * vals_array , float * vect, int nnz, int rows, int * row_ptr) {
    /*
    before, 1 thread -> the whole line 
	now, 32 threads -> the same line, perfect if the line is long 
	we use the shared memory and warp-per-row 
	each warp processes exatcly one matrix row
	partial sums are storedi in shared memory
	the version avoids __shfl_down_sync and relies on shared memory
	
	it stores one float per thread in the block	
	*/
	extern __shared__ float sharedArray[];
	
	// global thread id

	int tid = threadIdx.x; //thread index within the block
	int lane = tid & 31; //lane index inside the warp
    int globalThread = blockIdx.x * blockDim.x + threadIdx.x;
	
	//warp index inside the block
	int warpInBlock = tid >> 5; // local warp in block

	int warp_id = (blockIdx.x * (blockDim.x >> 5)) + warpInBlock;
	//global thread index 

	
	//each warp for one row 
	if (warp_id >= rows) return; //case of overlap
	
	
	int row = 0; 
	float sum = 0.0;
	int j,offset;

	//current CSR row inside this warp
	row = warp_id;
	
	//Accumulator for partial sum of this thread
	sum = 0.0f;
	// each lane processes part of row
	//each lane processes every 32nd element of the row, starting at its lane offset
	for (j = row_ptr[row] + lane;j < row_ptr[row + 1]; j += 32)
	{
		sum += vals_array[j] * vect[cols_array[j]];
	}

	//storage in the shared memory (1 value per warp) 
	sharedArray[warpInBlock * 32 + lane] = sum;
	

	// Synchronize to ensure all lanes wrote their partial results
	__syncthreads();


	// Tree reduction inside shared memory (warp-sized reduction)
    if (lane < 16) sharedArray[warpInBlock * 32 + lane] += sharedArray[warpInBlock * 32 + lane + 16];
    __syncthreads();

    if (lane < 8)  sharedArray[warpInBlock * 32 + lane] += sharedArray[warpInBlock * 32 + lane + 8];
    __syncthreads();

    if (lane < 4)  sharedArray[warpInBlock * 32 + lane] += sharedArray[warpInBlock * 32 + lane + 4];
    __syncthreads();

    if (lane < 2)  sharedArray[warpInBlock * 32 + lane] += sharedArray[warpInBlock * 32 + lane + 2];
    __syncthreads();
	
	//lane 0 completes reduction for the final reduction
    if (lane == 0) {
        sharedArray[warpInBlock * 32] += sharedArray[warpInBlock * 32 + 1];

		//writes final result for this row
        res[row] = sharedArray[warpInBlock * 32];
    }

}


#endif


__global__ void gatherXValues(float *toSend, float *xLocal, int *colsToServe, int n) {
    int k = blockIdx.x * blockDim.x + threadIdx.x;
    if (k < n) toSend[k] = xLocal[colsToServe[k]];
}

__global__ void scatterXValues(float *xForKernel, float *xGhost, int *flatRequest, int n) {
    int k = blockIdx.x * blockDim.x + threadIdx.x;
    if (k < n) xForKernel[flatRequest[k]] = xGhost[k];
}