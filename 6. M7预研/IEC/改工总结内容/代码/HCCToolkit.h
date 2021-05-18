
#ifndef HCC_TOOLKIT_H
#define HCC_TOOLKIT_H


#undef IECCOMMON_DLL_DECL
#ifdef _IECCOMMON_DLL_DECL
#define IECCOMMON_DLL_DECL _declspec(dllexport)
#else
#define IECCOMMON_DLL_DECL _declspec(dllimport)
#endif

#include "02.AT_Platform/Public/BaseFunc/HCC.h"

class IECCOMMON_DLL_DECL HCCToolkit  
{
public:
	HCCToolkit();
	~HCCToolkit();

public:
	BOOL Generate(CString& strPOUName, CMap<CString,LPCSTR,tagHccSymbol*,tagHccSymbol*>* pParamMap, CMap<CString,LPCSTR,tagHccSymbol*,tagHccSymbol*>* pLocalMap, pTagHccTreeNode pCode);

private:
	static LPTSTR HCCOpCodeToString(HCC_OP_CODE nOpCode);
	static LPTSTR HCCTypeKindToString(HCC_TYPE_KIND nTypeKind);
	static CString GetConstValue(pTagHccTreeNode pCode);
	static CString GetHCCType(pTagHccType pType);

private:
	CString visit(pTagHccTreeNode pNode, CStringArray& arrNode, CStringArray& arrLink);
	CString GetHCCSymbol(pTagHccTreeNode pCode);
	BOOL GetSymbolName(tagHccSymbol* pSymbol, CString& strName);

	CString GetNodeId();

	void reverseMap(CMap<CString,LPCSTR,tagHccSymbol*,tagHccSymbol*>* pMap, CMap<tagHccSymbol*, tagHccSymbol*, CString, LPCTSTR>& map);

private:
	int m_nNodeId;
	CMap<tagHccSymbol*, tagHccSymbol*, CString, LPCTSTR> m_mapParam;
	CMap<tagHccSymbol*, tagHccSymbol*, CString, LPCTSTR> m_mapLocal;
};

#endif // HCC_TOOLKIT_H