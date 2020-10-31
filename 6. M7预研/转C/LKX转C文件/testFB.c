#include"testFB.h"
#include<malloc.h>
#include"Global.h"

void TestFB(void* TestFB_p)
{
	//	//强制标记
	struct TestFB* pHead = (struct TestFB*)TestFB_p;
	//强制标记
	if(*pHead->FB_Out1  == 0)
		*(pHead->FB_Out1) =  *(pHead->FB_In1);

	if(*(pHead->FB_In1) == 0)
	{
		//调用除0保护函数
		return;
	}
	//强制标记
	if(pHead->FB_In_Out1 == 0)
		*(pHead->FB_In_Out1) =  *(pHead->FB_In1) + *(pHead->FB_Out1)/ *(pHead->FB_In1)+*g_0;
	
	//强制标记
	if(pHead->FB_temp1 == 0)
		*(pHead->FB_temp1) = 10;
	//计算偏移地址 
	*pHead->testFB1obj.FB1_In1 = *pHead->FB_In1;
	TestFB1(&pHead->testFB1obj);
	
	TestFB2(&pHead->testFB1obj2);
}
