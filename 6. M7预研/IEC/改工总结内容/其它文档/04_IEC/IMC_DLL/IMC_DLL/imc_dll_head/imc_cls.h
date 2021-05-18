// imc_cls.h: interface for the CImcType class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_IMC_CLS_H__664F3318_CEBF_431A_9AED_2860DACBAD25__INCLUDED_)
#define AFX_IMC_CLS_H__664F3318_CEBF_431A_9AED_2860DACBAD25__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
#include <afxtempl.h>


class CElem  
{
public:
	CString m_sDscrp;		//��Ԫ�ص�����
	int m_nSeq;				//Ԫ�ص��ڲ����
	
public:
	void SetValue(int seq, CString sDscrp);
	int GetSeq(){ return m_nSeq;}
	void SetSeq(int seq) { m_nSeq = seq;}
	CString GetDscrp(){ return m_sDscrp;}
	void SetDscrp(CString sDscrp) { m_sDscrp = sDscrp;}
	
	CElem();
	virtual ~CElem();
};

class CImcType : public CElem
{

public:
	HccType m_tType;		//���͵�����

public:
	CString GetIdentifyStr();
	CString Restore();
	static HccType SetHccType(char align, char kind, unsigned short size);
	void Create(int nSeq, CString sDscrp, HccType *pHccType);
	HccType* GetHccTypePtr();
	CImcType();
	virtual ~CImcType();

};

class CImcTypeList  
{
private:
	CList<CImcType, CImcType&> m_lstType;
public:
	int GetMaxSeq();
	CList<CImcType, CImcType&> *GetTypeListPtr(){return &m_lstType;}
	int GetCount();
	void Remove(int seq);
	CImcType* GetTypePtr(HccType *pHccType);
	CString Restore();
	void RemoveAll();
	CImcType* GetTypePtr(int seq);
	void Add(CImcType type);
	CImcTypeList();
	virtual ~CImcTypeList();

};

class CImcSymbol: public CElem
{
public:
	HccSymbol m_tSymbol;
public:

	CString GetIdentifyStr();
	CString Restore(CImcTypeList *pTypeList);
	void SetType(CImcType *pType);
	void Create(int nSeq, CString sDscrp, HccSymbol *pHccSymbol);
	HccSymbol * GetHccSymPtr();
	CImcSymbol();
	virtual ~CImcSymbol();

};

class CImcSymbolList  
{
private:
	CList<CImcSymbol, CImcSymbol&> m_lstSymbol;
public:
	int GetMaxSeq();
	void Remove(int seq);
	CList<CImcSymbol, CImcSymbol&> *GetSymbolListPtr(){return &m_lstSymbol;}
	CImcSymbol * GetSymbolPtr(HccSymbol *pHccSymbol);
	CString Restore(CImcTypeList *pTypeList);
	void RemoveAll();
	POSITION Add(CImcSymbol sym);
	CImcSymbol* GetSymbolPtr(int seq);
	CImcSymbolList();
	virtual ~CImcSymbolList();

};

class CNodeList;

class CNode : public CElem
{
public:
	 HccTreeNode * GetHccNodePtr();
public:
	void SetStandby(CNode *pStandby);
	void SetFather(CNode *pFather);
	void SetNext(CNode *pNext);
	void Clear();
	void SetPrev(CNode *pNodePrev);
	CString GetIdentifyStr();
	CString Restore(CNodeList *pNodeList, CImcSymbolList *pSymList);
	void Create(int nSeq, CString sDscrp, HccTreeNode *pHccNode);
	void SetConstant(CONSTANT cnst);
	void SetProperties(char op, char kind);
	void SetKids(CNode *pKids[], int kids = 2);
	void SetSymbol(CImcSymbol *pSym);
	HccTreeNode m_tNode;
	CNode();
	virtual ~CNode();
};

class CNodeList  
{
private:
	HccTreeNode* GetTreeHead(HccTreeNode *pNode);
	CList<CNode, CNode&> m_lstNode;			//�洢���ɵ�CNode�ڵ�
	CImcSymbolList *m_pSymList;
	CImcTypeList *m_pTypeList;
	
public:
	CNode * MakeNode(int seq);
	int GetMaxSeq();
	void Remove(int seq);
	CList<CNode, CNode&> *GetNodeListPtr()
	{return &m_lstNode;}
	
