/***************************************************
* Copyright (c) 2009, ��������ʱϵͳ���̹ɷ����޹�˾
* All rights reserved.
* �ļ�����: hcc_hbtest.h
* ժ    Ҫ������HccMdlʱ��Ҫ�ĸ���ͷ�ļ�,��Щͷ�ļ��а�����
*			HBTest����Ҫ�����ݽṹ������������������
*
* ��ǰ�汾��0.0
* ��    �ߣ��Űٳ�
* ��ʼ���ڣ�2009��9��8��
* ȡ���汾���� 
* ԭ �� �ߣ���
* ������ڣ�2009��9��8��
***************************************************/

#ifndef _HBTEST_IMC_DEFINE_H_
#define _HBTEST_IMC_DEFINE_H_


/*********************************   �궨��   *********************************/
//���HCC.h�л��ظ����������ֵ
#ifndef __HCC_H__
enum{//�﷨����
	HCC_OP_START=0,     //���START��������ʼ
	HCC_OP_LOCAL,       //���LOCAL������ֲ�����
	HCC_OP_BLOCKBEG,    //���BLOCKBEG��{
	HCC_OP_BLOCKEND,    //���BLOCKEND��}
	HCC_OP_IF,          //���IF��if
	HCC_OP_IF_ELSE,     //���IF_ELSE��if else
	HCC_OP_FOR,         //���FOR��for
	HCC_OP_WHILE,       //���WHILE��while
	HCC_OP_DO_WHILE,    //���DO_WHILE��do while
	HCC_OP_SWITCH,      //���SWITCH��switch
    HCC_OP_BREAK,       //���BREAK��break
    HCC_OP_CONTINUE,    //���CONTINUE��continue
    HCC_OP_RETURN,      //���RETURN����������
    HCC_OP_CALL,        //���CALL����������
    HCC_OP_JUMP,        //���JUMP��goto
    HCC_OP_LABEL,       //���LABEL��������
    HCC_OP_ASGN,        //���ASGN��=
    HCC_OP_ADDRF,       //���ADDRF��&(��ȡ������ַ)
    HCC_OP_ADDRG,       //���ADDRG��&(��ȡȫ�ֵ�ַ)
    HCC_OP_ADDRL,       //���ADDRL��&(��ȡ�ֲ���ַ)
    HCC_OP_CNST,        //���CNST��ȡ����
    HCC_OP_VAR,         //���VAR��ȡ����
    HCC_OP_NOT,         //���NOT��!(�߼���)
    HCC_OP_BITNOT,      //���BITNOT��~(��λȡ��)
    HCC_OP_I8TO,        //���I8TO��I8���͵�ת��
    HCC_OP_I16TO,       //���I16TO��I16���͵�ת��
    HCC_OP_I32TO,       //���I32TO��I32���͵�ת��
    HCC_OP_U8TO,        //���U8TO��U8���͵�ת��
    HCC_OP_U16TO,       //���U16TO��U16���͵�ת��
    HCC_OP_U32TO,       //���U32TO��U32���͵�ת��
    HCC_OP_PTO,         //���PTO��P���͵�ת��
    HCC_OP_BOOLTO,      //���BOOLTO��BOOL���͵�ת��
    HCC_OP_BITTO,       //���BITTO��BIT���͵�ת��
    HCC_OP_F32TO,       //���F32TO��F32���͵�ת��
    HCC_OP_F64TO,       //���F64TO��F64���͵�ת��
    HCC_OP_INDIR,       //���INDIR��*(����ַȡֵ)
    HCC_OP_NEG,         //���NEG��-(ȡ�෴��)
    HCC_OP_CASE,        //���CAEE��SWITCH�е�CASE���,Ĭ�ϴ�break
    HCC_OP_ARG,         //���ARG����������ʱ����ʵ��
    HCC_OP_AND,         //���AND��&&(�߼���)
    HCC_OP_OR,          //���OR��||(�߼���)
    HCC_OP_XOR,         //���XOR���߼����
    HCC_OP_ADD,         //���ADD��+(��)
    HCC_OP_SUB,         //���SUB��-(��)
    HCC_OP_ADDP,        //���ADDP����ַ����
    HCC_OP_SUBP,        //���SUBP����ַ����
    HCC_OP_ADDPBIT,     //���ADDPBIT��λ��ַ����
    HCC_OP_SUBPBIT,     //���SUBPBIT��λ��ַ����
    HCC_OP_MUL,         //���MUL����ʾ*(��)
    HCC_OP_DIV,         //���DIV����ʾ/(��ȡ��)
    HCC_OP_MOD,         //���MOD����ʾ%(��ȡģ)
    HCC_OP_BITAND,      //���BITAND����ʾ&(λ��)
    HCC_OP_BITOR,       //���BITOR����ʾ|(λ��)
    HCC_OP_BITXOR,      //���BITXOR����ʾ^(λ���)
    HCC_OP_SHL,         //���SHL��<<(����)
    HCC_OP_SHR,         //���SHR��>>(����)
    HCC_OP_ROL,         //���ROL��ѭ������
    HCC_OP_ROR,         //���ROR��ѭ������
    HCC_OP_EQ,          //���EQ��==
    HCC_OP_NE,          //���NE��!=
    HCC_OP_GE,          //���GE��>=
    HCC_OP_GT,          //���GT��>
    HCC_OP_LE,          //���LE��<=
    HCC_OP_LT,          //���LT��<
	HCC_OP_SELECT,      //���SELECT��?:  //2010.01.12 llz
	HCC_OP_END          //���END����������
};
enum{//���͵�����,TK=TypeKind
	HCC_TK_VOID=0,      //���VOID
	HCC_TK_I8,          //���I8
	HCC_TK_I16,         //���I16
	HCC_TK_I32,         //���I32
	HCC_TK_U8,          //���U8
	HCC_TK_U16,         //���U16
	HCC_TK_U32,         //���U32
	HCC_TK_POINTER,     //���P
	HCC_TK_BOOL,        //���BOOL
	HCC_TK_BIT,         //���BIT
	HCC_TK_F32,         //���F32
	HCC_TK_F64,         //���F64
	HCC_TK_COMPLEX      //���COMPLEX
};
enum{//��������,SK=SymKind
	HCC_SK_VARIABLE=0,  //��������
	HCC_SK_FUNCTION     //��������
};
enum{//����������,SS=SymScope
	HCC_SS_GLOBAL=0,    //ȫ��������
	HCC_SS_PARAMETER,   //����������
	HCC_SS_LOCAL        //�ֲ�������
};
#define HCC_TREENODE_KIDS_NUM       3                //�﷨���ڵ���ӽڵ����
//��������
#define HCC_SUCCESS 0
//������
enum{//������3301~3500
	HCC_ERR_SETASM_0=3301,    //HccSetAsmState��������:HCC���ڱ���Ĺ����в����������Ƿ��������ļ�
	HCC_ERR_SETASM_1,         //HccSetAsmState��������:�ú�����������
	HCC_ERR_SETARCH_0,        //HccSetArchitecture��������:HCC���ڱ���Ĺ����в���������Ӳ��ƽ̨��Ϣ
	HCC_ERR_SETARCH_1,        //HccSetArchitecture��������:�ú�����������    
    HCC_ERR_INIT_CONFIF,      //Hcc��ʼ��ʧ��:����ָ�����ɳ��ִ���
	HCC_ERR_INIT_FILE         //Hcc��ʼ��ʧ��:�ϴα�����ļ�δ��ɾ��,HCC����
};
#define HCC_OUTPUT_NO_ASM         0
#define HCC_OUTPUT_ASM            1
#define HCC_INTEL_IA_32           0
#define HCC_POWERPC_E300          1
#define HCC_FPU_OK                0
#define HCC_NO_FPU                1
#define HCC_LITTLE_ENDIAN         0
#define HCC_BIG_ENDIAN            1
#define HCC_TIGHT_ALIGNMENT       0
#define HCC_NATURAL_ALIGNMENT     1
#define HCC_SET_ASM_OK            0  //HccSetAsmState���������������ļ��ɹ�
#define HCC_SET_ARCHI_OK          0  //HccSetArchitecture���������������ļ��ɹ�
#define HCC_CPU_KIND              0  //HccGetArchitecture�����Ĳ���ȡֵ
#define HCC_FPU_KIND              1  //HccGetArchitecture�����Ĳ���ȡֵ
#define HCC_ENDIAN_KIND           2  //HccGetArchitecture�����Ĳ���ȡֵ
#define HCC_ALIGNMENT_KIND        3  //HccGetArchitecture�����Ĳ���ȡֵ
#define HCC_GETARCH_PARA_ERR      -1 //HccGetArchitecture��������:�ú�����������
#define HCC_TREE_LEFT_SUB_NODE     0  //��ʾ���ӽڵ�
#define HCC_TREE_MIDDLE_SUB_NODE   1  //��ʾ���ӽڵ�
#define HCC_TREE_RIGHT_SUB_NODE    2  //��ʾ���ӽڵ�
//��������
/*********************************   ��������   *********************************/
typedef struct tagHccParameter    *pTagHccParameter;    //HCC���������б�ָ��
typedef struct tagHccTreeNode     *pTagHccTreeNode;     //�﷨���ڵ�ָ��
typedef struct tagHccSymbol       *pTagHccSymbol;       //HCC����ָ��
typedef struct tagHccType         *pTagHccType;         //HCC����ָ��
typedef struct tagHccRemarkNode   *pTagHccRemarkNode;   //HCC��Ҫ�Ľṹ,�������Ա༭ģ�������м����ʱΪ�ռ���
typedef struct tagHccParameter{                         
	pTagHccSymbol    pVar;                           //ָ���������
	pTagHccParameter pNext;                          //ָ����һ������
}HccParameter;                                       //HCC�����������ҵĲ����б�                  
typedef  struct tagHccTreeNode{                         
	char cOp;                                        //�﷨����
	char cTypeKind;                                  //���͵�����
	pTagHccTreeNode pFather;                         //���ڵ�ָ��
	pTagHccTreeNode pKids[HCC_TREENODE_KIDS_NUM];    //�����������ӽڵ��ָ�룬�������
	union HccSym{
		pTagHccSymbol pSym;                          //ָ���뱾�ڵ���صķ���
		union HccConstValue{                         
	           char           cI8Cnst;               //I8�ͳ���ֵ
			   short          sI16Cnst;              //I16�ͳ���ֵ
			   int            iI32Cnst;              //I32�ͳ���ֵ
			   unsigned char  ucU8Cnst;              //U8�ͳ���ֵ
			   unsigned short usU16Cnst;             //U16�ͳ���ֵ
			   unsigned int   uiU32Cnst;             //U32�ͳ���ֵ
			   unsigned char  ucBoolCnst;            //BOOL�ͳ���
			   unsigned char  ucBitCnst;             //BIT���ͳ���ֵ
			   unsigned int   uiPCnst;               //P�ͳ���ֵ
			   float          fF32Cnst;              //F32�ͳ���ֵ
			   double         dF64Cnst;              //F64�ͳ���ֵ
		}constValue;                                 //ָ���뱾�ڵ���صĳ���,cOp=CNST��CASEʱ��Ч
	}hccSymbol;                                      //ָ���뱾�ڵ���صķ��Ż���
	pTagHccTreeNode   pPrev, pNext;                  //�ò�ɭ���е���һ��������һ����
	pTagHccTreeNode   pStandby;                      //����
	pTagHccRemarkNode pRemarkNode;                   //ָ��һ���ṹ�壬ǰ���ṩʱ��Ϊ�ռ��ɡ�
}HccTreeNode;                                        //�﷨���ڵ�
typedef struct tagHccSymbol {
	char cSymKind;                                   //�������ࣺ��������
	char cSymScope;                                  //������������ȫ�֣��������ֲ���
	pTagHccType pType;                               //�÷��ŵ����ͣ����������ͻ��ߺ����ķ�������
	struct HccAddress{                               
		int   iByteOffset;                           //�ֽ�ƫ��:ȫ�ֱ�����ƫ����ǰ�˸���������Ϊ-1
		int   iBitOffset;	                         //����������ΪBITʱ��Ч����iByteOffset������ƫ�Ƶ�λ
		char* pName;                                 //�������ͱ�����
	}address;                                        //���ŵ�ַ
}HccSymbol;                                          //����
typedef struct tagHccType {
	char cTypeKind;                                  //���͵�����:V,I8,I16,I32,U8,U16,U32,P,F32,F64,BOOL,BIT,COMPLEX
	char cAlign;                                     //�����ֽ�������BIT����ʱΪ1��2��4������ΪBITʱΪ1��
	unsigned short  usSize;                          //���ʹ�С���ֽ�����������ΪBITʱΪ0��
}HccType;                                            //HCC����
#endif //#ifndef __HCC_H__

