#!/bin/bash
#SBATCH --partition=edu-short
#SBATCH --account=gpu.computing26
#SBATCH --job-name=weak-4
#SBATCH --output=coo-weak-4.o
#SBATCH --error=coo-weak-4.e
#SBATCH --time=00:05:00
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4 #can be changed 
#SBATCH --mem=1G

# Load modules
module load OpenMPI
module load CUDA/12.5.0

# Print compiler versions
gcc --version
mpicc --version




# makefile 
#make 

# Compile
#mpicc main.cu -o bin/main -lcudart -lmpi 

#ne pas hesiter a enlever -lmpi si pb 

# Build via makefile (no need of mpicc, nvcc does all the job)
#make clean && make

#for the MPI-cuda device aware 
#export OMPI_MCA_opal_cuda_support=true

#run
mpirun --mca opal_cuda_support 1 -np 4 bin/main weak_matrices/matrix_P4.mtx

# Run
#mpirun -np 4 --bind-to none bin/main ../../del-1/GPU_solution/mtx_matrix/nvidia.mtx

#precisions on -bind-to none : 
#sans ça, OpenMPI peut épingler 
#les processus de façon agressive et bloquer l'accès GPU.

ompi_info | grep -i cuda
