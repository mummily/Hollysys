Attribute VB_Name = "G16_ConvertUREGLoop_MULDIV_"
'ver20190821_by cjt

'转化SWITCH
Sub G16_ConvertUREGLoop_MULDIV()

'局部变量
'*****************************************************
'通用
Dim i As Integer '循环变量
Dim Element_NO As Long      '元件号号
Dim Element_X As Long       '元件X坐标
Dim Element_Y As Long       '元件Y坐标
Dim Element_ID As Long      '元件id号变量
Dim Sort_ID As Long         'Sid数据流存贮号
Dim Binputstr1 As String, Binputstr2 As String, Binputstr3 As String, outputstr1 As String, outputstr2 As String '块输入输出引脚字符串



'id号
Dim Blok_ID As Long            '块id号变量
'Dim MAN_ID As Long             'MANid号变量
'Dim CAS_ID As Long             'CASid号变量
Dim X1_ID As Long              'X1id号变量
Dim X2_ID As Long              'X2id号变量
Dim X3_ID As Long              'X3id号变量
'Dim X4_ID As Long              'X4id号变量
'Dim B_ID As Long               'Bid号变量
'Dim B1_ID As Long              'B1id号变量
'Dim B2_ID As Long              'B2id号变量
'Dim B3_ID As Long              'B3id号变量
'Dim K_ID As Long               'Kid号变量
'Dim K1_ID As Long              'K1id号变量
'Dim K2_ID As Long              'K2id号变量
'Dim K3_ID As Long              'K3id号变量
'Dim K4_ID As Long              'K4id号变量
'Dim EQU_ID As Long             'EUQid号变量
Dim CV_ID As Long               'CVid号变量
Dim OPEU_ID As Long              'OPid号变量

'位号
Dim Blok_Tag As String            '块位号
'Dim MAN_Tag As String             'MAN位号变量
'Dim CAS_Tag As String             'CAS位号变量
Dim X1_Tag As String              'X1位号变量
Dim X2_Tag As String              'X2位号变量
Dim X3_Tag As String              'X3位号变量
'Dim X4_Tag As String              'X4位号变量
'Dim B_Tag As String               'B位号变量
'Dim B1_Tag As String              'B1位号变量
'Dim B2_Tag As String              'B2位号变量
'Dim B3_Tag As String              'B3位号变量
'Dim K_Tag As String               'K位号变量
'Dim K1_Tag As String              'K1位号变量
'Dim K2_Tag As String              'K2位号变量
'Dim K3_Tag As String              'K3位号变量
'Dim K4_Tag As String              'K4位号变量
'Dim EQU_Tag As String             'EUQ位号变量
Dim CV_Tag As String               'CV位号变量
Dim OPEU_Tag As String             'OPEU位号变量
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
'MAN_ID = Element_ID + 1    'MANid号
'CAS_ID = Element_ID + 2    'CASid号
X1_ID = Element_ID + 1     'X1id号
X2_ID = Element_ID + 2     'X2id号
X3_ID = Element_ID + 3     'X3id号
X4_ID = Element_ID + 4     'X4id号
'B_ID = Element_ID + 7      'Bid号
'B1_ID = Element_ID + 8     'B1id号
'B2_ID = Element_ID + 9     'B2id号
'B3_ID = Element_ID + 10    'B3id号
'K_ID = Element_ID + 11      'Kid号
'K1_ID = Element_ID + 12     'K1id号
'K2_ID = Element_ID + 13     'K2id号
'K3_ID = Element_ID + 14    'K3id号
'K4_ID = Element_ID + 15    'K4id号
'EQU_ID = Element_ID + 16    'EQUid号
CV_ID = Element_ID + 5     'OPid号
OPEU_ID = Element_ID + 6    'OPEUid号



'03---------位号tag获取
'03-01--块位号赋值
Blok_Tag = UREGC_arr(UREGC_i, UREGC("NAME"))

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
HNPN_TI = UREGC_arr(UREGC_i, UREGC("CISRC(1)")) '赋值
Call F2_ConvertPN_TI(HNPN_TI) '转换
X1_Tag = M6PN_TI
'X2
HNPN_TI = UREGC_arr(UREGC_i, UREGC("CISRC(2)")) '赋值
Call F2_ConvertPN_TI(HNPN_TI) '转换
X2_Tag = M6PN_TI
'X3
HNPN_TI = UREGC_arr(UREGC_i, UREGC("CISRC(3)")) '赋值
Call F2_ConvertPN_TI(HNPN_TI) '转换
X3_Tag = M6PN_TI
''X4
'HNPN_TI = UREGC_arr(UREGC_i, UREGC("CISRC(4)")) '赋值
'Call F2_ConvertPN_TI(HNPN_TI) '转换
'X4_Tag = M6PN_TI
''B
'HNPN_TI = UREGC_arr(UREGC_i, UREGC("B")) '赋值
'Call F2_ConvertPN_TI(HNPN_TI) '转换
'B_Tag = M6PN_TI
''B1
'HNPN_TI = UREGC_arr(UREGC_i, UREGC("B1")) '赋值
'Call F2_ConvertPN_TI(HNPN_TI) '转换
'B1_Tag = M6PN_TI
''B2
'HNPN_TI = UREGC_arr(UREGC_i, UREGC("B2")) '赋值
'Call F2_ConvertPN_TI(HNPN_TI) '转换
'B2_Tag = M6PN_TI
''B3
'HNPN_TI = UREGC_arr(UREGC_i, UREGC("B3")) '赋值
'Call F2_ConvertPN_TI(HNPN_TI) '转换
'B3_Tag = M6PN_TI
''K
'HNPN_TI = UREGC_arr(UREGC_i, UREGC("K")) '赋值
'Call F2_ConvertPN_TI(HNPN_TI) '转换
'K_Tag = M6PN_TI
''K1
'HNPN_TI = UREGC_arr(UREGC_i, UREGC("K1")) '赋值
'Call F2_ConvertPN_TI(HNPN_TI) '转换
'K1_Tag = M6PN_TI
''K2
'HNPN_TI = UREGC_arr(UREGC_i, UREGC("K2")) '赋值
'Call F2_ConvertPN_TI(HNPN_TI) '转换
'K2_Tag = M6PN_TI
''K3
'HNPN_TI = UREGC_arr(UREGC_i, UREGC("K3")) '赋值
'Call F2_ConvertPN_TI(HNPN_TI) '转换
'K3_Tag = M6PN_TI
''K4
'HNPN_TI = UREGC_arr(UREGC_i, UREGC("K4")) '赋值
'Call F2_ConvertPN_TI(HNPN_TI) '转换
'K4_Tag = M6PN_TI
''EQU
'If UREGC_arr(UREGC_i, UREGC("CTLEQN")) = "" Then
'    EQU_Tag = "0"
'End If
'If UREGC_arr(UREGC_i, UREGC("CTLEQN")) = "EQA" Then
'    EQU_Tag = "1"
'End If
'If UREGC_arr(UREGC_i, UREGC("CTLEQN")) = "EQB" Then
'    EQU_Tag = "2"
'End If
'-输出赋值：先转换再赋值
'CV
If Len(UREGC_arr(UREGC_i, UREGC("CODSTN(1)"))) > 0 Then
    HNPN_TI = UREGC_arr(UREGC_i, UREGC("CODSTN(1)"))  '赋值
    Call F2_ConvertPN_TI(HNPN_TI) '转换
    CV_Tag = M6PN_TI
