#ifndef __TEST_FB2_H_
#define __TEST_FB2_H_
#include<stdint.h>
#include<stdbool.h>

/*(*Function_Block FB_Test*)
(*VAR_INPUT
	FB2_In1 : INT
	END_VAR
	VAR_TEMP
	FB2_Temp1 : INT
	END_VAR
	VAR_OUTPUT
	FB2_Out1 : DWORD
	ENDVAR
	VAR_INOUTPUT
	FB2_IN_Out1 : DWORD
	ENDVAR*)
	FB2_OUT1: = FB2_in1;
	FB2_IN_out1: = FB2_in1 + FB2_out1 / FB2_in1+g2;
    FB2_temp1: = 10;
(*End_Function_Block*)*/

#pragma pack(1) //让编译器对这个结构作1字节对齐
struct TestFB2  // FB_Test.h
{
	uint32_t* FB2_In1;
	uint32_t* FB2_In_Out1;
	uint16_t* FB2_Out1;
	uint16_t* FB2_temp1;
};
#pragma pack() //取消1字节对齐，恢复为默认4字节对齐

void TestFB2(void* TestFB2_p);
#endif
