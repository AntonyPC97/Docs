
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

extern void asmSTD(float *v1, int n, float*v2);

int main(int argc, char** argv) {
    
    int n=2048;
    float *v1 = malloc(n*sizeof(float));
    float *v2 = malloc(sizeof(float));
    
    //llenado de la tabla de 4 en 4
    for(int i=0;i<=n-4;i=i+4){
        v1[i] =   (float)i+1;
        v1[i+1] = (float)i+2;
        v1[i+2] = (float)i+3;
        v1[i+3] = (float)i+4;  
    }
    
    asmSTD(v1,n,v2);
    
    printf("EL resultado de la desviacion estandar en asm es %.2f",*v2);

    return (EXIT_SUCCESS);
}