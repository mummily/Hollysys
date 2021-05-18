%{
/**************************************************************************
 * Copyright(c) 2010,北京和利时系统工程有限公司
 * All rights reserved.
 * 文件名称：LexForIEC.c
 * 摘    要：将IEC语言中用到的词法分析器
 *
 * 当前版本：3.0
 * 作    者：chx
 * 创建日期：2011-10-12
**************************************************************************/

#include <malloc.h>
#include <string.h>
#include <ctype.h>
#include <process.h>
#include <memory.h>

#define LEXFORIEC_API _declspec(dllexport)
#include "../../../01_Include/08.IEC/ST/LexForIEC.h"

//全局变量
tagLexTokenList *p_yy_token_pre;     //指向符号链表前缀节点指针
tagLexTokenList *p_yy_token_head;    //指向符号链表的头节点
tagLexTokenList *p_yy_token_cur;     //指向当前符号节点的指针

int yy_st_line=1;          //所在行数
int yy_st_nest=0;          //用于支持嵌套注释
int yy_st_offset=0;        //字符所在位置
int yy_st_length=0;        //文本长度
int yy_token_head_init=0;  //头是否创建,0表示为创建,1表示创建

//2011-11-18,start_add
const int TOKEN_CHINESE = 10000; //2011-11-18 chx添加，内部使用的用来标记中文字符的Token类型
//end_add

char *p_yy_st_text;        //输入需要解析的文本


//重新定义flex中文本的输入输出函数
#undef YY_INPUT
#define YY_INPUT(b,r,ms) (r=my_yyinput(b,ms))
int my_yyinput(char* buf,int MaxSize);

#undef unput
void unput(int ch);

#undef yywrap

//将新匹配的符号插入到符号链表中
void newSTToken(unsigned long ulType, unsigned long ulSubType);
//启动词法分析器
void GetSTTokenListFromLex(char *pText,tagLexTokenList **ppTokenHead);
//对于变量和图形语言来说"-9"或"+9"这样的字符串应该识别为一个常量标记，而现在的
//词法分析器则将其识别为"-"和"9"两个标记，因此需要对它的识别结果进行修改
//此外对于中文字符，也识别为两个标记，应合并为一个
int ModifyTokenList(tagLexTokenList *pTokenList,int bMergeConst);
//int MergeChineseToken(tagLexTokenList *pTokenList)
%}

%s COMMENT

%%
"(*"  {
       if (yy_st_nest==0)
         {   
            BEGIN COMMENT;
            yy_st_nest=1;
         }
       else
	 yy_st_nest++;
	 printf("Begin Comment:%d\n",yy_st_nest); 
      }
<COMMENT>"*)" { 
		printf("Comment Over:%d\n ",yy_st_nest);  
		yy_st_nest--;
		if (yy_st_nest==0)
		    BEGIN 0; 
	      }	      
<COMMENT>[^"(""*"\n]* {printf(" :comment: %s",yytext);}
<COMMENT>"("|"*"|\"   {printf(" :comment: %s",yytext);}

<COMMENT>\n   {yy_st_line++;}

