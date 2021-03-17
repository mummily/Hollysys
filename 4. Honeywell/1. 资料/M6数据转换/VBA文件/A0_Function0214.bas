Attribute VB_Name = "A0_Function0214"
'ver20190814_by cjt
Function FileExists(FullFileName As String) As Boolean '判断工作簿是否存在
    '如果工作簿存在,则返回True
    FileExists = Len(Dir(FullFileName)) > 0
End Function
Function WorkbookOpen(WorkbookName As String) As Boolean
    '如果该工作簿已打开则返回真
    WorkbookOpen = False
    On Error GoTo WorkBookNotOpen
    If Len(Application.Workbooks(WorkbookName).NAME) > 0 Then
        WorkbookOpen = True
        Exit Function
    End If
WorkBookNotOpen:
End Function
Function SheetExists(Workbook_name As String, SheetName As String) As Boolean '判断工作表是否存在
    '如果工作表存在,则返回True
    For Each sht In Workbooks(Workbook_name).Worksheets
    If sht.NAME = SheetName Then
        SheetExists = True
        Workbooks(Workbook_name).Worksheets(SheetName).Activate
        Exit Function
    End If
    
Next
    
    
End Function
Function filefolderExists(PATH As String) As Boolean '判断文件夹是否存在
    On Error GoTo EarlyExit
    If Not Dir(PATH, vbDirectory) = vbNullString Then
       filefolderExists = True
    End If
    Exit Function
EarlyExit:
    filefolderExists = False
End Function


Function StnNo(ByRef Stationnumber As String) As String  '判断热电偶类型

If Len(Stationnumber) > 0 Then
     If Stationnumber Like "A1" Then
     StnNo = "10"
     End If
     If Stationnumber Like "A2" Then
     StnNo = "11"
     End If
     If Stationnumber Like "A3" Then
     StnNo = "12"
     End If
     If Stationnumber Like "A4" Then
     StnNo = "13"
     End If
End If
     
End Function


Function PN(var As String) As String '获取位号
    If var Like "*.*" Then '是否是位号+项名
        PN = Left(var, InStr(var, ".") - 1) '位号
    Else
        PN = var
    End If
End Function
Function TI(var As String, Typ As String) As String '获取项名（将HN项名转化为M6项名）
Dim HN_TI As String 'HN数据库项名
   If var Like "*.*" Then '是否是位号+项名
     HN_TI = Right(var, Len(var) - InStr(var, "."))  'HN项名
   Else
     HN_TI = ""
   End If
   
   If Len(HN_TI) > 0 Then '存在项名
      Select Case Typ '根据类型转化
      
        Case "UAI" 'UAI类型转化
              Select Case HN_TI
                     Case "PV" 'HN项名转M6
                          TI = ".AV"
              End Select
              
        Case "UAO" 'UAO类型转化
              Select Case HN_TI
                     Case "OP" 'HN项名转M6
                          TI = ".AI"
              End Select
              
        Case Else
        
             TI = ""
        
      End Select
        
   End If
   
End Function

Function inputid(Tag As String, ID As Long) As Long 'XMl生成时判断块输入位号是不是有确定块引脚是不是写输入位号ID
    If Len(Tag) > 0 Then
        inputid = ID
    Else
        inputid = 0
    End If
End Function
Function DelDit(PVFORMAT As Variant) As Variant 'HN数据显示小数位数转M6 Decimal digit
    Select Case PVFORMAT
           Case "D0"
                 DelDit = "%-8.f"
           Case "D1"
                 DelDit = "%-8.1f"
           Case "D2"
                 DelDit = "%-8.2f"
           Case "D3"
                 DelDit = "%-8.3f"
           Case "D4"
                 DelDit = "%-8.4f"
           Case "D5"
                 DelDit = "%-8.5f"
           End Select
End Function

