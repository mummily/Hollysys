Attribute VB_Name = "I15_ConvertUREGPVLoop_VDTLDLAG_"
'ver20191010_by cjt

'转化VDTLDLAG
Sub I15_ConvertUREGPVLoop_VDTLDLAG()

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
Dim P1_ID As Long               'P1id号变量
Dim TD_ID As Long               'TDid号变量

Dim PVCALC_ID As Long              'PVCALCid号变量


'位号
Dim Blok_Tag As String            '块位号
'Dim MAN_Tag As String             'MAN位号变量
'Dim CAS_Tag As String             'CAS位号变量
Dim P1_Tag As String              'P1位号变量
Dim TD_Tag As String              'TD位号变量

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
Blok_ID = Element_ID         '块id号
'MAN_ID = Element_ID + 1    'MANid号
'CAS_ID = Element_ID + 2    'CASid号
P1_ID = Element_ID + 1       'P1id号
TD_ID = Element_ID + 2       'TDid号

PVCALC_ID = Element_ID + 3   'PVCALCid号




'03---------位号tag获取
'03-01--块位号赋值
Blok_Tag = UREGPV_arr(UREGPV_i, UREGPV("NAME")) & "_LAG"

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
'TD
TD_Tag = UREGPV_arr(UREGPV_i, UREGPV("TD"))
'-输出赋值：先转换再赋值
'PVCALC
PVCALC_Tag = UREGPV_arr(UREGPV_i, UREGPV("NAME")) & ".AI"


'04---------写xml

'04-01--块开始
'写块XML:'位号,ID,坐标X,坐标Y,数据流,块名
Call BOX_XML(Blok_Tag, Blok_ID, Element_X, Element_Y, Sort_ID, "VDTLDLAG")
'-块输入引脚:写块输入引脚XML: 块引脚项名,块引脚连接的位号,块引脚连接的位号ID,是否显示引脚
'Call BoxIn_XML("MAN", MAN_Tag, MAN_ID, "true")
'Call BoxIn_XML("CAS", CAS_Tag, CAS_ID, "true")
Call BoxIn_XML("P1", P1_Tag, P1_ID, "true")
Call BoxIn_XML("TD", TD_Tag, TD_ID, "true")

'-块输出引脚:写块输出引脚XML: 块引脚项名,是否显示引脚
Call BoxOut_XML("PVCALC", "true")

'--块结束
POU.WriteLine "</element>"

'04-02--输入元件:写输入元件XML: 位号,ID号,坐标X,坐标Y
'Call Input_XML(MAN_Tag, MAN_ID, Element_X - 2, Element_Y + 1)
'Call Input_XML(CAS_Tag, CAS_ID, Element_X - 2, Element_Y + 2)
Call Input_XML(P1_Tag, P1_ID, Element_X - 2, Element_Y + 1)
Call Input_XML(TD_Tag, TD_ID, Element_X - 2, Element_Y + 2)


'04-03--输出元件:写输出元件XML:'位号,ID,坐标X,坐标Y,数据流,连接的块ID,连接的块输出引脚序号
Call Output_XML(PVCALC_Tag, PVCALC_ID, Element_X + 12, Element_Y + 1, Sort_ID + 1, Blok_ID, 0)


End Sub

