#include"testFB1.h"
#include"testFB2.h"
#include"testPrg.h"
#include"Global.h"

void TestFB1(void* TestFB1_p)
{

	struct TestFB1* pHead = (struct TestFB1*)TestFB1_p;
	if (*pHead->FB1_Out1 == 0)
		*(pHead->FB1_Out1) = *(pHead->FB1_In1);

	if (*(pHead->FB1_In1) == 0)
	{
		//调用除0保护函数
		return;
	}
	if (pHead->FB1_In_Out1 == 0)
		*(pHead->FB1_In_Out1) = *(pHead->FB1_In1) + *(pHead->FB1_Out1) / *(pHead->FB1_In1)+ *g_1;

	if (pHead->FB1_temp1 == 0)
		*(pHead->FB1_temp1) = 10;


	*pHead->testFB2obj.FB2_In1 = *pHead->FB1_In1;
	TestFB2(&pHead->testFB2obj);
}

