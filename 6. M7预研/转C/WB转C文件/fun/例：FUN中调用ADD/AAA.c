#include "AAA.h"
#include "HOLLYSYS-M7-AT-TASK-DEFINE.h"

bool AAA(void* _pHead) {
bool AAA = false;
struct AAA* pHead = (struct AAA*)_pHead;
bool __AT__AAA_EN_3 = true;
uint8_t __AT__AAA_3 = 0;
if((bool)__AT__AAA_EN_3) { 
__AT__AAA_3 = (*(pHead->P1))+(*(pHead->P2)); }
if((bool)__AT__AAA_EN_3) { (*(pHead->P3)) = __AT__AAA_3;; }
return AAA;
}