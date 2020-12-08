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
int16_t* a;
int16_t* b;
int16_t* c;
// OUT
// INOUT
bool* d;
// TEMP
};
#pragma pack()

// Struct Copy
inline void FB_FUN_Copy(struct FB_FUN* pSrc, struct FB_FUN* pDesc)
{
*(pDesc->a) = *(pSrc->a);
*(pDesc->b) = *(pSrc->b);
*(pDesc->c) = *(pSrc->c);
*(pDesc->d) = *(pSrc->d);
}

#endif