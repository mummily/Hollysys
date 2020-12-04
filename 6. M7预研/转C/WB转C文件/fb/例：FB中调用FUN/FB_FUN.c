#include "FB_FUN.h"
#include "HOLLYSYS-M7-AT-TASK-DEFINE.h"
#include "CFCFUN.h"

void FB_FUN(void* _pHead) {
struct FB_FUN* pHead = (struct FB_FUN*)_pHead;
bool __AT__FB_FUN_EN_1 = true;
bool __AT__FB_FUN_1 = false;
if((bool)__AT__FB_FUN_EN_1){
struct CFCFUN CFCFUN1;
CFCFUN1.p1 = pHead->a;
CFCFUN1.p2 = pHead->b;
CFCFUN1.p3 = pHead->c;
__AT__FB_FUN_1 = CFCFUN(&CFCFUN1);
}
if((bool)__AT__FB_FUN_EN_1){
(*(((int16_t*)(pHead->d)))) = __AT__FB_FUN_1;
}
}