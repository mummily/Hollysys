#include "BBB.h"
#include "HOLLYSYS-M7-AT-TASK-DEFINE.h"

bool BBB(void* _pHead) {
bool BBB = false;
struct BBB* pHead = (struct BBB*)_pHead;
bool __AT__BBB_EN_2 = true;
int16_t __AT__BBB_2 = 0;
if((bool)__AT__BBB_EN_2) { 
__AT__BBB_2 = (*(pHead->P1)); }
if((bool)__AT__BBB_EN_2) { (*(pHead->P2)) = __AT__BBB_2;; }
return BBB;
}