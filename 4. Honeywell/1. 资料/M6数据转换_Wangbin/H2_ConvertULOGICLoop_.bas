Attribute VB_Name = "H2_ConvertULOGICLoop_"
'ver20190821_by cjt
'UREGC全局变量定义
Public ULOGIC_i As Long         'ULOGIC自动生成循环变量
Public ULOGIC1Name As Object     'ULOGIC1name字典
Public ULOGIC2Name As Object     'ULOGIC2name字典

Public LSort_ID As Long         'LOGIC Sid数据流存贮号
Public LElement_ID As Long      'LOGIC 元件id号变量

Public ExcelInfo As T_EXCELINFO

'-----------------------------------------------------------------------------------------------------------
'Purpose: 转化UREGC公用
'History: 9-24-2019
'-----------------------------------------------------------------------------------------------------------
Sub H2_ConvertULOGICLoop()
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
        Dim sPouName As String '块类型
        sPouName = ULOGIC_arr(ULOGIC_i, ULOGIC("NAME")) '名称位号
        If sPouName <> "" Then
            '初始化ExcelInfo
            Dim ExcelInfo_Temp As T_EXCELINFO
            ExcelInfo = ExcelInfo_Temp
            
            '初始化属性
            Call InitProperty(sPouName)
        
            '输出至XML
            Call WriteXML
        End If
    Next ULOGIC_i
End Sub

