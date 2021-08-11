#include <stdio.h>
#include <mpi.h>
int main(int argc, char **argv)
{
    int a = 10;
    int size, my_rank;
    MPI_Init(&a, &argv);
    MPI_Comm_size(MPI_COMM_WORLD, &size);
    MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);
    printf("Hello from %d out of %d\n", my_rank, size);
    MPI_Finalize();
    return 0;    
}