	HccTreeNode * GetTreeHead();
	int GetCounts();
	CString Restore(CNodeList *pNodeList, CImcSymbolList *pSymList);
	CNode * GetNodePtr(HccTreeNode *pHccNode);
	void TestCreatTree();
	void RemoveAll();
	void Insert(int curSeq, int preSeq);
	void SetKids(int nodeSeq, int kidsSeq[], int kids = 2);
	void SetSymbol(int nodeSeq, int symSeq);
	void SetList(CImcSymbolList *pSymList, CImcTypeList *pTypeList);
	CNode* GetNodePtr(int seq);
	POSITION Add(CNode node);
	CNodeList();
	virtual ~CNodeList();

};

class CMem  
{	
public:
	static void ReleaseMem(char *pMem);
	static CList<char *, char *&> m_lstMem;	//����������ڴ�
	static void ReleaseMem();
	static char * ApllyMem(int size);
	CMem();
	virtual ~CMem();

};



/*
 *	˵����	���ཫHccTreeNodeת��ΪCNodList������������
 *			CImcSymbolList��CImcTypeList
 *
 */
class CTransform  
{
private:
	/*
	 *	�洢һ��������ݵĶ�Ӧ
	 *	HccType����Ҫʹ�ú�˵����뺯������
	 */
	CMap<CImcSymbol*, CImcSymbol*, HccSymbol*, HccSymbol*> m_mapCImcSymbol;
	CMap<CNode*, CNode*, HccTreeNode*, HccTreeNode*> m_mapCNode;
	CMap<char*, char*, char*, char*> m_mapName;
	
	/*
	 *�洢�ڱ����ڵ�����б����Ѿ�����CImcSymbol��HccSymbol�Ķ�Ӧ��ϵ��
	 *֮����Ҫ����һ�ݸõ�ַ������Ϊ��HccSmbol���Ƶ�CImcSymbol��CImcType
	 *��ʱ���ڴ��ַ�Ѿ��ı�
	 */
	CMap<HccTreeNode*, HccTreeNode*, CNode*, CNode*> m_mapNode;
	CMap<HccSymbol*, HccSymbol*, CImcSymbol*, CImcSymbol*> m_mapSymbol;
	CMap<HccType*, HccType*, CImcType*, CImcType*> m_mapType;

	int m_nSeqType;
	int m_nSeqSym;
	int m_nSeqNode;
	CNodeList *m_pNodeList;
	CImcSymbolList *m_pSmbList;
	CImcTypeList *m_pTypeList;
public:	
	char* MakeHccPtr(char *pName);
	HccSymbol* MakeHccPtr(CImcSymbol *pSymbol);
	HccTreeNode* MakeHccPtr(CNode *pNode);

	HccTreeNode* HccMemTransform(CImcTypeList *pTypeList, CImcSymbolList *pSymbolList, CNodeList* pNodeList);
	void Transform(HccTreeNode *pTreeHead);
	CImcType * Type(HccType *pHccType);
	CImcSymbol * Symbol(HccSymbol *pHccSymbol);
	void SetListPtr(CImcTypeList *pTypeList, CImcSymbolList *pSmbList, CNodeList *pNodeList);
	CTransform(CImcTypeList *pTypeList, CImcSymbolList *pSmbList, CNodeList *pNodeList);
	CTransform();
	virtual ~CTransform();

private:
	//////////////////////////////////////////////////////////////////////////
	void ApplyNode();


	//	
	void Init();
	CNode * Node(HccTreeNode *pHccNode);
	CImcType* MakePtr(HccType *pHccType);
	CImcSymbol* MakePtr(HccSymbol *pHccSymbol);
	CNode* MakePtr(HccTreeNode *pHccNode);
	int MakeTypeSeq(){return m_nSeqType++;}
	int MakeSymSeq() {return m_nSeqSym++;}
	int MakeNodeSeq(){return m_nSeqNode++;}

};
/*
 *	˵����	����������ṩ�м������﷨�����ļ���ת��
 *			
 */
//class CDllImcInterface
//{
//private:
//	CNodeList m_lstNode;
//	CImcSymbolList m_lstSymol;
//	CImcTypeList m_lstType;
//
//private:
//public:
//	void ExportHccFun(CString sExportPath, HccTreeNode *pTreeHead);
//	HccTreeNode * ImportHccFun(CString sImportPath);
//	HccTreeNode * GetHccTreeHead();
//	CDllImcInterface();
//	virtual ~CDllImcInterface();
//};


#endif // !defined(AFX_IMC_CLS_H__664F3318_CEBF_431A_9AED_2860DACBAD25__INCLUDED_)