//IMC���������
enum IMC_FILE_TYPE
{
	IMC_NO_FILE = 0,	//��Ч�ļ�
	IMC_TYPE_FILE,		//�����ļ�
	IMC_SYM_FILE,		//�����ļ�
	IMC_NODE_FILE,		//�ڵ��ļ�
};
enum IMC_KIND_TYPE
{
	IMC_NO_KIND = 0,
	IMC_OP_KIND,
	IMC_TK_KIND,
	IMC_SK_KIND,
	IMC_SS_KIND,
};

union CONSTANT{                         
	char           cI8Cnst;               //I8�ͳ���ֵ
	short          sI16Cnst;              //I16�ͳ���ֵ
	int            iI32Cnst;              //I32�ͳ���ֵ
	unsigned char  ucU8Cnst;              //U8�ͳ���ֵ
	unsigned short usU16Cnst;             //U16�ͳ���ֵ
	unsigned int   uiU32Cnst;             //U32�ͳ���ֵ
	unsigned char  ucBoolCnst;            //BOOL�ͳ���
	unsigned char  ucBitCnst;             //BIT���ͳ���ֵ
	unsigned int   uiPCnst;               //P�ͳ���ֵ
	float          fF32Cnst;              //F32�ͳ���ֵ
	double         dF64Cnst;              //F64�ͳ���ֵ
}; 

#endif