Sub BOX_XML(Tag As String, ID As Long, X As Long, Y As Long, Sort_ID As Long, AT_type As String)  '写块XML:'位号,ID,坐标X,坐标Y,数据流,块名
        POU.WriteLine "<element type=" & Lab & "box" & Lab & ">"
        POU.WriteLine "<id>" & ID & "</id>" '块ID
        POU.WriteLine "<AT_position>" & X & "," & Y & "</AT_position>" '块位置坐标
        POU.WriteLine "<Comment>?????</Comment>"
        
        POU.WriteLine "<isinst>TRUE</isinst>"
        POU.WriteLine "<text>" & Tag & "</text>" '块位号
        
        POU.WriteLine "<AT_type>" & AT_type & "</AT_type>"
        POU.WriteLine "<typetext>BT_FB</typetext>"
        POU.WriteLine "<ttype>4</ttype>"
        POU.WriteLine "<AT_isen>false</AT_isen>"
        POU.WriteLine "<AT_iseno>false</AT_iseno>"
        POU.WriteLine "<sortid>" & Sort_ID & "</sortid>" 'Sid数据流存贮号
End Sub
Sub BoxIn_XML(TI As String, Tag As String, ID As Long, Display As String) '写块输入引脚XML: 块引脚项名,块引脚连接的位号,块引脚连接的位号ID,是否显示引脚
    Dim Binputid As Long '输入引脚id
    Dim Lab1 As String '特殊字符替换
    
    '不能直接输入的特殊字符
    Lab1 = """"
    '如果位号没有就不要连接位号ID
    If Len(Tag) > 0 Then
        Binputid = ID '输入引脚id
    Else
        Binputid = 0 '输入引脚id
    End If
    
    POU.WriteLine "<input inputid=" & Lab1 & Binputid & Lab1 & " inputidx=" & Lab1 & "0" & Lab1 & " negate=" & Lab1 & "false" & Lab1 & " visible=" & Lab1 & Display & Lab1 & " pinname=" & Lab1 & TI & Lab1 & " />"
End Sub
Sub BoxIn_XML2(TI As String, Tag As String, ID As Long, Inputidx As Long, negate As String, Display As String) '写块输入引脚XML: 块引脚项名,块引脚连接的位号,块引脚连接的位号ID,输入信号在自己块的输出序号，是否取反，是否显示引脚
    Dim Binputid As Long '输入引脚id
    Dim Lab1 As String '特殊字符替换

    
    '不能直接输入的特殊字符
    Lab1 = """"
    '如果位号没有就不要连接位号ID
    If Len(Tag) > 0 Then
        Binputid = ID '输入引脚id
    Else
        Binputid = 0 '输入引脚id
    End If
    
    POU.WriteLine "<input inputid=" & Lab1 & Binputid & Lab1 & " inputidx=" & Lab1 & Inputidx & Lab1 & " negate=" & Lab1 & negate & Lab1 & " visible=" & Lab1 & Display & Lab1 & " pinname=" & Lab1 & TI & Lab1 & " />"
End Sub
Sub BoxOut_XML(TI As String, Display As String) '写块输出引脚XML: 块引脚项名,是否显示引脚
    Dim Lab1 As String '特殊字符替换
    '不能直接输入的特殊字符
    Lab1 = """"
    POU.WriteLine "<output negate=" & Lab1 & "false" & Lab1 & " visible=" & Lab1 & Display & Lab1 & " pinname=" & Lab1 & TI & Lab1 & "/>"
End Sub
Sub Input_XML(Tag As String, ID As Long, X As Long, Y As Long) '写输入元件XML: 位号,ID号,坐标X,坐标Y
    Dim Lab1 As String '特殊字符替换
    '不能直接输入的特殊字符
    Lab1 = """"
    '如果位号没有就不建立
    If Len(Tag) > 0 Then
        POU.WriteLine "<element type=" & Lab1 & "input" & Lab1 & ">"
        POU.WriteLine "<id>" & ID & "</id>" 'ID
        POU.WriteLine "<AT_position>" & X & "," & Y & "</AT_position>" '信号坐标
        POU.WriteLine "<text>" & Tag & "</text>" '信号
        POU.WriteLine "<Comment>?????</Comment>"
        POU.WriteLine "<negate>false</negate>"
        POU.WriteLine "<ttype>4</ttype>"
        POU.WriteLine "<Flag>FALSE</Flag>"
        POU.WriteLine "</element>"
    End If
