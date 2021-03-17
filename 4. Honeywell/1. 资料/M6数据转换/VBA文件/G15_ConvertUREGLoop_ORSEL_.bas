Attribute VB_Name = "G15_ConvertUREGLoop_ORSEL_"
'ver20190821_by cjt

'转化SWITCH
Sub G15_ConvertUREGLoop_ORSEL()

'局部变量
'*****************************************************
'通用
Dim i As Integer '循环变量
Dim Element_NO As Long      '元件号号
Dim Element_X As Long       '元件X坐标
Dim Element_Y As Long       '元件Y坐标
Dim Element_ID As Long      '元件id号变量
Dim B_ID As Long            '块id号变量
Dim Sort_ID As Long         'Sid数据流存贮号

'id号
Dim Blok_ID As Long            '块id号变量
'Dim MAN_ID As Long             'MANid号变量
'Dim CAS_ID As Long             'CASid号变量
Dim X1_ID As Long              'X1id号变量
Dim X2_ID As Long              'X2id号变量
Dim X3_ID As Long              'X3id号变量
Dim X4_ID As Long              'X4id号变量
Dim P1_ID As Long              'P1id号变量
Dim P2_ID As Long              'P2id号变量
Dim P3_ID As Long              'P3id号变量
Dim P4_ID As Long              'P4id号变量
Dim CV_ID As Long              'CVid号变量
Dim OPEU_ID As Long            'OPEUid号变量

'位号
Dim Blok_Tag As String            '块位号
'Dim MAN_Tag As String             'MAN位号变量
'Dim CAS_Tag As String             'CAS位号变量
Dim X1_Tag As String              'X1位号变量
Dim X2_Tag As String              'X2位号变量
Dim X3_Tag As String              'X3位号变量
Dim X4_Tag As String              'X4位号变量
Dim P1_Tag As String              'P1位号变量
Dim P2_Tag As String              'P2位号变量
Dim P3_Tag As String              'P3位号变量
Dim P4_Tag As String              'P4位号变量
Dim CV_Tag As String               'CV位号变量
Dim OPEU_Tag As String            'OPEU位号变量
'CISRC字典
Dim CISRC As Object '输入位号字典

'*****************************************************


'01---------通用赋值
'初始值
Element_ID = 1         'id号
Sort_ID = 0            'Sid数据流存贮号变量
'块坐标
Element_X = 34         '方案页第一个块X坐标
Element_Y = 15         '方案页第一个块Y坐标


'02---------各种元件id号
'pid用
'获取ID\ID自加
Blok_ID = Element_ID      '块id号
MAN_ID = Element_ID + 1    'MANid号
CAS_ID = Element_ID + 2    'CASid号
X1_ID = Element_ID + 3     'X1id号
X2_ID = Element_ID + 4     'X2id号
X3_ID = Element_ID + 5     'X3id号
X4_ID = Element_ID + 6     'X4id号
P1_ID = Element_ID + 7     'S1id号
P2_ID = Element_ID + 8     'S2id号
P3_ID = Element_ID + 9    'S3id号
P4_ID = Element_ID + 10     'S4id号
CV_ID = Element_ID + 12     '块CVid号
OPEU_ID = Element_ID + 13     'OPid号



'03---------位号tag获取
'03-01--块位号赋值
Blok_Tag = UREGC_arr(UREGC_i, UREGC("NAME"))

'03-02--输入变量字典
Set CISRC = CreateObject("Scripting.Dictionary") 'CIDSTN字典
CISRC.RemoveAll
With CISRC
    For i = 1 To 4
      If Len(UREGC_arr(UREGC_i, UREGC("CIDSTN(" & i & ")"))) > 0 Then
         .Add UREGC_arr(UREGC_i, UREGC("CIDSTN(" & i & ")")), UREGC_arr(UREGC_i, UREGC("CISRC(" & i & ")")) '点名
      Else
         .Add "空白" & i, "" '点名
      End If
    Next
End With

'-输入赋值：先转换再赋值
''MAN
'If Len(UREGC_arr(UREGC_i, UREGC("CTLEQN"))) = "EQA" Then
'    MAN_Tag = "TRUE"
'Else
'    MAN_Tag = "FALSE"
'End If
''CAS
'If Len(UREGC_arr(UREGC_i, UREGC("CTLEQN"))) = "EQA" Then
'    CAS_Tag = "FALSE"
'Else
'    CAS_Tag = "TRUE"
'End If
'X1
If CISRC.Exists("X1") Then
    HNPN_TI = CISRC("X1") '赋值
    Call F2_ConvertPN_TI(HNPN_TI) '转换
    X1_Tag = M6PN_TI
Else
    X1_Tag = ""
End If
'X2
If CISRC.Exists("X2") Then
    HNPN_TI = CISRC("X2") '赋值
    Call F2_ConvertPN_TI(HNPN_TI) '转换
    X2_Tag = M6PN_TI
Else
    X2_Tag = ""
End If
'X3
If CISRC.Exists("X3") Then
    HNPN_TI = CISRC("X3") '赋值
    Call F2_ConvertPN_TI(HNPN_TI) '转换
    X3_Tag = M6PN_TI
