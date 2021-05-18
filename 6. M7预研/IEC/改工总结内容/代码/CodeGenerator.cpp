// CodeGenerator.cpp: implementation of the CodeGenerator class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "CodeGenerator.h"
#include "IECDataTypeInfo.h"
#include "01.Public/AppData/DB/StringDB.h"
#include "01.Public/AppData/DB/StructDB.h"
#include "01.Public/AppData/DB/FunctionBlockDB.h"
#include "01.Public/CommonInfo/Interface/GlobalFunc.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CodeGenerator::CodeGenerator(CIECPOU* pPOU)
: m_pPOU(pPOU)
{
}

CodeGenerator::~CodeGenerator()
{

}

BOOL CodeGenerator::Generate(CString& strDeclare, CString& strCode) {
	BOOL bRet = FALSE;
	bRet = GenerateFunction(strDeclare, strCode);
	/*
	char nType = m_pPOU->GetPOUType();
	switch (nType) {
	case PT_PRG:
		bRet = GenerateProgram(strDeclare, strCode);
		break;
	case PT_FB:
		bRet = GenerateFunctionBlock(strDeclare, strCode);
		break;
	case PT_FUN:
		bRet = GenerateFunction(strDeclare, strCode);
		break;
	}
	*/
	return bRet;
}

BOOL CodeGenerator::GenerateProgram(CString& strDeclare, CString& strCode) {
	return FALSE;
}

BOOL CodeGenerator::GenerateFunctionBlock(CString& strDeclare, CString& strCode) {
	return FALSE;
}

BOOL CodeGenerator::GenerateFunction(CString& strDeclare, CString& strCode) {
	CString strParams = GenerateFunctionParameters();
	CString strVariables = GenerateFunctionLocalVariables();
	CString strBody = GenerateFunctionBody();
	
	// FIXME: 处理函数返回值
	CString strReturnType;
	CString strReturnTypeStr = m_pPOU->GetReturnTypeString();
	char nType = CIECDataTypeInfo::GetIECType(strReturnTypeStr);
	if (nType < 0) {
		// FIXME:
		// 复合类型
	} else {
		// FIXME:
		// 简单类型
		strReturnType = GetTypeString((emDataType)nType);
	}

	strDeclare.Empty();
	strDeclare += strReturnType;
	strDeclare += " ";
	strDeclare += m_pPOU->GetPOUName();
	strDeclare += strParams;
	strDeclare += ";\n";

	strCode.Empty();
	strCode += strReturnType;
	strCode += " ";
	strCode += m_pPOU->GetPOUName();
	strCode += strParams;
	strCode += "\n{\n";
	strCode += strVariables;
	strCode += strBody;
	strCode += "}\n";

	return TRUE;
}

CString CodeGenerator::GenerateFunctionParameters() {
	// FIXME:
	// 需要注意初始化值应该怎么生成代码
	CString strResult = "(";
	CLocalVarContainer* pLocalVarContainer = m_pPOU->GetLocalVarContainer();
	//CUserTypeContainer* pUserTypeContainer = m_pPOU->GetUserDefinedTypeContainer();


	POSITION pos = NULL;

	// Input parameters.
	CString strInput;
	pos = pLocalVarContainer->m_inputList.GetHeadPosition();
	while (pos != NULL) {
		CBaseDB* pBaseDB = pLocalVarContainer->m_inputList.GetNext(pos);
		if (pBaseDB != NULL) {
			strInput += "/*[IN]*/ ";
			strInput += InitVariable(pBaseDB, FALSE, FALSE);
			if (pos != NULL) {
				strInput += ", ";
			}
		}
	}
	
	// Input/Output parameters.
	CString strInOut;
	pos = pLocalVarContainer->m_inoutList.GetHeadPosition();
	while (pos != NULL) {
		CBaseDB* pBaseDB = pLocalVarContainer->m_inoutList.GetNext(pos);
		if (pBaseDB != NULL) {
			strInOut += "/*[IN/OUT]*/ ";
			strInOut += InitVariable(pBaseDB, TRUE, FALSE);
			if (pos != NULL) {
				strInOut += ", ";
			}
		}
	}

	if (!strInput.IsEmpty()) {
		strResult += strInput;
	}
	if (!strInOut.IsEmpty()) {
		if (!strInput.IsEmpty()) {
			strResult += ", ";
		}
		strResult += strInOut;
	}

	strResult += ")";

	return strResult;
}

