// STCodeGenerator.cpp: implementation of the STCodeGenerator class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "STCodeGenerator.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

STCodeGenerator::STCodeGenerator(CIECPOU* pPOU)
: CodeGenerator(pPOU)
{
}

STCodeGenerator::~STCodeGenerator()
{
	
}

CString STCodeGenerator::GenerateFunctionBody() {
	CString strResult;
    CArray<CSyntaxElement*,CSyntaxElement*>* arrSyntaxElement = m_pPOU->m_pIECSyntaxElementStack;
    int nSize = arrSyntaxElement->GetSize();
	if (nSize <= 0) {
		return strResult;
	}

    for (int i = 0; i < nSize; i++) {
        CSyntaxElement* pElem = arrSyntaxElement->GetAt(i);
		strResult += visit(pElem);
    }
	return strResult;
}

CString STCodeGenerator::visit(CSyntaxElement* pSyntaxElement) {
	log(pSyntaxElement);
	CString strResult;
	if (pSyntaxElement->IsKindOf(RUNTIME_CLASS(CSyntaxMark))) {
		strResult = visit((CSyntaxMark*)pSyntaxElement);
	} else if (pSyntaxElement->IsKindOf(RUNTIME_CLASS(CStatement))) {
		strResult = visit((CStatement*)pSyntaxElement);
	} else if (pSyntaxElement->IsKindOf(RUNTIME_CLASS(CExpression))) {
		strResult = visit((CExpression*)pSyntaxElement);
	} else {
		OutputDebugString("Unknown\n");
	}
	return strResult;
}

CString STCodeGenerator::visit(CSyntaxMark* pSyntaxMark) {
	return "";
}

CString STCodeGenerator::visit(CStatement* pStatement) {
	log(pStatement);
	CString strResult;
	if (pStatement->IsKindOf(RUNTIME_CLASS(CStatementList))) {
		strResult = visit((CStatementList*)pStatement);
    } else if (pStatement->IsKindOf(RUNTIME_CLASS(CStatementNOP))) {
		strResult = visit((CStatementNOP*)pStatement);
	} else if (pStatement->IsKindOf(RUNTIME_CLASS(CStatementEXIT))) {
		strResult = visit((CStatementEXIT*)pStatement);
	} else if (pStatement->IsKindOf(RUNTIME_CLASS(CStatementRETURN))) {
		strResult = visit((CStatementRETURN*)pStatement);
	} else if (pStatement->IsKindOf(RUNTIME_CLASS(CStatementASGN))) {
		strResult = visit((CStatementASGN*)pStatement);
	} else if (pStatement->IsKindOf(RUNTIME_CLASS(CStatementParamASGN))) {
		strResult = visit((CStatementParamASGN*)pStatement);
	} else if (pStatement->IsKindOf(RUNTIME_CLASS(CStatementCALL))) {
		strResult = visit((CStatementCALL*)pStatement);
	} else if (pStatement->IsKindOf(RUNTIME_CLASS(CStatementREPEAT))) {
		strResult = visit((CStatementREPEAT*)pStatement);
	} else if (pStatement->IsKindOf(RUNTIME_CLASS(CStatementWHILE))) {
		strResult = visit((CStatementWHILE*)pStatement);
	} else if (pStatement->IsKindOf(RUNTIME_CLASS(CFORList))) {
		strResult = visit((CFORList*)pStatement);
	} else if (pStatement->IsKindOf(RUNTIME_CLASS(CStatementFOR))) {
		strResult = visit((CStatementFOR*)pStatement);
	} else if (pStatement->IsKindOf(RUNTIME_CLASS(CCaseList))) {
		strResult = visit((CCaseList*)pStatement);
	} else if (pStatement->IsKindOf(RUNTIME_CLASS(CCaseElement))) {
		strResult = visit((CCaseElement*)pStatement);
	} else if (pStatement->IsKindOf(RUNTIME_CLASS(CCaseElementList))) {
		strResult = visit((CCaseElementList*)pStatement);
	} else if (pStatement->IsKindOf(RUNTIME_CLASS(CStatementCASE))) {
		strResult = visit((CStatementCASE*)pStatement);
	} else if (pStatement->IsKindOf(RUNTIME_CLASS(CIForElseIFItem))) {
		strResult = visit((CIForElseIFItem*)pStatement);
	} else if (pStatement->IsKindOf(RUNTIME_CLASS(CIForElseIFItemList))) {
		strResult = visit((CIForElseIFItemList*)pStatement);
	} else if (pStatement->IsKindOf(RUNTIME_CLASS(CElseIForElseItem))) {
		strResult = visit((CElseIForElseItem*)pStatement);
	} else if (pStatement->IsKindOf(RUNTIME_CLASS(CStatementIF))) {
		strResult = visit((CStatementIF*)pStatement);
	} else {
		OutputDebugStringA("Unknown Statement\n");
	}
	return strResult;
}