End Sub

Sub Output_XML(Tag As String, ID As Long, X As Long, Y As Long, Sort_ID As Long, Blok_ID As Long, Inputidx As Long) '写输出元件XML:'位号,ID,坐标X,坐标Y,数据流,连接的块ID,连接的块输出引脚序号
    Dim Lab1 As String '特殊字符替换
    Dim mytag As String
    '不能直接输入的特殊字符
    Lab1 = """"
    '防止空格
    mytag = Replace(Tag, " ", "")
    
If Len(mytag) > 0 Then
    POU.WriteLine "<element type=" & Lab1 & "output" & Lab1 & ">"
    POU.WriteLine "<id>" & ID & "</id>" '信号ID
    POU.WriteLine "<position>" & X & "," & Y & "</position>" '信号坐标
    POU.WriteLine "<text>" & mytag & "</text>"  '信号
    POU.WriteLine "<Comment>?????/?</Comment>"
    POU.WriteLine "<ttype>4</ttype>"
    POU.WriteLine "<Inputid>" & Blok_ID & "</Inputid>" '连接块块ID
    POU.WriteLine "<Inputidx>" & Inputidx & "</Inputidx>"
    POU.WriteLine "<negate>false</negate>"
    POU.WriteLine "<sortid>" & Sort_ID & "</sortid>" 'Sid数据流存贮号
    POU.WriteLine "</element>"
End If
End Sub
Sub Output_XML2(Tag As String, ID As Long, X As Long, Y As Long, Sort_ID As Long, Blok_ID As Long, Inputidx As Long, negate As String) '写输出元件XML:'位号,ID,坐标X,坐标Y,数据流,连接的块ID,连接的块输出引脚序号，是否取反
    Dim Lab1 As String '特殊字符替换
    Dim mytag As String
    '不能直接输入的特殊字符
    Lab1 = """"
    '防止空格
    mytag = Replace(Tag, " ", "")
    
If Len(mytag) > 0 Then
    POU.WriteLine "<element type=" & Lab1 & "output" & Lab1 & ">"
    POU.WriteLine "<id>" & ID & "</id>" '信号ID
    POU.WriteLine "<position>" & X & "," & Y & "</position>" '信号坐标
    POU.WriteLine "<text>" & mytag & "</text>"  '信号
    POU.WriteLine "<Comment>?????/?</Comment>"
    POU.WriteLine "<ttype>4</ttype>"
    POU.WriteLine "<Inputid>" & Blok_ID & "</Inputid>" '连接块块ID
    POU.WriteLine "<Inputidx>" & Inputidx & "</Inputidx>"
    POU.WriteLine "<negate>" & negate & "</negate>"
    POU.WriteLine "<sortid>" & Sort_ID & "</sortid>" 'Sid数据流存贮号
    POU.WriteLine "</element>"
End If
End Sub

