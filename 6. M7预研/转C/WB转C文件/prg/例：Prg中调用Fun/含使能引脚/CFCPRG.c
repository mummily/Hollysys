#include "CFCPRG.h"
#include "HOLLYSYS-M7-AT-TASK-DEFINE.h"
#include "CFCFUN.h"

void CFCPRG() {
bool __AT__CFCPRG_EN_1 = (*(((int16_t*)(gl_ulDatRangeHeadAdress + H_GrVarHAdr + H_CFCPRG_FEN))));
bool __AT__CFCPRG_1 = false;
if((bool)__AT__CFCPRG_EN_1) { struct CFCFUN CFCFUN1;
CFCFUN1.P1 = ((int16_t*)(gl_ulDatRangeHeadAdress + H_GrVarHAdr + H_CFCPRG_A));
CFCFUN1.P2 = ((int16_t*)(gl_ulDatRangeHeadAdress + H_GrVarHAdr + H_CFCPRG_B));
CFCFUN1.P3 = ((int16_t*)(gl_ulDatRangeHeadAdress + H_GrVarHAdr + H_CFCPRG_C));
__AT__CFCPRG_1 = CFCFUN(&CFCFUN1); }
if((bool)__AT__CFCPRG_EN_1) { (*(((int16_t*)(gl_ulDatRangeHeadAdress + H_GrVarHAdr + H_CFCPRG_D)))) = __AT__CFCPRG_1;; }
if((bool)__AT__CFCPRG_EN_1) { (*(((int16_t*)(gl_ulDatRangeHeadAdress + H_GrVarHAdr + H_CFCPRG_FENO)))) = __AT__CFCPRG_EN_1;; }
}