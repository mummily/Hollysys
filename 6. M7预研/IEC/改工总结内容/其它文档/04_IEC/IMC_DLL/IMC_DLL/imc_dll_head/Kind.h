// Kind.h: interface for the CKind class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_KIND_H__5F8A36E7_1618_4D2A_881A_7F615F834CF3__INCLUDED_)
#define AFX_KIND_H__5F8A36E7_1618_4D2A_881A_7F615F834CF3__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

class CKind  
{
	class CData
	{
	private:
		int m_nKind;
		CString m_sString;
	public:
		void SetValue(int kind, CString str)
		{
			m_nKind = kind;
			m_sString = str;
		}
		CString GetString() {return m_sString;}
		int GetKind() {return m_nKind;}
	};
public:
	CString GetKindStr(int kind, IMC_KIND_TYPE type);
    int GetKind(CString sKind, IMC_KIND_TYPE type);
	CKind();
	virtual ~CKind();

	CData m_kdOP[HCC_OP_END + 1];
	CData m_kdTK[HCC_TK_COMPLEX + 1];
	CData m_kdSS[HCC_SS_LOCAL + 1];
	CData m_kdSK[HCC_SK_FUNCTION + 1];
	
};

#endif // !defined(AFX_KIND_H__5F8A36E7_1618_4D2A_881A_7F615F834CF3__INCLUDED_)
