#ifndef __FB_FB_H_
#define __FB_FB_H_
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <math.h>
#include "CFCFB.h"
// FB
#pragma pack(1)
struct FB_FB
{
// IN
int16_t* A;
int16_t* B;
int16_t* C;
struct CFCFB FB01;
// OUT
bool* D;
int16_t* E;
// INOUT
// TEMP
};
#pragma pack()
#endif