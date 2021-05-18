
#ifndef CODE_GENERATOR_H
#define CODE_GENERATOR_H

/*
FUNCTION_BLOCK 打包成结构体，输入输出类型不需要特殊处理，传入参数通过指针传入；使用FUNCTION_BLOCK需要通过指针传入结构体
FUNCTION 参数不打包处理，输出类型的参数需要通过指针传入
全局变量需要特殊处理

需要同时生成.h和.c

*/


#undef IECCOMMON_DLL_DECL
#ifdef _IECCOMMON_DLL_DECL
#define IECCOMMON_DLL_DECL _declspec(dllexport)
#else
#define IECCOMMON_DLL_DECL _declspec(dllimport)
#endif

#include "01.Public\AppData\Pou/IECPOU.h"
#include "IECDataTypeInfo.h"
#include "01.Public/AppData/DB/StringDB.h"
#include "01.Public/AppData/DB/StructDB.h"

class IECCOMMON_DLL_DECL CodeGenerator  
{
public:
	CodeGenerator(CIECPOU* pPOU);
	virtual ~CodeGenerator();
	
public:
	BOOL Generate(CString& strDeclare, CString& strCode);

protected:
	virtual BOOL GenerateProgram(CString& strDeclare, CString& strCode);
	virtual BOOL GenerateFunctionBlock(CString& strDeclare, CString& strCode);
	virtual BOOL GenerateFunction(CString& strDeclare, CString& strCode);
	
	virtual CString GenerateFunctionParameters();
	virtual CString GenerateFunctionLocalVariables();

	virtual CString GenerateFunctionBody() = 0;

protected:
	static BOOL IsSimpleDataType(emDataType nDataType);

	CString GetTypeString(CBaseDB* pBaseDB);
	CString GetTypeString(emDataType nDataType);

	CString GetExpressType(const CString& str);
	
	CString InitVariable(CBaseDB* pBaseDB, BOOL bIsOut, BOOL bInit = FALSE);
	CString GetVariableName(CBaseDB* pBaseDB);

protected:
	CIECPOU* m_pPOU;
	CMap<CBaseDB*, CBaseDB*, CString, LPCTSTR> m_mapVariableNames;

};

#endif // CODE_GENERATOR_H
