#include"testFunc.h"
#include"Global.h"
#include"testFB.h"
#include"testPrg.h"



void testPrg()  // test_prg.c
{
	long aa = sizeof(struct TestFB);
	aa = sizeof(struct TestFB1);
	aa = sizeof(struct TestFB2);
	struct TestFB* hol_pHead = Hol_g_p_testPrg_test_fb_obj;
	void* pTemp[4] = {0};
	pTemp[0] = hol_g_p_testPrg_g1;
	pTemp[1] = Hol_g_p_testPrg_g2;
	pTemp[2] = hol_g_p_testPrg_d2;
	pTemp[3] = Hol_g_p_testPrg_d3;
	//模拟分配地址
	*hol_g_p_testPrg_res = Factorial(pTemp);//只能传两个参数

	//强制变量
	if(hol_pHead->FB_In1 == 0)
		* (hol_pHead->FB_In1) = *hol_g_p_testPrg_g1;

	//强制变量
	if(hol_pHead->FB_In_Out1 == 0)
		* (hol_pHead->FB_In_Out1) = *hol_g_p_testPrg_d2;

	//强制变量
	if(hol_pHead->FB_temp1 == 0)
		*(hol_pHead->FB_temp1) = *hol_g_p_testPrg_res;

	TestFB(hol_pHead);

	if (hol_g_p_Prg_out2 == 0)
		*(hol_g_p_Prg_out2) = *(hol_pHead->FB_Out1);
	

}
