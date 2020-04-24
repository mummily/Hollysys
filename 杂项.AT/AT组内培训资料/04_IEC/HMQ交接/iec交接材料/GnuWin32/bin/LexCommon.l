%{
#include <malloc.h>
#include <string.h>
#include <ctype.h>
#include <process.h>

#include "../../10_Pub/01_Include/Common/LexCommon/LexCommon.h"

//终结符


//全局变量
tagLexTokenList *p_yy_token_pre; //指向符号链表前缀节点指针
tagLexTokenList *p_yy_token_head; //指向符号链表的头节点
tagLexTokenList *p_yy_token_cur; //指向当前符号节点的指针

int yy_st_line=1;  //所在行数
int yy_st_nest=0;   //用于支持嵌套注释
int yy_st_offset=0;  //字符所在位置
int yy_st_length=0;  //文本长度
int yy_token_head_init=0; //头是否创建,0表示为创建,1表示创建


char *p_yy_st_text; //输入需要解析的文本

//重新定义flex中文本的输入输出函数
#undef YY_INPUT
#undef unput
void unput(int ch);
#define YY_INPUT(b,r,ms) (r=my_yyinput(b,ms))
int my_yyinput(char* buf,int MaxSize);
void unput(int ch);
#undef yywrap

//将新匹配的符号插入到符号链表中
void NewToken(unsigned long ulType, unsigned long ulSubType);

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
       
      }
<COMMENT>"*)" { 
		yy_st_nest--;
		if (yy_st_nest==0)
		    BEGIN 0; 
	      }	      
<COMMENT>[^"(""*"\n]* {  NewToken(TOKEN_COMMENT,0); }
<COMMENT>"("|"*"        {  NewToken(TOKEN_COMMENT,0); }

<COMMENT>\n   {yy_st_line++;}

(I|i)(F|f)      { 
                  NewToken(TOKEN_IF,0); //if
	        }
(T|t)(H|h)(E|e)(N|n)   { 
                         NewToken(TOKEN_THEN,0); //then
	               }
(E|e)(L|l)(S|s)(I|i)(F|f)    {
                               NewToken(TOKEN_ELSIF,0); //elsif
	                     }
(E|e)(L|l)(S|s)(E|e)    { 
                          NewToken(TOKEN_ELSE,0); //else
	                }
(E|e)(N|n)(D|d)"_"(I|i)(F|f)   { 
                                 NewToken(TOKEN_END_IF,0); //end_if
	                       }
(C|c)(A|a)(S|s)(E|e)    { 
                          NewToken(TOKEN_CASE,0); //case
	                }
(E|e)(N|n)(D|d)"_"(C|c)(A|a)(S|s)(E|e)   {
                                            NewToken(TOKEN_END_CASE,0); //end_case
	                                 }
(O|o)(F|f)      {
                   NewToken(TOKEN_OF,0); //of
	        }
(F|f)(O|o)(R|r)     { 
                       NewToken(TOKEN_FOR,0); //for
	            }
(T|t)(O|o)      {
                   NewToken(TOKEN_TO,0); //to
	        }
(D|d)(O|o)      {
                   NewToken(TOKEN_DO,0); //do
	        }
(B|b)(Y|y)      {
                   NewToken(TOKEN_BY,0); //by
	        } 
(E|e)(N|n)(D|d)"_"(F|f)(O|o)(R|r) {
                                     NewToken(TOKEN_END_FOR,0); //end_for
	                          }
(W|w)(H|h)(I|i)(L|l)(E|e)   {
                               NewToken(TOKEN_WHILE,0); //while
	                    } 
	  
(E|e)(N|n)(D|d)"_"(W|w)(H|h)(I|i)(L|l)(E|e)   { 
                                                 NewToken(TOKEN_END_WHILE,0); //end_while
	                                      } 
(R|r)(E|e)(P|p)(E|e)(A|a)(T|t)   {
                                    NewToken(TOKEN_REPEAT,0); //repeat
	                         } 
(E|e)(N|n)(D|d)"_"(R|r)(E|e)(P|p)(E|e)(A|a)(T|t) {
                                                     NewToken(TOKEN_END_REPEAT,0); //end_repeat
	                                         }  