CString STCodeGenerator::visit(CStatementList* pStatementList) {
	CString strResult;
	POSITION pos = pStatementList->m_StatementList.GetHeadPosition();
	while (pos != NULL) {
		CSyntaxElement* pElem = pStatementList->m_StatementList.GetNext(pos);
		strResult += visit(pElem);
	}
	return strResult;
}

CString STCodeGenerator::visit(CStatementNOP* pStatementNOP) {
	CString strResult;
	return strResult;
}

CString STCodeGenerator::visit(CStatementEXIT* pStatementEXIT) {
	CString strResult;
	return strResult;
}

CString STCodeGenerator::visit(CStatementRETURN* pStatementRETURN) {
	CString strResult;
	return strResult;
}

CString STCodeGenerator::visit(CStatementASGN* pStatementASGN) {
	// POUType == FUNCTION 
	// Process return xxxx
	CString strResult;
	CString strLeft = visit(pStatementASGN->m_pLeftExpression);
	CString strRight = visit(pStatementASGN->m_pRightExpression);
	if (m_pPOU->GetPOUType() == PT_FUN && strLeft.Find(m_pPOU->GetPOUName(), 0) >= 0) {
		// FIXME:
		// 处理函数返回值，此处仅仅做了简单处理
		strResult = "return ";
	} else {
		strResult = strLeft;
		strResult += " = ";
	}
	strResult += strRight;
	strResult += ";\n";
	return strResult;
}

CString STCodeGenerator::visit(CStatementParamASGN* pStatementParamASGN) {
	CString strResult;
	return strResult;
}

CString STCodeGenerator::visit(CStatementCALL* pStatementCALL) {
	CString strResult;
	return strResult;
}

CString STCodeGenerator::visit(CStatementREPEAT* pStatementREPEAT) {
	CString strResult;
	return strResult;
}

CString STCodeGenerator::visit(CStatementWHILE* pStatementWHILE) {
	CString strCondition = visit(pStatementWHILE->m_pWhileCondition);
	CString strStatements = visit(pStatementWHILE->m_pStatementList);

	CString strResult;
	strResult += "while (";
	strResult += strCondition;
	strResult += ")\n";
	strResult += "{\n";
	strResult += strStatements;
	strResult += "}\n";
	return strResult;
}

CString STCodeGenerator::visit(CFORList* pFORList) {
	CString strResult;
	return strResult;
}

CString STCodeGenerator::visit(CStatementFOR* pStatementFOR) {
	ASSERT(pStatementFOR->m_pFORControl != NULL);
	ASSERT(pStatementFOR->m_pFORControl->IsKindOf(RUNTIME_CLASS(CExpressionVariable)));

	CString strControl = visit(pStatementFOR->m_pFORControl);
	CString strForLeft = visit(pStatementFOR->m_pFORList->m_pToLeft);
	CString strForRight = visit(pStatementFOR->m_pFORList->m_pToRight);
	CString strForBy = visit(pStatementFOR->m_pFORList->m_pBy);
	CString strForStatements = visit(pStatementFOR->m_pStatementList);

	CString strResult;
	strResult += "for(";
	strResult += strControl + " = " + strForLeft + "; ";
	strResult += strControl + " <= " + strForRight + "; ";
	strResult += strControl + " += " + strForBy + "";
	strResult += ")\n";
	strResult += "{\n";
	strResult += strForStatements;
	strResult += "}\n";
	return strResult;
}

CString STCodeGenerator::visit(CCaseList* pCaseList) {
	CString strResult;
	return strResult;
}

CString STCodeGenerator::visit(CCaseElement* pCaseElement) {
	CString strResult;
	return strResult;
}

CString STCodeGenerator::visit(CCaseElementList* pCaseElementList) {
	CString strResult;
	return strResult;
}

CString STCodeGenerator::visit(CStatementCASE* pStatementCASE) {
	CString strResult;
	return strResult;
}

CString STCodeGenerator::visit(CIForElseIFItem* pIForElseIFItem) {
	CString strCondition = visit(pIForElseIFItem->m_pCondition);
	CString strStatements = visit(pIForElseIFItem->m_pStatementList);

	CString strResult;
	strResult += "if ";
	strResult += "(";
	strResult += strCondition;
	strResult += ")";
	strResult += "\n";
	strResult += "{\n";
	strResult += strStatements;
	strResult += "}\n";
	return strResult;
}

