/*
*  name: task-6.cu
*/

#include<stdio.h>
__global__ void myHelloOnGPU(int *array){
    // Position-1
    int index_x = blockIdx.x * blockDim.x + threadIdx.x;
    int index_y = blockIdx.y * blockDim.y + threadIdx.y;
    array[index_y * blockDim.x * blockDim.y + index_x] = 
    11 * (( blockDim.x * gridDim.x )-(( blockIdx.x * gridDim.x - blockIdx.x*1 )+ ( blockIdx.y* gridDim.x )));
}

int main(){
    int N = 16;
    int *cpuArray = (int*)malloc(sizeof(int)*N);
    int *gpuArray;
    cudaMalloc((void **)&gpuArray, sizeof(int)*N);
    // Position-2
    dim3 dimGrid(N/8, N/8, 1); 
    dim3 dimBlock(N/8, N/8, 1);
    
    myHelloOnGPU<<<dimGrid, dimBlock>>>(gpuArray);
    
    cudaMemcpy(cpuArray, gpuArray, sizeof(int)*N, cudaMemcpyDeviceToHost);
    for (int i = 0; i < N/4; i++){
        for (int j = 0; j < N/4; j++){
            printf("%2.2d ", cpuArray[i*N/4+j]);
        }
        printf("\n");
    }
    printf("\n");
    return 0;
}