(U|u)(N|n)(T|t)(I|i)(L|l)      { 
                                  NewToken(TOKEN_UNTIL,0); //until
	                       } 
(R|r)(E|e)(T|t)(U|u)(R|r)(N|n)     { 
                                      NewToken(TOKEN_RETURN,0); //return
	                           } 
(E|e)(X|x)(I|i)(T|t)    {
                           NewToken(TOKEN_EXIT,0); //exit
	                }
(X|x)(O|o)(R|r)      { 
                        NewToken(TOKEN_XOR,0); //xor
	             }
(A|a)(N|n)(D|d)      {
                         NewToken(TOKEN_AND,0); //and
	             }
(O|o)(R|r)       {
                    NewToken(TOKEN_OR,0); //or
	         }
(M|m)(O|o)(D|d)      {
                         NewToken(TOKEN_MOD,0); //mod
	             }
(N|n)(O|o)(T|t)      { 
                        NewToken(TOKEN_NOT,0); //not
	             }
	             
"+"   {
         NewToken('+',0); //"+"
      }
"-"   { 
         NewToken('-',0); //"-"
      }
"*"   { 
         NewToken('*',0); //"*"
      } 
"/"   {
         NewToken('/',0); //"/" 
      }
";"   {
         NewToken(';',0); //";" 
      } 
","   {
         NewToken(',',0); //","
      }
":"   { 
         NewToken(':',0); //":"
      }
":="  {
         NewToken(TOKEN_EVALUATE,0); //":=" 
      }
"."   {
         NewToken('.',0); //"."
      }
".."  {
         NewToken(TOKEN_RANGE,0); //".." 
      }
"("   { 
         NewToken('(',0); //"("
      }
")"   { 
         NewToken(')',0); //")"
      }
"["   {
         NewToken('[',0); //"["
      }
"]"   {
         NewToken(']',0); //"]"
      }
">"   { 
         NewToken('>',0); //">"
      }
"="   {
         NewToken('=',0); //"=" 
      }
"<"   {
         NewToken('<',0); //"<"
      }
">="  { 
         NewToken(TOKEN_GE,0); //">="
      }
"<="  {
         NewToken(TOKEN_LE,0); //"<="
      }
"<>"  { 
         NewToken(TOKEN_NE,0); //"<>"
      }
"&"   { 
         NewToken('&',0); //"&"
      }

(0|1)  {
          NewToken(TOKEN_CONSTANT,SUBTYPE_ZO); //"0|1"
       } 
[0-9]*"@"(([A-Z]|[a-z]|_)([A-Z]|[a-z]|[0-9]|_|".")*("["((([A-Z]|[a-z]|[0-9]|_)([A-Z]|[a-z]|[0-9]|_|".")*("["((([A-Z]|[a-z]|[0-9]|_)([A-Z]|[a-z]|[0-9]|_|".")*)((" ")*","(" ")*([A-Z]|[a-z]|[0-9]|_)([A-Z]|[a-z]|[0-9]|_|".")*)*)"]")*)((" ")*","(" ")*([A-Z]|[a-z]|[0-9]|_)([A-Z]|[a-z]|[0-9]|_|".")*("["((([A-Z]|[a-z]|[0-9]|_)([A-Z]|[a-z]|[0-9]|_|".")*)((" ")*","(" ")*([A-Z]|[a-z]|[0-9]|_)([A-Z]|[a-z]|[0-9]|_|".")*)*)"]")*)*)"]")*) {
            NewToken(TOKEN_IDENTIFIER, 0);  //网络变量
          }    
"(#".*"#)" {
	    NewToken(TOKEN_OTHER_NAME,0);  //别名
	}  
((((B|b)(Y|y)(T|t)(E|e))|((W|w)(O|o)(R|r)(D|d))|((D|d)(W|w)(O|o)(R|r)(D|d)))"#")?([0-9]+)  {
	    NewToken(TOKEN_CONSTANT,SUBTYPE_BIT); //"byte,word,dword"    
	  }
((((B|b)(Y|y)(T|t)(E|e))|((W|w)(O|o)(R|r)(D|d))|((D|d)(W|w)(O|o)(R|r)(D|d)))"#")?("2#"(0|1)+)  {
	     NewToken(TOKEN_CONSTANT,SUBTYPE_BIT); //"byte,word,dword"+"2#"      
	  }
