#include "aaa.h"
#include "HOLLYSYS-M7-AT-TASK-DEFINE.h"

BOOL aaa(void* pHead) {
bool aaa = false;
struct aaa* pFun = (struct aaa*)pHead;
bool __AT__AAA_EN_3 = true;
int16_t __AT__AAA_3 = 0;
if((bool)__AT__AAA_EN_3) { 
__AT__AAA_3 = pFun->a+pFun->b; }
if((bool)__AT__AAA_EN_3) { pFun->c = __AT__AAA_3;; }
return aaa;
}
