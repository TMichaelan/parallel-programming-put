#include <stdio.h>
#include <stdlib.h>
#include <cuda.h>

#define MAX_VAL 1000
#define BLOCK_SIZE 256

__device__ void mergeSort(int *input, int p, int r){
    if ( p < r ){
        if(input[p] > input[r]) {
            // swap elements
            int temp = input[p];
            input[p] = input[r];
            input[r] = temp;
        }
    }
}

__global__ void kernel(int *input, int size){
    int idx = threadIdx.x + blockIdx.x * blockDim.x;

    if(idx * 2 < size) {
        mergeSort(input, idx * 2, idx * 2 + 1);
    }
}

int main(int argc, char* argv[]){
    int *d_input;
    int size;
    sscanf(argv[1], "%d", &size); // get array size from command line
    size *= sizeof(int);
    
    int *input = (int*)malloc(size);
    for(int i = 0; i < size/sizeof(int); i++){
        input[i] = rand() % MAX_VAL;
    }
    
    cudaMalloc((void**)&d_input, size);
    cudaMemcpy(d_input, input, size, cudaMemcpyHostToDevice);

    // Timer start
    float gpu_time = 0.0f;
    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);
    cudaEventRecord(start, 0);
    
    kernel<<<(size + BLOCK_SIZE - 1) / (2*BLOCK_SIZE), BLOCK_SIZE>>>(d_input, size/sizeof(int));
    
    cudaEventRecord(stop, 0);
    cudaEventSynchronize(stop);
    cudaEventElapsedTime(&gpu_time, start, stop);
    
    cudaMemcpy(input, d_input, size, cudaMemcpyDeviceToHost);
    
    printf("Elapsed time: %f s\n", gpu_time / 1000.0);
    
    cudaFree(d_input);
    free(input);
    
    return 0;
}
