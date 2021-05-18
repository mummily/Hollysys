// CFCCodeGenerator.h: interface for the CFCCodeGenerator class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_CFCCODEGENERATOR_H__5372DF6C_3484_47AB_9D55_335AC46B1147__INCLUDED_)
#define AFX_CFCCODEGENERATOR_H__5372DF6C_3484_47AB_9D55_335AC46B1147__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "..\01.IECCommon\CodeGenerator.h"

#include "08.IEC/CFC/CFCSource/CFCPOU.h"

#include "CFCSource/CFCBox.h"
#include "CFCSource/CFCAssign.h"
#include "CFCSource/CFCInput.h"
#include "CFCSource/CFCPin.h"
#include "CFCSource/CFCInputPin.h"
#include "CFCSource/CFCOutput.h"
#include "CFCSource/CFCOutputPin.h"


class CFCCodeGenerator : public CodeGenerator {
public:
	CFCCodeGenerator(CCFCPOU* pPOU);
	virtual ~CFCCodeGenerator();

protected:
	virtual CString GenerateFunctionBody();
	virtual CString GenerateFunctionLocalVariables();

private:
	CString visit(CElement* pElement);
	CString visit(CCFCElement* pElement);
	CString visit(CCFCBox* pBox);
	CString visitFunBox(CCFCBox* pBox);
	CString visitFBBox(CCFCBox* pBox);
	CString visit(CCFCInput* pInput);
	CString visit(CCFCAssign* pAssign);
	CString visit(CCFCLabel* pLabel);
	CString visit(CCFCReturn* pReturn);
	CString visit(CCFCOutput* pOutput);
	CString visit(CCFCJump* pJump);
	CString visit(CCFCComment* pComment);

	CString visit(CCFCPin* pPin);
	CString visit(CCFCInputPin* pInputPin);
	CString visit(CCFCOutputPin* pOutputPin);

	CString visit(CCFCLine* pLine);

	CString GetLeft(CCFCBox* pBox);

	CString GetBoxOutputPinVariableName(CCFCBox* pBox, int nPinIndex);

	//CString visitOperatorBox(CCFCBox* pBox);
	//CString visitFBBox(CCFCBox* pBox);

};

#endif // !defined(AFX_CFCCODEGENERATOR_H__5372DF6C_3484_47AB_9D55_335AC46B1147__INCLUDED_)
