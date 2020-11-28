#include "BBB.h"
#include "HOLLYSYS-M7-AT-TASK-DEFINE.h"
#include "AAA.h"

void BBB() {
bool __AT__BBB_EN_1 = true;
bool __AT__BBB_1 = false;
if((bool)__AT__BBB_EN_1) { 
struct AAA AAA1;
AAA1.p1 = (*(int16_t*)(gl_ulDatRangeHeadAdress + H_GrVarHAdr + H_BBB_A));
AAA1.p2 = (*(int16_t*)(gl_ulDatRangeHeadAdress + H_GrVarHAdr + H_BBB_B));
AAA1.p3 = (*(int16_t*)(gl_ulDatRangeHeadAdress + H_GrVarHAdr + H_BBB_C));
__AT__BBB_1 = AAA(&AAA1); }
if((bool)__AT__BBB_EN_1) { (*(int16_t*)(gl_ulDatRangeHeadAdress + H_GrVarHAdr + H_BBB_C)) = AAA1.p3;; }
if((bool)__AT__BBB_EN_1) { (*(int16_t*)(gl_ulDatRangeHeadAdress + H_GrVarHAdr + H_BBB_D)) = __AT__BBB_1;; }
}