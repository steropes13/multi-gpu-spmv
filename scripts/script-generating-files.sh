#!/bin/bash
matrix_names=("cage15" "ASIC_680ks" "vas_stokes_2M" "poisson3Db" "degme" "1138_bus" "shipsec5" "msdoor" "Ge87H76" "bmw3_2")
number_gpu=(1 2 3 4)
ARRAY_SIZE=${#matrix_names[@]}
current_dir=$(pwd)
echo -e "number of matrices : $ARRAY_SIZE"
for mName in "${matrix_names[@]}"; do
    for nbGpu in "${number_gpu[@]}"; do 
        echo -e "#!/bin/bash
#SBATCH --partition=edu-short
#SBATCH --account=gpu.computing26
#SBATCH --job-name=$mName-$nbGpu
#SBATCH --output=$mName-$nbGpu.o
#SBATCH --error=$mName-$nbGpu.e
#SBATCH --time=00:05:00
#SBATCH --nodes=1
#SBATCH --ntasks=$nbGpu
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:$nbGpu #can be changed 
#SBATCH --mem=1G

# Load modules
module load OpenMPI
module load CUDA/12.5.0

# Print compiler versions
#gcc --version
#mpicc --version

VAL=\$(hostname) 
echo \"host: \$VAL\" 


# makefile 
#make 

# Compile
#mpicc $current_dir/main.cu -o $current_dir/bin/main -lcudart -lmpi 


# Build via makefile (no need of mpicc, nvcc does all the job)
#make clean && make

#for the MPI-cuda device aware 
export OMPI_MCA_opal_cuda_support=true

#run
mpirun --mca opal_cuda_support 1 -np $nbGpu $current_dir/bin/main $current_dir/$mName/$mName.mtx

#ompi_info | grep -i cuda



    " > $current_dir/sbatch-$mName-$nbGpu.sh 
    done
done