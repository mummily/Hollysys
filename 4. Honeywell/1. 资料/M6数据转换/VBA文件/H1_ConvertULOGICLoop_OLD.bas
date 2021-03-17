Attribute VB_Name = "H1_ConvertULOGICLoop_OLD"
'ver20190821_by cjt
'UREGC全局变量定义
Public ULOGIC_i As Long         'ULOGIC自动生成循环变量
Public ULOGIC1Name As Object     'ULOGIC1name字典
Public ULOGIC2Name As Object     'ULOGIC2name字典
Public LElement_X As Long       'LOGIC 元件X坐标
Public LElement_Y As Long       'LOGIC 元件Y坐标

Public LBox_X As Long            'LOGIC 元件X坐标
Public LBox_Y As Long            'LOGIC 元件Y坐标

Public LSort_ID As Long         'LOGIC Sid数据流存贮号

Public LElement_ID As Long      'LOGIC 元件id号变量
Public LBox_ID As Long          'LOGIC 块ID
Public LBoxEN_ID As Long       'LOGIC 块EN ID
Public LBoxIn1_ID As Long       'LOGIC 块输入1ID
Public LBoxIn2_ID As Long       'LOGIC 块输入2ID
Public LBoxIn3_ID As Long       'LOGIC 块输入3ID
Public LBoxOut1_ID As Long       'LOGIC 块输出1ID
Public LBox_type As String        'LOGIC块类型
'转化UREGC公用
Sub H1_ConvertULOGICLoop()
Dim i As Integer '循环变量
Dim Box_type As String '块类型
Dim NAME As Variant '块类型

