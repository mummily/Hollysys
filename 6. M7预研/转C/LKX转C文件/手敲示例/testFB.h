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
	testPrg();//�γɱջ��Ƿ�-del
	FB_temp1: = 10;
(*End_Function_Block*)*/
////pou�����Ǻ�������
//
 //һ�ֽڶ���
#pragma pack(1) //�ñ�����������ṹ��1�ֽڶ���
struct TestFB  // FB_Test.h
{
	uint32_t* FB_In1;
	struct TestFB1 testFB1obj;
	struct TestFB2 testFB1obj2;
	uint32_t* FB_In_Out1;
	uint16_t* FB_Out1;
	uint16_t* FB_temp1;
};
#pragma pack() //ȡ��1�ֽڶ��룬�ָ�ΪĬ��4�ֽڶ���

void TestFB(void * TestFB_p);
#endif
 //*.h
//1.�����еı�����������һ���ṹ����,�ṹ��������ST����һ�£��ṹ��������pou����
//2.����ִ�к���    �޷���ֵ ������  �ṹ���������� (������voidָ��  ������address)����Ϊָ��   \
  (������void* ������address)�����׵�ַ

//ȫ�����Ͷ�����global.h��  ȫ�ֱ��� �⹤������+ȫ�ֱ�������

///prg ���͵ı�����ȫ��ָ�����,���� hol_g_prg����+��������


//���븳ֵ���
//����ִ�������

//���ܿ����prg
//�ڴ��Ѿ��ֺ��˲���Ҫ���·���