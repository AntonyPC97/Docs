
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

extern void asmSTD(float *v1, int n, float*v2);
void cSTD(float *v1, int n, float*v2){
    //se halla la media aritemtcia
    float sum = 0,media,resta,sumaDs,varianza;
    for(int i=0;i<n;i++)
        sum += v1[i];
    media = sum/n;
    
    //hallo la varianza
    for(int i =0;i<n;i++){
        resta = abs(v1[i] - media);
        sumaDs = sumaDs + pow(resta,2);
    }
    varianza = sumaDs/(float)n;
    *v2 = sqrt(varianza);
    
}

int comp(const void * a, const void * b) {
   return ( *(int*)a - *(int*)b );
}

int main(int argc, char** argv){

	int n=2048;
	float cSuma =0,aSuma=0;
	float *tiempoASM = malloc(100*sizeof(float));
	float *tiempoC = malloc(100*sizeof(float));
    float *v1 = malloc(n*sizeof(float));
    float *v2 = malloc(sizeof(float));
    float *aStd = malloc(sizeof(float));
    float *cStd = malloc(sizeof(float));
    
    //llenado de la tabla de 4 en 4
    for(int i=0;i<=n-4;i=i+4){
        v1[i] =   (float)i+1;
        v1[i+1] = (float)i+2;
        v1[i+2] = (float)i+3;
        v1[i+3] = (float)i+4;  
    }


    clock_t astart_t,aend_t;
    clock_t cstart_t,cend_t;
    for(int i=0;i<100;i++){

    	cstart_t = clock();
    	cSTD(v1,n,v2);
    	cend_t=clock();
    	tiempoC[i]= cend_t-cstart_t;
    	cSuma+=tiempoC[i];


    	astart_t=clock();
    	asmSTD(v1,n,v2);
    	aend_t=clock();
    	tiempoASM[i]= aend_t-astart_t;
        aSuma = tiempoASM[i]; 
    }
    qsort(tiempoC,100,sizeof(float),comp);
    qsort(tiempoASM,100,sizeof(float),comp);

    float aMedia = aSuma/100;
    float cMedia = cSuma/100;

    float aMediana = tiempoASM[50];
    float cMediana = tiempoC[50];

    cSTD(tiempoASM,100,aStd);
    cSTD(tiempoC,100,cStd);

    printf("La media de los 100 tiempos de ejecucion en ASM es %.2f us \n",1000000*((float)aMedia)/CLOCKS_PER_SEC);
    printf("La STD de los 100 tiempos de ejecucion en ASM es %.2f us \n",1000000*((float)*aStd)/CLOCKS_PER_SEC);
    printf("La mediana de los 100 tiempos de ejecucion en ASM es %.2f us \n",1000000*((float)cMediana)/CLOCKS_PER_SEC);
    printf("La media de los 100 tiempos de ejecucion en C es %.2f us \n",1000000*((float)cMedia)/CLOCKS_PER_SEC);
    printf("La STD de los 100 tiempos de ejecucion en C es %.2f us \n",1000000*((float)*cStd)/CLOCKS_PER_SEC);
    printf("La mediana de los 100 tiempos de ejecucion en C es %.2f us \n",1000000*((float)cMediana)/CLOCKS_PER_SEC);

	return(EXIT_SUCCESS);
}
