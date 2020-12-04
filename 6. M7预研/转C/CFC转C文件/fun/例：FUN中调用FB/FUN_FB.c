#include "FUN_FB.h"
#include "HOLLYSYS-M7-AT-TASK-DEFINE.h"
#include "CFCFB.h"

bool FUN_FB(void* _pHead) {
bool FUN_FB = false;
struct FUN_FB* pHead = (struct FUN_FB*)_pHead;
bool __AT__FUN_FB_EN_1 = true;
if((bool)__AT__FUN_FB_EN_1){
(*(pHead->fb01.p1)) = (*(pHead->a));
(*(pHead->fb01.p2)) = (*(pHead->b));
(*(pHead->fb01.p4)) = (*(pHead->c));
CFCFB(&(pHead->fb01));
}
if((bool)__AT__FUN_FB_EN_1){
(*(((int16_t*)(pHead->d)))) = (*(pHead->fb01.p3));
}
if((bool)__AT__FUN_FB_EN_1){
(*(((int16_t*)(pHead->e)))) = (*(pHead->fb01.p4));
}
return FUN_FB;
}