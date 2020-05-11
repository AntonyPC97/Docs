#include <stdio.h>
#include <stdlib.h>
#include <time.h>

extern void asmOrdenar (int len , int * vectorIn , int * VectorOut );
void cOrdenar (int len , int * vectorIn , int * vectorOut );
void cOrdenarOptimizado (int len , int * vectorIn , int * vectorOut );
void imprimir(int len,int*vector){
	for(int i=0;i<len;i++){
		printf("%d  ",vector[i]);
	}
	printf("\n");
}

int main(void){

	clock_t astart_t,aend_t,atotal;
    clock_t cstart_t,cend_t,ctotal;
    clock_t costart_t,coend_t,cototal;
	int len=8;
	int* vectorIn = malloc(len*sizeof(int));
	int* vectorOut = malloc(len*sizeof(int));

	vectorIn[0] =1;
		vectorIn[1] =2;
		vectorIn[2] =3;
		vectorIn[3] =4;
		vectorIn[4] =8;
		vectorIn[5] =7;
		vectorIn[6] =6;
		vectorIn[7] =5;
	printf("En C el vector inicial es: ");
	imprimir(len,vectorIn);
	cstart_t=clock();
	for(int i=0;i<1000;i++){
		vectorIn[0] =1;
		vectorIn[1] =2;
		vectorIn[2] =3;
		vectorIn[3] =4;
		vectorIn[4] =8;
		vectorIn[5] =7;
		vectorIn[6] =6;
		vectorIn[7] =5;
		cOrdenar(len,vectorIn,vectorOut);
	}
	cend_t= clock();
	printf("En C  el vector ordenado es: ");
	imprimir(len,vectorOut);
	ctotal = cend_t-cstart_t;
	printf("El tiempo de ejecucion de 1000 veces en C es %.2f us \n",1000000*((float)ctotal)/CLOCKS_PER_SEC);
//##############################################################3
	costart_t=clock();
	for(int i=0;i<1000;i++){
		vectorIn[0] =1;
		vectorIn[1] =2;
		vectorIn[2] =3;
		vectorIn[3] =4;
		vectorIn[4] =8;
		vectorIn[5] =7;
		vectorIn[6] =6;
		vectorIn[7] =5;
		cOrdenarOptimizado(len,vectorIn,vectorOut);
	}
	printf("En C Optimizado el vector ordenado es: ");
	imprimir(len,vectorOut);
	coend_t= clock();
	cototal = coend_t-costart_t;
	printf("El tiempo de ejecucion de 1000 veces en C opt es %.2f us \n",1000000*((float)cototal)/CLOCKS_PER_SEC);
//##############################################################3
	astart_t=clock();
	for(int i=0;i<1000;i++){
		vectorIn[0] =1;
		vectorIn[1] =2;
		vectorIn[2] =3;
		vectorIn[3] =4;
		vectorIn[4] =8;
		vectorIn[5] =7;
		vectorIn[6] =6;
		vectorIn[7] =5;
		asmOrdenar(len,vectorIn,vectorOut);
	}
	printf("EnAsm el vector ordenado es: ");
	imprimir(len,vectorOut);
	aend_t= clock();
	atotal = aend_t-astart_t;
	printf("El tiempo de ejecucion de 1000 veces en Asm es %.2f us \n",1000000*((float)atotal)/CLOCKS_PER_SEC);
	printf("\n");
	 printf("El speedup de C optimizado con respecto a C es %.6f \n",1000000*((float)(cototal/ctotal))/CLOCKS_PER_SEC);
    printf("El speedup de Asm con respecto a C es %.6f \n",1000000*((float)(atotal/ctotal))/CLOCKS_PER_SEC);
	return 0;
}

void cOrdenar (int len , int * vectorIn , int * vectorOut ){

	for(int i=0;i<len;i++){
		int aux = 0;
		//encuentro el mayor
		for(int j=0;j<len;j++){
			if(vectorIn[j]>aux){
				aux=vectorIn[j];
			}
		}
		//elimino el mayor valor del arreglo
		for(int j=0;j<len;j++){
			if(vectorIn[j]==aux){
				vectorIn[j]=0;
			}
		}
		vectorOut[i]=aux;
	}
}

void cOrdenarOptimizado (int len , int * vectorIn , int * vectorOut ){

	for(int i=0;i<len;i++){
		int aux = 0;
		//encuentro el mayor
		for(int j=0;j<len;j+=4){
			if(vectorIn[j]>aux){
				aux=vectorIn[j];
			}
			if(vectorIn[j+1]>aux){
				aux=vectorIn[j+1];
			}
			if(vectorIn[j+2]>aux){
				aux=vectorIn[j+2];
			}
			if(vectorIn[j+3]>aux){
				aux=vectorIn[j+3];
			}

		}
		//elimino el mayor valor del arreglo
		for(int j=0;j<len;j+=4){
			if(vectorIn[j]==aux){
				vectorIn[j]=0;
			}
			if(vectorIn[j+1]==aux){
				vectorIn[j+1]=0;
			}
			if(vectorIn[j+2]==aux){
				vectorIn[j+2]=0;
			}
			if(vectorIn[j+3]==aux){
				vectorIn[j+3]=0;
			}
		}
		vectorOut[i]=aux;
	}
}