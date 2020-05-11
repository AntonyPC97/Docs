#include <stdio.h>
#include <stdlib.h>
# include <math.h>

void GenerarNumeros (int cant , float *x, float *y);
void Taylor (int cant , int n , float *x, float *y, float a);
extern void asmTaylor (int cant , int n , float *x, float *y,float a);

int main (){
	int cant = 10, n = 100 , i;
	float *x, *y, a = 3.5;

	x = malloc(cant*sizeof(float));
	y = malloc(cant*sizeof(float));

	GenerarNumeros (cant ,x, y);
	Taylor (cant , n , x, y, a);
	printf ("En C:\n");

	for (i = 0; i < cant ; i++){
		printf (" Numero : %.2f Aproximacion : %.3f \n", x[i], y[i]);
	}

	printf ("\n");
	
	GenerarNumeros (cant ,x, y);
	asmTaylor (cant , n , x, y, a);
	printf ("En ASM :\n");

	for (i = 0; i < cant ; i++){
		printf (" Numero : %.2f Aproximacion : %.3f \n", x[i], y[i]);
	}
}

void GenerarNumeros(int cant , float *x, float *y){
	float num = 0.0;
	for(int i=0;i<cant;i++){
		x[i] =num;
		y[i]=0.0;
		num+=0.1;
	}
}
void Taylor (int cant , int n , float *x, float *y, float a){
	for(int i=0;i<cant;i++){
		for(int j=0;j<=n;j++){
			y[i]+=a*pow(x[i],j);
		}
	}
}