#include <stdio.h>
#include <stdlib.h>
__global__ void add(int *a, int *b, int *c) {
    // Position 1: To write Code here later
    int n = 16;
    int index = blockIdx.x * blockDim.x + threadIdx.x  ;
    int stride = gridDim.x * blockDim.x;
    for (int i = index; i < n; i+=stride)
        c[i] = a[i] + b[i];
}

int main()
{
    int *a, *b, *c, *da, *db, *dc, N=16, i;
    a = (int*)malloc(sizeof(int)*N); // allocate host mem
    b = (int*)malloc(sizeof(int)*N); // and assign random
    c = (int*)malloc(sizeof(int)*N); // memory
    // Write code to initialize both a and b to 1’s.
    for (i = 0; i < N; i++) {
        a[i] = b[i] = 1;
    }
    cudaMalloc((void **)&da, sizeof(int)*N);
    cudaMalloc((void **)&db, sizeof(int)*N);
    cudaMalloc((void **)&dc, sizeof(int)*N);
    cudaMemcpy(da, a, sizeof(int)*N, cudaMemcpyHostToDevice);
    cudaMemcpy(db, b, sizeof(int)*N, cudaMemcpyHostToDevice);
    dim3 dimGrid(N/8, 1, 1);
    dim3 dimBlock(N/4, 1, 1);
    
    add<<<dimGrid,dimBlock>>>(da, db, dc);
    
    cudaMemcpy(c, dc, sizeof(int)*N, cudaMemcpyDeviceToHost);
    for (i = 0; i < N; i++) {
        printf("a[%d] + b[%d] = %d\n", i, i, c[i]);
    }
}