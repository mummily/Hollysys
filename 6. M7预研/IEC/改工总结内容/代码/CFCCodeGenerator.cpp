// CFCCodeGenerator.cpp: implementation of the CFCCodeGenerator class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "CFCCodeGenerator.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CFCCodeGenerator::CFCCodeGenerator(CCFCPOU* pPOU)
: CodeGenerator(pPOU)
{
}

CFCCodeGenerator::~CFCCodeGenerator() {
}

CString CFCCodeGenerator::GenerateFunctionBody() {
	CString strResult;
	CCFCPOU* pPOU = static_cast<CCFCPOU*>(m_pPOU);
	// sort cfc element with cfc execute order
	CArray<CCFCElementIDAndExecuteOrder,CCFCElementIDAndExecuteOrder&> CFCOrderArray;
	pPOU->SortCFCExecute(CFCOrderArray);

	// deal with cfc element with execute order logic
	int nSize = CFCOrderArray.GetSize();
	for (int i = 0; i < nSize; i++) {
		CCFCElementIDAndExecuteOrder& order = CFCOrderArray[i];
		int nElementID = order.GetElementID();
		CCFCElement* pElement = NULL;
		pPOU->GetElementMap()->Lookup(nElementID, pElement);
		strResult += visit(pElement);
	}
	return strResult;
}

CString CFCCodeGenerator::GenerateFunctionLocalVariables() {
	CString strResult = CodeGenerator::GenerateFunctionLocalVariables();
	
	CMap<CString,LPCSTR,CBaseDB*,CBaseDB*>* pTempVarMap = m_pPOU->GetPOUTempVarMap();

	POSITION pos = NULL;
	pos = pTempVarMap->GetStartPosition();
	while (pos != NULL) {
		CString strKey;
		CBaseDB* pBaseDB = NULL;
		pTempVarMap->GetNextAssoc(pos, strKey, pBaseDB);
		if (pBaseDB != NULL) {
			strResult += InitVariable(pBaseDB, FALSE, TRUE);
		}
	}
	
	return strResult;
}

CString CFCCodeGenerator::visit(CElement* pElement) {
	CString strResult;
	if (pElement->IsKindOf(RUNTIME_CLASS(CCFCElement))) {
		strResult = visit((CCFCElement*)pElement);
	}
	return strResult;
}

CString CFCCodeGenerator::visit(CCFCElement* pElement) {
	CString strResult;
	if (pElement->IsKindOf(RUNTIME_CLASS(CCFCBox))) {
		strResult = visit((CCFCBox*)pElement);
	} else if (pElement->IsKindOf(RUNTIME_CLASS(CCFCOutput))) {
		strResult = visit((CCFCOutput*)pElement);
	}
	return strResult;
}

CString CFCCodeGenerator::visit(CCFCBox* pBox) {
	CString strResult;

	// Process box
	emBoxType nBoxType = pBox->GetBoxType();
	if (nBoxType == BT_FB) {
		strResult = visitFBBox(pBox);
	} else {
		strResult = visitFunBox(pBox);
	}

	return strResult;
}

CString CFCCodeGenerator::visitFunBox(CCFCBox* pBox) {
	CString strResult;

	// Function name.
	CString strElementText = pBox->GetElementText();
	CString strOperator = strElementText;

	// Block EN/ENO.
	CString strEN;
	CCFCInputPin* pENPin = pBox->GetInputPinByIndex(0);
	CBaseDB* pENVar = pBox->GetBoxEnEnoVar();
	if (pENPin->DoesHaveLine()) {
		strEN.Format("%s = %s;\n", pENVar->GetName(), visit(pENPin));
	}

	// Function return.
	CString strLeft = GetLeft(pBox);
	
	// Function parameters.
	CString strParams;
	int nInputPinCount = pBox->GetInputPinCount();
	for (int i = 1; i < nInputPinCount; i++) {
		CCFCInputPin* pInputPin = pBox->GetInputPinByIndex(i);
		strParams += visit(pInputPin);
		if (i != nInputPinCount - 1) {
			strParams += ", ";
		}
	}
	CString str = strLeft + " = " + strOperator + "(" + strParams + ");\n";
	if (strEN.IsEmpty()) {
		strResult.Format("%s = %s(%s);\n", strLeft, strOperator, strParams);
	} else {
		strResult.Format("%sif (%s) {\n%s = %s(%s);\n}\n", strEN, pENVar->GetName(), strLeft, strOperator, strParams);
	}

	return strResult;
}