'-----------------------------------------------------------------------------------------------------------
'Purpose: EXCEL信息解析至POU
'History: 9-25-2019
'-----------------------------------------------------------------------------------------------------------
Private Sub InitProperty(sPouName As String)
    Dim rowLogic, rowLogic1, rowLogic2 As Integer
    rowLogic = ULOGIC_i
    rowLogic1 = ULOGIC1Name(sPouName)
    rowLogic2 = ULOGIC2Name(sPouName)
    
    With ExcelInfo
        .NAME = sPouName & "_LG"
        .PTDESC = ULOGIC_arr(rowLogic, ULOGIC("PTDESC"))
        .PATH = PATH & "\工程文件\" & SN(ULOGIC_arr(rowLogic, ULOGIC("NODENUM"))) & "\" & .NAME & ".xml"   '方案页文件存储路径
        
        ' NN 赋值
        InitNN
        
        For index = 1 To 12
            With .HN_INPUT(index)
                .LISRC = ULOGIC_arr(rowLogic, ULOGIC("LISRC(" & index & ")"))
                .LISRC = ReplaceLISRCSuffix(.LISRC)
            End With
        Next
        
        For index = 1 To 12
            With .HN_OUTPUT(index)
                .LODSTN = ULOGIC_arr(rowLogic, ULOGIC("LODSTN(" & index & ")"))
                .LODSTN = ReplaceLODSTNSuffix(.LODSTN)
                .LOSRC = ULOGIC_arr(rowLogic, ULOGIC("LOSRC(" & index & ")"))
                .LOENBL = ULOGIC_arr(rowLogic, ULOGIC("LOENBL(" & index & ")"))
            End With
        Next
        
        For index = 1 To 12
            With .HN_BOX(index)
                .LOGALGID = ULOGIC1_arr(rowLogic1, ULOGIC1("LOGALGID(" & index & ")"))
                .S1 = ULOGIC1_arr(rowLogic1, ULOGIC1("S1(" & index & ")"))
                .S2 = ULOGIC1_arr(rowLogic1, ULOGIC1("S2(" & index & ")"))
                .S3 = ULOGIC1_arr(rowLogic1, ULOGIC1("S3(" & index & ")"))
                .S4 = ULOGIC1_arr(rowLogic1, ULOGIC1("S4(" & index & ")"))
                .S1REV = ULOGIC1_arr(rowLogic1, ULOGIC1("S1REV(" & index & ")"))
                .S2REV = ULOGIC1_arr(rowLogic1, ULOGIC1("S2REV(" & index & ")"))
                .S3REV = ULOGIC1_arr(rowLogic1, ULOGIC1("S3REV(" & index & ")"))
                .S4REV = ULOGIC1_arr(rowLogic1, ULOGIC1("S4REV(" & index & ")"))
                .R1 = ULOGIC1_arr(rowLogic1, ULOGIC1("R1(" & index & ")"))
                .R2 = ULOGIC1_arr(rowLogic1, ULOGIC1("R2(" & index & ")"))
                .DLYTIME = ULOGIC2_arr(rowLogic2, ULOGIC2("DLYTIME(" & index & ")"))
            End With
        Next
        
        For index = 13 To 24
            With .HN_BOX(index)
                .LOGALGID = ULOGIC2_arr(rowLogic2, ULOGIC2("LOGALGID(" & index & ")"))
                .S1 = ULOGIC2_arr(rowLogic2, ULOGIC2("S1(" & index & ")"))
                .S2 = ULOGIC2_arr(rowLogic2, ULOGIC2("S2(" & index & ")"))
                .S3 = ULOGIC2_arr(rowLogic2, ULOGIC2("S3(" & index & ")"))
                .S4 = ULOGIC2_arr(rowLogic2, ULOGIC2("S4(" & index & ")"))
                .S1REV = ULOGIC2_arr(rowLogic2, ULOGIC2("S1REV(" & index & ")"))
                .S2REV = ULOGIC2_arr(rowLogic2, ULOGIC2("S2REV(" & index & ")"))
                .S3REV = ULOGIC2_arr(rowLogic2, ULOGIC2("S3REV(" & index & ")"))
                .S4REV = ULOGIC2_arr(rowLogic2, ULOGIC2("S4REV(" & index & ")"))
                .R1 = ULOGIC2_arr(rowLogic2, ULOGIC2("R1(" & index & ")"))
                .R2 = ULOGIC2_arr(rowLogic2, ULOGIC2("R2(" & index & ")"))
                .DLYTIME = ULOGIC2_arr(rowLogic2, ULOGIC2("DLYTIME(" & index & ")"))
            End With
        Next
    
    End With
    
    Dim LElement_X As Integer, LElement_Y As Integer, LElement_ID As Integer, LSort_ID As Integer
    LSort_ID = 0
    LElement_ID = 1
    LElement_Y = 2
    LElement_X = 10
    
    '输入 赋值
    For index = 1 To 12
        With ExcelInfo.HN_INPUT(index)
            If .LISRC <> "" And .LISRC <> "--.--" Then
                .ElementLevel = 0
                .ElementID = LElement_ID
                LElement_ID = LElement_ID + 1
                
                .Element_X = LElement_X
                .Element_Y = LElement_Y
                LElement_Y = LElement_Y + 6
             End If
        End With
    Next
    
    'NN 赋值
    For index = 1 To 24
        With ExcelInfo.HN_BOX(index)
            If .R1 Like "NN*" Then
                .ElementID_R1 = LElement_ID
                LElement_ID = LElement_ID + 1
             End If
            If .R2 Like "NN*" Then
                .ElementID_R2 = LElement_ID
                LElement_ID = LElement_ID + 1
             End If
        End With
    Next
    
    'DLYTIME 赋值
    For index = 1 To 24
        With ExcelInfo.HN_BOX(index)
           If .DLYTIME <> "" Then
                 .ElementID_DT = LElement_ID
                LElement_ID = LElement_ID + 1
           End If
        End With
    Next
    
    'BOX 赋值
    Call InitAllBoxLevel
    
    LElement_Y = 2
    Dim LElementLevel_X_Max, LElementLevel_X As Integer
    LElementLevel_X = LElement_X
    LElementLevel_X_Max = LElement_X
    
    'BOX 获取BOX层级
    Dim nLevelMax As Integer
    nLevelMax = 0
    For index = 1 To 24
       With ExcelInfo.HN_BOX(index)
             If .ElementLevel > nLevelMax Then
                nLevelMax = .ElementLevel
             End If
       End With
    Next
    
    'BOX 按层级设置BOX属性值
    For nLevelIndex = 1 To nLevelMax
        LElement_Y = 2
        For index = 1 To 24
            With ExcelInfo.HN_BOX(index)
               If .LOGALGID <> "" And .LOGALGID <> "NULL" And .ElementLevel = nLevelIndex Then
                    .ElementID = LElement_ID
                    LElement_ID = LElement_ID + 1
                   
                    LElementLevel_X = LElement_X * .ElementLevel + 5
                    If LElementLevel_X > LElementLevel_X_Max Then
                         LElementLevel_X_Max = LElementLevel_X
                    End If
                    
                    .Element_X = LElementLevel_X
                    .Element_Y = GetBoxYPosition(ExcelInfo.HN_BOX(index), LElement_Y)
                    LElement_Y = .Element_Y
                    
                    If .LOGALGID = "PULSE" Then
                        .ElementATType = "TP"
                    ElseIf .LOGALGID = "SWITCH" Then
                        .ElementATType = "SEL"
                    ElseIf .LOGALGID = "CHECKBAD" Then
                        .ElementATType = "Q"
                    ElseIf .LOGALGID = "ONDLY" Then
                        .ElementATType = "TON"
                    ElseIf .LOGALGID = "OFFDLY" Then
                        .ElementATType = "TOF"
                    Else
                        .ElementATType = .LOGALGID
                    End If
                    
                    .ElementSortID = LSort_ID
                    LSort_ID = LSort_ID + 1
                End If
            End With
        Next
    Next
    
    '输出 赋值
    LElement_X = LElementLevel_X_Max + 10
    LElement_Y = 2
    For index = 1 To 12
        With ExcelInfo.HN_OUTPUT(index)
            If .LODSTN <> "" And .LODSTN <> "--.--" Then
                .ElementID = LElement_ID
                LElement_ID = LElement_ID + 1
                
                .Element_X = LElement_X
                .Element_Y = GetOutputYPosition(ExcelInfo.HN_OUTPUT(index), LElement_Y)
                LElement_Y = .Element_Y
                
                Dim strSo As String
                strSo = .LOSRC
                If strSo Like "NN*" Then
                    strSo = .LOENBL
                End If
                If strSo Like "FL*" Then
                    strSo = .LOENBL
                End If
                
                .ElementInputID = CInt(Trim(GetInputIndex(strSo)))
                .ElementSortID = LSort_ID
                LSort_ID = LSort_ID + 1
            End If
        End With
    Next
End Sub

