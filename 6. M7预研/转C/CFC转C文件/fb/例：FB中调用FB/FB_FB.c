#include "FB_FB.h"
#include "HOLLYSYS-M7-AT-TASK-DEFINE.h"
#include "CFCFB.h"

void FB_FB(void* _pHead) {
struct FB_FB* pHead = (struct FB_FB*)_pHead;
bool __AT__FB_FB_EN_1 = true;
if((bool)__AT__FB_FB_EN_1){
(*(pHead->fb01.p1)) = (*(pHead->a));
(*(pHead->fb01.p2)) = (*(pHead->b));
(*(pHead->fb01.p4)) = (*(pHead->c));
CFCFB(&(pHead->fb01));
}
if((bool)__AT__FB_FB_EN_1){
(*(((int16_t*)(pHead->d)))) = (*(pHead->fb01.p3));
}
if((bool)__AT__FB_FB_EN_1){
(*(((int16_t*)(pHead->e)))) = (*(pHead->fb01.p4));
}
}