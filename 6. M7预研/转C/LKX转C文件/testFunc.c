#include<stdint.h>
#include"testFunc.h"
#include"testPrg.h"

int16_t   hol_Factorial_i = 0;
int16_t   hol_Factorial_gap = 0;

int16_t Factorial(void* hol_Factorial_p)
{
	/////////////////////////////////
	int16_t   Factorial = 0; //函数返回值定义栈空间
	struct Factorial *pHead = (struct Factorial*)hol_Factorial_p;
	
	///////////////////////////////////////
	//取s的强制属性
	if (pHead->X == 0)
	{
		*(pHead->X) = 10 ;
	}
	if (hol_Factorial_gap > 0)
	{
		long AT_ST_CHECK_DEAD_LOOP = 0;
		while (hol_Factorial_i <= *(pHead->X))
		{
			if (AT_ST_CHECK_DEAD_LOOP > 2000)
			{
				//调用异常保护函数AT_FillPOUErrorData t
				return Factorial;
			}
			//取acc的强制属性
			if (pHead->Acc == 0)
			{
				*pHead->Acc = (*pHead->Acc) * hol_Factorial_i + *hol_g_p_testPrg_g1;
			}
			hol_Factorial_i = hol_Factorial_i + hol_Factorial_gap;
		}
		AT_ST_CHECK_DEAD_LOOP++;

	}
	else
	{
		long AT_ST_CHECK_DEAD_LOOP = 0;
		while (hol_Factorial_i >= *pHead->X)
		{
			if (AT_ST_CHECK_DEAD_LOOP > 2000)
			{
				//调用异常保护函数AT_FillPOUErrorData t
				return Factorial;
			}
			//取acc的强制属性
			if (pHead->Acc == 0)
			{
				*(pHead->Acc) = (*(pHead->Acc)) * hol_Factorial_i + *hol_g_p_testPrg_g1;
			}
			hol_Factorial_i = hol_Factorial_i + hol_Factorial_gap;
			AT_ST_CHECK_DEAD_LOOP++;
		}

	}
	*pHead->Acc = *hol_g_p_testPrg_d2;
	return Factorial;
}