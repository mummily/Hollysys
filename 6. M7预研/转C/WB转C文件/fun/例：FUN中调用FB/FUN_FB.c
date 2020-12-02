#include "FUN_FB.h"
#include "HOLLYSYS-M7-AT-TASK-DEFINE.h"
#include "CFCFB.h"
bool FUN_FB(void* _pHead) {
bool FUN_FB = false;
struct FUN_FB* pHead = (struct FUN_FB*)_pHead;
bool __AT__FUN_FB_EN_1 = true;
if((bool)__AT__FUN_FB_EN_1){
(*(pHead->FB01.P1)) = (*(pHead->A));
(*(pHead->FB01.P2)) = (*(pHead->B));
(*(pHead->FB01.P4)) = (*(pHead->C));
CFCFB(&FB01);
}
if((bool)__AT__FUN_FB_EN_1) { (*(((int16_t*)(pHead->D)))) = (*(pHead->FB01.P3)); }
if((bool)__AT__FUN_FB_EN_1) { (*(((int16_t*)(pHead->E)))) = (*(pHead->FB01.P4)); }
return FUN_FB;
}