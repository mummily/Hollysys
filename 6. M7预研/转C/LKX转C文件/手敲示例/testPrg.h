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
res: = Factorial(g1, d2);//ֻ�ܴ���������
test_fb_obj(in1: = g1, in_out1 : = d2, temp1 : = res);//���������������Ҳ���Բ���
out2: = test_fb_obj.out2;
(*end program*)*/
//����ȫ�Ǵ�д ����ȫ��Сд, test_fb_obj2.res
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

////pou������prg����
///temp ���͵ı�����ȫ��ָ�����,���� hol_g_p_ prg����+�������ƣ�����������hol��ͷ
////ȫ�����Ͷ�����global.h�� ȫ�ֱ���������_������ 
///while for repeat�������Ƶ�ͳ�Ʊ����ں�������,����Ϊlong


//prg����֮ǰ�����е�ȫ�ֱ�����prg����������ڴ�,ֱ�Ӻ궨��