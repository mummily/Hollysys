

#include "stdafx.h"
#include "HCCToolkit.h"

LPTSTR kOpCodeStr[] = {
	"START",       //���START��������ʼ
	"LOCAL",       //���LOCAL������ֲ�����
	"BLOCKBEG",    //���BLOCKBEG��{
	"BLOCKEND",    //���BLOCKEND��}
	"IF",          //���IF��if
	"IF_ELSE",     //���IF_ELSE��if else
	"FOR",         //���FOR��for
	"WHILE",       //���WHILE��while
	"DO_WHILE",    //���DO_WHILE��do while
	"SWITCH",      //���SWITCH��switch
	"BREAK",       //���BREAK��break
	"CONTINUE",    //���CONTINUE��continue
	"RETURN",      //���RETURN����������
	"CALL",        //���CALL����������
	"JUMP",        //���JUMP��goto
	"LABEL",       //���LABEL��������
	"ASGN",        //���ASGN��=
	"ADDRF",       //���ADDRF��&(��ȡ������ַ)
	"ADDRG",       //���ADDRG��&(��ȡȫ�ֵ�ַ)
	"ADDRL",       //���ADDRL��&(��ȡ�ֲ���ַ)
	"CNST",        //���CNST��ȡ����
	"VAR",         //���VAR��ȡ����
	"NOT",         //���NOT��!(�߼���)
	"BITNOT",      //���BITNOT��~(��λȡ��)
	"I8TO",        //���I8TO��I8���͵�ת��
	"I16TO",       //���I16TO��I16���͵�ת��
	"I32TO",       //���I32TO��I32���͵�ת��
	"U8TO",        //���U8TO��U8���͵�ת��
	"U16TO",       //���U16TO��U16���͵�ת��
	"U32TO",       //���U32TO��U32���͵�ת��
	"PTO",         //���PTO��P���͵�ת��
	"BOOLTO",      //���BOOLTO��BOOL���͵�ת��
	"BITTO",       //���BITTO��BIT���͵�ת��
	"F32TO",       //���F32TO��F32���͵�ת��
	"F64TO",       //���F64TO��F64���͵�ת��
	"INDIR",       //���INDIR��*(����ַȡֵ)
	"NEG",         //���NEG��-(ȡ�෴��)
	"CASE",        //���CAEE��SWITCH�е�CASE���,Ĭ�ϴ�break
	"ARG",         //���ARG����������ʱ����ʵ��
	"AND",         //���AND��&&(�߼���)
	"OR",          //���OR��||(�߼���)
	"XOR",         //���XOR���߼����
	"ADD",         //���ADD��+(��)
	"SUB",         //���SUB��-(��)
	"ADDP",        //���ADDP����ַ����
	"SUBP",        //���SUBP����ַ����
	"ADDPBIT",     //���ADDPBIT��λ��ַ����
	"SUBPBIT",     //���SUBPBIT��λ��ַ����
	"MUL",         //���MUL����ʾ*(��)
	"DIV",         //���DIV����ʾ/(��ȡ��)
	"MOD",         //���MOD����ʾ%(��ȡģ)
	"BITAND",      //���BITAND����ʾ&(λ��)
	"BITOR",       //���BITOR����ʾ|(λ��)
	"BITXOR",      //���BITXOR����ʾ^(λ���)
	"SHL",         //���SHL��<<(����)
	"SHR",         //���SHR��>>(����)
	"ROL",         //���ROL��ѭ������
	"ROR",         //���ROR��ѭ������
	"EQ",          //���EQ��==
	"NE",          //���NE��!=
	"GE",          //���GE��>=
	"GT",          //���GT��>
	"LE",          //���LE��<=
	"LT",          //���LT��<
	"SELECT",      //���SELECT��?:  //2010.01.12 llz
	"DATA",        //���DATA,������CODE���в������� 2015-3-6 lhl	
    "END",         //���END����������
};

LPTSTR kTypeKindStr[] = {
	"VOID",        //���VOID,˳�򲻿ɱ�
	"I8",          //���I8,˳�򲻿ɱ�
	"I16",         //���I16,˳�򲻿ɱ�
	"I32",         //���I32,˳�򲻿ɱ�
	"U8",          //���U8,˳�򲻿ɱ�
	"U16",         //���U16,˳�򲻿ɱ�
	"U32",         //���U32,˳�򲻿ɱ�
	"POINTER",     //���P,˳�򲻿ɱ�
	"BOOL",        //���BOOL,˳�򲻿ɱ�
	"BIT",         //���BIT,˳�򲻿ɱ�
	"F32",         //���F32,˳�򲻿ɱ�
	"F64",         //���F64,˳�򲻿ɱ�
	"COMPLEX"      //���COMPLEX,˳�򲻿ɱ�
};


HCCToolkit::HCCToolkit()
: m_nNodeId(0) {
}

HCCToolkit::~HCCToolkit() {
}