'-----------------------------------------------------------------------------------------------------------
'Purpose: EXCEL信息写入XML
'History: 9-25-2019
'-----------------------------------------------------------------------------------------------------------
Private Sub WriteXML()
     '创建文件
    Set fs = CreateObject("Scripting.FileSystemObject")
    Set POU = fs.CreateTextFile(ExcelInfo.PATH, True)
                
    '(*XML文件开始公用部分*)
    '--------------------------------------------------------------------------------------------------------
    POU.WriteLine "<?xml version=" & Lab & "1.0" & Lab & " encoding=" & Lab & "ISO-8859-1" & Lab & "?>"
    POU.WriteLine "<pou>"
    POU.WriteLine "<path><![CDATA[\/" & "ULOGIC" & "]]></path>"
    POU.WriteLine "<name>" & ExcelInfo.NAME & "</name>" '方案页名
    POU.WriteLine "<secondName></secondName>"
    POU.WriteLine "<description>" & ExcelInfo.PTDESC & "</description>" '方案页描述
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
    
    'NN变量  写入XML
    Call WriteVar
    
    POU.WriteLine "</interface>"
    POU.WriteLine "<cfc>"
    
    '输入 写入XML
    For index = 1 To 12
        With ExcelInfo.HN_INPUT(index)
            If .LISRC <> "" And .LISRC <> "--.--" Then
                POU.WriteLine "<element type=" & Lab & "input" & Lab & ">"
                POU.WriteLine "<id>" & .ElementID & "</id>"
                POU.WriteLine "<AT_position>" & .Element_X & "," & .Element_Y & "</AT_position>"
                POU.WriteLine "<text>" & .LISRC & "</text>"
                POU.WriteLine "<Comment>?????</Comment>"
                POU.WriteLine "<negate>false</negate>"
                POU.WriteLine "<ttype>4</ttype>"
                POU.WriteLine "<Flag>FALSE</Flag>"
                POU.WriteLine "</element>"
             End If
        End With
    Next
    
    'BOX 写入XML
    For index = 1 To 24
        With ExcelInfo.HN_BOX(index)
           If .LOGALGID <> "" And .LOGALGID <> "NULL" And .ElementLevel > 0 Then
               POU.WriteLine "<element type=" & Lab & "box" & Lab & ">"
                POU.WriteLine "<id>" & .ElementID & "</id>"
                POU.WriteLine "<AT_position>" & .Element_X & "," & .Element_Y & "</AT_position>"
                POU.WriteLine "<isinst>TRUE</isinst>"
                POU.WriteLine "<text>" & .ElementATType & "</text>"
                POU.WriteLine "<AT_type>" & .ElementATType & "</AT_type>"
                POU.WriteLine "<typetext>BT_FB</typetext>"
                POU.WriteLine "<ttype>9</ttype>"
                POU.WriteLine "<sortid>" & .ElementSortID & "</sortid>"
                Call WriteBoxInputs(CInt(index))
                Call WriteBoxOutputs(CInt(index))
                POU.WriteLine "</element>"
            End If
        End With
    Next
    
    'NN  写入XML
    For index = 1 To 24
        With ExcelInfo.HN_BOX(index)
            If .R1 Like "NN*" Then
                POU.WriteLine "<element type=" & Lab & "input" & Lab & ">"
                POU.WriteLine "<id>" & .ElementID_R1 & "</id>"
                POU.WriteLine "<AT_position>" & .Element_X - 1 & "," & .Element_Y + 2 & "</AT_position>"
                POU.WriteLine "<text>" & .R1 & "</text>"
                POU.WriteLine "<Comment>?????</Comment>"
                POU.WriteLine "<negate>false</negate>"
                POU.WriteLine "<ttype>4</ttype>"
                POU.WriteLine "<Flag>FALSE</Flag>"
                POU.WriteLine "</element>"
            End If
            If .R2 Like "NN*" Then
                POU.WriteLine "<element type=" & Lab & "input" & Lab & ">"
                POU.WriteLine "<id>" & .ElementID_R2 & "</id>"
                POU.WriteLine "<AT_position>" & .Element_X - 1 & "," & .Element_Y + 2 & "</AT_position>"
                POU.WriteLine "<text>" & .R2 & "</text>"
                POU.WriteLine "<Comment>?????</Comment>"
                POU.WriteLine "<negate>false</negate>"
                POU.WriteLine "<ttype>4</ttype>"
                POU.WriteLine "<Flag>FALSE</Flag>"
                POU.WriteLine "</element>"
             End If
        End With
    Next
    
    'DLYTIME  写入XML
    For index = 1 To 24
        With ExcelInfo.HN_BOX(index)
           If .DLYTIME <> "" Then
                POU.WriteLine "<element type=" & Lab & "input" & Lab & ">"
                POU.WriteLine "<id>" & .ElementID_DT & "</id>"
                POU.WriteLine "<AT_position>" & .Element_X - 1 & "," & .Element_Y + 2 & "</AT_position>"
                POU.WriteLine "<text>" & .DLYTIME & "</text>"
                POU.WriteLine "<Comment>?????</Comment>"
                POU.WriteLine "<negate>false</negate>"
                POU.WriteLine "<ttype>4</ttype>"
                POU.WriteLine "<Flag>FALSE</Flag>"
                POU.WriteLine "</element>"
           End If
        End With
    Next
    
    '输出  写入XML
    For index = 1 To 12
        With ExcelInfo.HN_OUTPUT(index)
            If .LODSTN <> "" And .LODSTN <> "--.--" Then
                POU.WriteLine "<element type=" & Lab & "output" & Lab & ">"
                POU.WriteLine "<id>" & .ElementID & "</id>"
                POU.WriteLine "<position>" & .Element_X & "," & .Element_Y & "</position>"
                POU.WriteLine "<text>" & .LODSTN & "</text>"
                POU.WriteLine "<Comment>?????</Comment>"
                POU.WriteLine "<negate>false</negate>"
                POU.WriteLine "<ttype>4</ttype>"
                POU.WriteLine "<Inputid>" & .ElementInputID & "</Inputid>"
                POU.WriteLine "<Inputidx>0</Inputidx>"
                POU.WriteLine "<negate>false</negate>"
                POU.WriteLine "<sortid>" & .ElementSortID & "</sortid>"
                POU.WriteLine "</element>"
            End If
        End With
    Next

    '(*XML文件结束公用部分*)
    '--------------------------
    POU.WriteLine "</cfc>"
    POU.WriteLine "</pou>"
     
    '(*方案页文件关闭*)
    '---------------------------
    POU.Close
End Sub