CString CFCCodeGenerator::visitFBBox(CCFCBox* pBox) {
	CString strResult;

	CBaseDB* pBoxVar = pBox->GetVar();
	CString strElementText = pBox->GetElementText();

	// Initialize input variables.
	int nInputPinCount = pBox->GetInputPinCount();
	for (int i = 1; i < nInputPinCount; i++) {
		CCFCInputPin* pInputPin = pBox->GetInputPinByIndex(i);
		CString strPinName = pInputPin->GetPinName();
		strResult += GetVariableName(pBoxVar) + "." + strPinName + " = " + visit(pInputPin) + ";\n";
	}

	// Call function block.
	CString strName;
	if (pBoxVar != NULL) {
		strName = pBoxVar->GetName();
	}
	CString strCall = strElementText + "(" + strName + ");\n";
	strResult += strCall;

	return strResult;
}

CString CFCCodeGenerator::visit(CCFCInput* pInput) {
	CString strResult;
	return strResult;
}

CString CFCCodeGenerator::visit(CCFCAssign* pAssign) {
	CString strResult;
	return strResult;
}

CString CFCCodeGenerator::visit(CCFCLabel* pLabel) {
	CString strResult;
	return strResult;
}

CString CFCCodeGenerator::visit(CCFCReturn* pReturn) {
	CString strResult;
	return strResult;
}

CString CFCCodeGenerator::visit(CCFCOutput* pOutput) {
	CString strResult;
	CCFCPOU* pPOU = static_cast<CCFCPOU*>(m_pPOU);

	CString strRight;
	CCFCInputPin* pInputPin = pOutput->GetInputPinByIndex(0);
	CCFCLine *pCFCLine = pInputPin->GetCFCLine();
	if (pCFCLine == NULL) {
		return strResult;
	}

	CString strEN;
	CCFCElement* pElement = pPOU->GetCFCElementByID(pCFCLine->m_iOutputPinElementID);
	if (pElement->IsKindOf(RUNTIME_CLASS(CCFCBox))) {
		CCFCBox* pBox = (CCFCBox*)pElement;
		strRight += GetBoxOutputPinVariableName(pBox, pCFCLine->m_iOutputPinIndex);
		CCFCInputPin* pENPin = pBox->GetInputPinByIndex(0);
		if (pENPin->DoesHaveLine()) {
			strEN = pBox->GetBoxEnEnoVar()->GetName();
		}
	}

	CBaseDB* pVar = pOutput->GetVar();
	if (pVar == NULL) {
		return strResult;
	}
	BOOL bCanBeForced = pPOU->CanBeForced(pVar->GetName());
	CString strLeft = pVar->GetName();

	CString str;
	if (m_pPOU->GetPOUName().CompareNoCase(strLeft) == 0) {
		str = "return " + strRight + ";\n";
	} else {
		if (bCanBeForced) {
			CString s;
			s.Format("bool %s_FORCE_FLAG = (bool)(*((uint8_t*)ADDR(%s) + DATA_AREA_TOTAL_SIZE));\n", strLeft, strLeft);
			str.Format("%sif (!%s_FORCE_FLAG) {\n%s = %s;\n}\n", s, strLeft, strLeft, strRight);
		} else {
			str.Format("%s = %s;\n", strLeft, strRight);
		}
	}
	if (strEN.IsEmpty()) {
		strResult = str;
	} else {
		strResult.Format("if (%s) {\n%s}\n", strEN, str);
	}

	return strResult;
}

CString CFCCodeGenerator::visit(CCFCJump* pJump) {
	CString strResult;
	return strResult;
}

CString CFCCodeGenerator::visit(CCFCComment* pComment) {
	CString strResult;
	return strResult;
}

CString CFCCodeGenerator::visit(CCFCPin* pPin) {
	CString strResult;
	if (pPin->IsKindOf(RUNTIME_CLASS(CCFCInputPin))) {
		strResult = visit((CCFCInputPin*)pPin);
	} else if (pPin->IsKindOf(RUNTIME_CLASS(CCFCOutputPin))) {
		strResult = visit((CCFCOutputPin*)pPin);
	}
	return strResult;
}

