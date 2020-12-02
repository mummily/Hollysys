#ifndef __FUN_FB_H_
#define __FUN_FB_H_
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <math.h>
#include "CFCFB.h"
// Fun
#pragma pack(1)
struct FUN_FB
{
// IN
int16_t* A;
int16_t* B;
int16_t* C;
// INOUT
int16_t* D;
int16_t* E;
struct CFCFB FB01;
};
#pragma pack()
#endif