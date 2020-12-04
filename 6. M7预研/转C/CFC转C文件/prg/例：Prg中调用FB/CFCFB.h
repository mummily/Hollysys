#ifndef __CFCFB_H_
#define __CFCFB_H_
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <math.h>

// FB
#pragma pack(1)
struct CFCFB
{
// IN
int16_t* p1;
int16_t* p2;
// OUT
int16_t* p3;
// INOUT
int16_t* p4;
// TEMP
int16_t* p5;
};
#pragma pack()
#endif