#ifndef __TEST_FB1_H_
#define __TEST_FB1_H_
#include<stdint.h>
#include<stdbool.h>
#include"testFB2.h"
/*(*Function_Block FB_Test*)
(*VAR_INPUT
	FB1_In1 : INT
	testFB2obj:testFB2
	END_VAR
	VAR_TEMP
	FB1_Temp1 : INT
	END_VAR
	VAR_OUTPUT
	FB1_Out1 : DWORD
	ENDVAR
	VAR_INOUTPUT
	FB1_IN_Out1 : DWORD
	ENDVAR*)
	FB1_OUT1: = FB1_in1;
	FB1_IN_out1: = FB1_in1 + FB1_out1 / FB1_in1 + g_1;
	testFB2obj(FB2_In1:=FB1_In1);
	testFB2obj(FB2_In1:=FB1_In1);
	FB1_temp1: = 10;
(*End_Function_Block*)*/
#pragma pack(1) //让编译器对这个结构作1字节对齐
struct TestFB1  // FB_Test.h
{
	uint32_t* FB1_In1;
	struct TestFB2 testFB2obj;
	uint32_t* FB1_In_Out1;
	uint16_t* FB1_Out1;
	uint16_t* FB1_temp1;
};
#pragma pack() //取消1字节对齐，恢复为默认4字节对齐
void TestFB1(void* TestFB1_p);
#endif