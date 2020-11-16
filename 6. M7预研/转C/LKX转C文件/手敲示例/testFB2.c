#include"testFB2.h"
#include"Global.h"

void TestFB2(void* TestFB2_p)
{
	struct TestFB2* pHead = (struct TestFB2*)TestFB2_p;
	if (*pHead->FB2_Out1 == 0)
		*(pHead->FB2_Out1) = *(pHead->FB2_In1);

	if (*(pHead->FB2_In1) == 0)
	{
		//调用除0保护函数
		return;
	}
	if (pHead->FB2_In_Out1 == 0)
		*(pHead->FB2_In_Out1) = *(pHead->FB2_In1) + *(pHead->FB2_Out1) / *(pHead->FB2_In1)+ *g_2;

	if (pHead->FB2_temp1 == 0)
		*(pHead->FB2_temp1) = 10;
}