'-----------------------------------------------------------------------------------------------------------
'Purpose: 写入NN变量信息
'History: 9-26-2019
'-----------------------------------------------------------------------------------------------------------
Private Sub InitNN()
    Dim strVarTemp As String
    Dim strVar As String
    Dim strCur As String
    Dim iIndex As Integer
    Dim iPos As Integer
    
    strVarTemp = ""
    strVar = ""
    iIndex = 1
    
    ' 拼接NN的字符串到strVar
    For index = 1 To 8
        strVarTemp = ULOGIC_arr(ULOGIC_i, ULOGIC("NN(00" & index & ")"))
        If strVarTemp <> "" And strVarTemp <> "--" Then
            If strVar <> "" Then
                strVar = strVar & " "
            End If
            
            strVar = strVar & "NN(00" & index & ")=" & strVarTemp
        End If
    Next
                  
    ' 对Var数据进行逻辑拆分
    Do While strVar <> ""
        iPos = InStr(strVar, " ")
        If iPos <> 0 Then
            strCur = Mid(strVar, 1, iPos)
            strVar = Mid(strVar, iPos + 1, Len(strVar) - iPos)
            Do While Len(strVar) > 0 And Mid(strVar, 1, 1) = " "
                strVar = Mid(strVar, 2, Len(strVar) - 1)
            Loop
        Else
            strCur = strVar
            strVar = ""
        End If
        
        iPos = InStr(strCur, "=")
        iIndex = CInt(Mid(strCur, iPos - 4, 3))
        strCur = Mid(strCur, iPos + 1, Len(strCur) - iPos)
        ExcelInfo.HN_NN(iIndex).NN = strCur
    Loop
End Sub

'-----------------------------------------------------------------------------------------------------------
'Purpose: 写入Var变量信息到XML
'History: 9-26-2019
'-----------------------------------------------------------------------------------------------------------
Private Sub WriteVar()
    POU.WriteLine "<![CDATA[PROGRAM " & ExcelInfo.NAME
    POU.WriteLine "VAR"
    
    For index = 1 To 8
        If ExcelInfo.HN_NN(index).NN <> "" Then
            POU.WriteLine "NN" & index & "(2070): REAL := " & ExcelInfo.HN_NN(index).NN & ";       (*NN" & index & "描述*)"
        End If
    Next
    
    POU.WriteLine "END_VAR]]>"
End Sub

'-----------------------------------------------------------------------------------------------------------
'Purpose: 初始化BOX层级
'History: 9-26-2019
'-----------------------------------------------------------------------------------------------------------
Private Sub InitAllBoxLevel()
    For index = 1 To 24
        With ExcelInfo.HN_BOX(index)
            If .LOGALGID <> "" And .LOGALGID <> "NULL" Then
                InitBoxLevel (index)
            End If
        End With
    Next
End Sub

'-----------------------------------------------------------------------------------------------------------
'Purpose: 初始化BOX层级
'History:
'-----------------------------------------------------------------------------------------------------------
Private Sub InitBoxLevel(boxIndex As Integer)
    With ExcelInfo.HN_BOX(boxIndex)
        If .ElementLevel = 0 Then
            
            nLevel = 0
            If .S1 Like "S*" Then
                sIndex = Right(.S1, Len(.S1) - 2)
                nIndex = CInt(sIndex)
                nElementLevel = ExcelInfo.HN_BOX(nIndex).ElementLevel
                If nElementLevel = 0 And .LOGALGID <> "" And .LOGALGID <> "NULL" Then
                    InitBoxLevel (nIndex)
                    nElementLevel = ExcelInfo.HN_BOX(nIndex).ElementLevel
                End If
                If nElementLevel > nLevel Then
                    nLevel = nElementLevel
                End If
            End If
            If .S2 Like "S*" Then
                sIndex = Right(.S2, Len(.S2) - 2)
                nIndex = CInt(sIndex)
                nElementLevel = ExcelInfo.HN_BOX(nIndex).ElementLevel
                If nElementLevel = 0 And .LOGALGID <> "" And .LOGALGID <> "NULL" Then
                    InitBoxLevel (nIndex)
                    nElementLevel = ExcelInfo.HN_BOX(nIndex).ElementLevel
                End If
                If nElementLevel > nLevel Then
                    nLevel = nElementLevel
                End If
            End If
            If .S3 Like "S*" Then
                sIndex = Right(.S3, Len(.S3) - 2)
                nIndex = CInt(sIndex)
                nElementLevel = ExcelInfo.HN_BOX(nIndex).ElementLevel
                If nElementLevel = 0 And .LOGALGID <> "" And .LOGALGID <> "NULL" Then
                    InitBoxLevel (nIndex)
                    nElementLevel = ExcelInfo.HN_BOX(nIndex).ElementLevel
                End If
                If nElementLevel > nLevel Then
                    nLevel = nElementLevel
                End If
            End If
            If .S4 Like "S*" Then
                sIndex = Right(.S4, Len(.S4) - 2)
                nIndex = CInt(sIndex)
                nElementLevel = ExcelInfo.HN_BOX(nIndex).ElementLevel
                If nElementLevel = 0 And .LOGALGID <> "" And .LOGALGID <> "NULL" Then
                    InitBoxLevel (nIndex)
                    nElementLevel = ExcelInfo.HN_BOX(nIndex).ElementLevel
                End If
                If nElementLevel > nLevel Then
                    nLevel = nElementLevel
                End If
            End If
            .ElementLevel = nLevel + 1
        End If
    End With
End Sub

