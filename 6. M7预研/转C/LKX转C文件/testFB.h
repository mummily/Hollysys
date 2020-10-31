#ifndef __TEST_FB_H_
#define __TEST_FB_H_
#include<stdint.h>
#include<stdbool.h>
#include"testFB1.h"
#include"testFB2.h"
/*(*Function_Block TestFB*)
(*VAR_INPUT
	FB_In1 : INT
	testFB1obj:testFB1
	testFB2obj:testFB2
	END_VAR
	VAR_TEMP
	FB_Temp1 : INT
	END_VAR
	VAR_OUTPUT
	FB_Out1 : DWORD
	ENDVAR
	VAR_INOUTPUT
	FB_IN_Out1 : DWORD
	ENDVAR*)
	FB_OUT1: = FB_in1;
	FB_IN_out1: = FB_in1 + FB_out1 / FB_in1 + g_0;
	testFb1(FB_In2:=FB_In1);
	testFb2();
	testPrg();//形成闭环非法-del
	FB_temp1: = 10;
(*End_Function_Block*)*/
////pou名称是函数名称
//
 //一字节对齐
#pragma pack(1) //让编译器对这个结构作1字节对齐
struct TestFB  // FB_Test.h
{
	uint32_t* FB_In1;
	struct TestFB1 testFB1obj;
	struct TestFB2 testFB1obj2;
	uint32_t* FB_In_Out1;
	uint16_t* FB_Out1;
	uint16_t* FB_temp1;
};
#pragma pack() //取消1字节对齐，恢复为默认4字节对齐

void TestFB(void * TestFB_p);
#endif
 //*.h
//1.把所有的变量都定义在一个结构体内,结构体类型与ST保持一致，结构体类型是pou名称
//2.定义执行函数    无返回值 名称是  结构体类型名称 (类型是void指针  名称是address)参数为指针   \
  (类型是void* 名称是address)变量首地址

//全局类型定义在global.h里  全局变量 库工程名称+全局变量名称

///prg 类型的变量是全局指针变量,名称 hol_g_prg名称+变量名称


//翻译赋值语句
//调用执行体语句

//功能块调用prg
//内存已经分好了不需要重新分配