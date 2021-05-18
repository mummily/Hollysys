// ParseFile.h: interface for the CParseFile class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_PARSEFILE_H__969CB7CA_FEE5_4580_96B1_C9D1EEEE019F__INCLUDED_)
#define AFX_PARSEFILE_H__969CB7CA_FEE5_4580_96B1_C9D1EEEE019F__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

class CParseFile  
{
private:
	
public:
	void RestoreFile(CString sFile, IMC_FILE_TYPE type);
	void ParseFile(CString sFile, IMC_FILE_TYPE type);
	void RestoreNodeFile();
	static CString ConstString(CONSTANT cnst, int type);
	void RestoreSymbolFile();
	void RestoreTypeFile();
	static CONSTANT ConstValue(CString str, int type);
	void ParseNodeFile();
	void SetNodeListPtr(CNodeList *pNodeList);
	void SetSymbolListPtr(CImcSymbolList *pSymList);
	void ParseSymbolFile();
	void SetTypeListPtr(CImcTypeList *pTypeList);
	void SetFilePath(CString sPath);
	void ParseTypeFile();
	int GetKind(CString sKind, IMC_KIND_TYPE type);
	CParseFile();
	virtual ~CParseFile();
private:
	CString m_sPath;
	CImcTypeList *m_pTypeList;
	CNodeList *m_pNodeList;
	CImcSymbolList	*m_pSymList;
	
	IMC_FILE_TYPE	m_tFileType;

};

#endif // !defined(AFX_PARSEFILE_H__969CB7CA_FEE5_4580_96B1_C9D1EEEE019F__INCLUDED_)
