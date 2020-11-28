#include "AAA.h"
#include "HOLLYSYS-M7-AT-TASK-DEFINE.h"
#include "BBB.h"

bool AAA(void* _pHead) {
bool AAA = false;
struct AAA* pHead = (struct AAA*)_pHead;
bool __AT__AAA_EN_1 = true;
bool __AT__AAA_1 = false;
if((bool)__AT__AAA_EN_1) { 
struct BBB BBB1;
BBB1.P1 = pHead->A;
BBB1.P2 = pHead->B;
__AT__AAA_1 = BBB(&BBB1); }
if((bool)__AT__AAA_EN_1) { (*(pHead->B)) = BBB1.P2;; }
if((bool)__AT__AAA_EN_1) { (*(pHead->C)) = __AT__AAA_1;; }
return AAA;
}