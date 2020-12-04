#ifndef __CFCFUN_H_
#define __CFCFUN_H_
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <math.h>

// Fun
#pragma pack(1)
struct CFCFUN
{
// IN
int16_t* p1;
int16_t* p2;
// INOUT
int16_t* p3;
};
#pragma pack()
#endif