BOOL HCCToolkit::Generate(CString& strPOUName, CMap<CString,LPCSTR,tagHccSymbol*,tagHccSymbol*>* pParamMap, CMap<CString,LPCSTR,tagHccSymbol*,tagHccSymbol*>* pLocalMap, pTagHccTreeNode pCode) {
	if (strPOUName.IsEmpty() || pParamMap == NULL || pLocalMap == NULL || pCode == NULL) {
		return FALSE;
	}

	reverseMap(pParamMap, m_mapParam);
	reverseMap(pLocalMap, m_mapLocal);
	
	CStringArray arrNode, arrLink;
	CString strNodeName = visit(pCode, arrNode, arrLink);  // ��Ҫ����

	CString strFileName;
	strFileName.Format("C:\\Documents and Settings\\gaiyangjun\\����\\code\\txt\\%s.dot", strPOUName);   /// �޸�·��

	CFile file;
	file.Open(strFileName, CFile::modeCreate | CFile::modeWrite);

	CString str;
	str.Format("digraph %s{\r\n", strPOUName);
	file.Write((LPCTSTR)str, str.GetLength());

	str = "  node [shape=record]\r\n";
	file.Write((LPCTSTR)str, str.GetLength());

	int i = 0;
	int nCount = arrNode.GetSize();
	for (i = 0; i < nCount; i++) {
		str = arrNode.GetAt(i);
		file.Write((LPCTSTR)str, str.GetLength());
		file.Write("\r\n", 2);
	}

	nCount = arrLink.GetSize();
	for (i = 0; i < nCount; i++) {
		str = arrLink.GetAt(i);
		file.Write((LPCTSTR)str, str.GetLength());
		file.Write("\r\n", 2);
	}

	str = "}\r\n";
	file.Write((LPCTSTR)str, str.GetLength());
	file.Close();

	return TRUE;
}

LPTSTR HCCToolkit::HCCOpCodeToString(HCC_OP_CODE nOpCode) {
	if (nOpCode >= HCC_OP_START && nOpCode <= HCC_OP_END) {
		return kOpCodeStr[nOpCode];
	} else {
		return "INVALID";
	}
}

LPTSTR HCCToolkit::HCCTypeKindToString(HCC_TYPE_KIND nTypeKind) {
	if (nTypeKind >= HCC_TK_VOID && nTypeKind <= HCC_TK_COMPLEX) {
		return kTypeKindStr[nTypeKind];
	} else {
		return "INVALID";
	}
}

CString HCCToolkit::GetHCCSymbol(pTagHccTreeNode pCode) {
	CString strResult;
	if (pCode->cOp == HCC_OP_CNST || pCode->cOp == HCC_OP_DATA) {
		return strResult;
	}

	pTagHccSymbol pSymbol = pCode->hccSymbol.pSym;
	if (pSymbol == NULL) {
		return strResult;
	}

	CString strSymbolName;
	if (GetSymbolName(pSymbol, strSymbolName)) {
		strResult += strSymbolName;
		strResult += "|";
	}

	switch (pSymbol->cSymKind) {
	case HCC_SK_VARIABLE:
		strResult += "VAR|";
		break;
	case HCC_SK_FUNCTION:
		strResult += "FUNC|";
		break;
	default:
		break;
	}

	switch (pSymbol->cSymScope) {
	case HCC_SS_GLOBAL:
		strResult += "GLOBAL|";
		break;
	case HCC_SS_PARAMETER:
		strResult += "PARAMETER|";
		break;
	case HCC_SS_LOCAL:
		strResult += "LOCAL|";
		break;
	default:
		break;
	}

	strResult += GetHCCType(pSymbol->pType);
	if (pSymbol->address.iByteOffset != -1) {
		char szBuf[128];
		sprintf(szBuf, "OFFSET: %X", pSymbol->address.iByteOffset);
		strResult += "|";
		strResult += szBuf;
	}
	if (strlen(pSymbol->address.pName) > 0 && strcmp(pSymbol->address.pName, "pName") != 0) {
		strResult += "|";
		strResult += pSymbol->address.pName;
	}

	return strResult;
}

