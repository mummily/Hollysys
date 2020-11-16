#ifndef  __TEST_FUN_H_
#define  __TEST_FUN_H_
#include<stdint.h>
//函数不支持递归,语义检查时函数不能调用自己
/*(*Function Factorial : INT*)
(*VAR_INPUT
	X : INT
	X1: SINT
	END_VAR

	VAR_TEMP ---jing tai bian liang qu 
	I : INT
	Gap : INT
	END_VAR


	VAR_INOUTPUT
	Acc : DWORD
	Acc1 : DWORD
	ENDVAR*)
	X: = 10;
Gap: = 2;
FOR I : = 1 to x  by Gap do
acc : = acc * I + test_prg.g1;
end_for 

acc := testPrg.d2;

*/
//有复杂类型，复杂类型直接结构体对象
struct Factorial
{
	uint16_t* X;
	uint8_t* X1;
	uint16_t* Acc;
	uint16_t* Acc1;
};
//多个输入或者多个输入输出值传入首地址
int16_t Factorial(void* Factorial_p);
#endif // ! __TEST_H_


//.h
////pou名称是函数名称

/////1.把所有的变量都定义在一个结构体内,结构体类型与ST保持一致，结构体类型是pou名称
////in 输入变量 翻译成同类型的指针，
////INout输入输出变量翻译成同类型指针
/////返回值名称为pou名称  类型为函数返回类型

///如果有全局变量  库工程名称+全局变量名称,定义在global里

//*.c

///如果有功能块变量调用或prg变量调用，头文件包含进来  类型名称(参数) 
//如果有全局变量,全局变量头文件包进来
//////temp 类型的变量是本地静态区变量,名称hol_ + pou名称 _名称
///while for repeat变量名称的统计变量在函数体内 long


//函数中调用功能块
//功能块作为全局变量调用，事先必须分配好内存

//函数中调用prg
//函数调用prg，prg已经事先分配好内存，直接调用

//函数的局部变量的地址定义在静态变量区