#include "CFCFB.h"
#include "HOLLYSYS-M7-AT-TASK-DEFINE.h"

void CFCFB(void* _pHead) {
struct CFCFB* pHead = (struct CFCFB*)_pHead;
bool __AT__CFCFB_EN_3 = true;
int16_t __AT__CFCFB_3 = 0;
if((bool)__AT__CFCFB_EN_3){

__AT__CFCFB_3 = (*(((int16_t*)(pHead->P1))))+(*(((int16_t*)(pHead->P2))));
}
if((bool)__AT__CFCFB_EN_3) { (*(((int16_t*)(pHead->P3)))) = __AT__CFCFB_3;; }
}