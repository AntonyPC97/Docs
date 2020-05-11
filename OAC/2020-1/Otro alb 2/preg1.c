#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

extern void ContarVotosAsm (int cant , float *v, float * asmh,int max);
void GenerarVotos (int cant , int max , float *v);
void MostrarVector (int cant , float * vector );
void ContarVotos (int cant , float *v, float *ch, int max);
void ContarVotosOptimizado (int cant , float *v, float *ch, int max);

int main(int argc, char** argv) {

    int cant =100 , max =5; 
    float *v, *ch , * asmh ;
    v = malloc(cant*sizeof(float));
    ch = malloc(max*sizeof(float));
    asmh = malloc(max*sizeof(float));
    clock_t astart_t,aend_t,atotal;
    clock_t cstart_t,cend_t,ctotal;
    clock_t costart_t,coend_t,cototal;

    GenerarVotos (cant ,max ,v);
    MostrarVector (cant , v);

    //Programa en C
    cstart_t = clock();
    for(int i=0;i<1000;i++){
        ch = malloc(max*sizeof(float));
        ContarVotos (cant , v, ch,max);
    }
    cend_t = clock();
    ctotal = cend_t - cstart_t;
    printf("El tiempo de ejecucion de 1000 veces en C es %.2f us \n",1000000*((float)ctotal)/CLOCKS_PER_SEC);
    MostrarVector (max , ch);
    
    //Program en C optimizado
    costart_t = clock();
    for(int i=0;i<1000;i++){
        ch = malloc(max*sizeof(float));
        ContarVotosOptimizado (cant , v, ch,max);
    }
    coend_t = clock();
    cototal = coend_t - costart_t;
    printf("El tiempo de ejecucion de 1000 veces en C optimizado es %.2f us \n",1000000*((float)cototal)/CLOCKS_PER_SEC);
    MostrarVector (max , ch);

    //Programa en Asm
    astart_t = clock();
    for(int i=0;i<1000;i++){
        asmh = malloc(max*sizeof(float));
        ContarVotosAsm (cant , v, asmh,max);
    }
    aend_t = clock();
    atotal = aend_t - astart_t;
    printf("El tiempo de ejecucion de 1000 veces en Asm es %.2f us \n",1000000*((float)atotal)/CLOCKS_PER_SEC);
    MostrarVector (max,asmh);

    printf("El speedup de ASM con respecto a C es %.4f \n",1000000*((float)(atotal/ctotal))/CLOCKS_PER_SEC);
    printf("El speedup de C optimizado con respecto a ASM es %.4f \n",1000000*((float)(cototal/atotal))/CLOCKS_PER_SEC);
    return 0;
}

void GenerarVotos (int cant , int max , float *v){
    for(int i=0;i<cant;i++){
        v[i]=(float)(rand()% max);
    }
}

void MostrarVector (int cant , float * v ){
    for(int i=0;i<cant;i++){
        printf("%.f  ",v[i]);
    }
    printf("\n");
}


void ContarVotos (int cant , float *v, float *ch, int max){
    for(int i=0;i<max;i++){
        for(int j=0;j<cant;j++){
        	if((float)i == v[j])
        		ch[i]++;
        }
    }
}

void ContarVotosOptimizado (int cant , float *v, float *ch, int max){
    for(int i=0;i<max;i++){
        for(int j=0;j<cant;j+=5){
        	if((float)i == v[j])
        		ch[i]++;
        	if((float)i == v[j+1] && j+1 < cant)
        		ch[i]++;
        	if((float)i == v[j+2] && j+2 < cant)
        		ch[i]++;
        	if((float)i == v[j+3] && j+3 < cant)
        		ch[i]++;
        	if((float)i == v[j+4] && j+4 < cant)
        		ch[i]++;
        }
    }
}
//nasm -f elf64 -o ContarVotosAsm.o ContarVotosAsm.asm
//gcc ContarVotosAsm.o preg1.c -o preg1 -lm
//./preg1