CString STCodeGenerator::visit(CIForElseIFItemList* pIForElseIFItemList) {
	CString strResult;
	return strResult;
}

CString STCodeGenerator::visit(CElseIForElseItem* pElseIForElseItem) {
	CString strElseList, strElse;
	if (pElseIForElseItem->m_pIForElseIFItemList != NULL) {
		strElseList = visit(pElseIForElseItem->m_pIForElseIFItemList);
	}
	if (pElseIForElseItem->m_pElesStatementList != NULL) {
		strElse = visit(pElseIForElseItem->m_pElesStatementList);
	}

	CString strResult;
	if (!strElseList.IsEmpty()) {

	}
	if (!strElse.IsEmpty()) {
		strResult += " else ";
		strResult += "{\n";
		strResult += strElse;
		strResult += "}\n";
	}
	return strResult;
}

CString STCodeGenerator::visit(CStatementIF* pStatementIF) {
	CString strIf, strElse;
	strIf = visit(pStatementIF->m_pIForElseIFItem);
	if (pStatementIF->m_pElseIForElseItem) {
		strElse = visit(pStatementIF->m_pElseIForElseItem);
	}

	CString strResult;
	strResult += strIf;
	if (!strElse.IsEmpty()) {
		strResult += strElse;
	}
	return strResult;
}

CString STCodeGenerator::visit(CExpression* pExpression) {
	CString strResult;
	if (pExpression == NULL) {
		return strResult;
	}
	log(pExpression);	
	if (pExpression->IsKindOf(RUNTIME_CLASS(CExpressionBasic))) {
		strResult = visit((CExpressionBasic*)pExpression);
	} else if (pExpression->IsKindOf(RUNTIME_CLASS(CExpressionInnerData))) {
		strResult = visit((CExpressionInnerData*)pExpression);
	} else if (pExpression->IsKindOf(RUNTIME_CLASS(CExpressionConst))) {
		strResult = visit((CExpressionConst*)pExpression);
	} else if (pExpression->IsKindOf(RUNTIME_CLASS(CExpressionEnumConst))) {
		strResult = visit((CExpressionEnumConst*)pExpression);
	} else if (pExpression->IsKindOf(RUNTIME_CLASS(CExpressionDirectAddress))) {
		strResult = visit((CExpressionDirectAddress*)pExpression);
	} else if (pExpression->IsKindOf(RUNTIME_CLASS(CArraySubscriptList))) {
		// FIXME:
		strResult = visit(NULL, (CArraySubscriptList*)pExpression);
	} else if (pExpression->IsKindOf(RUNTIME_CLASS(CExpressionVariable))) {
		strResult = visit((CExpressionVariable*)pExpression);
	} else if (pExpression->IsKindOf(RUNTIME_CLASS(CParameterList))) {
		strResult = visit((CParameterList*)pExpression);
	} else if (pExpression->IsKindOf(RUNTIME_CLASS(CExpressionCALL))) {
		strResult = visit((CExpressionCALL*)pExpression);
	} else if (pExpression->IsKindOf(RUNTIME_CLASS(CStatement))) {
		strResult = visit((CStatement*)pExpression);
	} else if (pExpression->IsKindOf(RUNTIME_CLASS(CExpression))) {
		strResult = visit((CExpression*)pExpression);
	} else {
		OutputDebugString("Known Expression\n");
	}
	return strResult;
}

CString STCodeGenerator::visit(CExpressionBasic* pExpressionBasic) {
	CString strOperator = GetExpressionType(pExpressionBasic->m_emExpressionType);
	CString strFirst = visit(pExpressionBasic->m_p1Expression);
	CString strSecond;
	if (pExpressionBasic->m_p2Expression != NULL) {
		strSecond = visit(pExpressionBasic->m_p2Expression);
	}

	CString strResult;
	if (strSecond.IsEmpty()) {
		strResult += strOperator;
		strResult += strFirst;
	} else {
		strResult += strFirst;
		strResult += " ";
		strResult += strOperator;
		strResult += " ";
		strResult += strSecond;
	}
	return strResult;
}

CString STCodeGenerator::visit(CExpressionInnerData* pExpressionInnerData) {
	CString strResult;
	return strResult;
}

CString STCodeGenerator::visit(CExpressionConst* pExpressionConst) {
	CString strResult;
	strResult = pExpressionConst->m_LexToken.m_sContent;
	return strResult;
}

CString STCodeGenerator::visit(CExpressionEnumConst* pExpressionEnumConst) {
	CString strResult;
	return strResult;
}

