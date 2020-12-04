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
int16_t* a;
int16_t* b;
int16_t* c;
struct CFCFB fb01;
// OUT
bool* d;
int16_t* e;
// INOUT
// TEMP
};
#pragma pack()
#endif