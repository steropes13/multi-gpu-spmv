#include <iostream> 
#include <vector> // for the vectors of cpp (std)
#include <mpi.h> 
#include <nvml.h> 
#include <stdio.h>
#include <time.h>
#include <sys/time.h>
#include <math.h>
#include <cuda_runtime.h>
#include <cusparse.h>

#include "include/mmio.h"

// Print device properties
void printDevProp(cudaDeviceProp devProp)
{
    printf("Major revision number:         %d\n",  devProp.major);
    printf("Minor revision number:         %d\n",  devProp.minor);
    printf("Name:                          %s\n",  devProp.name);
    printf("  Memory Clock rate:           %.0f Mhz\n", devProp.memoryClockRate * 1e-3f);

    printf("  Memory Bus Width:            %d bit\n",devProp.memoryBusWidth);

    printf("  Peak Memory Bandwidth:       %7.3f GB/s\n",2.0*devProp.memoryClockRate*(devProp.memoryBusWidth/8)/1.0e6);

    printf("  Multiprocessors:             %3d\n",devProp.multiProcessorCount);
    printf("  Maximum number of threads per multiprocessor:  %d\n",devProp.maxThreadsPerMultiProcessor);
    printf("  Maximum number of threads per block:           %d\n",devProp.maxThreadsPerBlock);
    printf("  Max dimension size of a thread block (x,y,z): (%d, %d, %d)\n",
           devProp.maxThreadsDim[0], devProp.maxThreadsDim[1],devProp.maxThreadsDim[2]);
    printf("  Max dimension size of a grid size    (x,y,z): (%d, %d, %d)\n",
           devProp.maxGridSize[0], devProp.maxGridSize[1],devProp.maxGridSize[2]);
    printf("  Total amount of shared memory per block:       %zu bytes\n", devProp.sharedMemPerBlock);
    return;

}

#define DATATYPE float 

//TODO: envoyer des std::vector.data() (pour les pointeurs)
// dans les scatter pour chaque autres processeus 
//ici on veut envoyer I,J et Vals. 




// I: Row index 
// P: Number of processes 
#define ROLE(I , P) ((I) % (P)) // Row ownership rule 

