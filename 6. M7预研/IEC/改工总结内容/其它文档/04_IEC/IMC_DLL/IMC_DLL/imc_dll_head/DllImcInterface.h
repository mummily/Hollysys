// DllImcInterfaceEx.h: interface for the CDllImcInterface class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_DLLIMCINTERFACEEX_H__B1967E25_262E_49A4_B33A_91BC49A822C4__INCLUDED_)
#define AFX_DLLIMCINTERFACEEX_H__B1967E25_262E_49A4_B33A_91BC49A822C4__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

//class CDllImcInterface  
//{
//public:
//	CDllImcInterface();
//	virtual ~CDllImcInterface();
//
//};

#include "imc_define.h"
#include "Kind.h"
#include "imc_cls.h"
#include "ParseFile.h"

#ifdef IMC_DLL
class  __declspec(dllexport) CDllImcInterface
#else
class __declspec(dllimport) CDllImcInterface
#endif
{
private:
	CNodeList m_lstNode;
	CImcSymbolList m_lstSymbol;
	CImcTypeList m_lstType;

private:
public:
/*
 *	功能：		获取序号为seq对应的语法节点的指针
 *	参数：
 *	seq：		序号获取的语法节点的序号（在导出的node文件中可以查到）
 *	返回值：
 *	NULL：		没有与seq对应的语法节点时
 *	一个指针：	存在与seq对应的语法节点时
 *	说明：		使用该函数前，总是先调用ImportHccFun函数先形成语法树
 */
	HccTreeNode* GetHccTreeNodePtr(int seq);
/*
 *	功能：	将HccFun的内存语法树树并且导出到相应的文件中
 *	参数：
 *	sExportPath：	导出配置文件路径，含文件名。
 *	pTreeHead:		HccFun语法树中的头节点
 *
 */	
	void ExportHccFun(CString sExportPath, HccTreeNode *pTreeHead);
	void ExportHccFunEx(CString sExportPath, HccTreeNode *pTreeHead);
/*
 *	功能：		导入HCC函数数据（输入函数）.
 *	参数：	
 *	sImortPath:	导入配置文件的路径，含文件名。
 *				导入配置文件中有类型，符号，节点文件的路径
 *	返回值：	
 *	当配置文件打开失败时，	返回空
 *	当导入成功后，			返回语法树头节点指针
 * 
 *	说明：	
 */	
	HccTreeNode * ImportHccFun(CString sImportPath);
/*
 *	功能：		导入HCC函数数据，使用Hcc后端内存申请函数进行内存申请（输入函数）.
 *	参数：	
 *	sImortPath:	导入配置文件的路径，含文件名。
 *				导入配置文件中有类型，符号，节点文件的路径
 *	返回值：	
 *	当配置文件打开失败时，	返回空
 *	当导入成功后，			返回语法树头节点指针
 * 
 *	说明：	
 */	
	HccTreeNode * ImportHccFunEx(CString sImportPath);

/*
 *	功能：		获取HCC函数的首指针
 *	返回值：
 *	当头节点（START节点）不存在时，	返回NULL
 *	存在时，						返回START节点
 *	说明：		使用该函数前，总是先调用ImportHccFun函数先形成语法树
 */	
	HccTreeNode * GetHccTreeHead();
/*
 *	功能：	清空类型，符号，节点信息，恢复到起始状态
 */
	void Reset();

/*
 *	功能：	获取指定的符号
 */
	HccSymbol* GetHccSymbol(int seq);
	//////////////////////////////////////////////////////////////////////////
	CDllImcInterface();
	~CDllImcInterface();
};

#endif // !defined(AFX_DLLIMCINTERFACEEX_H__B1967E25_262E_49A4_B33A_91BC49A822C4__INCLUDED_)