CString STCodeGenerator::visit(CExpressionDirectAddress* pExpressionDirectAddress) {
	CString strResult;
	return strResult;
}

CString STCodeGenerator::visit(CExpressionVariable* pFather, CArraySubscriptList* pArraySubscriptList) {
	// Check parameters.
	CString strResult;
	if (NULL == pFather || NULL == pArraySubscriptList) {
		return strResult;
	}
	if (NULL == pFather->m_pVarAssociated) {
		return strResult;
	}

	CArrayDB* pArrayDB = (CArrayDB*)pFather->m_pVarAssociated;
	int nSize = pArraySubscriptList->m_arrArrayIndex.GetSize();
	for (int i = 0; i < nSize; i++) {
		CExpression* pExpression = pArraySubscriptList->m_arrArrayIndex.GetAt(i);

		BOOL bValid = pArrayDB->IsValidDimensionNO(i + 1);
		int nStart = pArrayDB->GetDimensionStartPos(i + 1);
		CString s;
		s.Format(" - %d /* LOW BOUND */", nStart);

		strResult += "[";
		strResult += visit(pExpression);
		strResult += s;
		strResult += "]";
	}
	return strResult;
}

CString STCodeGenerator::visit(CExpressionVariable* pExpressionVariable) {
	// FIXME:
	// 处理变量名称需要注意大小写
	CString strResult;
	switch (pExpressionVariable->m_cVariableType) {
	case VT_SINGLE_VAR:
		strResult = pExpressionVariable->m_LexToken.m_sContent;
		break;
	case VT_ARRAY_PIN:
		strResult = pExpressionVariable->m_pFatherExpressionVariable->m_LexToken.m_sContent;
		strResult += visit(pExpressionVariable->m_pFatherExpressionVariable, pExpressionVariable->m_pArraySubscriptList);
		break;
	case VT_STRUCT_PIN:
		// FIXME:
		break;
	}
	return strResult;
}

CString STCodeGenerator::visit(CParameterList* pParameterList) {
	CString strResult;
	if (pParameterList == NULL) {
		return strResult;
	}
	POSITION pos = pParameterList->m_pSynEleList->GetHeadPosition();
	while (pos != NULL) {
		CSyntaxElement* pElem = pParameterList->m_pSynEleList->GetNext(pos);
		strResult += visit(pElem);
		if (pos != NULL) {
			strResult += ", ";
		}
	}
	return strResult;
}

CString STCodeGenerator::visit(CExpressionCALL* pExpressionCALL) {
	// FIXME: m_pExprVariable
	CString strParam = visit(pExpressionCALL->m_pParameterList);

	CString strResult;
	strResult += pExpressionCALL->m_strCallString;
	strResult += "(";
	strResult += strParam;
	strResult += ")";
	return strResult;
}

CString STCodeGenerator::GetExpressionType(emExpressionType type) {
	CString strResult;
	switch (type) {
		// unary expression
	case IEC_ET_NOT:
		strResult = "~";
		break;
	case IEC_ET_NEGATIVE:
		strResult = "-";
		break;
	case IEC_ET_POSITIVE:
		strResult = "+";
		break;
		
		// logic operate expression
	case IEC_ET_OR:
		strResult = "||";
		break;
	case IEC_ET_XOR:
		strResult = "^";
		break;
	case IEC_ET_AND:
		strResult = "&&";
		break;
		
		// compare expression
	case IEC_ET_EQ:
		strResult = "==";
		break;
	case IEC_ET_NE:
		strResult = "!=";
		break;
	case IEC_ET_GT:
		strResult = ">";
		break;
	case IEC_ET_LT:
		strResult = "<";
		break;
	case IEC_ET_GE:
		strResult = ">=";
		break;
	case IEC_ET_LE:
		strResult = "<=";
		break;
		
		// arthimetic operate expression
	case IEC_ET_ADD:
		strResult = "+";
		break;
	case IEC_ET_SUB:
		strResult = "-";
		break;
	case IEC_ET_MUL:
		strResult = "*";
		break;
	case IEC_ET_DIV:
		strResult = "/";
		break;
	case IEC_ET_MOD:
		strResult = "%";
		break;
	case IEC_ET_RANGE:
		break;
		
	default:
		strResult = "";
		break;
	}
	return strResult;
}

void STCodeGenerator::log(CSyntaxElement* pElement) {
	CRuntimeClass* pRuntimeClass = pElement->GetRuntimeClass();
	OutputDebugString(pRuntimeClass->m_lpszClassName);
	OutputDebugString("\n");
}