CString HCCToolkit::GetConstValue(pTagHccTreeNode pCode) {
	CString strResult;
	if (pCode->cOp != HCC_OP_CNST) {
		//return strResult;
	}

	char szBuf[128];
	switch (pCode->cTypeKind) {
	case HCC_TK_VOID:
		strcpy(szBuf, "VOID");
		break;
	case HCC_TK_I8:
		sprintf(szBuf, "I8-%d", pCode->hccSymbol.constValue.cI8Cnst);
		break;
	case HCC_TK_I16:
		sprintf(szBuf, "I16-%d", pCode->hccSymbol.constValue.sI16Cnst);
		break;
	case HCC_TK_I32:
		sprintf(szBuf, "I32-%d", pCode->hccSymbol.constValue.iI32Cnst);
		break;
	case HCC_TK_U8:
		sprintf(szBuf, "U8-%d", pCode->hccSymbol.constValue.ucU8Cnst);
		break;
	case HCC_TK_U16:
		sprintf(szBuf, "U16-%d", pCode->hccSymbol.constValue.usU16Cnst);
		break;
	case HCC_TK_U32:
		sprintf(szBuf, "U32-%d", pCode->hccSymbol.constValue.uiU32Cnst);
		break;
	case HCC_TK_POINTER:
		if (pCode->cOp == HCC_OP_CNST) {
			sprintf(szBuf, "POINTER-%x", pCode->hccSymbol.constValue.uiPCnst);
		} else {
			szBuf[0] = NULL;
		}
		break;
	case HCC_TK_BOOL:
		sprintf(szBuf, "BOOL-%d", pCode->hccSymbol.constValue.ucBoolCnst);
		break;
	case HCC_TK_BIT:
		sprintf(szBuf, "BIT-%d", pCode->hccSymbol.constValue.ucBitCnst);
		break;
	case HCC_TK_F32:
		sprintf(szBuf, "F32-%f", pCode->hccSymbol.constValue.fF32Cnst);
		break;
	case HCC_TK_F64:
		sprintf(szBuf, "F64-%f", pCode->hccSymbol.constValue.fF32Cnst);
		break;
	case HCC_TK_COMPLEX:
		strcpy(szBuf, "COMPLEX");
		break;
	default:
		strcpy(szBuf, "INVALID");
		break;
	}
	strResult = szBuf;
	return strResult;
}

CString HCCToolkit::GetHCCType(pTagHccType pType) {
	return HCCTypeKindToString(static_cast<HCC_TYPE_KIND>(pType->cTypeKind));
}

CString HCCToolkit::visit(pTagHccTreeNode pNode, CStringArray& arrNode, CStringArray& arrLink) {
	CString strNodeName;
	if (pNode == NULL) {
		return strNodeName;
	}

	CString strCurrent;
	strCurrent += HCCOpCodeToString(static_cast<HCC_OP_CODE>(pNode->cOp));
	strCurrent += "|";

	strCurrent += HCCTypeKindToString(static_cast<HCC_TYPE_KIND>(pNode->cTypeKind));
	//strCurrent += "|";


	CString strSymbol = GetHCCSymbol(pNode);
	CString strConstValue = GetConstValue(pNode);

	if (!strSymbol.IsEmpty()) {
		strCurrent += "|";
		strCurrent += strSymbol;
	}
	if (!strConstValue.IsEmpty()) {
		strCurrent += "|";
		strCurrent += strConstValue;
	}
	//OutputDebugStringA((LPCTSTR)strCurrent);
	//OutputDebugStringA("\n");

	CString strNodeId = GetNodeId();


	CString strLeft		= visit(HCC_LEFT_KID(pNode), arrNode, arrLink);
	CString strMiddle	= visit(HCC_MIDDLE_KID(pNode), arrNode, arrLink);
	CString strRight	= visit(HCC_RIGHT_KID(pNode), arrNode, arrLink);
	CString strNext		= visit(pNode->pNext, arrNode, arrLink);

	CString str;
	str.Format("  %s [style=\"rounded\" label=\"{%s}\"]", strNodeId, strCurrent);
	arrNode.Add(str);

	if (!strLeft.IsEmpty()) {
		str.Format("  %s->%s", strNodeId, strLeft);
		arrLink.Add(str);
	}
	if (!strMiddle.IsEmpty()) {
		str.Format("  %s->%s", strNodeId, strMiddle);
		arrLink.Add(str);
	}
	if (!strRight.IsEmpty()) {
		str.Format("  %s->%s", strNodeId, strRight);
		arrLink.Add(str);
	}

	if (!strNext.IsEmpty()) {
		str.Format("  %s->%s [style=\"dotted\" arrowhead=\"none\"]", strNodeId, strNext);
		arrLink.Add(str);
	}

	return strNodeId;
}

void HCCToolkit::reverseMap(CMap<CString,LPCSTR,tagHccSymbol*,tagHccSymbol*>* pMap, CMap<tagHccSymbol*, tagHccSymbol*, CString, LPCTSTR>& map) {
	POSITION pos = pMap->GetStartPosition();
	while (pos != NULL) {
		CString str;
		tagHccSymbol* pSymbol = NULL;
		pMap->GetNextAssoc(pos, str, pSymbol);
		map.SetAt(pSymbol, str);
	}
}

BOOL HCCToolkit::GetSymbolName(tagHccSymbol* pSymbol, CString& strName) {
	CString str;
	if (m_mapParam.Lookup(pSymbol, str)) {
		strName = "P:" + str;
		return TRUE;
	}
	if (!m_mapLocal.Lookup(pSymbol, str)) {
		return FALSE;
	}
	strName = "L:" + str;
	return TRUE;
}

CString HCCToolkit::GetNodeId() {
	CString str;
	str.Format("node%d", m_nNodeId);
	m_nNodeId++;
	return str;
}