"'"([^'\n]|"$'")*"'" {
            newSTToken(TOKEN_CONSTANT,SUBTYPE_STRING);
   }

(I|i)(F|f)      { 
                  newSTToken(TOKEN_IF,0); //if
	        }
(T|t)(H|h)(E|e)(N|n)   { 
                         newSTToken(TOKEN_THEN,0); //then
	               }
(E|e)(L|l)(S|s)(I|i)(F|f)    {
                               newSTToken(TOKEN_ELSIF,0); //elsif
	                     }
(E|e)(L|l)(S|s)(E|e)    { 
                          newSTToken(TOKEN_ELSE,0); //else
	                }
(E|e)(N|n)(D|d)"_"(I|i)(F|f)   { 
                                 newSTToken(TOKEN_END_IF,0); //end_if
	                       }
(C|c)(A|a)(S|s)(E|e)    { 
                          newSTToken(TOKEN_CASE,0); //case
	                }
(E|e)(N|n)(D|d)"_"(C|c)(A|a)(S|s)(E|e)   {
                                            newSTToken(TOKEN_END_CASE,0); //end_case
	                                 }
(O|o)(F|f)      {
                   newSTToken(TOKEN_OF,0); //of
	        }
(F|f)(O|o)(R|r)     { 
                       newSTToken(TOKEN_FOR,0); //for
	            }
(T|t)(O|o)      {
                   newSTToken(TOKEN_TO,0); //to
	        }
(D|d)(O|o)      {
                   newSTToken(TOKEN_DO,0); //do
	        }
(B|b)(Y|y)      {
                   newSTToken(TOKEN_BY,0); //by
	        } 
(E|e)(N|n)(D|d)"_"(F|f)(O|o)(R|r) {
                                     newSTToken(TOKEN_END_FOR,0); //end_for
	                          }
(W|w)(H|h)(I|i)(L|l)(E|e)   {
                               newSTToken(TOKEN_WHILE,0); //while
	                    } 
	  
(E|e)(N|n)(D|d)"_"(W|w)(H|h)(I|i)(L|l)(E|e)   { 
                                                 newSTToken(TOKEN_END_WHILE,0); //end_while
	                                      } 
(R|r)(E|e)(P|p)(E|e)(A|a)(T|t)   {
                                    newSTToken(TOKEN_REPEAT,0); //repeat
	                         } 
(E|e)(N|n)(D|d)"_"(R|r)(E|e)(P|p)(E|e)(A|a)(T|t) {
                                                     newSTToken(TOKEN_END_REPEAT,0); //end_repeat
	                                         }  
(U|u)(N|n)(T|t)(I|i)(L|l)      { 
                                  newSTToken(TOKEN_UNTIL,0); //until
	                       } 
(R|r)(E|e)(T|t)(U|u)(R|r)(N|n)     { 
                                      newSTToken(TOKEN_RETURN,0); //return
	                           } 
(E|e)(X|x)(I|i)(T|t)    {
                           newSTToken(TOKEN_EXIT,0); //exit
	                }
(X|x)(O|o)(R|r)      { 
                        newSTToken(TOKEN_XOR,0); //xor
	             }
(A|a)(N|n)(D|d)      {
                         newSTToken(TOKEN_AND,0); //and
	             }
(O|o)(R|r)       {
                    newSTToken(TOKEN_OR,0); //or
	         }
(M|m)(O|o)(D|d)      {
                         newSTToken(TOKEN_MOD,0); //mod
	             }
(N|n)(O|o)(T|t)      { 
                        newSTToken(TOKEN_NOT,0); //not
	             }
	             
"+"   {
         newSTToken('+',0); //"+"
      }
"-"   { 
         newSTToken('-',0); //"-"
      }
"*"   { 
         newSTToken('*',0); //"*"
      } 
"/"   {
         newSTToken('/',0); //"/" 
      }
";"   {
         newSTToken(';',0); //";" 
      } 
","   {
         newSTToken(',',0); //","
      }
":"   { 
         newSTToken(':',0); //":"
      }
":="  {
         newSTToken(TOKEN_EVALUATE,0); //":=" 
      }
"."   {
         newSTToken('.',0); //"."
      }
".."  {
         newSTToken(TOKEN_RANGE,0); //".." 
      }
"("   { 
         newSTToken('(',0); //"("
      }
")"   { 
         newSTToken(')',0); //")"
      }
"["   {
         newSTToken('[',0); //"["
      }
"]"   {
         newSTToken(']',0); //"]"
      }
">"   { 
         newSTToken('>',0); //">"
      }
"="   {
         newSTToken('=',0); //"=" 
      }
"<"   {
         newSTToken('<',0); //"<"
      }
">="  { 
         newSTToken(TOKEN_GE,0); //">="
      }
"<="  {
         newSTToken(TOKEN_LE,0); //"<="
      }
"<>"  { 
         newSTToken(TOKEN_NE,0); //"<>"
      }
"&"   { 
         newSTToken('&',0); //"&"
      }

[0-9]*"@"(([A-Z]|[a-z]|_)([A-Z]|[a-z]|[0-9]|_|".")*("["((([A-Z]|[a-z]|[0-9]|_)([A-Z]|[a-z]|[0-9]|_|".")*("["((([A-Z]|[a-z]|[0-9]|_)([A-Z]|[a-z]|[0-9]|_|".")*)((" ")*","(" ")*([A-Z]|[a-z]|[0-9]|_)([A-Z]|[a-z]|[0-9]|_|".")*)*)"]")*)((" ")*","(" ")*([A-Z]|[a-z]|[0-9]|_)([A-Z]|[a-z]|[0-9]|_|".")*("["((([A-Z]|[a-z]|[0-9]|_)([A-Z]|[a-z]|[0-9]|_|".")*)((" ")*","(" ")*([A-Z]|[a-z]|[0-9]|_)([A-Z]|[a-z]|[0-9]|_|".")*)*)"]")*)*)"]")*) {
            newSTToken(TOKEN_IDENTIFIER,0);  //网络变量
          }  
          
[0-9]*"@"([0-9]+([A-Z]|[a-z]|_)([A-Z]|[a-z]|[0-9]|_|".")*("["((([A-Z]|[a-z]|[0-9]|_)([A-Z]|[a-z]|[0-9]|_|".")*("["((([A-Z]|[a-z]|[0-9]|_)([A-Z]|[a-z]|[0-9]|_|".")*)((" ")*","(" ")*([A-Z]|[a-z]|[0-9]|_)([A-Z]|[a-z]|[0-9]|_|".")*)*)"]")*)((" ")*","(" ")*([A-Z]|[a-z]|[0-9]|_)([A-Z]|[a-z]|[0-9]|_|".")*("["((([A-Z]|[a-z]|[0-9]|_)([A-Z]|[a-z]|[0-9]|_|".")*)((" ")*","(" ")*([A-Z]|[a-z]|[0-9]|_)([A-Z]|[a-z]|[0-9]|_|".")*)*)"]")*)*)"]")*) {
            newSTToken(TOKEN_IDENTIFIER,0);  //网络变量    //2011-11-23 chx 添加 为了是网络变量的命名可以以数字开头
          }
          
(0|1)  {
          newSTToken(TOKEN_CONSTANT,SUBTYPE_ZO); //"0|1"       //2011-10-13 chx添加 为了使变模块和图形语言模块能够识别DT_ZO类型
       }  
	
((((B|b)(Y|y)(T|t)(E|e))|((W|w)(O|o)(R|r)(D|d))|((D|d)(W|w)(O|o)(R|r)(D|d)))"#")?([0-9]+)  {
	    newSTToken(TOKEN_CONSTANT,SUBTYPE_BIT); //"byte,word,dword"    
	  }
((((B|b)(Y|y)(T|t)(E|e))|((W|w)(O|o)(R|r)(D|d))|((D|d)(W|w)(O|o)(R|r)(D|d)))"#")?("2#"(0|1)+)  {
	     newSTToken(TOKEN_CONSTANT,SUBTYPE_BIT); //"byte,word,dword"+"2#"      
	  }
((((B|b)(Y|y)(T|t)(E|e))|((W|w)(O|o)(R|r)(D|d))|((D|d)(W|w)(O|o)(R|r)(D|d)))"#")?("8#"[0-7]+)  {
	     newSTToken(TOKEN_CONSTANT,SUBTYPE_BIT); //"byte,word,dword"+"8#"      
	  }
((((B|b)(Y|y)(T|t)(E|e))|((W|w)(O|o)(R|r)(D|d))|((D|d)(W|w)(O|o)(R|r)(D|d)))"#")?("16#"[0-9A-Fa-f]+) {
	     newSTToken(TOKEN_CONSTANT,SUBTYPE_BIT); //"byte,word,dword"+"16#" 
	  }
(((B|b)(O|o)(O|o)(L|l))"#")?((0|1)|((T|t)(R|r)(U|u)(E|e))|((F|f)(A|a)(L|l)(S|s)(E|e)))   {
	     newSTToken(TOKEN_CONSTANT,SUBTYPE_BOOL); //"bool#"    
	  }
((((S|s)(I|i)(N|n)(T|t))|((I|i)(N|n)(T|t))|((D|d)(I|i)(N|n)(T|t))|((U|u)(S|s)(I|i)(N|n)(T|t))|((U|u)(I|i)(N|n)(T|t))|((U|u)(D|d)(I|i)(N|n)(T|t)))"#")?([0-9]+) {
	     newSTToken(TOKEN_CONSTANT,SUBTYPE_INTEGER); //"sint,int,dint,usint,uint,udint""#"    
	  } 
((((S|s)(I|i)(N|n)(T|t))|((I|i)(N|n)(T|t))|((D|d)(I|i)(N|n)(T|t)))"#")("+"|"-")([0-9]+) {
			 //2012-02-02, chx altered, save old rules
			 //因为usint，unit，udint类型没有‘+’或‘-’
	     //((((S|s)(I|i)(N|n)(T|t))|((I|i)(N|n)(T|t))|((D|d)(I|i)(N|n)(T|t))|((U|u)(S|s)(I|i)(N|n)(T|t))|((U|u)(I|i)(N|n)(T|t))|((U|u)(D|d)(I|i)(N|n)(T|t)))"#")("+"|"-")([0-9]+)
	     newSTToken(TOKEN_CONSTANT,SUBTYPE_INTEGER); //"sint,int,dint,usint,uint,udint""#+|-"    
	  } 
((((S|s)(I|i)(N|n)(T|t))|((I|i)(N|n)(T|t))|((D|d)(I|i)(N|n)(T|t))|((U|u)(S|s)(I|i)(N|n)(T|t))|((U|u)(I|i)(N|n)(T|t))|((U|u)(D|d)(I|i)(N|n)(T|t)))"#")?("2#"(0|1)+) {
	     newSTToken(TOKEN_CONSTANT,SUBTYPE_INTEGER); //"sint,int,dint,usint,uint,udint""2#"    
	  } 
((((S|s)(I|i)(N|n)(T|t))|((I|i)(N|n)(T|t))|((D|d)(I|i)(N|n)(T|t)))"#")?("8#"("+"|"-")[0-7]+) {
	     //2012-02-02, chx altered, save old rules
			 //因为usint，unit，udint类型没有‘+’或‘-’
	     //((((S|s)(I|i)(N|n)(T|t))|((I|i)(N|n)(T|t))|((D|d)(I|i)(N|n)(T|t))|((U|u)(S|s)(I|i)(N|n)(T|t))|((U|u)(I|i)(N|n)(T|t))|((U|u)(D|d)(I|i)(N|n)(T|t)))"#")("8#"("+"|"-")[0-8]+)
	     newSTToken(TOKEN_CONSTANT,SUBTYPE_INTEGER); //"sint,int,dint,usint,uint,udint""8#+|-"   
	  } 
((((S|s)(I|i)(N|n)(T|t))|((I|i)(N|n)(T|t))|((D|d)(I|i)(N|n)(T|t))|((U|u)(S|s)(I|i)(N|n)(T|t))|((U|u)(I|i)(N|n)(T|t))|((U|u)(D|d)(I|i)(N|n)(T|t)))"#")?("8#"[0-7]+) {
	     newSTToken(TOKEN_CONSTANT,SUBTYPE_INTEGER); //"sint,int,dint,usint,uint,udint""8#"    
	  } 

((((S|s)(I|i)(N|n)(T|t))|((I|i)(N|n)(T|t))|((D|d)(I|i)(N|n)(T|t))|((U|u)(S|s)(I|i)(N|n)(T|t))|((U|u)(I|i)(N|n)(T|t))|((U|u)(D|d)(I|i)(N|n)(T|t)))"#")?("16#"[0-9A-Fa-f]+)  {
	     newSTToken(TOKEN_CONSTANT,SUBTYPE_INTEGER); //"sint,int,dint,usint,uint,udint""16#"    
	  } 
((((S|s)(I|i)(N|n)(T|t))|((I|i)(N|n)(T|t))|((D|d)(I|i)(N|n)(T|t)))"#")?("16#"("+"|"-")[0-9A-Fa-f]+)  {  
	     //2012-02-02, chx altered, save old rules
			 //因为usint，unit，udint类型没有‘+’或‘-’
	     //((((S|s)(I|i)(N|n)(T|t))|((I|i)(N|n)(T|t))|((D|d)(I|i)(N|n)(T|t))|((U|u)(S|s)(I|i)(N|n)(T|t))|((U|u)(I|i)(N|n)(T|t))|((U|u)(D|d)(I|i)(N|n)(T|t)))"#")("16#"("+"|"-")[0-9A-Fa-f]+)
	     newSTToken(TOKEN_CONSTANT,SUBTYPE_INTEGER); //"sint,int,dint,usint,uint,udint""16#+|-"    
	  } 
((((R|r)(E|e)(A|a)(L|l))|((L|l)(R|r)(E|e)(A|a)(L|l)))"#")("+"|"-")([0-9]+)"."([0-9]+)(("E"|"e")("+"|"-")?[0-9]+)?    {
	     newSTToken(TOKEN_CONSTANT,SUBTYPE_REAL); //"real,lreal""#+|-"    //2011-10-12 chx 修改 为了区别在变量命名规则中可以以数字开头的功能，将该规则格式改为 number.number E number 其中的"."不能省略
	  } 
((((R|r)(E|e)(A|a)(L|l))|((L|l)(R|r)(E|e)(A|a)(L|l)))"#")?([0-9]+)"."([0-9]+)(("E"|"e")("+"|"-")?[0-9]+)?    {
	     newSTToken(TOKEN_CONSTANT,SUBTYPE_REAL); //"real,lreal""#"      //2011-10-12 chx 修改 为了区别在变量命名规则中可以以数字开头的功能，将该规则格式改为 number.number E number 其中的"."不能省略
	  } 
	  
(T|t)((I|i)(M|m)(E|e))?"#"([0-9]+("."[0-9]+)?(D|d))?([0-9]+("."[0-9]+)?(H|h))?([0-9]+("."[0-9]+)?(M|m))?([0-9]+("."[0-9]+)?(S|s))?([0-9]+("."[0-9]+)?((M|m)(S|s)))?    {
	      //2012-03-29,chx comment,去掉所有间隔，由于带间隔的时间常量在语法检查时报错
	      //(T|t)((I|i)(M|m)(E|e))?"#""-"?([0-9]+("."[0-9]+)?(D|d))?([0-9]+("."[0-9]+)?(H|h))?([0-9]+("."[0-9]+)?(M|m))?([0-9]+("."[0-9]+)?(S|s))?([0-9]+("."[0-9]+)?((M|m)(S|s)))? 
	      newSTToken(TOKEN_CONSTANT,SUBTYPE_TIME); //"time""#"       
	  } 
(((T|t)(I|i)(M|m)(E|e)"_"(O|o)(F|f)"_"(D|d)(A|a)(Y|y))|((T|t)(O|o)(D|d)))"#"[0-9]+":"[0-9]+":"[0-9]+("."[0-9]+)?  {
	      newSTToken(TOKEN_CONSTANT,SUBTYPE_TOD); //"time_of_day""#"      
	  } 
	  
(((D|d)(A|a)(T|t)(E|e))|(D|d))"#"[0-9]+"-"[0-9]+"-"[0-9]+       {
	      newSTToken(TOKEN_CONSTANT,SUBTYPE_DATE); //"date""#"       
	  } 
(((D|d)(A|a)(T|t)(E|e)"_"(A|a)(N|n)(D|d)"_"(T|t)(I|i)(M|m)(E|e))|((D|d)(T|t)))"#"[0-9]+"-"[0-9]+"-"[0-9]+"-"[0-9]+":"[0-9]+":"[0-9]+("."[0-9]+)?  {
	      newSTToken(TOKEN_CONSTANT,SUBTYPE_DT); //"date_and_time""#"       
	  } 
	  
([A-Z]|[a-z]|_)([A-Z]|[a-z]|[0-9]|_)*    {
	      newSTToken(TOKEN_IDENTIFIER,0); //标识符        
	  } 
	   	  
[0-9]+([A-Z]|[a-z]|_)([A-Z]|[a-z]|[0-9]|_)*    {
	      newSTToken(TOKEN_IDENTIFIER,0); //标识符  2011-11-24 chx添加 使得变量名称可以以数字开头   
	  }                                  

"%"((I|i)|(Q|q)|(M|m)|(S|s))((X|x)|(B|b)|(W|w)|(D|d))[0-9]+("."[0-9]+)* {
	      newSTToken(TOKEN_DIRECTVAR, 0);  //直接地址变量       
	  } 

[ \t]       {;}
\n          {  yy_st_line++; }
.            {
	         newSTToken(yytext[0],0); //单个字符  
	     } 	  
%%

/*************************************************************
*函数功能： 创建Token节点
*参    数： ulType：节点类型，ulSubType：节点子类型
*返 回 值： void
*创 建 者： chx
*创建日期： 2011-10-12
***************************************************************/
void newSTToken(unsigned long ulType, unsigned long ulSubType)
{
	 int iLen = strlen(yytext);
	 
	 //2012-04-24,chx comment, 为了统一token内容长度128的使用
	 //if (iLen > 127)
	 //   iLen = 127;
	 //end_comment
	 
	 //2012-04-24,chx add, 为了统一token内容长度128的使用, bug1695的修改需要
	 if (iLen > MAX_LEX_CONTENT_LENGTH-1)
	 {
	    iLen = MAX_LEX_CONTENT_LENGTH-1;
		//将词法分析器回退到第128个字符的位置，以便于后续字符也可以被分析
		//不会产生丢失POU内容的情况
		yyless(MAX_LEX_CONTENT_LENGTH-1);
	 }
	 //end_add
			 
    p_yy_token_cur = (tagLexTokenList*)malloc(sizeof(struct tagLexicalTokenList)); 
	  strncpy((p_yy_token_cur->m_lexToken).m_sContent, yytext, iLen);
	  (p_yy_token_cur->m_lexToken).m_sContent[iLen] = 0 ;  
	  (p_yy_token_cur->m_lexToken).m_iTokenType = ulType;
	  (p_yy_token_cur->m_lexToken).m_iSubType = ulSubType;  
	  (p_yy_token_cur->m_lexToken).m_iLineNO = yy_st_line;
	  p_yy_token_cur->m_pNext = NULL;
	  if (p_yy_token_pre) 
	  {
	      p_yy_token_pre->m_pNext = p_yy_token_cur;
	  }
	  p_yy_token_pre = p_yy_token_cur;
	  if (yy_token_head_init == 0)
	  { 
	      p_yy_token_head = p_yy_token_cur;
	      yy_token_head_init = 1;
	  }		  
}

/*************************************************************
*函数功能： IEC语言的词法分析器入口函数
*参    数： pText：IEC编辑区中的文本，ppTokenHead：词法分析结果
*返 回 值： void
*创 建 者： chx
*创建日期： 2011-10-12
***************************************************************/
void GetSTTokenListFromLex(char *pText,tagLexTokenList **ppTokenHead)
{
	yy_token_head_init = 0;
	p_yy_token_head = *ppTokenHead;
	p_yy_st_text = pText;
	p_yy_token_pre = NULL;

	yy_st_length = strlen(p_yy_st_text);
	yy_st_offset = 0;
	yy_st_nest = 0;
	yy_st_line = 1;
		
	yylex();	
	
	*ppTokenHead = p_yy_token_head;
}

/*************************************************************
*函数功能： 对图形语言和变量模块的词法分析结果进行修改
*参    数： pTokenList：词法分析结果
*返 回 值： int：修改成功或失败
*创 建 者： chx
*创建日期： 2011-10-12
*修改日期： 2011-11-23，chx修改，将函数MergeChineseToken(...)的主体内容合并到此函数中，
*           提高执行效率
***************************************************************/
int ModifyTokenList(tagLexTokenList *pTokenList,int bMergeConst)
{
	//2011-10-20 chx 添加 
	//1.处理类似于-9或+9这样的常数
	//2.处理中文字符问题
	//3.对于-SINT#1或-UINT#1这样的常数不处理
	//该函数主要用于配合函数GetSTTokenListFromLex(),修改变量、图形语言模块的词法分析结果
	tagLexTokenList *pTempTokenList = NULL;
	for (pTempTokenList = pTokenList;pTempTokenList != NULL;pTempTokenList = pTempTokenList->m_pNext)
	{
		tagLexTokenList *pTokenNode = pTempTokenList;
		
		/************************************************************************************************/
		//此处变量主要用来处理问题1
		int iTokenSymbolLen = strlen(pTokenNode->m_lexToken.m_sContent)+1;//因为strlen返回的长度不包含'\0'，因此长度+1
		char *pSymbol = (char *)malloc(iTokenSymbolLen*sizeof(char));
		/************************************************************************************************/
		//此处变量主要用来处理问题2
		char * pCharactor = pSymbol;  //如果symbol中存储的不是"-"和"+"，则认为它可能为汉字的前半个字符
		int iStrCharactorLen = iTokenSymbolLen;
		/************************************************************************************************/
		
		if (NULL != pSymbol)
		{
			memcpy(pSymbol,pTokenNode->m_lexToken.m_sContent,iTokenSymbolLen); //取'-'或'+'
		}
		else
		{
		
			free(pSymbol);
			pSymbol = NULL;
						
			return 0;
		}
		
		/*start_merge_positive_Const_token************************************************************************/
		//2011-10-12,add
		//1.处理类似于-9或+9这样的常数
		if ((0 == strcmp(pSymbol,"-") || 0 == strcmp(pSymbol,"+")) && bMergeConst)
		{
			pTokenNode = pTokenNode->m_pNext;
			
			//SUBTYPE_INTEGER,SUBTYPE_REAL,SUBTYPE_ZO,SUBTYPE_BIT
			if ((NULL != pTokenNode) &&
				(TOKEN_CONSTANT == pTokenNode->m_lexToken.m_iTokenType) && //当前'-'或'+'后的输入文本是常量
				(SUBTYPE_INTEGER == pTokenNode->m_lexToken.m_iSubType || //当前'-'或'+'后的输入文本是常量的子类型是整型、实型、ZO型、BIT型的一种
				SUBTYPE_REAL == pTokenNode->m_lexToken.m_iSubType ||
				SUBTYPE_ZO == pTokenNode->m_lexToken.m_iSubType ||
				SUBTYPE_BIT == pTokenNode->m_lexToken.m_iSubType))
			{
				//修改当前token的文本内容
				int iStrContentLength = strlen(pTokenNode->m_lexToken.m_sContent)+1;
				char *pStrConten = (char *)malloc(iStrContentLength*sizeof(char));
				char *pTempContent = (char *)malloc((iTokenSymbolLen+iStrContentLength-1)*sizeof(char));
				
				/************************************************************************************************/
				//此处变量主要用来处理问题3
				//2012-02-02,chx add,
				//如果当前Token文本中存在#标记，则不需要修改
				
				//是否存在#标记
				int bPound = 0;			
				int i = 0;
				
				for (i = 0; i < iStrContentLength-1; i++)
				{
					if (pTokenNode->m_lexToken.m_sContent[i+1] == '#')
					{
						bPound = 1;
					}
				}
				//end_add,2012-02-02
				/************************************************************************************************/
				
				//2012-02-02,chx add,
				//此处变量主要用来处理问题3
				if (1 != bPound)
				{
				//end_add,2012-02-02
				
					if (NULL != pStrConten && NULL != pTempContent)
					{
						//将pSymbol和pStrConten两个字符串拼接成一个字符串
						//并放置到pTempContent中
						memcpy(pStrConten,pTokenNode->m_lexToken.m_sContent,iStrContentLength);
					
						memcpy(pTempContent,pSymbol,iTokenSymbolLen);
						memcpy(pTempContent+iTokenSymbolLen-1,pStrConten,iStrContentLength);
						
						//2012-04-20,chx add, for bug 1695, 由于后边的字符串长度为128，再加上符号位就导致该段字符串的长度为129
						//进而导致在字符串拷贝过程中，溢出
						if (iTokenSymbolLen+iStrContentLength > MAX_LEX_CONTENT_LENGTH)
						{
							//那么就只拷贝后边字符串的前127个字符
						 	iStrContentLength -= 1;
						}
						//end_add
						memcpy(pTempTokenList->m_lexToken.m_sContent,pTempContent,iTokenSymbolLen+iStrContentLength-1);
						pTempTokenList->m_lexToken.m_sContent[iTokenSymbolLen+iStrContentLength-2] = '\0';
					}
					else
					{

						free(pSymbol);
						free(pStrConten);
						free(pTempContent);
						pSymbol = NULL;
						pStrConten = NULL;
						pTempContent = NULL;
				
						return 0;
					}
				
					//修改当前token的类型
					pTempTokenList->m_lexToken.m_iTokenType = TOKEN_CONSTANT;
					if (SUBTYPE_ZO == pTokenNode->m_lexToken.m_iSubType || SUBTYPE_BIT == pTokenNode->m_lexToken.m_iSubType)
					{
						pTempTokenList->m_lexToken.m_iSubType = SUBTYPE_INTEGER;
					}
					else
					{
						pTempTokenList->m_lexToken.m_iSubType = pTokenNode->m_lexToken.m_iSubType;
					}

					//删除'-'或'+'后的文本节点
					if (pTempTokenList->m_pNext)
					{
						pTempTokenList->m_pNext = pTokenNode->m_pNext;
					
						pTokenNode->m_pNext = NULL;//只释放当前节点的内存
					}
					else
					{
						pTempTokenList->m_pNext = NULL;
					}
					
					FreeTokenListMem(pTokenNode);
					
				//2012-02-02,chx add,
				//此处变量主要用来处理问题3
				}
				//end_add,2012-02-02
 				
				free(pStrConten);
				free(pTempContent);
				pStrConten = NULL;
				pTempContent = NULL;		
			}
		}
		/*end_merge_positive_Const_token************************************************************************/
		/*start_merge_chinese_charactor_token*******************************************************************/
		//2011-11-18,add
		//2.处理中文字符问题
		else if (0 > (*pCharactor))
		{
		//说明当前字符为汉字的前半个字符
			pTokenNode = pTokenNode->m_pNext;
			
			if(NULL != pTokenNode)
			{
				//修改当前token的文本内容
				int iStrContentLength = strlen(pTokenNode->m_lexToken.m_sContent)+1;
				char *pStrConten = (char *)malloc(iStrContentLength*sizeof(char));//存储中文字符后半个字符
				char *pTempContent = (char *)malloc((iStrCharactorLen+iStrContentLength-1)*sizeof(char));
				
				if (NULL != pStrConten && NULL != pTempContent)
				{
					//将pCharactor和pStrConten两个字符串拼接成一个字符串
					//并放置到pTempContent中
					memcpy(pStrConten,pTokenNode->m_lexToken.m_sContent,iStrContentLength);
					
					memcpy(pTempContent,pCharactor,iStrCharactorLen);
					memcpy(pTempContent+iStrCharactorLen-1,pStrConten,iStrContentLength);
					
					memcpy(pTempTokenList->m_lexToken.m_sContent,pTempContent,iStrCharactorLen+iStrContentLength-1);
					pTempTokenList->m_lexToken.m_sContent[iStrCharactorLen+iStrContentLength] = '\0';
				}
				else
				{

					free(pSymbol);
					free(pStrConten);
					free(pTempContent);
					pSymbol = NULL;
					pStrConten = NULL;
					pTempContent = NULL;
						
					return 0;
				}
				
				//修改当前token的类型
				pTempTokenList->m_lexToken.m_iTokenType = TOKEN_CHINESE;
				
				//删除中文字符后半个字符的节点
				if (pTempTokenList->m_pNext)
				{
					pTempTokenList->m_pNext = pTokenNode->m_pNext;
					
					pTokenNode->m_pNext = NULL;//只释放当前节点的内存
				}
				else
				{
					pTempTokenList->m_pNext = NULL;
				}
 				
				FreeTokenListMem(pTokenNode);

				free(pStrConten);
				free(pTempContent);
				pStrConten = NULL;
				pTempContent = NULL;	
			}
		}
		/*end_merge_chinese_charactor_token**************************************************************/
		pTokenNode = NULL;

		free(pSymbol);
		pSymbol = NULL;
	}
	pTempTokenList = NULL;

	return 1;
}

/*************************************************************
*函数功能： 对于字符串常量进行二次分析
*参    数： ppTokenHead：词法分析结果
*返 回 值： int：修改成功或失败
*创 建 者： chx
*创建日期： 2014-11-18
***************************************************************/
int ReparseStringConstToken(tagLexTokenList **ppTokenHead)
{
	tagLexTokenList *pHeadToken = (*ppTokenHead);
	if (NULL != pHeadToken)
	{
		tagLexTokenList *pPreToken = pHeadToken;
		while (NULL != pHeadToken /*&& NULL != pHeadToken->m_pNext*/)
		{
			int nQuote = 0;

			if (TOKEN_CONSTANT == pHeadToken->m_lexToken.m_iTokenType &&
				SUBTYPE_STRING == pHeadToken->m_lexToken.m_iSubType)
			{
				tagLexTokenList *pNexToken = NULL;

				int iStrLength = strlen(pHeadToken->m_lexToken.m_sContent)+1;
				char *pStrConten = (char *)malloc(iStrLength*sizeof(char));
				//memset(pStrConten,0,iStrLength);

// 				if (NULL != pPreToken && NULL != pPreToken->m_pNext)
// 				{
					//pPreToken->m_pNext = ppTokenHead->m_pNext;
					pNexToken = pHeadToken->m_pNext;
/*				}*/
				
				if (NULL != pStrConten && NULL != pStrConten)
				{
					int iFirIndex = 0;
					int iSecIndex = 0;

					memcpy(pStrConten,pHeadToken->m_lexToken.m_sContent,iStrLength-1);
					pStrConten[iStrLength-1] = '\0';

					//
					for (iSecIndex = 0;iSecIndex < iStrLength-1;iSecIndex++)
					{
						int nCount = 0;
						char *pStr = NULL;
						tagLexTokenList *pParseResult = NULL;
// 
// 						if ('\'' == pStrConten[iSecIndex])
// 						{
// 							iFirIndex = iSecIndex;
// 							
// 						}
						if (0 == iFirIndex)
						{
							nQuote++;
						}

						iSecIndex++;

						while (iSecIndex < iStrLength-1)
						{
							if (iSecIndex+1 < iStrLength-1 && 
								'$'== pStrConten[iSecIndex] &&
								'\'' == pStrConten[iSecIndex+1])
							{
								iSecIndex++;
							}
							else if ('\'' == pStrConten[iSecIndex])
							{
								nQuote++;
								if (0 != nQuote%2 && iFirIndex != iSecIndex-1)
								{
									iSecIndex--;
								}

								break;
							}

							iSecIndex++;
						}

						nCount = iSecIndex-iFirIndex+2;
						pStr = (char *)malloc(nCount*sizeof(char));
						memcpy(pStr,pStrConten+iFirIndex,nCount-1);
						pStr[nCount-1] = '\0';

						GetSTTokenListFromLex(pStr,&pParseResult);
						ModifyTokenList(pParseResult,0);

						if (NULL != pParseResult)
						{
							//tagLexTokenList *pTemp = pPreToken;//->m_pNext;
							pPreToken->m_pNext = pParseResult;
							pParseResult->m_lexToken.m_iLineNO = pHeadToken->m_lexToken.m_iLineNO;
							while (NULL != pParseResult &&
								NULL != pParseResult->m_pNext)
							{
								pParseResult = pParseResult->m_pNext;
								pParseResult->m_lexToken.m_iLineNO = pHeadToken->m_lexToken.m_iLineNO;
							}

							if (pPreToken == (*ppTokenHead))
							{
								//pHeadToken = pPreToken;
								(*ppTokenHead) = pParseResult;
							}
							//pParseResult->m_pNext = pTemp->m_pNext;
							pPreToken = pParseResult;
						}
						
						if (NULL != pStr)
						{
							free(pStr);
							pStr = NULL;
						}

						iFirIndex = iSecIndex+1;
					}
					
					//
					if (NULL != pHeadToken)
					{
						pHeadToken->m_pNext = NULL;
						free(pHeadToken);
					}

					//
					pHeadToken = pNexToken;
					pPreToken->m_pNext = pNexToken;
				}

				if (NULL != pStrConten)
				{
					free(pStrConten);
					pStrConten = NULL;
				}
			}

			pPreToken = pHeadToken;
			if (NULL != pHeadToken)
			{
				pHeadToken = pHeadToken->m_pNext;
			}
		}
		//return 1;
	}
	
	return 1;
}


/*************************************************************
*函数功能： 图形语言或变量模块的词法分析入口函数
*参    数： pText：EC编辑区中的文本，ppTokenHead：词法分析结果
*返 回 值： int：修改成功或失败
*创 建 者： chx
*创建日期： 2011-10-12
***************************************************************/
LEXFORIEC_API int GetTokenListForVarOrGraph(char *pText,tagLexTokenList **ppTokenHead)
{
	GetSTTokenListFromLex(pText,ppTokenHead);

	if (NULL != ppTokenHead)
	{
		if (ModifyTokenList(*ppTokenHead,1))
		{
			return 1;
		}
	}

	return 0;
}

/*************************************************************
*函数功能： ST语言模块的词法分析入口函数
*参    数： pText：EC编辑区中的文本，ppTokenHead：词法分析结果
*返 回 值： int：修改成功或失败
*创 建 者： chx
*创建日期： 2011-10-12
***************************************************************/
LEXFORIEC_API int GetTokenListForST(char *pText,tagLexTokenList **ppTokenHead)
{
	GetSTTokenListFromLex(pText,ppTokenHead);

	if (NULL != ppTokenHead)
	{
			if (ModifyTokenList(*ppTokenHead,0))
			{
				return 1;
			}
	}
	
	return 0;
}

/*************************************************************
*函数功能： 复制一个Token
*参    数： pDstToken：目标Token，pSrcToken：源Token
*返 回 值： int：复制成功标志
*创 建 者： chx
*创建日期： 2015-03-19
***************************************************************/
LEXFORIEC_API int CopyToken(tagLexToken *pDstToken,const tagLexToken *pSrcToken)
{
	if (NULL == pDstToken || NULL == pSrcToken)
	{
		return 0;
	}

// 	if (NULL != pDstToken->m_sContent)
// 	{
// 		free(pDstToken->m_sContent);
// 		pDstToken->m_sContent = NULL;
// 	}

	{
		int nLength = strlen(pSrcToken->m_sContent)+1;
		//pDstToken->m_sContent = (char *)malloc((nLength+1)*sizeof(char));

		memcpy(pDstToken->m_sContent,pSrcToken->m_sContent,nLength);
		pDstToken->m_sContent[nLength] = '\0';
	}
	
	pDstToken->m_iTokenType = pSrcToken->m_iTokenType;
	pDstToken->m_iSubType = pSrcToken->m_iSubType;
	pDstToken->m_iLineNO = pSrcToken->m_iLineNO;

	return 1;
}

/*************************************************************
*函数功能： 释放一个Token
*参    数： tagToken：需要释放的Token
*返 回 值： 
*创 建 者： chx
*创建日期： 2015-03-19
***************************************************************/
LEXFORIEC_API void FreeToken(tagLexToken *pToken)
{
	if(NULL != pToken)
	{
// 		if (NULL != pToken->m_sContent)
// 		{
// 			free(pToken->m_sContent);
// 			pToken->m_sContent = NULL;
// 		}
		
		free(pToken);
		pToken = NULL;
	}
}


/*************************************************************
*函数功能： ST语言模块的词法分析入口函数
*参    数： pTokenList：词法分析结果
*返 回 值： void
*创 建 者： chx
*创建日期： 2011-10-12
***************************************************************/
LEXFORIEC_API void FreeTokenListMem(tagLexTokenList *pTokenList)
{
	tagLexTokenList *pTemp;
	if (NULL != pTokenList)
	{
			while(pTokenList)
			{
	     	 	pTemp=pTokenList->m_pNext;
	      	free(pTokenList);
	      	pTokenList=pTemp;
			}
	}
	else
	{
			//默认,释放整个Token链表
			while(p_yy_token_head)
			{
	      	pTemp = p_yy_token_head->m_pNext;
	      	free(p_yy_token_head);
	      	p_yy_token_head = NULL;
	      	p_yy_token_head = pTemp;
			}
	}
	
	yy_delete_buffer(YY_CURRENT_BUFFER);
	
	yy_start=0;
	yy_init=1;
}

int yywrap()
{
    return 1;
}

int my_yyinput(char* buf,int MaxSize)
{
    char tempstring[10];	
    if (yy_st_offset<yy_st_length)
    {	
        tempstring[0]=p_yy_st_text[yy_st_offset++];
        tempstring[1]='\0';
        memcpy(buf,tempstring,1);
        
        return 1;
    }
    else
    {
        memcpy(buf," ",1);
        return 0;
    }
}

void unput(int ch)
{
     if (ch==0)
	 return;
     if (yy_st_offset>0)
     {
	 yy_st_offset--;
	 return;
     }
}

int main(int argc,char *argv[])
{
    char *Text="1 123456 1.0123 1.0E-12 1eE3FAG 1.0e3dfg";
    tagLexTokenList *pText=NULL;
    
    GetSTTokenListFromLex(Text,&pText);
    
    while(pText)
    {
	printf("Token: %s Type:%d SubType:%d\n",(pText->m_lexToken).m_sContent,
		(pText->m_lexToken).m_iTokenType,(pText->m_lexToken).m_iSubType);
	pText=pText->m_pNext;
    }
    
    return 1;
}