Else
    X3_Tag = ""
End If
'X4
If CISRC.Exists("X4") Then
    HNPN_TI = CISRC("X4") '赋值
    Call F2_ConvertPN_TI(HNPN_TI) '转换
    X4_Tag = M6PN_TI
Else
    X4_Tag = ""
End If
''P1
'If UREGC1_arr(UREGC1Name(Blok_Tag), UREGC1("$MODESEL(1)")) = "ON" Then
'    S1_Tag = "TRUE"
'Else
'    S1_Tag = "FALSE"
'End If
''P2
'If UREGC1_arr(UREGC1Name(Blok_Tag), UREGC1("$MODESEL(2)")) = "ON" Then
'    S2_Tag = "TRUE"
'Else
'    S2_Tag = "FALSE"
'End If
''P3
'If UREGC1_arr(UREGC1Name(Blok_Tag), UREGC1("$MODESEL(3)")) = "ON" Then
'    S3_Tag = "TRUE"
'Else
'    S3_Tag = "FALSE"
'End If
''P4
'If UREGC1_arr(UREGC1Name(Blok_Tag), UREGC1("$MODESEL(4)")) = "ON" Then
'    S4_Tag = "TRUE"
'Else
'    S4_Tag = "FALSE"
'End If


'-输出赋值：先转换再赋值
'CV
If Len(UREGC_arr(UREGC_i, UREGC("CODSTN(1)"))) > 0 Then
    HNPN_TI = UREGC_arr(UREGC_i, UREGC("CODSTN(1)"))  '赋值
    Call F2_ConvertPN_TI(HNPN_TI) '转换
    CV_Tag = M6PN_TI
Else
    CV_Tag = ""
End If
'OPEU
If Len(UREGC_arr(UREGC_i, UREGC("CODSTN(2)"))) > 0 Then
    HNPN_TI = UREGC_arr(UREGC_i, UREGC("CODSTN(2)"))  '赋值
    Call F2_ConvertPN_TI(HNPN_TI) '转换
    OPEU_Tag = M6PN_TI
Else
    OPEU_Tag = ""
End If

'04---------写xml

'04-01--块开始
'写块XML:'位号,ID,坐标X,坐标Y,数据流,块名
Call BOX_XML(Blok_Tag, Blok_ID, Element_X, Element_Y, Sort_ID, "ORSEL")
'-块输入引脚:写块输入引脚XML: 块引脚项名,块引脚连接的位号,块引脚连接的位号ID,是否显示引脚
'Call BoxIn_XML("MAN", MAN_Tag, MAN_ID, "true")
'Call BoxIn_XML("CAS", CAS_Tag, CAS_ID, "true")
Call BoxIn_XML("X1", X1_Tag, X1_ID, "true")
Call BoxIn_XML("X2", X2_Tag, X2_ID, "true")
Call BoxIn_XML("X3", X3_Tag, X3_ID, "true")
Call BoxIn_XML("X4", X4_Tag, X4_ID, "true")
Call BoxIn_XML("P1", P1_Tag, P1_ID, "true")
Call BoxIn_XML("P2", P2_Tag, P2_ID, "true")
Call BoxIn_XML("P3", P3_Tag, P3_ID, "true")
Call BoxIn_XML("P4", P4_Tag, P4_ID, "true")

'-块输出引脚:写块输出引脚XML: 块引脚项名,是否显示引脚
Call BoxOut_XML("CV", "true")

'--块结束
POU.WriteLine "</element>"

'04-02--输入元件:写输入元件XML: 位号,ID号,坐标X,坐标Y
'Call Input_XML(MAN_Tag, MAN_ID, Element_X - 2, Element_Y + 1)
'Call Input_XML(CAS_Tag, CAS_ID, Element_X - 2, Element_Y + 2)
Call Input_XML(X1_Tag, X1_ID, Element_X - 2, Element_Y + 5)
Call Input_XML(X2_Tag, X2_ID, Element_X - 2, Element_Y + 6)
Call Input_XML(X3_Tag, X3_ID, Element_X - 2, Element_Y + 7)
Call Input_XML(X4_Tag, X4_ID, Element_X - 2, Element_Y + 8)
Call Input_XML(P1_Tag, P1_ID, Element_X - 2, Element_Y + 1)
Call Input_XML(P2_Tag, P2_ID, Element_X - 2, Element_Y + 2)
Call Input_XML(P3_Tag, P3_ID, Element_X - 2, Element_Y + 3)
Call Input_XML(P4_Tag, P4_ID, Element_X - 2, Element_Y + 4)

'04-03--输出元件:写输出元件XML:'位号,ID,坐标X,坐标Y,数据流,连接的块ID,连接的块输出引脚序号
Call Output_XML(CV_Tag, CV_ID, Element_X + 12, Element_Y + 3, Sort_ID + 1, Blok_ID, 2)
Call Output_XML(OPEU_Tag, OPEU_ID, Element_X + 12, Element_Y + 4, Sort_ID + 2, Blok_ID, 2)

End Sub
