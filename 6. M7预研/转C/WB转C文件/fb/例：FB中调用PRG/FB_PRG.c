#include "FB_PRG.h"
#include "HOLLYSYS-M7-AT-TASK-DEFINE.h"
#include "CFCPRG.h"
void FB_PRG(void* _pHead) {
struct FB_PRG* pHead = (struct FB_PRG*)_pHead;
bool __AT__FB_PRG_EN_1 = true;
if((bool)__AT__FB_PRG_EN_1){
CFCPRG();
}
}