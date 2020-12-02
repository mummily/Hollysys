#include "CFCPRG_FB.h"
#include "HOLLYSYS-M7-AT-TASK-DEFINE.h"
#include "CFCFB.h"

void CFCPRG_FB() {
bool __AT__CFCPRG_FB_EN_1 = true;

if((bool)__AT__CFCPRG_FB_EN_1){

struct CFCFB FB01;
FB01.P1 = ((int16_t*)(gl_ulDatRangeHeadAdress + H_GrVarHAdr + H_CFCPRG_FB_FB01_P1));
FB01.P2 = ((int16_t*)(gl_ulDatRangeHeadAdress + H_GrVarHAdr + H_CFCPRG_FB_FB01_P2));
FB01.P3 = ((int16_t*)(gl_ulDatRangeHeadAdress + H_GrVarHAdr + H_CFCPRG_FB_FB01_P3));
FB01.P5 = ((int16_t*)(gl_ulDatRangeHeadAdress + H_GrVarHAdr + H_CFCPRG_FB_FB01_P5));
FB01.P4 = ((int16_t*)(gl_ulDatRangeHeadAdress + H_GrVarHAdr + H_CFCPRG_FB_FB01_P4));
(*(FB01.P1)) = (*(((int16_t*)(gl_ulDatRangeHeadAdress + H_GrVarHAdr + H_CFCPRG_FB_A))));
(*(FB01.P2)) = (*(((int16_t*)(gl_ulDatRangeHeadAdress + H_GrVarHAdr + H_CFCPRG_FB_B))));
(*(FB01.P4)) = (*(((int16_t*)(gl_ulDatRangeHeadAdress + H_GrVarHAdr + H_CFCPRG_FB_C))));
CFCFB(&FB01);

}
if((bool)__AT__CFCPRG_FB_EN_1) { (*(((int16_t*)(gl_ulDatRangeHeadAdress + H_GrVarHAdr + H_CFCPRG_FB_D)))) = (*(FB01.P3));; }
if((bool)__AT__CFCPRG_FB_EN_1) { (*(((int16_t*)(gl_ulDatRangeHeadAdress + H_GrVarHAdr + H_CFCPRG_FB_E)))) = (*(FB01.P4));; }
}