#ifndef __FB_FUN_H_
#define __FB_FUN_H_
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <math.h>
// FB
#pragma pack(1)
struct FB_FUN
{
// IN
int16_t* A;
int16_t* B;
int16_t* C;
// OUT
// INOUT
bool* D;
// TEMP
};
#pragma pack()
#endif