'-----------------------------------------------------------------------------------------------------------
' Purpose: 写Box输入引脚
' History:
'            sw create function on 2019.9.25
'-----------------------------------------------------------------------------------------------------------
Private Function WriteBoxInputs(iIndex As Integer)
    If iIndex > 0 And iIndex < 25 Then
        Dim bIsRPin As Boolean
        Dim bHasDlyTime As Boolean
        
        If ExcelInfo.HN_BOX(iIndex).LOGALGID = "EQ" Then
            bIsRPin = True
        ElseIf ExcelInfo.HN_BOX(iIndex).LOGALGID = "NE" Then
            bIsRPin = True
        ElseIf ExcelInfo.HN_BOX(iIndex).LOGALGID = "GT" Then
            bIsRPin = True
        ElseIf ExcelInfo.HN_BOX(iIndex).LOGALGID = "GE" Then
            bIsRPin = True
        ElseIf ExcelInfo.HN_BOX(iIndex).LOGALGID = "LT" Then
            bIsRPin = True
        ElseIf ExcelInfo.HN_BOX(iIndex).LOGALGID = "LE" Then
            bIsRPin = True
        Else
            bIsRPin = False
        End If
        
        If ExcelInfo.HN_BOX(iIndex).LOGALGID = "PULSE" Then
            bHasDlyTime = True
        ElseIf ExcelInfo.HN_BOX(iIndex).LOGALGID = "MAXPULSE" Then
            bHasDlyTime = True
        ElseIf ExcelInfo.HN_BOX(iIndex).LOGALGID = "MINPULSE" Then
            bHasDlyTime = True
        ElseIf ExcelInfo.HN_BOX(iIndex).LOGALGID = "ONDLY" Then
            bHasDlyTime = True
        ElseIf ExcelInfo.HN_BOX(iIndex).LOGALGID = "OFFDLY" Then
            bHasDlyTime = True
        Else
            bHasDlyTime = False
        End If
        
        If bIsRPin Then
            Call WriteBoxInput(ExcelInfo.HN_BOX(iIndex).LOGALGID, ExcelInfo.HN_BOX(iIndex).R1, "OFF", "R1", iIndex)
            Call WriteBoxInput(ExcelInfo.HN_BOX(iIndex).LOGALGID, ExcelInfo.HN_BOX(iIndex).R2, "OFF", "R2", iIndex)
        ElseIf bHasDlyTime Then
            Call WriteBoxInput(ExcelInfo.HN_BOX(iIndex).LOGALGID, ExcelInfo.HN_BOX(iIndex).S1, ExcelInfo.HN_BOX(iIndex).S1REV, "S1", iIndex)
            Call WriteBoxInput(ExcelInfo.HN_BOX(iIndex).LOGALGID, "DLYTIME" & str(iIndex), "OFF", "DLYTIME" & str(iIndex), iIndex)
        Else
            Call WriteBoxInput(ExcelInfo.HN_BOX(iIndex).LOGALGID, ExcelInfo.HN_BOX(iIndex).S1, ExcelInfo.HN_BOX(iIndex).S1REV, "S1", iIndex)
            Call WriteBoxInput(ExcelInfo.HN_BOX(iIndex).LOGALGID, ExcelInfo.HN_BOX(iIndex).S2, ExcelInfo.HN_BOX(iIndex).S2REV, "S2", iIndex)
            Call WriteBoxInput(ExcelInfo.HN_BOX(iIndex).LOGALGID, ExcelInfo.HN_BOX(iIndex).S3, ExcelInfo.HN_BOX(iIndex).S3REV, "S3", iIndex)
            Call WriteBoxInput(ExcelInfo.HN_BOX(iIndex).LOGALGID, ExcelInfo.HN_BOX(iIndex).S4, ExcelInfo.HN_BOX(iIndex).S4REV, "S4", iIndex)
        End If
    End If
End Function

'-----------------------------------------------------------------------------------------------------------
' Purpose: 写Box输出引脚
' History:
'            sw create function on 2019.9.25
'-----------------------------------------------------------------------------------------------------------
Private Function WriteBoxOutputs(iIndex As Integer)
    If iIndex > 0 And iIndex < 25 Then
        If ExcelInfo.HN_BOX(iIndex).LOGALGID = "NAND" Then
            WriteBoxOutput ("SO")
        ElseIf ExcelInfo.HN_BOX(iIndex).LOGALGID = "NOR" Then
            WriteBoxOutput ("SO")
        ElseIf ExcelInfo.HN_BOX(iIndex).LOGALGID = "QOR2" Then
            WriteBoxOutput ("SO")
        ElseIf ExcelInfo.HN_BOX(iIndex).LOGALGID = "QOR3" Then
            WriteBoxOutput ("SO")
        ElseIf ExcelInfo.HN_BOX(iIndex).LOGALGID = "PULSE" Then
            WriteBoxOutput ("Q")
            WriteBoxOutput ("ET")
        ElseIf ExcelInfo.HN_BOX(iIndex).LOGALGID = "MINPULSE" Then
            WriteBoxOutput ("SO")
        ElseIf ExcelInfo.HN_BOX(iIndex).LOGALGID = "MAXPULSE" Then
            WriteBoxOutput ("SO")
        ElseIf ExcelInfo.HN_BOX(iIndex).LOGALGID = "ONDLY" Then
            WriteBoxOutput ("Q")
            WriteBoxOutput ("ET")
        ElseIf ExcelInfo.HN_BOX(iIndex).LOGALGID = "OFFDLY" Then
            WriteBoxOutput ("Q")
            WriteBoxOutput ("ET")
        ElseIf ExcelInfo.HN_BOX(iIndex).LOGALGID = "FLIPFLOP" Then
            WriteBoxOutput ("Q1")
        Else
            WriteBoxOutput ("")
        End If
    End If
End Function