((((B|b)(Y|y)(T|t)(E|e))|((W|w)(O|o)(R|r)(D|d))|((D|d)(W|w)(O|o)(R|r)(D|d)))"#")?("8#"[0-7]+)  {
	     NewToken(TOKEN_CONSTANT,SUBTYPE_BIT); //"byte,word,dword"+"8#"      
	  }
((((B|b)(Y|y)(T|t)(E|e))|((W|w)(O|o)(R|r)(D|d))|((D|d)(W|w)(O|o)(R|r)(D|d)))"#")?("16#"[0-9A-Fa-f]+) {
	     NewToken(TOKEN_CONSTANT,SUBTYPE_BIT); //"byte,word,dword"+"16#" 
	  }
(((B|b)(O|o)(O|o)(L|l))"#")?((0|1)|((T|t)(R|r)(U|u)(E|e))|((F|f)(A|a)(L|l)(S|s)(E|e)))   {
	     NewToken(TOKEN_CONSTANT,SUBTYPE_BOOL); //"bool#"    
	  }
((((S|s)(I|i)(N|n)(T|t))|((I|i)(N|n)(T|t))|((D|d)(I|i)(N|n)(T|t))|((U|u)(S|s)(I|i)(N|n)(T|t))|((U|u)(I|i)(N|n)(T|t))|((U|u)(D|d)(I|i)(N|n)(T|t)))"#")?("+"|"-")?([0-9]+) {
	     NewToken(TOKEN_CONSTANT,SUBTYPE_INTEGER); //"sint,int,dint,usint,uint,udint""#"    
	  } 
((((S|s)(I|i)(N|n)(T|t))|((I|i)(N|n)(T|t))|((D|d)(I|i)(N|n)(T|t))|((U|u)(S|s)(I|i)(N|n)(T|t))|((U|u)(I|i)(N|n)(T|t))|((U|u)(D|d)(I|i)(N|n)(T|t)))"#")?("2#"(0|1)+) {
	     NewToken(TOKEN_CONSTANT,SUBTYPE_INTEGER); //"sint,int,dint,usint,uint,udint""2#"    
	  } 
	  ((((S|s)(I|i)(N|n)(T|t))|((I|i)(N|n)(T|t))|((D|d)(I|i)(N|n)(T|t))|((U|u)(S|s)(I|i)(N|n)(T|t))|((U|u)(I|i)(N|n)(T|t))|((U|u)(D|d)(I|i)(N|n)(T|t)))"#")?("8#"("+"|"-")?[0-7]+) {
	     NewToken(TOKEN_CONSTANT,SUBTYPE_INTEGER); //"sint,int,dint,usint,uint,udint""8#"    
	  } 
((((S|s)(I|i)(N|n)(T|t))|((I|i)(N|n)(T|t))|((D|d)(I|i)(N|n)(T|t))|((U|u)(S|s)(I|i)(N|n)(T|t))|((U|u)(I|i)(N|n)(T|t))|((U|u)(D|d)(I|i)(N|n)(T|t)))"#")?("16#"("+"|"-")?[0-9A-Fa-f]+)  {
	     NewToken(TOKEN_CONSTANT,SUBTYPE_INTEGER); //"sint,int,dint,usint,uint,udint""16#"    
	  } 
((((R|r)(E|e)(A|a)(L|l))|((L|l)(R|r)(E|e)(A|a)(L|l)))"#")?("+"|"-")?([0-9]+)("."([0-9]+))?(("E"|"e")("+"|"-")?[0-9]+)?    {
	     NewToken(TOKEN_CONSTANT,SUBTYPE_REAL); //"real,lreal""#"    
	  } 
	  	  
(T|t)((I|i)(M|m)(E|e))?"#""-"?([0-9]+("."[0-9]+)?(D|d))?([0-9]+("."[0-9]+)?(H|h))?([0-9]+("."[0-9]+)?(M|m))?([0-9]+("."[0-9]+)?(S|s))?([0-9]+("."[0-9]+)?((M|m)(S|s)))?    {
	      NewToken(TOKEN_CONSTANT,SUBTYPE_TIME); //"time""#"       
	  } 
