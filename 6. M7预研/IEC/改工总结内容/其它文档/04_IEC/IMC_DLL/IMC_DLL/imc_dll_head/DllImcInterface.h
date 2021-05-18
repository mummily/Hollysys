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
 *	���ܣ�		��ȡ���Ϊseq��Ӧ���﷨�ڵ��ָ��
 *	������
 *	seq��		��Ż�ȡ���﷨�ڵ����ţ��ڵ�����node�ļ��п��Բ鵽��
 *	����ֵ��
 *	NULL��		û����seq��Ӧ���﷨�ڵ�ʱ
 *	һ��ָ�룺	������seq��Ӧ���﷨�ڵ�ʱ
 *	˵����		ʹ�øú���ǰ�������ȵ���ImportHccFun�������γ��﷨��
 */
	HccTreeNode* GetHccTreeNodePtr(int seq);
/*
 *	���ܣ�	��HccFun���ڴ��﷨�������ҵ�������Ӧ���ļ���
 *	������
 *	sExportPath��	���������ļ�·�������ļ�����
 *	pTreeHead:		HccFun�﷨���е�ͷ�ڵ�
 *
 */	
	void ExportHccFun(CString sExportPath, HccTreeNode *pTreeHead);
	void ExportHccFunEx(CString sExportPath, HccTreeNode *pTreeHead);
/*
 *	���ܣ�		����HCC�������ݣ����뺯����.
 *	������	
 *	sImortPath:	���������ļ���·�������ļ�����
 *				���������ļ��������ͣ����ţ��ڵ��ļ���·��
 *	����ֵ��	
 *	�������ļ���ʧ��ʱ��	���ؿ�
 *	������ɹ���			�����﷨��ͷ�ڵ�ָ��
 * 
 *	˵����	
 */	
	HccTreeNode * ImportHccFun(CString sImportPath);
/*
 *	���ܣ�		����HCC�������ݣ�ʹ��Hcc����ڴ����뺯�������ڴ����루���뺯����.
 *	������	
 *	sImortPath:	���������ļ���·�������ļ�����
 *				���������ļ��������ͣ����ţ��ڵ��ļ���·��
 *	����ֵ��	
 *	�������ļ���ʧ��ʱ��	���ؿ�
 *	������ɹ���			�����﷨��ͷ�ڵ�ָ��
 * 
 *	˵����	
 */	
	HccTreeNode * ImportHccFunEx(CString sImportPath);

/*
 *	���ܣ�		��ȡHCC��������ָ��
 *	����ֵ��
 *	��ͷ�ڵ㣨START�ڵ㣩������ʱ��	����NULL
 *	����ʱ��						����START�ڵ�
 *	˵����		ʹ�øú���ǰ�������ȵ���ImportHccFun�������γ��﷨��
 */	
	HccTreeNode * GetHccTreeHead();
/*
 *	���ܣ�	������ͣ����ţ��ڵ���Ϣ���ָ�����ʼ״̬
 */
	void Reset();

/*
 *	���ܣ�	��ȡָ���ķ���
 */
	HccSymbol* GetHccSymbol(int seq);
	//////////////////////////////////////////////////////////////////////////
	CDllImcInterface();
	~CDllImcInterface();
};

#endif // !defined(AFX_DLLIMCINTERFACEEX_H__B1967E25_262E_49A4_B33A_91BC49A822C4__INCLUDED_)
