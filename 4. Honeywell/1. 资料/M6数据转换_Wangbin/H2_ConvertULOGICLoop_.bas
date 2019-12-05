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
            Call WriteXML(sPouName)
        End If
    Next ULOGIC_i
End Sub

'-----------------------------------------------------------------------------------------------------------
'Purpose: EXCEL信息解析至POU
'History: 9-25-2019
'-----------------------------------------------------------------------------------------------------------
Private Sub InitProperty(sPouName As String)
    Dim rowLogic As Integer, rowLogic1 As Integer, rowLogic2 As Integer
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
                If .DLYTIME <> "" Then
                    .DLYTIME = Split(.DLYTIME, ".")(0)
                End If
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
                If .DLYTIME <> "" Then
                    .DLYTIME = Split(.DLYTIME, ".")(0)
                End If
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
    
    'NN FL赋值
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
            If .S1 Like "FL*" Then
                .ElementID_S1 = LElement_ID
                LElement_ID = LElement_ID + 1
            End If
            If .S2 Like "FL*" Then
                .ElementID_S2 = LElement_ID
                LElement_ID = LElement_ID + 1
            End If
            If .S3 Like "FL*" Then
                .ElementID_S3 = LElement_ID
                LElement_ID = LElement_ID + 1
            End If
            If .S4 Like "FL*" Then
                .ElementID_S4 = LElement_ID
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
    Dim LElementLevel_X_Max As Integer, LElementLevel_X As Integer
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
                If strSo Like "NN*" Or strSo Like "FL*" Then
                    strSo = .LOENBL
                End If
                
                .ElementInputID = GetInputIndex(strSo)
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
Private Sub WriteXML(sPouName As String)
     '创建文件
    Set fs = CreateObject("Scripting.FileSystemObject")
    Set POU = fs.CreateTextFile(ExcelInfo.PATH, True)
    
    POU.WriteLine "<?xml version=" & Lab & "1.0" & Lab & " encoding=" & Lab & "ISO-8859-1" & Lab & "?>"
    POU.WriteLine "<pou>"
                
    Call WriteHead
    Call WriteInterface(sPouName)
    Call WriteCFC(sPouName)
    
    POU.WriteLine "</pou>"
     
    POU.Close
End Sub

'-----------------------------------------------------------------------------------------------------------
'Purpose: EXCEL信息写入XML
'History: 12-05-2019
'-----------------------------------------------------------------------------------------------------------
Private Sub WriteHead()
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
End Sub

'-----------------------------------------------------------------------------------------------------------
'Purpose: EXCEL信息写入XML
'History: 12-05-2019
'-----------------------------------------------------------------------------------------------------------
Private Sub WriteInterface(sPouName As String)
    POU.WriteLine "<interface>"
    POU.WriteLine "<![CDATA[PROGRAM " & ExcelInfo.NAME
    POU.WriteLine "VAR"
    
    ' 计时器变量
    For index = 1 To 24
        With ExcelInfo.HN_BOX(index)
            If .ElementATType = "TON" Or .ElementATType = "TOF" Or .ElementATType = "TP" Then
                POU.WriteLine sPouName & "_" & .ElementATType & .ElementSortID & "(2086): " & .ElementATType & " := ( IN:=FALSE, PT:=T#0S, Q:=FALSE, ET:=T#0S, M:=FALSE, StartTime:=T#0S );"
            End If
        End With
    Next
    
    POU.WriteLine "END_VAR]]>"
    POU.WriteLine "</interface>"
End Sub

'-----------------------------------------------------------------------------------------------------------
'Purpose: EXCEL信息写入XML
'History: 12-05-2019
'-----------------------------------------------------------------------------------------------------------
Private Sub WriteCFC(sPouName As String)
    POU.WriteLine "<cfc>"
    
    Call WriteInput(sPouName)
    Call WriteBox(sPouName)
    Call WriteOutput
    
    POU.WriteLine "</cfc>"
End Sub

