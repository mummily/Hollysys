/***************************************************
* Copyright (c) 2009, 北京和利时系统工程股份有限公司
* All rights reserved.
* 文件名称: hcc_hbtest.h
* 摘    要：测试HccMdl时需要的各个头文件,这些头文件中包含了
*			HBTest所需要的数据结构、导出函数、常量等
*
* 当前版本：0.0
* 作    者：张百成
* 开始日期：2009年9月8号
* 取代版本：无 
* 原 作 者：无
* 完成日期：2009年9月8号
***************************************************/

#ifndef _HBTEST_IMC_DEFINE_H_
#define _HBTEST_IMC_DEFINE_H_


/*********************************   宏定义   *********************************/
//如果HCC.h中会重复定义下面的值
#ifndef __HCC_H__
enum{//语法操作
	HCC_OP_START=0,     //简称START，函数开始
	HCC_OP_LOCAL,       //简称LOCAL，定义局部变量
	HCC_OP_BLOCKBEG,    //简称BLOCKBEG，{
	HCC_OP_BLOCKEND,    //简称BLOCKEND，}
	HCC_OP_IF,          //简称IF，if
	HCC_OP_IF_ELSE,     //简称IF_ELSE，if else
	HCC_OP_FOR,         //简称FOR，for
	HCC_OP_WHILE,       //简称WHILE，while
	HCC_OP_DO_WHILE,    //简称DO_WHILE，do while
	HCC_OP_SWITCH,      //简称SWITCH，switch
    HCC_OP_BREAK,       //简称BREAK，break
    HCC_OP_CONTINUE,    //简称CONTINUE，continue
    HCC_OP_RETURN,      //简称RETURN，函数返回
    HCC_OP_CALL,        //简称CALL，函数调用
    HCC_OP_JUMP,        //简称JUMP，goto
    HCC_OP_LABEL,       //简称LABEL，定义标号
    HCC_OP_ASGN,        //简称ASGN，=
    HCC_OP_ADDRF,       //简称ADDRF，&(获取参数地址)
    HCC_OP_ADDRG,       //简称ADDRG，&(获取全局地址)
    HCC_OP_ADDRL,       //简称ADDRL，&(获取局部地址)
    HCC_OP_CNST,        //简称CNST，取常量
    HCC_OP_VAR,         //简称VAR，取变量
    HCC_OP_NOT,         //简称NOT，!(逻辑非)
    HCC_OP_BITNOT,      //简称BITNOT，~(按位取反)
    HCC_OP_I8TO,        //简称I8TO，I8类型的转换
    HCC_OP_I16TO,       //简称I16TO，I16类型的转换
    HCC_OP_I32TO,       //简称I32TO，I32类型的转换
    HCC_OP_U8TO,        //简称U8TO，U8类型的转换
    HCC_OP_U16TO,       //简称U16TO，U16类型的转换
    HCC_OP_U32TO,       //简称U32TO，U32类型的转换
    HCC_OP_PTO,         //简称PTO，P类型的转换
    HCC_OP_BOOLTO,      //简称BOOLTO，BOOL类型的转换
    HCC_OP_BITTO,       //简称BITTO，BIT类型的转换
    HCC_OP_F32TO,       //简称F32TO，F32类型的转换
    HCC_OP_F64TO,       //简称F64TO，F64类型的转换
    HCC_OP_INDIR,       //简称INDIR，*(按地址取值)
    HCC_OP_NEG,         //简称NEG，-(取相反数)
    HCC_OP_CASE,        //简称CAEE，SWITCH中的CASE情况,默认带break
    HCC_OP_ARG,         //简称ARG，函数调用时传递实参
    HCC_OP_AND,         //简称AND，&&(逻辑与)
    HCC_OP_OR,          //简称OR，||(逻辑或)
    HCC_OP_XOR,         //简称XOR，逻辑异或
    HCC_OP_ADD,         //简称ADD，+(加)
    HCC_OP_SUB,         //简称SUB，-(减)
    HCC_OP_ADDP,        //简称ADDP，地址增加
    HCC_OP_SUBP,        //简称SUBP，地址减少
    HCC_OP_ADDPBIT,     //简称ADDPBIT，位地址增加
    HCC_OP_SUBPBIT,     //简称SUBPBIT，位地址减少
    HCC_OP_MUL,         //简称MUL，表示*(乘)
    HCC_OP_DIV,         //简称DIV，表示/(除取商)
    HCC_OP_MOD,         //简称MOD，表示%(除取模)
    HCC_OP_BITAND,      //简称BITAND，表示&(位与)
    HCC_OP_BITOR,       //简称BITOR，表示|(位或)
    HCC_OP_BITXOR,      //简称BITXOR，表示^(位异或)
    HCC_OP_SHL,         //简称SHL，<<(左移)
    HCC_OP_SHR,         //简称SHR，>>(右移)
    HCC_OP_ROL,         //简称ROL，循环左移
    HCC_OP_ROR,         //简称ROR，循环右移
    HCC_OP_EQ,          //简称EQ，==
    HCC_OP_NE,          //简称NE，!=
    HCC_OP_GE,          //简称GE，>=
    HCC_OP_GT,          //简称GT，>
    HCC_OP_LE,          //简称LE，<=
    HCC_OP_LT,          //简称LT，<
	HCC_OP_SELECT,      //简称SELECT，?:  //2010.01.12 llz
	HCC_OP_END          //简称END，函数结束
};
enum{//类型的种类,TK=TypeKind
	HCC_TK_VOID=0,      //简称VOID
	HCC_TK_I8,          //简称I8
	HCC_TK_I16,         //简称I16
	HCC_TK_I32,         //简称I32
	HCC_TK_U8,          //简称U8
	HCC_TK_U16,         //简称U16
	HCC_TK_U32,         //简称U32
	HCC_TK_POINTER,     //简称P
	HCC_TK_BOOL,        //简称BOOL
	HCC_TK_BIT,         //简称BIT
	HCC_TK_F32,         //简称F32
	HCC_TK_F64,         //简称F64
	HCC_TK_COMPLEX      //简称COMPLEX
};
enum{//符号种类,SK=SymKind
	HCC_SK_VARIABLE=0,  //变量符号
	HCC_SK_FUNCTION     //函数符号
};
enum{//符号作用域,SS=SymScope
	HCC_SS_GLOBAL=0,    //全局作用域
	HCC_SS_PARAMETER,   //参数作用域
	HCC_SS_LOCAL        //局部作用域
};
#define HCC_TREENODE_KIDS_NUM       3                //语法树节点的子节点个数
//新增部分
#define HCC_SUCCESS 0
//错误码
enum{//错误码3301~3500
	HCC_ERR_SETASM_0=3301,    //HccSetAsmState函数错误:HCC正在编译的过程中不允许设置是否输出汇编文件
	HCC_ERR_SETASM_1,         //HccSetAsmState函数错误:该函数参数错误
	HCC_ERR_SETARCH_0,        //HccSetArchitecture函数错误:HCC正在编译的过程中不允许设置硬件平台信息
	HCC_ERR_SETARCH_1,        //HccSetArchitecture函数错误:该函数参数错误    
    HCC_ERR_INIT_CONFIF,      //Hcc初始化失败:配置指令生成出现错误
	HCC_ERR_INIT_FILE         //Hcc初始化失败:上次编译的文件未被删除,HCC出错
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
#define HCC_SET_ASM_OK            0  //HccSetAsmState函数设置输出汇编文件成功
#define HCC_SET_ARCHI_OK          0  //HccSetArchitecture函数设置输出汇编文件成功
#define HCC_CPU_KIND              0  //HccGetArchitecture函数的参数取值
#define HCC_FPU_KIND              1  //HccGetArchitecture函数的参数取值
#define HCC_ENDIAN_KIND           2  //HccGetArchitecture函数的参数取值
#define HCC_ALIGNMENT_KIND        3  //HccGetArchitecture函数的参数取值
#define HCC_GETARCH_PARA_ERR      -1 //HccGetArchitecture函数错误:该函数参数错误
#define HCC_TREE_LEFT_SUB_NODE     0  //表示左子节点
#define HCC_TREE_MIDDLE_SUB_NODE   1  //表示中子节点
#define HCC_TREE_RIGHT_SUB_NODE    2  //表示右子节点
//新增部分
/*********************************   类型声明   *********************************/
typedef struct tagHccParameter    *pTagHccParameter;    //HCC函数参数列表指针
typedef struct tagHccTreeNode     *pTagHccTreeNode;     //语法树节点指针
typedef struct tagHccSymbol       *pTagHccSymbol;       //HCC符号指针
typedef struct tagHccType         *pTagHccType;         //HCC类型指针
typedef struct tagHccRemarkNode   *pTagHccRemarkNode;   //HCC需要的结构,各个语言编辑模块生成中间代码时为空即可
typedef struct tagHccParameter{                         
	pTagHccSymbol    pVar;                           //指向参数变量
	pTagHccParameter pNext;                          //指向下一个参数
}HccParameter;                                       //HCC函数从左至右的参数列表                  
typedef  struct tagHccTreeNode{                         
	char cOp;                                        //语法操作
	char cTypeKind;                                  //类型的种类
	pTagHccTreeNode pFather;                         //父节点指针
	pTagHccTreeNode pKids[HCC_TREENODE_KIDS_NUM];    //左中右三个子节点的指针，最多三个
	union HccSym{
		pTagHccSymbol pSym;                          //指向与本节点相关的符号
		union HccConstValue{                         
	           char           cI8Cnst;               //I8型常量值
			   short          sI16Cnst;              //I16型常量值
			   int            iI32Cnst;              //I32型常量值
			   unsigned char  ucU8Cnst;              //U8型常量值
			   unsigned short usU16Cnst;             //U16型常量值
			   unsigned int   uiU32Cnst;             //U32型常量值
			   unsigned char  ucBoolCnst;            //BOOL型常量
			   unsigned char  ucBitCnst;             //BIT类型常量值
			   unsigned int   uiPCnst;               //P型常量值
			   float          fF32Cnst;              //F32型常量值
			   double         dF64Cnst;              //F64型常量值
		}constValue;                                 //指向与本节点相关的常量,cOp=CNST或CASE时有效
	}hccSymbol;                                      //指向与本节点相关的符号或常量
	pTagHccTreeNode   pPrev, pNext;                  //该层森林中的上一棵树和下一棵树
	pTagHccTreeNode   pStandby;                      //备用
	pTagHccRemarkNode pRemarkNode;                   //指向一个结构体，前端提供时设为空即可。
}HccTreeNode;                                        //语法树节点
typedef struct tagHccSymbol {
	char cSymKind;                                   //符号种类：变量或函数
	char cSymScope;                                  //变量的作用域：全局，参数，局部；
	pTagHccType pType;                               //该符号的类型：变量的类型或者函数的返回类型
	struct HccAddress{                               
		int   iByteOffset;                           //字节偏移:全局变量的偏移由前端给定，其余为-1
		int   iBitOffset;	                         //当参数类型为BIT时有效，在iByteOffset基础上偏移的位
		char* pName;                                 //函数名和变量名
	}address;                                        //符号地址
}HccSymbol;                                          //符号
typedef struct tagHccType {
	char cTypeKind;                                  //类型的种类:V,I8,I16,I32,U8,U16,U32,P,F32,F64,BOOL,BIT,COMPLEX
	char cAlign;                                     //对齐字节数，非BIT类型时为1，2，4；类型为BIT时为1。
	unsigned short  usSize;                          //类型大小（字节数）；类型为BIT时为0。
}HccType;                                            //HCC类型
#endif //#ifndef __HCC_H__

//IMC定义的类型
enum IMC_FILE_TYPE
{
	IMC_NO_FILE = 0,	//无效文件
	IMC_TYPE_FILE,		//类型文件
	IMC_SYM_FILE,		//符号文件
	IMC_NODE_FILE,		//节点文件
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
	char           cI8Cnst;               //I8型常量值
	short          sI16Cnst;              //I16型常量值
	int            iI32Cnst;              //I32型常量值
	unsigned char  ucU8Cnst;              //U8型常量值
	unsigned short usU16Cnst;             //U16型常量值
	unsigned int   uiU32Cnst;             //U32型常量值
	unsigned char  ucBoolCnst;            //BOOL型常量
	unsigned char  ucBitCnst;             //BIT类型常量值
	unsigned int   uiPCnst;               //P型常量值
	float          fF32Cnst;              //F32型常量值
	double         dF64Cnst;              //F64型常量值
}; 

#endif