(((T|t)(I|i)(M|m)(E|e)"_"(O|o)(F|f)"_"(D|d)(A|a)(Y|y))|((T|t)(O|o)(D|d)))"#"[0-9]+":"[0-9]+":"[0-9]+("."[0-9]+)?  {
	      NewToken(TOKEN_CONSTANT,SUBTYPE_TOD); //"time_of_day""#"      
	  } 
	  
(((D|d)(A|a)(T|t)(E|e))|(D|d))"#"[0-9]+"-"[0-9]+"-"[0-9]+       {
	      NewToken(TOKEN_CONSTANT,SUBTYPE_DATE); //"date""#"       
	  } 
(((D|d)(A|a)(T|t)(E|e)"_"(A|a)(N|n)(D|d)"_"(T|t)(I|i)(M|m)(E|e))|((D|d)(T|t)))"#"[0-9]+"-"[0-9]+"-"[0-9]+"-"[0-9]+":"[0-9]+":"[0-9]+("."[0-9]+)?  {
	      NewToken(TOKEN_CONSTANT,SUBTYPE_DT); //"date_and_time""#"       
	  } 
	  
([A-Z]|[a-z]|_)([A-Z]|[a-z]|[0-9]|_)*    {
	      NewToken(TOKEN_IDENTIFIER,0); //标识符        
	  } 
	  
\"[^\"]*\"    {
	          NewToken(TOKEN_CONSTANT,SUBTYPE_STRING); //标识符     
	      }
 
"%"((I|i)|(Q|q)|(M|m)|(S|s))((X|x)|(B|b)|(W|w)|(D|d))[0-9]+("."[0-9]+)*   {
	      NewToken(TOKEN_DIRECTVAR, 0);  //直接地址变量       
	  } 

[ \t]       {;}
\n          {  yy_st_line++; }
.            {
	         NewToken(yytext[0],0); //单个字符  
	     } 	  
%%
LEXDLL_API int LexCommonGetTokenList(char *pText,tagLexTokenList **ppTokenHead)
{
	yy_token_head_init=0;
	p_yy_token_head=*ppTokenHead;
	p_yy_st_text=pText;
	p_yy_token_pre=NULL;

	yy_st_length=strlen(p_yy_st_text);
	yy_st_offset=0;
	yy_st_nest=0;
	yy_st_line=1;
		
	yylex();	
	
	*ppTokenHead=p_yy_token_head;
	
	return 0;
}

LEXDLL_API void LexCommonFreeMem()
{
	tagLexTokenList *pTemp;
	while(p_yy_token_head)
	{
	      pTemp=p_yy_token_head->m_pNext;
	      free(p_yy_token_head);
	      p_yy_token_head=pTemp;
	}
	yy_start=0;
	yy_init=1;
}

LEXDLL_API void LexCommonFreeTokenListMem(tagLexTokenList *pTokenList)
{
	tagLexTokenList *pTemp;
	while(pTokenList)
	{
	      pTemp=pTokenList->m_pNext;
	      free(pTokenList);
	      pTokenList=pTemp;
	}
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

void NewToken(unsigned long ulType, unsigned long ulSubType)
{
	 int iLen = strlen(yytext);
	 if ( iLen > 127 )
	    iLen = 127;
			 
          p_yy_token_cur=(tagLexTokenList*)malloc(sizeof(struct tagLexicalTokenList)); 
	  strncpy((p_yy_token_cur->m_lexToken).m_sContent,yytext,iLen);
	  (p_yy_token_cur->m_lexToken).m_sContent[iLen] = 0 ;  
	  (p_yy_token_cur->m_lexToken).m_iTokenType=ulType;
	  (p_yy_token_cur->m_lexToken).m_iSubType=ulSubType;  
	  (p_yy_token_cur->m_lexToken).m_iLineNO=yy_st_line;
	  p_yy_token_cur->m_pNext=NULL;
	  if (p_yy_token_pre) 
	  {
	      p_yy_token_pre->m_pNext=p_yy_token_cur;
	  }
	  p_yy_token_pre=p_yy_token_cur;
	  if (yy_token_head_init==0)
	  {
	      p_yy_token_head=p_yy_token_cur;
	      yy_token_head_init=1;
	  }		  
}