'-----------------------------------------------------------------------------------------------------------
'Purpose: EXCEL信息写入XML
'History: 12-05-2019
'-----------------------------------------------------------------------------------------------------------
Private Sub WriteInput(sPouName As String)
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
    
    'NN  写入XML
    For index = 1 To 24
        With ExcelInfo.HN_BOX(index)
            If .R1 Like "NN*" Then
                POU.WriteLine "<element type=" & Lab & "input" & Lab & ">"
                POU.WriteLine "<id>" & .ElementID_R1 & "</id>"
                POU.WriteLine "<AT_position>" & .Element_X - 1 & "," & .Element_Y + 2 & "</AT_position>"
                POU.WriteLine "<text>" & sPouName & "_" & .R1 & "</text>"
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
                POU.WriteLine "<text>" & sPouName & "_" & .R2 & "</text>"
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
                POU.WriteLine "<text>" & "T#" & .DLYTIME & "s" & "</text>"
                POU.WriteLine "<Comment>?????</Comment>"
                POU.WriteLine "<negate>false</negate>"
                POU.WriteLine "<ttype>4</ttype>"
                POU.WriteLine "<Flag>FALSE</Flag>"
                POU.WriteLine "</element>"
           End If
        End With
    Next
    
    'S1 S2 S3 S4中FL写入XML
    For index = 1 To 24
        With ExcelInfo.HN_BOX(index)
           If .S1 Like "FL*" Then
                POU.WriteLine "<element type=" & Lab & "input" & Lab & ">"
                POU.WriteLine "<id>" & .ElementID_S1 & "</id>"
                POU.WriteLine "<AT_position>" & .Element_X - 1 & "," & .Element_Y + 2 & "</AT_position>"
                If .S1 = "FL1" Then
                    POU.WriteLine "<text>FALSE</text>"
                ElseIf .S1 = "FL2" Then
                    POU.WriteLine "<text>TRUE</text>"
                Else
                    POU.WriteLine "<text>" & sPouName & "_" & .S1 & "</text>"
                End If
                POU.WriteLine "<Comment>?????</Comment>"
                POU.WriteLine "<negate>false</negate>"
                POU.WriteLine "<ttype>4</ttype>"
                POU.WriteLine "<Flag>FALSE</Flag>"
                POU.WriteLine "</element>"
           End If
           If .S2 Like "FL*" Then
                POU.WriteLine "<element type=" & Lab & "input" & Lab & ">"
                POU.WriteLine "<id>" & .ElementID_S2 & "</id>"
                POU.WriteLine "<AT_position>" & .Element_X - 1 & "," & .Element_Y + 2 & "</AT_position>"
                If .S2 = "FL1" Then
                    POU.WriteLine "<text>FALSE</text>"
                ElseIf .S2 = "FL2" Then
                    POU.WriteLine "<text>TRUE</text>"
                Else
                    POU.WriteLine "<text>" & sPouName & "_" & .S2 & "</text>"
                End If
                POU.WriteLine "<Comment>?????</Comment>"
                POU.WriteLine "<negate>false</negate>"
                POU.WriteLine "<ttype>4</ttype>"
                POU.WriteLine "<Flag>FALSE</Flag>"
                POU.WriteLine "</element>"
           End If
           If .S3 Like "FL*" Then
                POU.WriteLine "<element type=" & Lab & "input" & Lab & ">"
                POU.WriteLine "<id>" & .ElementID_S3 & "</id>"
                POU.WriteLine "<AT_position>" & .Element_X - 1 & "," & .Element_Y + 2 & "</AT_position>"
                If .S3 = "FL1" Then
                    POU.WriteLine "<text>FALSE</text>"
                ElseIf .S3 = "FL2" Then
                    POU.WriteLine "<text>TRUE</text>"
                Else
                    POU.WriteLine "<text>" & sPouName & "_" & .S3 & "</text>"
                End If
                POU.WriteLine "<Comment>?????</Comment>"
                POU.WriteLine "<negate>false</negate>"
                POU.WriteLine "<ttype>4</ttype>"
                POU.WriteLine "<Flag>FALSE</Flag>"
                POU.WriteLine "</element>"
           End If
           If .S4 Like "FL*" Then
                POU.WriteLine "<element type=" & Lab & "input" & Lab & ">"
                POU.WriteLine "<id>" & .ElementID_S4 & "</id>"
                POU.WriteLine "<AT_position>" & .Element_X - 1 & "," & .Element_Y + 2 & "</AT_position>"
                If .S4 = "FL1" Then
                    POU.WriteLine "<text>FALSE</text>"
                ElseIf .S4 = "FL2" Then
                    POU.WriteLine "<text>TRUE</text>"
                Else
                    POU.WriteLine "<text>" & sPouName & "_" & .S4 & "</text>"
                End If
                POU.WriteLine "<Comment>?????</Comment>"
                POU.WriteLine "<negate>false</negate>"
                POU.WriteLine "<ttype>4</ttype>"
                POU.WriteLine "<Flag>FALSE</Flag>"
                POU.WriteLine "</element>"
           End If
        End With
    Next