CString CFCCodeGenerator::visit(CCFCInputPin* pInputPin) {
	CString strResult;
	CString strPinName = pInputPin->GetPinName();
	CCFCLine* pLine = pInputPin->GetCFCLine();
	if (pLine == NULL) {
		return strResult;
	}
	CCFCPOU* pPOU = static_cast<CCFCPOU*>(m_pPOU);
	CCFCElement* pElement = pPOU->GetCFCElementByID(pLine->m_iOutputPinElementID);
	if (pElement->IsKindOf(RUNTIME_CLASS(CCFCInput))) {
		CCFCInput* pInputElem = static_cast<CCFCInput*>(pElement);
		CCFCOutputPin* pOutputPin = pInputElem->GetOutputPin();
		CElementTextInfo* pTextInfo = pElement->GetElementTextInfo();
		strResult = pTextInfo->m_strContent;
	} else if (pElement->IsKindOf(RUNTIME_CLASS(CCFCBox))) {
		CCFCBox* pBoxElem = static_cast<CCFCBox*>(pElement);
		strResult =GetBoxOutputPinVariableName(pBoxElem, pLine->m_iOutputPinIndex);
	}
	return strResult;
}

CString CFCCodeGenerator::visit(CCFCOutputPin* pOutputPin) {
	CString strResult;
	return strResult;
}

CString CFCCodeGenerator::GetLeft(CCFCBox* pBox) {
	CBaseDB* pBoxVar = pBox->GetVar();
	CString strResult = pBoxVar->GetName();
	char nTypeId = pBoxVar->GetTypeID();
	if (nTypeId == DT_FB) {
		CFunctionBlockDB* pDB = (CFunctionBlockDB*)pBoxVar;

	}
	return strResult;
}

CString CFCCodeGenerator::GetBoxOutputPinVariableName(CCFCBox* pBox, int nPinIndex) {
	CString strResult;
	if (pBox == NULL || nPinIndex < 0) {
		return strResult;
	}
	CBaseDB* pBoxVar = pBox->GetBoxVar();
	CBaseDB* pBaseVar = pBox->GetOutputPinVar(nPinIndex);
	if (pBoxVar != NULL && pBoxVar->GetName().CompareNoCase(pBaseVar->GetName()) != 0 && nPinIndex != 0) {
		strResult = GetVariableName(pBoxVar) + "." + GetVariableName(pBaseVar);
	} else {
		strResult = GetVariableName(pBaseVar);
	}
	return strResult;
}

/*
CString CFCCodeGenerator::visitFBBox(CCFCBox* pBox) {
	CString strResult;

	CBaseDB* pBoxVar = pBox->GetVar();
	CString strElementText = pBox->GetElementText();


	CString strOperator = GetExpressType(strElementText);
	
	// 
	CCFCPOU* pPOU = static_cast<CCFCPOU*>(m_pPOU);
	CString strLeft = pBox->GetVar()->GetName();
	CString strRight;
	
	for (int i = 1; i < pBox->GetInputPinCount(); i++) {
		CCFCInputPin* pInputPin = pBox->GetInputPinByIndex(i);
		CString strText = visit(pInputPin);
		if (i != 1) {
			strRight += " " + strOperator + " ";
		}
		strRight += strText;
	}
	strResult = strLeft + " = " + strRight + ";\n";

	return strResult;
}

CString CFCCodeGenerator::visitOperatorBox(CCFCBox* pBox) {
	CString strResult;
	CString strElementText = pBox->GetElementText();
	if (CIECPOU::IsTypeConversionOperator(strElementText)) {
		
	} else if (strElementText.CompareNoCase("MOVE") == 0) {
		
	} else if (strElementText.CompareNoCase("SIZEOF") == 0) {
		
	} else if (strElementText.CompareNoCase("ADR") == 0) {
		
	} else if (strElementText.CompareNoCase("VAL") == 0) {
		
	} else if (CIECPOU::IsArithmeticOperators(strElementText) || CIECPOU::IsLogicOperators(strElementText)) {
		CString strOperator = GetExpressType(strElementText);
		
		// 
		CCFCPOU* pPOU = static_cast<CCFCPOU*>(m_pPOU);
		CString strLeft = pBox->GetVar()->GetName();
		CString strRight;
		
		for (int i = 1; i < pBox->GetInputPinCount(); i++) {
			CCFCInputPin* pInputPin = pBox->GetInputPinByIndex(i);
			CString strText = visit(pInputPin);
			if (i != 1) {
				strRight += " " + strOperator + " ";
			}
			strRight += strText;
		}
		strResult = strLeft + " = " + strRight + ";\n";
	}

	return strResult;
}
*/