CString CodeGenerator::GenerateFunctionLocalVariables() {
	CString strResult = "";

	ULONG ulDataAreaTotalSize = CGlobalFunc::GetDataAreaTotalSize();
	CString str;
	str.Format("uint32_t DATA_AREA_TOTAL_SIZE = %d;\n", ulDataAreaTotalSize);
	strResult += str;

	CLocalVarContainer* pLocalVarContainer = m_pPOU->GetLocalVarContainer();
	
	
	POSITION pos = NULL;
	pos = pLocalVarContainer->m_tempList.GetHeadPosition();
	while (pos != NULL) {
		CBaseDB* pBaseDB = pLocalVarContainer->m_tempList.GetNext(pos);
		if (pBaseDB != NULL) {
			strResult += InitVariable(pBaseDB, FALSE, TRUE);
		}
	}

	return strResult;
}

BOOL CodeGenerator::IsSimpleDataType(emDataType nDataType) {
	if (nDataType == DT_STRING || nDataType == DT_ARRAY || 
		nDataType == DT_ENUM || nDataType == DT_STRUCT || 
		nDataType == DT_POINTER || nDataType == DT_REF ||
		nDataType == DT_FB) {
		return FALSE;
	}
	return TRUE;
}

CString CodeGenerator::GetTypeString(CBaseDB* pBaseDB) {
	return GetTypeString((emDataType)pBaseDB->GetTypeID());
}

CString CodeGenerator::GetTypeString(emDataType nType) {
	CString strResult;
	switch (nType) {
	case DT_BOOL:
		strResult = "bool";
		break;
	case DT_INT:
		strResult = "int16_t"; // short
		break;
	case DT_BYTE:
		strResult = "uint8_t"; // unsigned char
		break;
	case DT_WORD:
		strResult = "uint16_t"; // unsigned short
		break;
	case DT_DINT:
		strResult = "int32_t"; // int 
		break;
	case DT_DWORD:
		strResult = "uint32_t"; // unsigned int
		break;
	case DT_REAL:
		strResult = "float";
		break;
	case DT_TIME:
		strResult = "TIME";
		break;
	case DT_STRING:
		strResult = "FIXME";
		break;
	case DT_ARRAY:
		strResult = "FIXME";
		break;
	case DT_ENUM:
		strResult = "FIXME";
		break;
	case DT_STRUCT:
		strResult = "FIXME";
		break;
	case DT_BIT:
		strResult = "FIXME";
		break;
	case DT_POINTER:
		strResult = "FIXME";
		break;
	case DT_SINT:
		strResult = "int8_t"; // char
		break;
	case DT_USINT:
		strResult = "uint8_t"; // unsigned char
		break;
	case DT_UINT:
		strResult = "uint16_t"; // unsigned short
		break;
	case DT_UDINT:
		strResult = "uint32_t"; // unsigned int
		break;
	case DT_DATE:
		strResult = "DATE";
		break;
	case DT_TOD:
		strResult = "TOD";
		break;
	case DT_DT:
		strResult = "DT";
		break;
	case DT_VOID:
		strResult = "void";
		break;
	case DT_LREAL:
		strResult = "double";
		break;
	case DT_REF:
		strResult = "FIXME";
		break;
	case DT_FB:
		strResult = "FIXME";
		break;
	case DT_ZO:
		strResult = "FIXME";
		break;
	case DT_NULL:
		strResult = "FIXME";
		break;
	default:
		break;
	}
	return strResult;
}