End Sub

'-----------------------------------------------------------------------------------------------------------
'Purpose: EXCEL信息写入XML
'History: 12-05-2019
'-----------------------------------------------------------------------------------------------------------
Private Sub WriteBox(sPouName As String)
    'BOX 写入XML
    For index = 1 To 24
        With ExcelInfo.HN_BOX(index)
           If .LOGALGID <> "" And .LOGALGID <> "NULL" And .ElementLevel > 0 Then
                POU.WriteLine "<element type=" & Lab & "box" & Lab & ">"
                POU.WriteLine "<id>" & .ElementID & "</id>"
                POU.WriteLine "<AT_position>" & .Element_X & "," & .Element_Y & "</AT_position>"
                POU.WriteLine "<isinst>TRUE</isinst>"
                POU.WriteLine "<text>" & sPouName & "_" & .ElementATType & .ElementSortID & "</text>"
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
End Sub

'-----------------------------------------------------------------------------------------------------------
'Purpose: EXCEL信息写入XML
'History: 12-05-2019
'-----------------------------------------------------------------------------------------------------------
Private Sub WriteOutput()
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
End Sub

'-----------------------------------------------------------------------------------------------------------
'Purpose: 写入NN变量信息
'History: 9-26-2019
'-----------------------------------------------------------------------------------------------------------
Private Sub InitNN()
    Dim strVarTemp As String, strVar As String, strCur As String
    Dim iIndex As Integer
    
    strVarTemp = "" ' Excel读取到的NN值
    strVar = "" ' Excel读取到的全部NN值
    strCur = "" ' 解析后的每个NN值
    iIndex = 0 ' NN索引值
    
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
    
    ' 解析NN值
    strVarArr = Split(strVar, " ")
    For i = 0 To UBound(strVarArr)
        strCur = strVarArr(i)
        If strCur <> "" Then
            iIndex = CInt(Mid(strCur, 4, 3))
            ExcelInfo.HN_NN(iIndex) = Mid(strCur, 9)
        End If
    Next
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
' History: sw create function on 2019.9.25
'-----------------------------------------------------------------------------------------------------------
Private Function WriteBoxInputs(iIndex As Integer)
    Dim bIsRPin As Boolean, bHasDlyTime As Boolean
    bIsRPin = False
    bHasDlyTime = False
    
    With ExcelInfo.HN_BOX(iIndex)
        If .LOGALGID = "EQ" Or .LOGALGID = "NE" Or .LOGALGID = "GT" Or .LOGALGID = "GE" Or .LOGALGID = "LT" Or .LOGALGID = "LE" Then
            bIsRPin = True
        ElseIf .LOGALGID = "PULSE" Or .LOGALGID = "MAXPULSE" Or .LOGALGID = "MINPULSE" Or .LOGALGID = "ONDLY" Or .LOGALGID = "OFFDLY" Then
            bHasDlyTime = True
        End If
    
        If bIsRPin Then
            Call WriteBoxInput(.LOGALGID, .R1, "OFF", "R1", iIndex)
            Call WriteBoxInput(.LOGALGID, .R2, "OFF", "R2", iIndex)
        ElseIf bHasDlyTime Then
            Call WriteBoxInput(.LOGALGID, .S1, .S1REV, "S1", iIndex)
            Call WriteBoxInput(.LOGALGID, "DLYTIME" & str(iIndex), "OFF", "DLYTIME" & str(iIndex), iIndex)
        Else
            Call WriteBoxInput(.LOGALGID, .S1, .S1REV, "S1", iIndex)
            Call WriteBoxInput(.LOGALGID, .S2, .S2REV, "S2", iIndex)
            Call WriteBoxInput(.LOGALGID, .S3, .S3REV, "S3", iIndex)
            Call WriteBoxInput(.LOGALGID, .S4, .S4REV, "S4", iIndex)
        End If
    End With
End Function