Sub BOX2_XML(Box_type As String, Box_ID As Long, Box_X As Long, Box_Y As Long, Box_Sort As Long, EN_ID As Long, Input1_ID As Long, Input2_ID As Long, EN_Sel As Boolean) '写块XML:'块类型,块类ID,块类坐标X,块类坐标Y,块类数据流,EN连接的元件id,输入1连接的元件id,输入2连接的元件id,是否显示EN
    Dim Lab1 As String '特殊字符替换
    '不能直接输入的特殊字符
    Lab1 = """"
        POU.WriteLine "<element type=" & Lab1 & "box" & Lab1 & ">"
        POU.WriteLine "<id>" & Box_ID & "</id>" '块ID
        POU.WriteLine "<AT_position>" & Box_X & "," & Box_Y & "</AT_position>" '块位置坐标
        POU.WriteLine "<AT_type>" & Box_type & "</AT_type>"
        POU.WriteLine "<typetext>BT_OPERATOR</typetext>"
        If EN_Sel Then
        POU.WriteLine "<AT_isen>true</AT_isen>"
        POU.WriteLine "<AT_iseno>true</AT_iseno>"
        Else
        POU.WriteLine "<AT_isen>false</AT_isen>"
        POU.WriteLine "<AT_iseno>false</AT_iseno>"
        End If
        POU.WriteLine "<sortid>" & Box_Sort & "</sortid>" 'Sid数据流存贮号
        If EN_Sel Then
        POU.WriteLine "<input inputid=" & Lab1 & EN_ID & Lab1 & " inputidx=" & Lab1 & "0" & Lab1 & " negate=" & Lab1 & "false" & Lab1 & " visible=" & Lab1 & "true" & Lab1 & " pinname=" & Lab1 & "EN" & Lab1 & "/>"
        End If
        POU.WriteLine "<input inputid=" & Lab1 & Input1_ID & Lab1 & " inputidx=" & Lab1 & "0" & Lab1 & " negate=" & Lab1 & "false" & Lab1 & " visible=" & Lab1 & "true" & Lab1 & " pinname=" & Lab1 & "" & Lab1 & "/>"
        POU.WriteLine "<input inputid=" & Lab1 & Input2_ID & Lab1 & " inputidx=" & Lab1 & "0" & Lab1 & " negate=" & Lab1 & "false" & Lab1 & " visible=" & Lab1 & "true" & Lab1 & " pinname=" & Lab1 & "" & Lab1 & "/>"
        If EN_Sel Then
        POU.WriteLine "<output negate=" & Lab1 & "false" & Lab1 & " visible=" & Lab1 & "true" & Lab1 & " pinname=" & Lab1 & "ENO" & Lab1 & "/>"
        End If
        POU.WriteLine "<output negate=" & Lab1 & "false" & Lab1 & " visible=" & Lab1 & "true" & Lab1 & " pinname=" & Lab1 & "" & Lab1 & "/>"
        POU.WriteLine "</element>"
        
End Sub
Sub BOX3_XML(Box_type As String, Box_ID As Long, Box_X As Long, Box_Y As Long, Box_Sort As Long, EN_ID As Long, Input1_ID As Long, Input2_ID As Long, Input3_ID As Long, EN_Sel As Boolean) '写块XML:'块类型,块类ID,块类坐标X,块类坐标Y,块类数据流,EN连接的元件id,输入1连接的元件id,输入2连接的元件id,是否显示EN
    Dim Lab1 As String '特殊字符替换
    '不能直接输入的特殊字符
    Lab1 = """"
        POU.WriteLine "<element type=" & Lab1 & "box" & Lab1 & ">"
        POU.WriteLine "<id>" & Box_ID & "</id>" '块ID
        POU.WriteLine "<AT_position>" & Box_X & "," & Box_Y & "</AT_position>" '块位置坐标
        POU.WriteLine "<AT_type>" & Box_type & "</AT_type>"
        POU.WriteLine "<typetext>BT_OPERATOR</typetext>"
        If EN_Sel Then
        POU.WriteLine "<AT_isen>true</AT_isen>"
        POU.WriteLine "<AT_iseno>true</AT_iseno>"
        Else
        POU.WriteLine "<AT_isen>false</AT_isen>"
        POU.WriteLine "<AT_iseno>false</AT_iseno>"
        End If
        POU.WriteLine "<sortid>" & Box_Sort & "</sortid>" 'Sid数据流存贮号
        If EN_Sel Then
        POU.WriteLine "<input inputid=" & Lab1 & EN_ID & Lab1 & " inputidx=" & Lab1 & "0" & Lab1 & " negate=" & Lab1 & "false" & Lab1 & " visible=" & Lab1 & "true" & Lab1 & " pinname=" & Lab1 & "EN" & Lab1 & "/>"
        End If
        POU.WriteLine "<input inputid=" & Lab1 & Input1_ID & Lab1 & " inputidx=" & Lab1 & "0" & Lab1 & " negate=" & Lab1 & "false" & Lab1 & " visible=" & Lab1 & "true" & Lab1 & " pinname=" & Lab1 & "" & Lab1 & "/>"
        POU.WriteLine "<input inputid=" & Lab1 & Input2_ID & Lab1 & " inputidx=" & Lab1 & "0" & Lab1 & " negate=" & Lab1 & "false" & Lab1 & " visible=" & Lab1 & "true" & Lab1 & " pinname=" & Lab1 & "" & Lab1 & "/>"
        POU.WriteLine "<input inputid=" & Lab1 & Input3_ID & Lab1 & " inputidx=" & Lab1 & "0" & Lab1 & " negate=" & Lab1 & "false" & Lab1 & " visible=" & Lab1 & "true" & Lab1 & " pinname=" & Lab1 & "" & Lab1 & "/>"
        If EN_Sel Then
        POU.WriteLine "<output negate=" & Lab1 & "false" & Lab1 & " visible=" & Lab1 & "true" & Lab1 & " pinname=" & Lab1 & "ENO" & Lab1 & "/>"
        End If
        POU.WriteLine "<output negate=" & Lab1 & "false" & Lab1 & " visible=" & Lab1 & "true" & Lab1 & " pinname=" & Lab1 & "" & Lab1 & "/>"
        POU.WriteLine "</element>"
        
