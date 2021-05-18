// STCodeGenerator.h: interface for the STCodeGenerator class.
//
//////////////////////////////////////////////////////////////////////

#ifndef ST_CODE_GENERATOR_H
#define ST_CODE_GENERATOR_H


#undef IECCOMMON_DLL_DECL
#ifdef _IECCOMMON_DLL_DECL
#define IECCOMMON_DLL_DECL _declspec(dllexport)
#else
#define IECCOMMON_DLL_DECL _declspec(dllimport)
#endif
 

#include "CodeGenerator.h"
#include "Statement.h"

class IECCOMMON_DLL_DECL STCodeGenerator : public CodeGenerator
{
public:
	STCodeGenerator(CIECPOU* pPOU);
	virtual ~STCodeGenerator();
	
protected:
	virtual CString GenerateFunctionBody();

private:
	CString visit(CSyntaxElement* pSyntaxElement);

	// Statement.h	
	CString visit(CSyntaxMark* pSyntaxMark);
	CString visit(CStatement* pStatement);
	CString visit(CStatementList* pStatementList);
	CString visit(CStatementNOP* pStatementNOP);
	CString visit(CStatementEXIT* pStatementEXIT);
	CString visit(CStatementRETURN* pStatementRETURN);
	CString visit(CStatementASGN* pStatementASGN);
	CString visit(CStatementParamASGN* pStatementParamASGN);
	CString visit(CStatementCALL* pStatementCALL);
	CString visit(CStatementREPEAT* pStatementREPEAT);
	CString visit(CStatementWHILE* pStatementWHILE);
	CString visit(CFORList* pFORList);
	CString visit(CStatementFOR* pStatementFOR);
	CString visit(CCaseList* pCaseList);
	CString visit(CCaseElement* pCaseElement);
	CString visit(CCaseElementList* pCaseElementList);
	CString visit(CStatementCASE* pStatementCASE);
	CString visit(CIForElseIFItem* pIForElseIFItem);
	CString visit(CIForElseIFItemList* pIForElseIFItemList);
	CString visit(CElseIForElseItem* pElseIForElseItem);
	CString visit(CStatementIF* pStatementIF);

	// Expression.h
	CString visit(CExpression* pExpression);
	CString visit(CExpressionBasic* pExpressionBasic);
	CString visit(CExpressionInnerData* pExpressionInnerData);
	CString visit(CExpressionConst* pExpressionConst);
	CString visit(CExpressionEnumConst* pExpressionEnumConst);
	CString visit(CExpressionDirectAddress* pExpressionDirectAddress);
	CString visit(CExpressionVariable* pFather, CArraySubscriptList* pArraySubscriptList);
	CString visit(CExpressionVariable* pExpressionVariable);
	CString visit(CParameterList* pParameterList);
	CString visit(CExpressionCALL* pExpressionCALL);

	CString GetExpressionType(emExpressionType type);

	void log(CSyntaxElement* pElement);
};

#endif // ST_CODE_GENERATOR_H
