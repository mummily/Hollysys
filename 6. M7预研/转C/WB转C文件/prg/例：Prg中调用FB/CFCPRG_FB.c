#include "CFCPRG_FB.h"
#include "HOLLYSYS-M7-AT-TASK-DEFINE.h"
#include "CFCFB.h"

void CFCPRG_FB() {
bool __AT__CFCPRG_FB_EN_1 = true;
if((bool)__AT__CFCPRG_FB_EN_1){
struct CFCFB fb01;
fb01.p1 = ((int16_t*)(gl_ulDatRangeHeadAdress + H_GrVarHAdr + H_CFCPRG_FB_FB01_p1));
fb01.p2 = ((int16_t*)(gl_ulDatRangeHeadAdress + H_GrVarHAdr + H_CFCPRG_FB_FB01_p2));
fb01.p3 = ((int16_t*)(gl_ulDatRangeHeadAdress + H_GrVarHAdr + H_CFCPRG_FB_FB01_p3));
fb01.p5 = ((int16_t*)(gl_ulDatRangeHeadAdress + H_GrVarHAdr + H_CFCPRG_FB_FB01_p5));
fb01.p4 = ((int16_t*)(gl_ulDatRangeHeadAdress + H_GrVarHAdr + H_CFCPRG_FB_FB01_p4));
(*(fb01.p1)) = (*(((int16_t*)(gl_ulDatRangeHeadAdress + H_GrVarHAdr + H_CFCPRG_FB_A))));
(*(fb01.p2)) = (*(((int16_t*)(gl_ulDatRangeHeadAdress + H_GrVarHAdr + H_CFCPRG_FB_B))));
(*(fb01.p4)) = (*(((int16_t*)(gl_ulDatRangeHeadAdress + H_GrVarHAdr + H_CFCPRG_FB_C))));
CFCFB(&fb01);
}
if((bool)__AT__CFCPRG_FB_EN_1){
(*(((int16_t*)(gl_ulDatRangeHeadAdress + H_GrVarHAdr + H_CFCPRG_FB_D)))) = (*(fb01.p3));
}
if((bool)__AT__CFCPRG_FB_EN_1){
(*(((int16_t*)(gl_ulDatRangeHeadAdress + H_GrVarHAdr + H_CFCPRG_FB_E)))) = (*(fb01.p4));
}
}