End Sub
Function UDCType(NAME As Variant, DISRC1 As Variant, DISRC2 As Variant, DODSTN1 As Variant, DODSTN2 As Variant, DODSTN3 As Variant) As String '判断UDC类型
Dim str1 As Variant
Dim str2 As Variant
str1 = DISRC1 & DISRC2
str2 = DODSTN1 & DODSTN2 & DODSTN3
If Len(str1) > 0 And Len(str2) > 0 Then
 If NAME Like "*V*" Then
    UDCType = "VAL2"
 End If
 If NAME Like "*P*" Or NAME Like "*M*" Then
    UDCType = "MOT2"
 End If
Else
    UDCType = ""
End If
End Function

'-----------------------------------------------------------------------------------------------------------
'Purpose:报警级翻译
'History: 18-12-2019
'Author:ChengJiangtao
'-----------------------------------------------------------------------------------------------------------
Function AlMLVl(HN As Variant) As Variant  '判断UDC类型
Select Case HN
       Case "LOW"
            AlMLVl = "1"
       Case "HIGH"
            AlMLVl = "2"
       Case "EMERGENCY"
            AlMLVl = "3"
       Case "NOACTION"
            AlMLVl = "0"
       Case Else
           AlMLVl = "0"
End Select
End Function

'-----------------------------------------------------------------------------------------------------------
'Purpose:AI是否开方翻译
'History: 18-12-2019
'Author:ChengJiangtao
'-----------------------------------------------------------------------------------------------------------
Function SQRTOPT(HN As Variant) As Variant  '判断UDC类型
Select Case HN
       Case "SQRROOT"
            SQRTOPT = "1"
       Case "LINEAR"
            SQRTOPT = "0"
       Case Else
           SQRTOPT = ""
End Select
End Function
'-----------------------------------------------------------------------------------------------------------
'Purpose:报警死区翻译
'History: 18-12-2019
'Author:ChengJiangtao
'-----------------------------------------------------------------------------------------------------------
Function ALMDB(HN As Variant, PVALDBEU As Variant, PVEUHI As Variant, PVEULO As Variant) As Variant
Select Case HN
       Case "EU"
            If VBA.IsNumeric(PVALDBEU) Then
               ALMDB = PVALDBEU
            End If
       Case "HALF"
            ALMDB = 0.005 * (PVEUHI - PVEULO)
       Case "ONE"
            ALMDB = 0.01 * (PVEUHI - PVEULO)
       Case "TWO"
            ALMDB = 0.02 * (PVEUHI - PVEULO)
       Case "TREE"
            ALMDB = 0.03 * (PVEUHI - PVEULO)
       Case "FOUR"
            ALMDB = 0.04 * (PVEUHI - PVEULO)
       Case "FIVE"
            ALMDB = 0.05 * (PVEUHI - PVEULO)
       Case Else
           ALMDB = ""
