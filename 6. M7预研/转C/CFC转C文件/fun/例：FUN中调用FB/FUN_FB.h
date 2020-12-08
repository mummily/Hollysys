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
int16_t* a;
int16_t* b;
int16_t* c;
struct CFCFB fb01;
// INOUT
int16_t* d;
int16_t* e;
};
#pragma pack()

// Struct Copy
inline void FUN_FB_Copy(struct FUN_FB* pSrc, struct FUN_FB* pDesc)
{
*(pDesc->a) = *(pSrc->a);
*(pDesc->b) = *(pSrc->b);
*(pDesc->c) = *(pSrc->c);
CFCFB_Copy(&(pSrc->fb01), &(pDesc->fb01));
*(pDesc->d) = *(pSrc->d);
*(pDesc->e) = *(pSrc->e);
}

#endif