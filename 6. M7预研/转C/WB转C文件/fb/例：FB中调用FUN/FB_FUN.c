#include "FB_FUN.h"
#include "HOLLYSYS-M7-AT-TASK-DEFINE.h"
#include "CFCFUN.h"
void FB_FUN(void* _pHead) {
struct FB_FUN* pHead = (struct FB_FUN*)_pHead;
bool __AT__FB_FUN_EN_1 = true;
bool __AT__FB_FUN_1 = false;
if((bool)__AT__FB_FUN_EN_1){
struct CFCFUN CFCFUN1;
CFCFUN1.P1 = pHead->A;
CFCFUN1.P2 = pHead->B;
CFCFUN1.P3 = pHead->C;
__AT__FB_FUN_1 = CFCFUN(&CFCFUN1);
}
if((bool)__AT__FB_FUN_EN_1) { (*(((int16_t*)(pHead->D)))) = __AT__FB_FUN_1; }
}