CString CodeGenerator::GetExpressType(const CString& str) {
	CString strResult;
	if (str.CompareNoCase("NOT") == 0) {
		strResult = "~";
	} else if (str.CompareNoCase("AND") == 0) {
		strResult = "&&";
	} else if (str.CompareNoCase("OR") == 0) {
		strResult = "||";
	} else if (str.CompareNoCase("XOR") == 0) {
		strResult = "^";
	} else if (str.CompareNoCase("ADD") == 0) {
		strResult = "+";
	} else if (str.CompareNoCase("SUB") == 0) {
		strResult = "-";
	} else if (str.CompareNoCase("MUL") == 0) {
		strResult = "*";
	} else if (str.CompareNoCase("DIV") == 0) {
		strResult = "/";
	} else if (str.CompareNoCase("MOD") == 0) {
		strResult = "%";
	}
	return strResult;
}

CString CodeGenerator::InitVariable(CBaseDB* pBaseDB, BOOL bOut, BOOL bInit) {
	CString strResult;

	emDataType nVariableType = (emDataType)pBaseDB->GetTypeID();
	if (IsSimpleDataType(nVariableType)) {
		strResult += GetTypeString(pBaseDB);
		strResult += " ";
		strResult += pBaseDB->GetName();
		if (bInit) {
			strResult += " = ";
			strResult += pBaseDB->GetInitValue();
			strResult += ";\n";
		}
	} else if (nVariableType == DT_POINTER) {
		CPointerDB* pPointerDB = (CPointerDB*)pBaseDB;
		char nType = CIECDataTypeInfo::GetIECType(pPointerDB->GetPointerType());
		strResult += GetTypeString((emDataType)nType);
		strResult += "*";
		strResult += " ";
		strResult += pBaseDB->GetName();
		if (bInit) {
			strResult += " = ";
			strResult += pBaseDB->GetInitValue();
			strResult += ";\n";
		}
	} else if (nVariableType == DT_ARRAY) {
		CArrayDB* pArrayDB = (CArrayDB*)pBaseDB;
		char nType = CIECDataTypeInfo::GetIECType(pArrayDB->GetMemberType());
		strResult += GetTypeString((emDataType)nType);
		strResult += " ";
		strResult += pBaseDB->GetName();

		UINT nDim = pArrayDB->GetDimension();
		for (UINT i = 0; i < nDim; i++) {
			strResult += "[";
			int nStart = pArrayDB->GetDimensionStartPos(i + 1);
			int nEnd = pArrayDB->GetDimensionEndPos(i + 1);
			CString s;
			s.Format("%d/* %d...%d */", nEnd - nStart + 1, nStart, nEnd);
			strResult += s;
			strResult += "]";
		}
		if (bInit) {
			strResult += ";\n";
		}
	} else if (nVariableType == DT_STRING) {
		CStringDB* pVariable = (CStringDB*)pBaseDB;
	} else if (nVariableType == DT_STRUCT) {
		CStructDB* pVariable = (CStructDB*)pBaseDB;
	} else if (nVariableType == DT_FB) {
		CFunctionBlockDB* pVariable = (CFunctionBlockDB*)pBaseDB;
		strResult += pVariable->GetType() + "_FB" + "*";
		strResult += " ";
		strResult += pBaseDB->GetName();
		m_mapVariableNames.SetAt(pBaseDB, "(*" + pBaseDB->GetName() + ")");
	} else {
		// FIXME:
		//ASSERT(FALSE);
	}
	return strResult;
}

CString CodeGenerator::GetVariableName(CBaseDB* pBaseDB) {
	CString str;
	if (pBaseDB == NULL) {
		return str;
	}
	if (m_mapVariableNames.Lookup(pBaseDB, str)) {
		return str;
	} else {
		return pBaseDB->GetName();
	}
}