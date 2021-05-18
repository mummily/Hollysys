

#include "stdafx.h"
#include "HCCToolkit.h"

LPTSTR kOpCodeStr[] = {
	"START",       //简称START，函数开始
	"LOCAL",       //简称LOCAL，定义局部变量
	"BLOCKBEG",    //简称BLOCKBEG，{
	"BLOCKEND",    //简称BLOCKEND，}
	"IF",          //简称IF，if
	"IF_ELSE",     //简称IF_ELSE，if else
	"FOR",         //简称FOR，for
	"WHILE",       //简称WHILE，while
	"DO_WHILE",    //简称DO_WHILE，do while
	"SWITCH",      //简称SWITCH，switch
	"BREAK",       //简称BREAK，break
	"CONTINUE",    //简称CONTINUE，continue
	"RETURN",      //简称RETURN，函数返回
	"CALL",        //简称CALL，函数调用
	"JUMP",        //简称JUMP，goto
	"LABEL",       //简称LABEL，定义标号
	"ASGN",        //简称ASGN，=
	"ADDRF",       //简称ADDRF，&(获取参数地址)
	"ADDRG",       //简称ADDRG，&(获取全局地址)
	"ADDRL",       //简称ADDRL，&(获取局部地址)
	"CNST",        //简称CNST，取常量
	"VAR",         //简称VAR，取变量
	"NOT",         //简称NOT，!(逻辑非)
	"BITNOT",      //简称BITNOT，~(按位取反)
	"I8TO",        //简称I8TO，I8类型的转换
	"I16TO",       //简称I16TO，I16类型的转换
	"I32TO",       //简称I32TO，I32类型的转换
	"U8TO",        //简称U8TO，U8类型的转换
	"U16TO",       //简称U16TO，U16类型的转换
	"U32TO",       //简称U32TO，U32类型的转换
	"PTO",         //简称PTO，P类型的转换
	"BOOLTO",      //简称BOOLTO，BOOL类型的转换
	"BITTO",       //简称BITTO，BIT类型的转换
	"F32TO",       //简称F32TO，F32类型的转换
	"F64TO",       //简称F64TO，F64类型的转换
	"INDIR",       //简称INDIR，*(按地址取值)
	"NEG",         //简称NEG，-(取相反数)
	"CASE",        //简称CAEE，SWITCH中的CASE情况,默认带break
	"ARG",         //简称ARG，函数调用时传递实参
	"AND",         //简称AND，&&(逻辑与)
	"OR",          //简称OR，||(逻辑或)
	"XOR",         //简称XOR，逻辑异或
	"ADD",         //简称ADD，+(加)
	"SUB",         //简称SUB，-(减)
	"ADDP",        //简称ADDP，地址增加
	"SUBP",        //简称SUBP，地址减少
	"ADDPBIT",     //简称ADDPBIT，位地址增加
	"SUBPBIT",     //简称SUBPBIT，位地址减少
	"MUL",         //简称MUL，表示*(乘)
	"DIV",         //简称DIV，表示/(除取商)
	"MOD",         //简称MOD，表示%(除取模)
	"BITAND",      //简称BITAND，表示&(位与)
	"BITOR",       //简称BITOR，表示|(位或)
	"BITXOR",      //简称BITXOR，表示^(位异或)
	"SHL",         //简称SHL，<<(左移)
	"SHR",         //简称SHR，>>(右移)
	"ROL",         //简称ROL，循环左移
	"ROR",         //简称ROR，循环右移
	"EQ",          //简称EQ，==
	"NE",          //简称NE，!=
	"GE",          //简称GE，>=
	"GT",          //简称GT，>
	"LE",          //简称LE，<=
	"LT",          //简称LT，<
	"SELECT",      //简称SELECT，?:  //2010.01.12 llz
	"DATA",        //简称DATA,可以向CODE区中插入数据 2015-3-6 lhl	
    "END",         //简称END，函数结束
};

LPTSTR kTypeKindStr[] = {
	"VOID",        //简称VOID,顺序不可变
	"I8",          //简称I8,顺序不可变
	"I16",         //简称I16,顺序不可变
	"I32",         //简称I32,顺序不可变
	"U8",          //简称U8,顺序不可变
	"U16",         //简称U16,顺序不可变
	"U32",         //简称U32,顺序不可变
	"POINTER",     //简称P,顺序不可变
	"BOOL",        //简称BOOL,顺序不可变
	"BIT",         //简称BIT,顺序不可变
	"F32",         //简称F32,顺序不可变
	"F64",         //简称F64,顺序不可变
	"COMPLEX"      //简称COMPLEX,顺序不可变
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
	CString strNodeName = visit(pCode, arrNode, arrLink);  // 主要函数

	CString strFileName;
	strFileName.Format("C:\\Documents and Settings\\gaiyangjun\\桌面\\code\\txt\\%s.dot", strPOUName);   /// 修改路径

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