Else
    OP_Tag = ""
End If
'OP
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
Call BOX_XML(Blok_Tag, Blok_ID, Element_X, Element_Y, Sort_ID, "MULDIV")
'-块输入引脚:写块输入引脚XML: 块引脚项名,块引脚连接的位号,块引脚连接的位号ID,是否显示引脚
'Call BoxIn_XML("MAN", MAN_Tag, MAN_ID, "true")
'Call BoxIn_XML("CAS", CAS_Tag, CAS_ID, "true")
Call BoxIn_XML("X1", X1_Tag, X1_ID, "true")
Call BoxIn_XML("X2", X2_Tag, X2_ID, "true")
Call BoxIn_XML("X3", X3_Tag, X3_ID, "true")
'Call BoxIn_XML("X4", X4_Tag, X4_ID, "true")
'Call BoxIn_XML("B", B_Tag, B_ID, "true")
'Call BoxIn_XML("B1", B1_Tag, B1_ID, "true")
'Call BoxIn_XML("B2", B2_Tag, B2_ID, "true")
'Call BoxIn_XML("B3", B3_Tag, B3_ID, "true")
'Call BoxIn_XML("K", K_Tag, K_ID, "true")
'Call BoxIn_XML("K1", K1_Tag, K1_ID, "true")
'Call BoxIn_XML("K2", K2_Tag, K2_ID, "true")
'Call BoxIn_XML("K3", K3_Tag, K3_ID, "true")
'Call BoxIn_XML("K4", K4_Tag, K4_ID, "true")
'Call BoxIn_XML("EQU", EQU_Tag, EQU_ID, "true")
'-块输出引脚:写块输出引脚XML: 块引脚项名,是否显示引脚
Call BoxOut_XML("CV", "true")
'Call BoxOut_XML("OPEU", "true")
'--块结束
POU.WriteLine "</element>"

'04-02--输入元件:写输入元件XML: 位号,ID号,坐标X,坐标Y
'Call Input_XML(MAN_Tag, MAN_ID, Element_X - 2, Element_Y + 1)
'Call Input_XML(CAS_Tag, CAS_ID, Element_X - 2, Element_Y + 2)
Call Input_XML(X1_Tag, X1_ID, Element_X - 2, Element_Y + 1)
Call Input_XML(X2_Tag, X2_ID, Element_X - 2, Element_Y + 2)
Call Input_XML(X3_Tag, X3_ID, Element_X - 2, Element_Y + 3)
'Call Input_XML(X4_Tag, X4_ID, Element_X - 2, Element_Y + 6)
'Call Input_XML(B_Tag, B_ID, Element_X - 2, Element_Y + 7)
'Call Input_XML(B1_Tag, B1_ID, Element_X - 2, Element_Y + 8)
'Call Input_XML(B2_Tag, B2_ID, Element_X - 2, Element_Y + 9)
'Call Input_XML(B3_Tag, B3_ID, Element_X - 2, Element_Y + 10)
'Call Input_XML(K_Tag, K_ID, Element_X - 2, Element_Y + 11)
'Call Input_XML(K1_Tag, K1_ID, Element_X - 2, Element_Y + 12)
'Call Input_XML(K2_Tag, K2_ID, Element_X - 2, Element_Y + 13)
'Call Input_XML(K3_Tag, K3_ID, Element_X - 2, Element_Y + 14)
'Call Input_XML(K4_Tag, K4_ID, Element_X - 2, Element_Y + 15)
'Call Input_XML(EQU_Tag, EQU_ID, Element_X - 2, Element_Y + 16)

'04-03--输出元件:写输出元件XML:'位号,ID,坐标X,坐标Y,数据流,连接的块ID,连接的块输出引脚序号
Call Output_XML(CV_Tag, CV_ID, Element_X + 12, Element_Y + 2, Sort_ID + 1, Blok_ID, 1)
Call Output_XML(OPEU_Tag, OPEU_ID, Element_X + 12, Element_Y + 3, Sort_ID + 2, Blok_ID, 1)


End Sub
