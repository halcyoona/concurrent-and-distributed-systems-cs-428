#include <stdio.h>
#include <time.h>
#include <string.h>
#include <pthread.h>

// #define SIZE 1000 // delete this line when testing is complete
#define MAX_THREAD 10		

double A[SIZE][SIZE];
double B[SIZE][SIZE];
double C[SIZE][SIZE];
int step_i = 0;

void* multi(void* arg)
{
    int core = step_i++;
  
    // Each thread computes  of matrix multiplication
    for (int i = core * SIZE / MAX_THREAD; i < (core + 1) * SIZE / MAX_THREAD; i++) 
        for (int j = 0; j < SIZE; j++) 
            for (int k = 0; k < SIZE; k++) 
                C[i][j] = C[i][j] + A[i][k] * B[k][j];
}


int main()
{
	int t, u;
	/* Input Data */
	for (t = 0; t < SIZE; t++) {
		for (u = 0; u < SIZE; u++) {
			A[t][u] = B[u][t] = 1;
            // C[t][u] = 5;
		}
	}

    // declaring four threads
    pthread_t threads[MAX_THREAD];
  

  	struct timespec start, finish;
	double elapsed;
	clock_gettime(CLOCK_MONOTONIC, &start);
	
	/* Multi-Threading Activity */
	for (int i = 0; i < MAX_THREAD; i++) {
        int* p;
        pthread_create(&threads[i], NULL, multi, (void*)(p));
    }
  
    // joining and waiting for all threads to complete
    for (int i = 0; i < MAX_THREAD; i++) 
        pthread_join(threads[i], NULL);
	
	// int i, j, k;
    // for (i = 0; i < SIZE; i++) {
    //     for (j = 0; j < SIZE; j++) {
    //         for (k = 0; k < SIZE; k++) {
    //             C[i][j] = C[i][j] + (A[i][k] * B[k][j]);
    //         }
    //     }
    // }
	
	clock_gettime(CLOCK_MONOTONIC, &finish);
	elapsed = (finish.tv_sec - start.tv_sec);
	elapsed += (finish.tv_nsec - start.tv_nsec) / 1000000000.0;
	
     

    
    

    

    

	for (t = 0; t < SIZE; t++) {
		for (u = 0; u < SIZE; u++) {
			printf("%.0f ", C[t][u]);
		}
		printf("\n");
	}

	fprintf(stderr, "Time: %f seconds\n", elapsed);
}