'01--初始赋值
'--------------------------------------------------------------------------------------------------------
Lab = """"             '"标示字符串

'实例化字典
Set ULOGIC1Name = CreateObject("Scripting.Dictionary") 'UREGC1name字典
Set ULOGIC2Name = CreateObject("Scripting.Dictionary") 'UREGC2name字典
'02--把ULOGIC1~2name和行号存到字典待用
For i = 2 To UBound(ULOGIC1_arr(), 1) 'ULOGICname1字典
    ULOGIC1Name.Add ULOGIC1_arr(i, ULOGIC1("NAME")), i
Next
For i = 2 To UBound(ULOGIC2_arr(), 1) 'ULOGICname1字典
    ULOGIC2Name.Add ULOGIC2_arr(i, ULOGIC2("NAME")), i
Next
'03--创建XML文件
'--------------------------------------------------------------------------------------------------------
For ULOGIC_i = 2 To UBound(ULOGIC_arr(), 1)
        LElement_X = 34
        LElement_Y = 15
        LElement_ID = 1
        LSort_ID = 0
        
        NAME = ULOGIC_arr(ULOGIC_i, ULOGIC("NAME")) '名称位号
        If Len(NAME) > 0 Then '名称存在则转换
        
                  POU_Name = NAME & "_LG" '方案页名
                  POU_Description = ULOGIC_arr(ULOGIC_i, ULOGIC("PTDESC"))     '方案页描述
                  POUnamef = PATH & "\工程文件\" & SN(ULOGIC_arr(ULOGIC_i, ULOGIC("NODENUM"))) & "\" & POU_Name & ".xml"   '方案页文件存储路径
                  
                   '创建文件
                  Set fs = CreateObject("Scripting.FileSystemObject")
                  Set POU = fs.CreateTextFile(POUnamef, True)
                  
                  '(*XML文件开始公用部分*)
                  '--------------------------------------------------------------------------------------------------------
                  POU.WriteLine "<?xml version=" & Lab & "1.0" & Lab & " encoding=" & Lab & "ISO-8859-1" & Lab & "?>"
                  POU.WriteLine "<pou>"
                  POU.WriteLine "<path><![CDATA[\/" & "ULOGIC" & "]]></path>"
                  POU.WriteLine "<name>" & POU_Name & "</name>" '方案页名
                  POU.WriteLine "<secondName></secondName>"
                  POU.WriteLine "<description>" & POU_Description & "</description>" '方案页描述
                  POU.WriteLine "<flags>2048</flags>"
                  POU.WriteLine "<POUCycle>500</POUCycle>"
                  POU.WriteLine "<auto-sort>0</auto-sort>"
                  POU.WriteLine "<exporttime>2014-04-29 21:41:00</exporttime>"
                  POU.WriteLine "<amendtime>2014-04-29 21:40:40</amendtime>"
                  POU.WriteLine "<downloadtime></downloadtime>"
                  POU.WriteLine "<modifier></modifier>"
                  POU.WriteLine "<PouPaperSize>AX</PouPaperSize>"
                  POU.WriteLine "<PouPrintType>0</PouPrintType>"
                  POU.WriteLine "<interface>"
                  POU.WriteLine "<![CDATA[PROGRAM " & POU_Name
                  POU.WriteLine "VAR"
                  POU.WriteLine "NN1(2070): REAL := 0;       (*NN1描述*)"
                  POU.WriteLine "NN2(2070): REAL := 0;       (*NN2描述*)"
                  POU.WriteLine "NN3(2070): REAL := 0;       (*NN3描述*)"
                  POU.WriteLine "NN4(2070): REAL := 0;       (*NN4描述*)"
                  POU.WriteLine "NN5(2070): REAL := 0;       (*NN5描述*)"
                  POU.WriteLine "NN6(2070): REAL := 0;       (*NN6描述*)"
                  POU.WriteLine "NN7(2070): REAL := 0;       (*NN7描述*)"
                  POU.WriteLine "NN8(2070): REAL := 0;       (*NN8描述*)"
                  POU.WriteLine "TPXX(2070): TP := ( IN:=FALSE, PT:=T#2S, Q:=FALSE, ET:=T#0S, StartTime:=T#0S );       (*TPXXX*)"
                  POU.WriteLine "END_VAR]]>"
                  POU.WriteLine "</interface>"
                  POU.WriteLine "<cfc>"
                  
                'ULOGIC1字段列数
                For i = 1 To UBound(ULOGIC1_arr(), 2)
                    If ULOGIC1_arr(1, i) Like "*LOGALGID*" Then
                       Box_type = ULOGIC1_arr(ULOGIC1Name(NAME), i)
                    End If
                    Select Case Box_type '根据类型转化
                      Case "AND" '转化
                            LBox_type = "ADD"
                            Call ULOGIC_AND '转化AND
                            
                      Case "PULSE" '转化
                            LBox_type = "TP"
                            Call ULOGIC_TP '转化TP
                            
                     End Select
                  
                Next

                  '(*XML文件结束公用部分*)
                  '--------------------------
                  POU.WriteLine "</cfc>"
                  POU.WriteLine "</pou>"
                  
                  '(*方案页文件关闭*)
                  '---------------------------
                 POU.Close
        End If
   
Next ULOGIC_i

End Sub
Sub ULOGIC_AND()

Dim TagTest As String
'ID
LBox_ID = LElement_ID
LElement_ID = LElement_ID + 1
LBoxEN_ID = LElement_ID
LElement_ID = LElement_ID + 1
LBoxIn1_ID = LElement_ID
LElement_ID = LElement_ID + 1
LBoxIn2_ID = LElement_ID
LElement_ID = LElement_ID + 1
LBoxIn3_ID = LElement_ID
LElement_ID = LElement_ID + 1
LBoxOut1_ID = LElement_ID
LElement_ID = LElement_ID + 1
'坐标
LBox_X = LElement_X
LBox_Y = LElement_Y

LElement_X = LElement_X + 0
LElement_Y = LElement_Y + 10
'-------块元件
'写块XML:'块类型,块类ID,块类坐标X,块类坐标Y,块类数据流,EN连接的元件id,输入1连接的元件id,输入2连接的元件id,是否显示EN
Call BOX2_XML(LBox_type, LBox_ID, LBox_X, LBox_Y, LSort_ID, LBoxEN_ID, LBoxIn1_ID, LBoxIn2_ID, False)
LSort_ID = LSort_ID + 1
'-------输入元件
'写输入元件XML: 位号,ID号,坐标X,坐标Y
TagTest = "13GSO0011A.PVFL"
Call F2_ConvertPN_TI(TagTest) '转换
TagTest = M6PN_TI '赋值

Call Input_XML(TagTest, LBoxIn1_ID, LBox_X - 2, LBox_Y + 1)
Call Input_XML("BB", LBoxIn2_ID, LBox_X - 2, LBox_Y + 2)
'-------输出元件
'写输出元件XML:'位号,ID,坐标X,坐标Y,数据流,连接的块ID,连接的块输出引脚序号
Call Output_XML("CC", LBoxOut1_ID, LBox_X + 6, LBox_Y + 1, LSort_ID, LBox_ID, 0)
LSort_ID = LSort_ID + 1
End Sub
  
Sub ULOGIC_TP()
'ID
LBox_ID = LElement_ID
LElement_ID = LElement_ID + 1
LBoxEN_ID = LElement_ID
LElement_ID = LElement_ID + 1
LBoxIn1_ID = LElement_ID
LElement_ID = LElement_ID + 1
LBoxIn2_ID = LElement_ID
LElement_ID = LElement_ID + 1
LBoxIn3_ID = LElement_ID
LElement_ID = LElement_ID + 1
LBoxOut1_ID = LElement_ID
LElement_ID = LElement_ID + 1
'坐标
LBox_X = LElement_X
LBox_Y = LElement_Y

LElement_X = LElement_X + 0
LElement_Y = LElement_Y + 10
'-------块元件
''写块XML:'位号,ID,坐标X,坐标Y,数据流,块名
Call BOX_XML("TPXX", LBox_ID, LBox_X, LBox_Y, LSort_ID, LBox_type)
'-块输入引脚:写块输入引脚XML: 块引脚项名,块引脚连接的位号,块引脚连接的位号ID,是否显示引脚
Call BoxIn_XML("IN", "AA", LBoxIn1_ID, "true")
Call BoxIn_XML("PT", "BB", LBoxIn2_ID, "true")
'-块输出引脚:写块输出引脚XML: 块引脚项名,是否显示引脚
Call BoxOut_XML("Q", "true")
'-块输出引脚:写块输出引脚XML: 块引脚项名,是否显示引脚
Call BoxOut_XML("ET", "true")
'--块结束
POU.WriteLine "</element>"
LSort_ID = LSort_ID + 1
'-------输入元件
'写输入元件XML: 位号,ID号,坐标X,坐标Y
Call Input_XML("AA", LBoxIn1_ID, LBox_X - 2, LBox_Y + 1)
Call Input_XML("T#3S", LBoxIn2_ID, LBox_X - 2, LBox_Y + 2)
'-------输出元件
'写输出元件XML:'位号,ID,坐标X,坐标Y,数据流,连接的块ID,连接的块输出引脚序号
Call Output_XML("CC", LBoxOut1_ID, LBox_X + 6, LBox_Y + 1, LSort_ID, LBox_ID, 0)
LSort_ID = LSort_ID + 1
End Sub
