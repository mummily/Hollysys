#include "CFCFUN.h"
#include "HOLLYSYS-M7-AT-TASK-DEFINE.h"
bool CFCFUN(void* _pHead) {
bool CFCFUN = false;
struct CFCFUN* pHead = (struct CFCFUN*)_pHead;
bool __AT__CFCFUN_EN_3 = true;
int16_t __AT__CFCFUN_3 = 0;
if((bool)__AT__CFCFUN_EN_3){
__AT__CFCFUN_3 = (*(((int16_t*)(pHead->P1))))+(*(((int16_t*)(pHead->P2))));
}
if((bool)__AT__CFCFUN_EN_3) { (*(((int16_t*)(pHead->P3)))) = __AT__CFCFUN_3; }
return CFCFUN;
}