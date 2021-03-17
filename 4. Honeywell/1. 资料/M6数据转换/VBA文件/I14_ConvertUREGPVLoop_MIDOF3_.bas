Attribute VB_Name = "I14_ConvertUREGPVLoop_MIDOF3_"
'ver20191010_by cjt

'转化MIDOF3
Sub I14_ConvertUREGPVLoop_MIDOF3()

'局部变量
'*****************************************************
'通用
Dim i As Integer '循环变量
Dim Element_NO As Long      '元件号号
Dim Element_X As Long       '元件X坐标
Dim Element_Y As Long       '元件Y坐标
Dim Element_ID As Long      '元件id号变量
Dim Sort_ID As Long         'Sid数据流存贮号

'id号
Dim Blok_ID As Long            '块id号变量
'Dim MAN_ID As Long             'MANid号变量
'Dim CAS_ID As Long             'CASid号变量
Dim P1_ID As Long              'P1id号变量
Dim P2_ID As Long              'P2id号变量
Dim P3_ID As Long              'P3id号变量

Dim P1STS_ID As Long           'P1STSid号变量
Dim P2STS_ID As Long           'P2STSid号变量
Dim P3STS_ID As Long           'P3STSid号变量


Dim PVCALC_ID As Long          'PVCALCid号变量


'位号
Dim Blok_Tag As String            '块位号
'Dim MAN_Tag As String             'MAN位号变量
'Dim CAS_Tag As String             'CAS位号变量
Dim P1_Tag As String              'P1位号变量
Dim P2_Tag As String              'P2位号变量
Dim P3_Tag As String              'P3位号变量

Dim P1STS_Tag As String              'P1STS位号变量
Dim P2STS_Tag As String              'P2STS位号变量
Dim P3STS_Tag As String              'P3STS位号变量

Dim PVCALC_Tag As String          'PVCALC位号变量

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
P1_ID = Element_ID + 1     'P1id号
P1STS_ID = Element_ID + 2  'P1STSid号
P2_ID = Element_ID + 3     'P2id号
P2STS_ID = Element_ID + 4  'P2STSid号
P3_ID = Element_ID + 5     'P3id号
P3STS_ID = Element_ID + 6  'P3STSid号

PVCALC_ID = Element_ID + 7     '块CVid号



'03---------位号tag获取
'03-01--块位号赋值
Blok_Tag = UREGPV_arr(UREGPV_i, UREGPV("NAME")) & "_OF3"

'-输入赋值：先转换再赋值
''MAN
'If Len(UREGPV_arr(UREGPV_i, UREGPV("PVSRCOPT"))) <> "ONLYAUTO" Then
'    MAN_Tag = "TRUE"
'Else
'    MAN_Tag = "FALSE"
'End If
''CAS
'If Len(UREGPV_arr(UREGPV_i, UREGPV("PVSRCOPT"))) = "ONLYAUTO" Then
'    CAS_Tag = "FALSE"
'Else
'    CAS_Tag = "TRUE"
'End If
'P1
HNPN_TI = UREGPV_arr(UREGPV_i, UREGPV("PISRC(1)")) '待转换变量
If Len(HNPN_TI) > 0 Then
    Call F2_ConvertPN_TI(HNPN_TI) '转换
    P1_Tag = M6PN_TI '赋值
Else
    P1_Tag = "" '赋值
End If
If NameType(HNPN) = "UAI" Then
    P1STS_Tag = Replace(P1_Tag, ".AV", ".Q")
Else
    P1STS_Tag = ""
End If
'P2
HNPN_TI = UREGPV_arr(UREGPV_i, UREGPV("PISRC(2)")) '待转换变量
If Len(HNPN_TI) > 0 Then
    Call F2_ConvertPN_TI(HNPN_TI) '转换
    P2_Tag = M6PN_TI '赋值
Else
    P2_Tag = "" '赋值
End If
If NameType(HNPN) = "UAI" Then
    P2STS_Tag = Replace(P2_Tag, ".AV", ".Q")
Else
    P2STS_Tag = ""
End If
'P3
HNPN_TI = UREGPV_arr(UREGPV_i, UREGPV("PISRC(3)")) '待转换变量
If Len(HNPN_TI) > 0 Then
    Call F2_ConvertPN_TI(HNPN_TI) '转换
    P3_Tag = M6PN_TI '赋值
Else
    P3_Tag = "" '赋值