'-----------------------------------------------------------------------------------------------------------
' Purpose: 写入一个输入引脚
' History:
'            sw create function on 2019.9.25
'-----------------------------------------------------------------------------------------------------------
Private Function WriteBoxInput(strBoxName As String, strIndexName As String, strNagetive As String, strPinName As String, iIndex As Integer)
    If strIndexName <> "" And strIndexName <> "NULL" And Not strIndexName Like "FL*" Then
        Dim strInputIndexName As String
        Dim strInputPinName As String
        Dim strInputNagetive As String
        
        strInputIndexName = GetInputIndex(strIndexName)
        If strIndexName Like "NN*" Then
            If strPinName = "R1" Or strPinName = "R2" Then
                strInputIndexName = GetInputNNIndex(iIndex, strPinName)
            End If
        End If
        
        strInputPinName = ConvertPinName(strBoxName, strPinName)
        strInputNagetive = ConvertNagetive(strNagetive)
        strInputIndexName = Trim(strInputIndexName)
        
        POU.WriteLine "<input inputid=""" & strInputIndexName & """ inputidx=""0"" negate=""" & strInputNagetive & """ visible=""true"" pinname=""" & strInputPinName & """/>"
    End If
End Function

'-----------------------------------------------------------------------------------------------------------
' Purpose: 写入一个输出引脚
' History:
'            sw create function on 2019.9.25
'-----------------------------------------------------------------------------------------------------------
Private Function WriteBoxOutput(strPinName As String)

    POU.WriteLine "<output negate=""false"" visible=""true"" pinname=""" & strPinName & """/>"

End Function

'-----------------------------------------------------------------------------------------------------------
' Purpose: 获取输入引脚连接的块索引
' History:
'            sw create function on 2019.9.25
'-----------------------------------------------------------------------------------------------------------
Private Function GetInputNNIndex(iIndex As Integer, strPinName As String)
    If strPinName = "R1" Then
        GetInputNNIndex = str(ExcelInfo.HN_BOX(iIndex).ElementID_R1)
    Else
        GetInputNNIndex = str(ExcelInfo.HN_BOX(iIndex).ElementID_R2)
    End If
End Function
'-----------------------------------------------------------------------------------------------------------
' Purpose: 获取输入引脚连接的块索引
' History:
'            sw create function on 2019.9.25
'-----------------------------------------------------------------------------------------------------------
Private Function GetInputIndex(strIndexName As String)
    Dim strIndex As String
    If strIndexName Like "DLYTIME*" Then
        Trim (strIndexName)
        strIndex = Mid(strIndexName, 8, Len(strIndexName) - 7)
        GetInputIndex = str(ExcelInfo.HN_BOX(CInt(strIndex)).ElementID_DT)
    ElseIf strIndexName Like "NN*" Then
        If strPinName = "R1" Then
            strIndex = Mid(strIndexName, 3, Len(strIndexName) - 2)
        Else
        End If
        strIndex = Mid(strIndexName, 3, Len(strIndexName) - 2)
        GetInputIndex = str(ExcelInfo.HN_NN(CInt(strIndex)).ElementID)
    ElseIf strIndexName Like "L*" Then
        strIndex = Mid(strIndexName, 2, Len(strIndexName) - 1)
        GetInputIndex = str(ExcelInfo.HN_INPUT(CInt(strIndex)).ElementID)
    ElseIf strIndexName Like "SO*" Then
        strIndex = Mid(strIndexName, 3, Len(strIndexName) - 2)
        GetInputIndex = str(ExcelInfo.HN_BOX(CInt(strIndex)).ElementID)
    Else
        GetInputIndex = "0"
    End If
End Function

'-----------------------------------------------------------------------------------------------------------
' Purpose: 转换置反
' History:
'            sw create function on 2019.9.25
'-----------------------------------------------------------------------------------------------------------
Private Function ConvertNagetive(strNagetive As String)
    If strNagetive = "ON" Then
        ConvertNagetive = "true"
    Else
        ConvertNagetive = "false"
    End If
End Function

'-----------------------------------------------------------------------------------------------------------
' Purpose: 转换引脚名称
' History:
'            sw create function on 2019.9.25
'-----------------------------------------------------------------------------------------------------------
Private Function ConvertPinName(strBoxName As String, strPinName As String) As String
    If strBoxName = "NAND" Then
        ConvertPinName = ConvertNANDPinName(strPinName)
    ElseIf strBoxName = "NOR" Then
        ConvertPinName = ConvertNORPinName(strPinName)
    ElseIf strBoxName = "QOR2" Then
        ConvertPinName = ConvertQOR2PinName(strPinName)
    ElseIf strBoxName = "QOR3" Then
        ConvertPinName = ConvertQOR3PinName(strPinName)
    ElseIf strBoxName = "PULSE" Then
        ConvertPinName = ConvertPULSEPinName(strPinName)
    ElseIf strBoxName = "MINPULSE" Then
        ConvertPinName = ConvertMINPULSEPinName(strPinName)
    ElseIf strBoxName = "MAXPULSE" Then
        ConvertPinName = ConvertMAXPULSEPinName(strPinName)
    ElseIf strBoxName = "ONDLY" Then
        ConvertPinName = ConvertONDLYPinName(strPinName)
    ElseIf strBoxName = "OFFDLY" Then
        ConvertPinName = ConvertOFFDLYPinName(strPinName)
    ElseIf strBoxName = "FLIPFLOP" Then
        ConvertPinName = ConvertFLIPFLOPPinName(strPinName, "RS")
    Else
        ConvertPinName = ""
    End If
End Function

'-----------------------------------------------------------------------------------------------------------
' Purpose: 转换NAND引脚名称
' History:
'            sw create function on 2019.9.25
'-----------------------------------------------------------------------------------------------------------
Private Function ConvertNANDPinName(strPinName As String)
    ConvertNANDPinName = strPinName
End Function

'-----------------------------------------------------------------------------------------------------------
' Purpose: 转换NOR引脚名称
' History:
'            sw create function on 2019.9.25
'-----------------------------------------------------------------------------------------------------------
Private Function ConvertNORPinName(strPinName As String)
    ConvertNORPinName = strPinName
End Function

'-----------------------------------------------------------------------------------------------------------
' Purpose: 转换QOR2引脚名称
' History:
'            sw create function on 2019.9.25
'-----------------------------------------------------------------------------------------------------------
Private Function ConvertQOR2PinName(strPinName As String)
    ConvertQOR2PinName = strPinName
End Function

'-----------------------------------------------------------------------------------------------------------
' Purpose: 转换QOR3引脚名称
' History:
'            sw create function on 2019.9.25
'-----------------------------------------------------------------------------------------------------------
Private Function ConvertQOR3PinName(strPinName As String)
    ConvertQOR3PinName = strPinName
End Function
'-----------------------------------------------------------------------------------------------------------
' Purpose: 转换 PULSE 引脚名称
' History:
'            sw create function on 2019.9.25
'-----------------------------------------------------------------------------------------------------------
Private Function ConvertPULSEPinName(strPinName As String)
    If strPinName = "S1" Then
        ConvertPULSEPinName = "IN"
    ElseIf strPinName Like "DLYTIME*" Then
        ConvertPULSEPinName = "PT"
    Else
        ConvertPULSEPinName = ""
    End If
End Function

' Purpose: 转换 MINPULSE 引脚名称
' History:
'            sw create function on 2019.9.25
'-----------------------------------------------------------------------------------------------------------
Private Function ConvertMINPULSEPinName(strPinName As String)
    If strPinName = "S1" Then
        ConvertMINPULSEPinName = strPinName
    Else
        ConvertMINPULSEPinName = "DLYTIME"
    End If
End Function

' Purpose: 转换 MAXPULSE 引脚名称
' History:
'            sw create function on 2019.9.25
'-----------------------------------------------------------------------------------------------------------
Private Function ConvertMAXPULSEPinName(strPinName As String)
    If strPinName = "S1" Then
        ConvertMAXPULSEPinName = strPinName
    Else
        ConvertMAXPULSEPinName = "DLYTIME"
    End If
End Function

'-----------------------------------------------------------------------------------------------------------
' Purpose: 转换 ONDLY 引脚名称
' History:
'            sw create function on 2019.9.25
'-----------------------------------------------------------------------------------------------------------
Private Function ConvertONDLYPinName(strPinName As String)
    If strPinName = "S1" Then
        ConvertONDLYPinName = "IN"
    ElseIf strPinName Like "DLYTIME*" Then
        ConvertONDLYPinName = "PT"
    Else
        ConvertONDLYPinName = ""
    End If
End Function

'-----------------------------------------------------------------------------------------------------------
' Purpose: 转换 OFFDLY 引脚名称
' History:
'            sw create function on 2019.9.25
'-----------------------------------------------------------------------------------------------------------
Private Function ConvertOFFDLYPinName(strPinName As String)
    If strPinName = "S1" Then
        ConvertOFFDLYPinName = "IN"
    ElseIf strPinName Like "DLYTIME*" Then
        ConvertOFFDLYPinName = "PT"
    Else
        ConvertOFFDLYPinName = ""
    End If
End Function

'-----------------------------------------------------------------------------------------------------------
' Purpose: 转换 FLIPFLOP 引脚名称
' History:
'            sw create function on 2019.9.25
'-----------------------------------------------------------------------------------------------------------
Private Function ConvertFLIPFLOPPinName(strPinName As String, strPinType As String)
    If strPinName = "S1" Then
        If strPinType = "RS" Then
            ConvertFLIPFLOPPinName = "SET"
        Else
            ConvertFLIPFLOPPinName = "SET1"
        End If
    ElseIf strPinName = "S2" Then
        If strPinType = "RS" Then
            ConvertFLIPFLOPPinName = "RESET1"
        Else
            ConvertFLIPFLOPPinName = "RESET"
        End If
    Else
        ConvertFLIPFLOPPinName = ""
    End If
End Function

'-----------------------------------------------------------------------------------------------------------
' Purpose: 获取BOX坐标Y值
' History:
'-----------------------------------------------------------------------------------------------------------
Private Function GetBoxYPosition(boxElement As T_HN_BOX, lastYPosition As Integer)
    Dim YPos_Min, YPos_Max As Integer
    Dim YPos_Temp As Integer
    YPos_Temp = 0
    YPos_Min = 1000
    YPos_Max = 0
    
    With boxElement
        If .LOGALGID <> "" And .LOGALGID <> "NULL" Then
            If .R1 Like "L*" Then
                YPos_Temp = ExcelInfo.HN_INPUT(CInt(Right(.R1, Len(.R1) - 1))).Element_Y
                If YPos_Temp > YPos_Max Then
                    YPos_Max = YPos_Temp
                End If
                If YPos_Temp < YPos_Min Then
                    YPos_Min = YPos_Temp
                End If
            End If
            
            If .R2 Like "L*" Then
                YPos_Temp = ExcelInfo.HN_INPUT(CInt(Right(.R2, Len(.R2) - 1))).Element_Y
                If YPos_Temp > YPos_Max Then
                    YPos_Max = YPos_Temp
                End If
                If YPos_Temp < YPos_Min Then
                    YPos_Min = YPos_Temp
                End If
            End If
        
            If .S1 Like "L*" Then
                YPos_Temp = ExcelInfo.HN_INPUT(CInt(Right(.S1, Len(.S1) - 1))).Element_Y
                If YPos_Temp > YPos_Max Then
                    YPos_Max = YPos_Temp
                End If
                If YPos_Temp < YPos_Min Then
                    YPos_Min = YPos_Temp
                End If
            ElseIf .S1 Like "SO*" Then
                YPos_Temp = ExcelInfo.HN_BOX(CInt(Right(.S1, Len(.S1) - 2))).Element_Y
                If YPos_Temp > YPos_Max Then
                    YPos_Max = YPos_Temp
                End If
                If YPos_Temp < YPos_Min Then
                    YPos_Min = YPos_Temp
                End If
            End If

            If .S2 Like "L*" Then
                YPos_Temp = ExcelInfo.HN_INPUT(CInt(Right(.S2, Len(.S2) - 1))).Element_Y
                If YPos_Temp > YPos_Max Then
                    YPos_Max = YPos_Temp
                End If
                If YPos_Temp < YPos_Min Then
                    YPos_Min = YPos_Temp
                End If
            ElseIf .S2 Like "SO*" Then
                YPos_Temp = ExcelInfo.HN_BOX(CInt(Right(.S2, Len(.S2) - 2))).Element_Y
                If YPos_Temp > YPos_Max Then
                    YPos_Max = YPos_Temp
                End If
                If YPos_Temp < YPos_Min Then
                    YPos_Min = YPos_Temp
                End If
            End If
            
            If .S3 Like "L*" Then
                YPos_Temp = ExcelInfo.HN_INPUT(CInt(Right(.S3, Len(.S3) - 1))).Element_Y
                If YPos_Temp > YPos_Max Then
                    YPos_Max = YPos_Temp
                End If
                If YPos_Temp < YPos_Min Then
                    YPos_Min = YPos_Temp
                End If
            ElseIf .S3 Like "SO*" Then
                YPos_Temp = ExcelInfo.HN_BOX(CInt(Right(.S3, Len(.S3) - 2))).Element_Y
                If YPos_Temp > YPos_Max Then
                    YPos_Max = YPos_Temp
                End If
                If YPos_Temp < YPos_Min Then
                    YPos_Min = YPos_Temp
                End If
            End If
            
             If .S4 Like "L*" Then
                YPos_Temp = ExcelInfo.HN_INPUT(CInt(Right(.S4, Len(.S4) - 1))).Element_Y
                If YPos_Temp > YPos_Max Then
                    YPos_Max = YPos_Temp
                End If
                If YPos_Temp < YPos_Min Then
                    YPos_Min = YPos_Temp
                End If
            ElseIf .S4 Like "SO*" Then
                YPos_Temp = ExcelInfo.HN_BOX(CInt(Right(.S4, Len(.S4) - 2))).Element_Y
                If YPos_Temp > YPos_Max Then
                    YPos_Max = YPos_Temp
                End If
                If YPos_Temp < YPos_Min Then
                    YPos_Min = YPos_Temp
                End If
            End If
        End If
    End With
    
    If YPos_Min = 1000 Or YPos_Max = 0 Then
        GetBoxYPosition = lastYPosition + 6
    Else
        GetBoxYPosition = (YPos_Min + YPos_Max) / 2
    End If
    
End Function


'-----------------------------------------------------------------------------------------------------------
' Purpose: 获取OUTPUT坐标Y值
' History:
'-----------------------------------------------------------------------------------------------------------
Private Function GetOutputYPosition(outputElement As T_HN_OUTPUT, lastYPosition As Integer)
    Dim YPos_Min, YPos_Max As Integer
    Dim YPos_Temp As Integer
    YPos_Temp = 0
    YPos_Min = 1000
    YPos_Max = 0
    
    With outputElement
        If .LOSRC Like "L*" Then
            YPos_Temp = ExcelInfo.HN_INPUT(CInt(Right(.LOSRC, Len(.LOSRC) - 1))).Element_Y
            If YPos_Temp > YPos_Max Then
                YPos_Max = YPos_Temp
            End If
            If YPos_Temp < YPos_Min Then
                YPos_Min = YPos_Temp
            End If
        ElseIf .LOSRC Like "SO*" Then
            YPos_Temp = ExcelInfo.HN_BOX(CInt(Right(.LOSRC, Len(.LOSRC) - 2))).Element_Y
            If YPos_Temp > YPos_Max Then
                YPos_Max = YPos_Temp
            End If
            If YPos_Temp < YPos_Min Then
                YPos_Min = YPos_Temp
            End If
        End If
    End With
    
    If YPos_Min = 1000 Or YPos_Max = 0 Then
        GetOutputYPosition = lastYPosition + 2
    Else
        GetOutputYPosition = (YPos_Min + YPos_Max) / 2
    End If
    
End Function

'-----------------------------------------------------------------------------------------------------------
' Purpose: LISRC替换后缀
' Remark:
'-----------------------------------------------------------------------------------------------------------
Private Function ReplaceLISRCSuffix(LISRC As String)
    Dim newLISRC As String
    newLISRC = LISRC
    
    newLISRC = Replace(newLISRC, ".PVFL", ".DV")
    newLISRC = Replace(newLISRC, ".SO", ".DI")
    newLISRC = Replace(newLISRC, ".PVLOFL", ".ALIND")
    newLISRC = Replace(newLISRC, ".PVLLFL", ".LLIND")
    newLISRC = Replace(newLISRC, ".PVHIFL", ".AHIND")
    newLISRC = Replace(newLISRC, ".PVHHFL", ".HHIND")
    
    ReplaceLISRCSuffix = newLISRC
End Function

'-----------------------------------------------------------------------------------------------------------
' Purpose: LODSTN替换后缀
' Remark: 目前替换的项和LISRC一致，若不一致需要更新
'-----------------------------------------------------------------------------------------------------------
Private Function ReplaceLODSTNSuffix(LODSTN As String)
    ReplaceLODSTNSuffix = ReplaceLISRCSuffix(LODSTN)
End Function
