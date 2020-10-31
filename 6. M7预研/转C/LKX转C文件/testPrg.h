/*(*program test_prg
	Var_temp
	g1 : int
	g2 : int
	d3 : Dword
	d2 : Dword
	res : int
	test_fb_obj : TestFB;
out2:dword
end_var*)
g1: = d2 / 4 + test_fb_obj2.res;
res: = Factorial(g1, d2);//只能传两个参数
test_fb_obj(in1: = g1, in_out1 : = d2, temp1 : = res);//最多这三个参数，也可以不传
out2: = test_fb_obj.out2;
(*end program*)*/
//类型全是大写 变量全是小写, test_fb_obj2.res
#ifndef __TEST_PRG_H_
#define __TEST_PRG_H_
#include<stdint.h>
#include"testFB.h"

#define hol_g_p_testPrg_g1 ((uint16_t*)0x1243677)
#define hol_g_p_testPrg_d2 ((uint32_t*)0x1283678)
#define hol_g_p_Prg_out2 ((uint32_t*)0x12373679)
#define hol_g_p_testPrg_res ((uint16_t*)0x12f33680)
#define Hol_g_p_testPrg_g2 ((uint16_t  *)0x1234387681)
#define Hol_g_p_testPrg_d3 ((uint32_t *)0x123439681)
#define Hol_g_p_testPrg_test_fb_obj ((struct TestFB  *)0x123433681)
void testPrg();

#endif

////pou名称是prg名称
///temp 类型的变量是全局指针变量,名称 hol_g_p_ prg名称+变量名称，其他不能以hol开头
////全局类型定义在global.h里 全局变量工程名_变量名 
///while for repeat变量名称的统计变量在函数体内,类型为long


//prg调用之前，所有的全局变量，prg变量分配好内存,直接宏定义