End If
If NameType(HNPN) = "UAI" Then
    P3STS_Tag = Replace(P3_Tag, ".AV", ".Q")
Else
    P3STS_Tag = ""
End If
'P4
HNPN_TI = UREGPV_arr(UREGPV_i, UREGPV("PISRC(4)")) '待转换变量
If Len(HNPN_TI) > 0 Then
    Call F2_ConvertPN_TI(HNPN_TI) '转换
    P4_Tag = M6PN_TI '赋值
Else
    P4_Tag = "" '赋值
End If
If NameType(HNPN) = "UAI" Then
    P4STS_Tag = Replace(P4_Tag, ".AV", ".Q")
Else
    P4STS_Tag = ""
End If
'P5
HNPN_TI = UREGPV_arr(UREGPV_i, UREGPV("PISRC(5)")) '待转换变量
If Len(HNPN_TI) > 0 Then
    Call F2_ConvertPN_TI(HNPN_TI) '转换
    P5_Tag = M6PN_TI '赋值
Else
    P5_Tag = "" '赋值
End If
If NameType(HNPN) = "UAI" Then
    P5STS_Tag = Replace(P5_Tag, ".AV", ".Q")
Else
    P5STS_Tag = ""
End If
'P6
HNPN_TI = UREGPV_arr(UREGPV_i, UREGPV("PISRC(6)")) '待转换变量
If Len(HNPN_TI) > 0 Then
    Call F2_ConvertPN_TI(HNPN_TI) '转换
    P6_Tag = M6PN_TI '赋值
Else
    P6_Tag = "" '赋值
End If
If NameType(HNPN) = "UAI" Then
    P6STS_Tag = Replace(P6_Tag, ".AV", ".Q")
Else
    P6STS_Tag = ""
End If

'-输出赋值：先转换再赋值
'OP
PVCALC_Tag = UREGPV_arr(UREGPV_i, UREGPV("NAME")) & ".AI"

'04---------写xml

'04-01--块开始
'写块XML:'位号,ID,坐标X,坐标Y,数据流,块名
Call BOX_XML(Blok_Tag, Blok_ID, Element_X, Element_Y, Sort_ID, "MIDOF3")
'-块输入引脚:写块输入引脚XML: 块引脚项名,块引脚连接的位号,块引脚连接的位号ID,是否显示引脚
'Call BoxIn_XML("MAN", MAN_Tag, MAN_ID, "true")
'Call BoxIn_XML("CAS", CAS_Tag, CAS_ID, "true")
Call BoxIn_XML("P1", P1_Tag, P1_ID, "true")
Call BoxIn_XML("P2", P2_Tag, P2_ID, "true")
Call BoxIn_XML("P3", P3_Tag, P3_ID, "true")

Call BoxIn_XML("P1STS", P1STS_Tag, P1STS_ID, "true")
Call BoxIn_XML("P2STS", P2STS_Tag, P2STS_ID, "true")
Call BoxIn_XML("P3STS", P3STS_Tag, P3STS_ID, "true")


'-块输出引脚:写块输出引脚XML: 块引脚项名,是否显示引脚
Call BoxOut_XML("PVCALC", "true")

'--块结束
POU.WriteLine "</element>"

'04-02--输入元件:写输入元件XML: 位号,ID号,坐标X,坐标Y
'Call Input_XML(MAN_Tag, MAN_ID, Element_X - 2, Element_Y + 1)
'Call Input_XML(CAS_Tag, CAS_ID, Element_X - 2, Element_Y + 2)
Call Input_XML(P1_Tag, P1_ID, Element_X - 2, Element_Y + 1)
Call Input_XML(P1STS_Tag, P1STS_ID, Element_X - 2, Element_Y + 2)
Call Input_XML(P2_Tag, P2_ID, Element_X - 2, Element_Y + 3)
Call Input_XML(P2STS_Tag, P2STS_ID, Element_X - 2, Element_Y + 4)

Call Input_XML(P3_Tag, P3_ID, Element_X - 2, Element_Y + 5)
Call Input_XML(P3STS_Tag, P3STS_ID, Element_X - 2, Element_Y + 6)

'04-03--输出元件:写输出元件XML:'位号,ID,坐标X,坐标Y,数据流,连接的块ID,连接的块输出引脚序号
Call Output_XML(PVCALC_Tag, PVCALC_ID, Element_X + 12, Element_Y + 1, Sort_ID + 1, Blok_ID, 0)


End Sub
