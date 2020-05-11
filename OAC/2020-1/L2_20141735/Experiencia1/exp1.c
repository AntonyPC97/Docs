#include <stdio.h>
#include <stdlib.h>
#include <time.h>

extern void asmMayorNumero (int len , int *vector , int* max );
void cMayorNumero (int len , int *vector , int *max );
int main(void){

	int len=5;
	int* max =malloc(sizeof(int));
	int* vector = malloc(len*sizeof(int));
	vector[0] =2;
	vector[1] =9;
	vector[2] =1;
	vector[3] =2;
	vector[4] =6;
	cMayorNumero(len,vector,max);
	printf("En C el mayor valor del vector es : %d\n",*max);

	*max = 0;
	asmMayorNumero(len,vector,max);
	printf("En Asm el mayor valor del vector es : %d\n",*max);
	return 0;
}

void cMayorNumero(int len , int *vector , int *max){
	*max = 0;
	for(int i=0;i<len;i++){
		if(vector[i]>*max){
			*max = vector[i];
		}
	}
}