End Select
End Function
'-----------------------------------------------------------------------------------------------------------
'Purpose:DI报警翻译
'History: 18-12-2019
'Author:ChengJiangtao
'-----------------------------------------------------------------------------------------------------------
Function DAMOPT(ALMOPT As Variant, PVNORMAL As Variant) As Variant '判断UDC类型
         If ALMOPT = "NONE" And PVNORMAL = "" Then
                 DAMOPT = "0"
         ElseIf ALMOPT = "OFFNORML" And PVNORMAL = "OFF" Then
                DAMOPT = "1"
         ElseIf ALMOPT = "OFFNORML" And PVNORMAL = "ON" Then
                DAMOPT = "2"
         ElseIf ALMOPT = "CHNGOFST" Then
                DAMOPT = "3"
         Else
                DAMOPT = "0"
         End If
End Function
'-----------------------------------------------------------------------------------------------------------
'Purpose:DI报警翻译
'History: 18-12-2019
'Author:ChengJiangtao
'-----------------------------------------------------------------------------------------------------------
Function RD(NODENUM As Variant, MODNUM As Variant) As Variant '判断模块是否冗余，根据站号和设备号查找UPMCONFIG
Dim NAME As Variant
Dim IOREDOPT As Variant
         If NODENUM < 10 Then
            NAME = "$NM01B0" & NODENUM '站号
         Else
            NAME = "$NM01B" & NODENUM '站号
         End If
         IOREDOPT = "IOREDOPT" & "(" & MODNUM & ")" '设备号
         
                If 0 < MODNUM And MODNUM <= 20 Then
                       If UPMCONFIG_arr(UPMCONFIGSN(NAME), UPMCONFIG(IOREDOPT)) = "REDUN" Then
                          RD = "1"
                       Else
                          RD = "0"
                       End If
                End If
                If 20 < MODNUM Then
                       If UPMCONFIG1_arr(UPMCONFIG1SN(NAME), UPMCONFIG1(IOREDOPT)) = "REDUN" Then
                          RD = "1"
                       Else
                          RD = "0"
                       End If
                 End If

         

End Function
'-----------------------------------------------------------------------------------------------------------
'Purpose:报警级翻译
'History: 14-2-2020
'Author:ChengJiangtao
'-----------------------------------------------------------------------------------------------------------
'DAMOPT    INHDAM          DAMLV
'报警属性  报警抑制         报警级
'2(0报警)      0(不抑制)       0(不报警)
'1(1报警)      1(抑制)         1(普通)
'3(双向报警)   0               2（一般)
'0(不报警)     0               3(紧急)
'0             0               4(特紧)
Function DAMLV(OFFNRMPR As Variant) As Variant

Select Case OFFNRMPR
       Case "LOW"
             DAMLV = "1"
       Case "EMERGNCY"
             DAMLV = "3"
       Case Else
             DAMLV = "0"
End Select

End Function

'-----------------------------------------------------------------------------------------------------------
'Purpose:CTLEQN转换
'History: 14-2-2020
'Author:ChengJiangtao
'-----------------------------------------------------------------------------------------------------------
'模式选择0-EQA,1-EQB,2-EQC,3-EQD,4-EQE
Function CTLEQN(EQX As Variant) As Variant

Select Case EQX
       Case "EQA"
             CTLEQN = "0"
       Case "EQB"
             CTLEQN = "1"
       Case "EQC"
             CTLEQN = "2"
       Case "EQD"
             CTLEQN = "3"
       Case "EQE"
             CTLEQN = "4"
       Case Else
             CTLEQN = ""
End Select

End Function
