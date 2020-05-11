/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   main.c
 * Author: Antony Palacios
 *
 * Created on September 23, 2019, 10:22 AM
 */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

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
	float cSuma =0,cAsm=0;
	float tiempoASM[100];
	float tiempoC[100];
    float *v1 = malloc(n*sizeof(float));
    float *v2 = malloc(sizeof(float));
    
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
    	cend_t=cloclk();
    	tiempoC[i]= cend_t-cstart_t;
    	cSuma+=tiempoC[i];


    	astart_t=clock();
    	asmSTD(v1,n,v2);
    	aend_t=cloclk();
    	tiempoASM[i]= aend_t-astart_t;

    }
    qsort(tiempoC,100,sizeof(float),comp);
    qsort(tiempoC,100,sizeof(float),comp);

	return(EXIT_SUCCESS);
}