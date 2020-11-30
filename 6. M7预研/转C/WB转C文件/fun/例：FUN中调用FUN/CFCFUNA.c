#include "CFCFUNA.h"
#include "HOLLYSYS-M7-AT-TASK-DEFINE.h"
#include "CFCFUN.h"

bool CFCFUNA(void* _pHead) {
bool CFCFUNA = false;
struct CFCFUNA* pHead = (struct CFCFUNA*)_pHead;
bool __AT__CFCFUNA_EN_1 = true;
bool __AT__CFCFUNA_1 = false;
if((bool)__AT__CFCFUNA_EN_1) { 
struct CFCFUN CFCFUN1;
CFCFUN1.P1 = pHead->A;
CFCFUN1.P2 = pHead->B;
CFCFUN1.P3 = pHead->C;
__AT__CFCFUNA_1 = CFCFUN(&CFCFUN1); }
if((bool)__AT__CFCFUNA_EN_1) { (*(((int16_t*)(pHead->D)))) = __AT__CFCFUNA_1;; }
return CFCFUNA;
}