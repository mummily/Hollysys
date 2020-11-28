#ifndef __BBB_H_
#define __BBB_H_
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <math.h>

// Fun
#pragma pack(1)
struct BBB
{
// IN
int16_t* P1;
// INOUT
int16_t* P2;
};
#pragma pack()
#endif