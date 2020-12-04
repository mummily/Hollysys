#include "aaa.h"
#include "HOLLYSYS-M7-AT-TASK-DEFINE.h"

void aaa() {
bool __AT__AAA_EN_3 = true;
int16_t __AT__AAA_3 = 0;
if((bool)__AT__AAA_EN_3) { 
__AT__AAA_3 = (*(int16_t*)(gl_ulDatRangeHeadAdress + H_GrVarHAdr + H_aaa_a))+(*(int16_t*)(gl_ulDatRangeHeadAdress + H_GrVarHAdr + H_aaa_b)); }
if((bool)__AT__AAA_EN_3) { (*(int16_t*)(gl_ulDatRangeHeadAdress + H_GrVarHAdr + H_aaa_c)) = __AT__AAA_3;; }
}