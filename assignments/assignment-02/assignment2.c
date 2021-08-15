#include <stdio.h>
#include <omp.h>
#include <time.h>

// #define SIZE 10 			// delete this line when testing is complete

double A[SIZE][SIZE];
double B[SIZE][SIZE];
double C[SIZE][SIZE];

int main()
{
	int t, u;
	/* Input Data */
	for (t = 0; t < SIZE; t++) {
		for (u = 0; u < SIZE; u++) {
			A[t][u] = B[u][t] = 1;
		}
	}

	double start_time = omp_get_wtime();

	 #pragma omp parallel num_threads(4)
    {
        #pragma omp for
        for(int i=0;i<SIZE;i++){
            for(int k=0;k<SIZE;k++){
                for(int j=0;j<SIZE;j++){
                    C[i][j] = C[i][j] + (A[i][k]*B[k][j]);
                }
            }
        }
    }


	double elapsed = omp_get_wtime() - start_time;

	for (t = 0; t < SIZE; t++) {
		for (u = 0; u < SIZE; u++) {
			printf("%.0f ", C[t][u]);
		}
		printf("\n");
	}

	fprintf(stderr, "Time: %f s\n", elapsed);	// Do not modify this line
}