int main(int argc, char ** argv) {
    int M = 0; 
    int N = 0; 
    int nnz = 0; 
    // M   : Number of lines 
    // N   : Number of columns 
    // nnz : Number of non-zeros;


    //MMIO reading matrix 
    int mmioReturn = 0; 
    MM_typecode matcode; 
    char filename[256]; 
    int * row_ptr_mtx; 
	int * cols_array_mtx; 
	DATATYPE * vals_array_mtx;

    //COO arrays 
    DATATYPE * vals_array; 
	int * cols_array;
	int * rows_array;

    //initializes MPI 
    int currentRank, commSize; 
    int bufferMtxHeaders[3]; 
    int bufferHeaderSize = (int) sizeof(bufferMtxHeaders)/sizeof(int);




    MPI_Init(&argc, &argv); // Initializes the MPI world model
    MPI_Comm_rank(MPI_COMM_WORLD, &currentRank);
    MPI_Comm_size(MPI_COMM_WORLD, &commSize);  

    int deviceCount = 0;
    cudaError_t error_id = cudaGetDeviceCount(&deviceCount);
    fprintf(stdout, "Process %d see %d GPUs.\n", currentRank, deviceCount);
    if (error_id != cudaSuccess) {
        fprintf(stderr, "cudaGetDeviceCount failed: %s\n", cudaGetErrorString(error_id));
        MPI_Abort(MPI_COMM_WORLD, EXIT_FAILURE);
    }
    int gpuId = currentRank % deviceCount;
    cudaSetDevice(gpuId); 
    printf("Rank %d uses GPU %d\n", currentRank, gpuId);


    if (currentRank == 0) //root rank 
    {
		sprintf(filename, "%s",argv[1]);
		printf("filename : %s \n",filename);
        mmioReturn = mm_read_mtx_crd_sym(filename,&M,&N,&nnz,&row_ptr_mtx,&cols_array_mtx,&vals_array_mtx,&matcode);
        printf("does the function work ? %d \n",mmioReturn);
        if (mmioReturn != 0) return EXIT_FAILURE; 
        printf("values of M = %d, N = %d, nnz = %d \n",M,N,nnz); 
        vals_array = (DATATYPE*) calloc(nnz,sizeof(DATATYPE));
		cols_array =  (int *) calloc(nnz,sizeof(int));
		rows_array = (int *) calloc(nnz,sizeof(int));
        for (int i = 0;i<nnz;i++) {
			//printf("value %d (%d, %d) : %.2f\n",i,row_ptr_mtx[i],cols_array_mtx[i],vals_array_mtx[i]);
			cols_array[i] = cols_array_mtx[i]-1; 
			vals_array[i] = vals_array_mtx[i];
			rows_array[i] = row_ptr_mtx[i]-1;
		}
        	if (!mmioReturn) { 
			if (cols_array_mtx) free(cols_array_mtx);
			if (vals_array_mtx) free(vals_array_mtx);
			if(row_ptr_mtx) free(row_ptr_mtx);
		}


        //Sends the header of the mtx file to others processes 
        bufferMtxHeaders[0] = M; 
        bufferMtxHeaders[1] = N; 
        bufferMtxHeaders[2] = nnz; 

    }
    MPI_Bcast(
            bufferMtxHeaders,
            bufferHeaderSize,
            MPI_INT,
            0,
            MPI_COMM_WORLD
    );

    std::vector<int> sendCounts(commSize, 0); //vector of sice comSize filled with 0 
    std::vector<int> displs(commSize, 0);
    std::vector<int> I; 
    std::vector<int> J; 
    std::vector<DATATYPE> valVect; 



    M = bufferMtxHeaders[0];
    N = bufferMtxHeaders[1];
    nnz = bufferMtxHeaders[2];
    printf("[MPI process %d] I am a broadcast receiver. Values : (%d, %d, %d) \n", currentRank,M,N,nnz);
    //rank 0 prepares the sorted datas per rank owner 
    if (currentRank == 0) {
        //count nnz per rank 
        for (int k = 0;k<nnz;k++) {
            sendCounts[ROLE(rows_array[k],commSize)]++; 
        }

        //computes the offset 
        displs[0] = 0; 
        for (int r = 1; r < commSize;r++) {
            displs[r] = displs[r-1] + sendCounts[r-1]; 
        }

        //fills I,J, valVect in the order (rank 0,1...)
        // They will contain the datas re-organized per rank owner 
        I.resize(nnz); 
        J.resize(nnz); 
        valVect.resize(nnz); 

        //cursor : how many elements have benn placed for the rank r 
        // allows us to know were to write the next element for each rank 
        std::vector<int> cursor(commSize,0); 
        int owner = 0; 
        int pos = 0; 
        int index = 0;
        for (index = 0;index<nnz;index++) {
             // determines which rank is the owner of this row (cyclic)
             owner = ROLE(rows_array[index],commSize); 

             // writing position: starting of the rank owner position 
             // + how many have been already written  
             pos = displs[owner] + cursor[owner]; 

             //place the triplet coo and the correct position 
             I[pos] = rows_array[index]; //global row  
             J[pos] = cols_array[index]; //global column
             valVect[pos] = vals_array[index]; //global value

             //increment the cursor of the rank owner 
             cursor[owner]++; 
        }
        // free the C origin arrays (replaced by I,J and valVect)
        free(rows_array); 
        free(cols_array); 
        free(vals_array); 

    }
    //broadcast sendcounts at all the ranks 
    MPI_Bcast(sendCounts.data(), commSize,MPI_INT,0,MPI_COMM_WORLD); 
    int localNnz = sendCounts[currentRank];

    //re-compute the displacement of all the ranks 
    displs[0] = 0; 
    for (int r = 1;r<commSize;r++) {
        displs[r] = displs[r-1] + sendCounts[r-1]; 
    }

    //allocate the local buffers 
    std::vector<int> localI(localNnz); 
    std::vector<int> localJ(localNnz); 
    std::vector<DATATYPE> localVals(localNnz);

    //scatterv of lines, columns and values 

    MPI_Scatterv( //for the comments : extracted from mpich.org
        I.data(),          //adress of the buffer

        sendCounts.data(), //integer array (of length group size) specifying 
                           //the number of elements to send to each processor

        displs.data(),      //integer array (of length group size). Entry
                            // i specifies the displacement (relative 
                            // to sendbuf from which 
                            // to take the outgoing data to process i

        MPI_INT,            //data type of send buffer elements (handle)

        localI.data(),      // number of elements in receive buffer (integer)

        localNnz,           // The number of elements in the receive buffer.

        MPI_INT,            // The type of one receive buffer element.

        0,                  // the rank of the root process

        MPI_COMM_WORLD      // The communicator in which the scatter takes place.
    );

    MPI_Scatterv(
        J.data(), 
        sendCounts.data(), 
        displs.data(),
        MPI_INT, 
        localJ.data(), 
        localNnz, 
        MPI_INT,
        0,
        MPI_COMM_WORLD
    );

    MPI_Scatterv(
        valVect.data(), 
        sendCounts.data(), 
        displs.data(),
        MPI_FLOAT,  //has to be modified if double type 
        localVals.data(), 
        localNnz, 
        MPI_FLOAT,
        0,
        MPI_COMM_WORLD
    );

for (int r = 0; r < commSize; r++) {
    MPI_Barrier(MPI_COMM_WORLD); //to group the printfs per ranks
    if (currentRank == r) {
        printf("[Rank %d] received %d non-zeros :\n", currentRank, localNnz);
        for (int k = 0; k < localNnz; k++) {
            printf("  nnz[%d] : row=%d col=%d val=%.2f\n",
                k, localI[k], localJ[k], localVals[k]);
        }
    }
}


    MPI_Finalize(); // Terminates MPI world model.
    return 0; 
}

