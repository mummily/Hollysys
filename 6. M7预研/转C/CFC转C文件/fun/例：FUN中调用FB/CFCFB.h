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

// Struct Copy
inline void CFCFB_Copy(struct CFCFB* pSrc, struct CFCFB* pDesc)
{
*(pDesc->p1) = *(pSrc->p1);
*(pDesc->p2) = *(pSrc->p2);
*(pDesc->p3) = *(pSrc->p3);
*(pDesc->p4) = *(pSrc->p4);
*(pDesc->p5) = *(pSrc->p5);
}

#endif