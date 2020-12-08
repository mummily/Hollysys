#include "FUN_FUN.h"
#include "HOLLYSYS-M7-AT-TASK-DEFINE.h"
#include "CFCFUN.h"

bool FUN_FUN(void* _pHead) {
bool FUN_FUN = false;
struct FUN_FUN* pHead = (struct FUN_FUN*)_pHead;
bool __AT__FUN_FUN_EN_1 = true;
bool __AT__FUN_FUN_1 = false;
if((bool)__AT__FUN_FUN_EN_1){
struct CFCFUN CFCFUN1;
CFCFUN1.p1 = pHead->a;
CFCFUN1.p2 = pHead->b;
CFCFUN1.p3 = pHead->c;
__AT__FUN_FUN_1 = CFCFUN(&CFCFUN1);
}
if((bool)__AT__FUN_FUN_EN_1){
(*(((int16_t*)(pHead->d)))) = __AT__FUN_FUN_1;
}
return FUN_FUN;
}