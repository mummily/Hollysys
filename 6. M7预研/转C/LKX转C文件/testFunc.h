#ifndef  __TEST_FUN_H_
#define  __TEST_FUN_H_
#include<stdint.h>
//������֧�ֵݹ�,������ʱ�������ܵ����Լ�
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
//�и������ͣ���������ֱ�ӽṹ�����
struct Factorial
{
	uint16_t* X;
	uint8_t* X1;
	uint16_t* Acc;
	uint16_t* Acc1;
};
//���������߶���������ֵ�����׵�ַ
int16_t Factorial(void* Factorial_p);
#endif // ! __TEST_H_


//.h
////pou�����Ǻ�������

/////1.�����еı�����������һ���ṹ����,�ṹ��������ST����һ�£��ṹ��������pou����
////in ������� �����ͬ���͵�ָ�룬
////INout����������������ͬ����ָ��
/////����ֵ����Ϊpou����  ����Ϊ������������

///�����ȫ�ֱ���  �⹤������+ȫ�ֱ�������,������global��

//*.c

///����й��ܿ�������û�prg�������ã�ͷ�ļ���������  ��������(����) 
//�����ȫ�ֱ���,ȫ�ֱ���ͷ�ļ�������
//////temp ���͵ı����Ǳ��ؾ�̬������,����hol_ + pou���� _����
///while for repeat�������Ƶ�ͳ�Ʊ����ں������� long


//�����е��ù��ܿ�
//���ܿ���Ϊȫ�ֱ������ã����ȱ��������ڴ�

//�����е���prg
//��������prg��prg�Ѿ����ȷ�����ڴ棬ֱ�ӵ���

//�����ľֲ������ĵ�ַ�����ھ�̬������