'-----------------------------------------------------------------------------------------------------------
' Purpose: 写Box输出引脚
' History: sw create function on 2019.9.25
'-----------------------------------------------------------------------------------------------------------
Private Function WriteBoxOutputs(iIndex As Integer)
    With ExcelInfo.HN_BOX(iIndex)
        If .LOGALGID = "NAND" Or .LOGALGID = "NOR" Or .LOGALGID = "QOR2" Or .LOGALGID = "QOR3" Or .LOGALGID = "MINPULSE" Or .LOGALGID = "MAXPULSE" Then
            Call WriteBoxOutput("SO")
        ElseIf .LOGALGID = "PULSE" Or .LOGALGID = "ONDLY" Or .LOGALGID = "OFFDLY" Then
            Call WriteBoxOutput("Q")
            Call WriteBoxOutput("ET")
        ElseIf .LOGALGID = "FLIPFLOP" Then
            Call WriteBoxOutput("Q1")
        Else
            Call WriteBoxOutput("")
        End If
    End With
End Function

'-----------------------------------------------------------------------------------------------------------
' Purpose: 写入一个输入引脚
' History: 2019.9.25
'-----------------------------------------------------------------------------------------------------------
Private Function WriteBoxInput(strBoxName As String, strIndexName As String, strNagetive As String, strPinName As String, iIndex As Integer)
    If strIndexName <> "" And strIndexName <> "NULL" Then
        Dim sPinname As String, sNegate As String
        sPinname = "" ' pinname
        sNegate = "" ' negate
        
        Dim nInputid As Integer
        nInputid = 0  ' inputid
        
        If strIndexName Like "DLYTIME*" Then
            nInputid = GetDlytimeInputIndex(iIndex)
        ElseIf strIndexName Like "NN*" Then
            nInputid = GetNNInputIndex(iIndex, strPinName)
        ElseIf strIndexName Like "FL*" Then
            nInputid = GetFLInputIndex(iIndex, strPinName)
        Else
            nInputid = GetInputIndex(strIndexName)
        End If
        
        sPinname = ConvertPinName(strBoxName, strPinName)
        sNegate = ConvertNagetive(strNagetive)
        
        POU.WriteLine "<input inputid=""" & nInputid & """ inputidx=""0"" negate=""" & sNegate & """ visible=""true"" pinname=""" & sPinname & """/>"
    End If
End Function

'-----------------------------------------------------------------------------------------------------------
' Purpose: 写入一个输出引脚
' History: 2019.12.01
'-----------------------------------------------------------------------------------------------------------
Private Function WriteBoxOutput(strPinName As String)
    POU.WriteLine "<output negate=""false"" visible=""true"" pinname=""" & strPinName & """/>"
End Function

'-----------------------------------------------------------------------------------------------------------
' Purpose: 获取输入引脚连接的块索引
' History: 2019.12.01
'-----------------------------------------------------------------------------------------------------------
Private Function GetDlytimeInputIndex(iIndex As Integer)
    With ExcelInfo.HN_BOX(iIndex)
        GetDlytimeInputIndex = .ElementID_DT
    End With
End Function

'-----------------------------------------------------------------------------------------------------------
' Purpose: 获取输入引脚连接的块索引
' History: 2019.12.01
'-----------------------------------------------------------------------------------------------------------
Private Function GetNNInputIndex(iIndex As Integer, strPinName As String)
    With ExcelInfo.HN_BOX(iIndex)
        If strPinName = "R1" Then
            GetNNInputIndex = .ElementID_R1
        Else
            GetNNInputIndex = .ElementID_R2
        End If
    End With
End Function

'-----------------------------------------------------------------------------------------------------------
' Purpose: 获取输入引脚连接的块索引
' History: sw create function on 2019.9.25
'-----------------------------------------------------------------------------------------------------------
Private Function GetFLInputIndex(iIndex As Integer, strPinName As String)
    With ExcelInfo.HN_BOX(iIndex)
        If strPinName = "S1" Then
            GetFLInputIndex = .ElementID_S1
        ElseIf strPinName = "S2" Then
            GetFLInputIndex = .ElementID_S2
        ElseIf strPinName = "S3" Then
            GetFLInputIndex = .ElementID_S3
        ElseIf strPinName = "S4" Then
            GetFLInputIndex = .ElementID_S4
        Else
            GetFLInputIndex = 0
        End If
    End With
End Function

'-----------------------------------------------------------------------------------------------------------
' Purpose: 获取输入引脚连接的块索引
' History: sw create function on 2019.9.25
'-----------------------------------------------------------------------------------------------------------
Private Function GetInputIndex(strIndexName As String)
    Dim nIndex As Integer
    
    If strIndexName Like "L*" Then
        nIndex = CInt(Right(strIndexName, Len(strIndexName) - 1))
        GetInputIndex = ExcelInfo.HN_INPUT(nIndex).ElementID
    ElseIf strIndexName Like "SO*" Then
        nIndex = CInt(Right(strIndexName, Len(strIndexName) - 2))
        GetInputIndex = ExcelInfo.HN_BOX(nIndex).ElementID
    Else
        GetInputIndex = 0
    End If
End Function

'-----------------------------------------------------------------------------------------------------------
' Purpose: 转换置反
' History: sw create function on 2019.9.25
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
' History: sw create function on 2019.9.25
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
' History: sw create function on 2019.9.25
'
'-----------------------------------------------------------------------------------------------------------
Private Function ConvertNANDPinName(strPinName As String)
    ConvertNANDPinName = strPinName
End Function

'-----------------------------------------------------------------------------------------------------------
' Purpose: 转换NOR引脚名称
' History: sw create function on 2019.9.25
'
'-----------------------------------------------------------------------------------------------------------
Private Function ConvertNORPinName(strPinName As String)
    ConvertNORPinName = strPinName
End Function

'-----------------------------------------------------------------------------------------------------------
' Purpose: 转换QOR2引脚名称
' History: sw create function on 2019.9.25
'
'-----------------------------------------------------------------------------------------------------------
Private Function ConvertQOR2PinName(strPinName As String)
    ConvertQOR2PinName = strPinName
End Function

'-----------------------------------------------------------------------------------------------------------
' Purpose: 转换QOR3引脚名称
' History: sw create function on 2019.9.25
'
'-----------------------------------------------------------------------------------------------------------
Private Function ConvertQOR3PinName(strPinName As String)
    ConvertQOR3PinName = strPinName
End Function

'-----------------------------------------------------------------------------------------------------------
' Purpose: 转换 PULSE 引脚名称
' History: sw create function on 2019.9.25
'
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
' History: sw create function on 2019.9.25
'
'-----------------------------------------------------------------------------------------------------------
Private Function ConvertMINPULSEPinName(strPinName As String)
    If strPinName = "S1" Then
        ConvertMINPULSEPinName = strPinName
    Else
        ConvertMINPULSEPinName = "DLYTIME"
    End If
End Function

' Purpose: 转换 MAXPULSE 引脚名称
' History: sw create function on 2019.9.25
'
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
' History: sw create function on 2019.9.25
'
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
' History: sw create function on 2019.9.25
'
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
' History: sw create function on 2019.9.25
'
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
    Dim YPos_Min As Integer, YPos_Max As Integer, YPos_Temp As Integer
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
    Dim YPos_Min As Integer, YPos_Max As Integer, YPos_Temp As Integer
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
    
    If newLISRC <> "--.--" Then
        newLISRC = Replace(newLISRC, ".PVFL", ".DV")
        newLISRC = Replace(newLISRC, ".SO", ".DI")
        newLISRC = Replace(newLISRC, ".PVLOFL", ".ALIND")
        newLISRC = Replace(newLISRC, ".PVLLFL", ".LLIND")
        newLISRC = Replace(newLISRC, ".PVHIFL", ".AHIND")
        newLISRC = Replace(newLISRC, ".PVHHFL", ".HHIND")
        If newLISRC Like "*.FL(*)" Or newLISRC Like "*.NN(*)" Then
            newLISRC = Replace(newLISRC, ".", "_")
            newLISRC = Replace(newLISRC, "(", "")
            newLISRC = Replace(newLISRC, ")", "")
        End If
    End If
    
    ReplaceLISRCSuffix = newLISRC
End Function

'-----------------------------------------------------------------------------------------------------------
' Purpose: LODSTN替换后缀
' Remark: 目前替换的项和LISRC一致，若不一致需要更新
'-----------------------------------------------------------------------------------------------------------
Private Function ReplaceLODSTNSuffix(LODSTN As String)
    ReplaceLODSTNSuffix = ReplaceLISRCSuffix(LODSTN)
End Function
