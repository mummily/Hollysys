#ifndef __CFCFUNA_H_
#define __CFCFUNA_H_
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <math.h>

// Fun
#pragma pack(1)
struct CFCFUNA
{
// IN
int16_t* A;
int16_t* B;
int16_t* C;
// INOUT
int16_t* D;
};
#pragma pack()
#endif