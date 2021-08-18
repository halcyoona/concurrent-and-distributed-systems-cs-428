/* task-5.cu */
#include <stdio.h>


__global__ void myHelloOnGPU(int *array){
	// Position1
	array[blockIdx.x * blockDim.x + threadIdx.x] = ( blockDim.x - threadIdx.x - 1);
	
}

int main(){
	int N = 16;
	int *cpuArray = (int*)malloc(sizeof(int)*N);
	int *gpuArray;
	cudaMalloc((void **)&gpuArray, sizeof(int)*N);

	// Position 2 
	myHelloOnGPU<<<N/4, N/4>>>(gpuArray);
	cudaMemcpy(cpuArray, gpuArray, sizeof(int)*N, cudaMemcpyDeviceToHost);

	for(int i=0; i<N; i++){
		printf("%d ", cpuArray[i]);
	}
	printf("\n");
	return 0;
}

