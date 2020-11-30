#include "AAA.h"
#include "HOLLYSYS-M7-AT-TASK-DEFINE.h"

void AAA(void* _pHead) {
struct AAA* pHead = (struct AAA*)_pHead;
bool __AT__AAA_EN_3 = true;
int16_t __AT__AAA_3 = 0;
if((bool)__AT__AAA_EN_3) { 
__AT__AAA_3 = (*(pHead->A))+(*(pHead->B)); }
if((bool)__AT__AAA_EN_3) { (*(pHead->C)) = __AT__AAA_3;; }
}