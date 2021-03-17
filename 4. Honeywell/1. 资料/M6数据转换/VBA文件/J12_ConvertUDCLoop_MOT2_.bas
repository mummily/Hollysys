Attribute VB_Name = "J12_ConvertUDCLoop_MOT2_"
'ver20190930_by cjt

'转化MOT2
Sub J12_ConvertUDCLoop_MOT2()

'局部变量
'*****************************************************
'通用
Dim i As Integer '循环变量
Dim Element_NO As Long      '元件号号
Dim Element_X As Long       '元件X坐标
Dim Element_Y As Long       '元件Y坐标
Dim Element_ID As Long      '元件id号变量
Dim Sort_ID As Long         'Sid数据流存贮号

'pid用
Dim Blok_ID As Long               '块id号变量
Dim FBKON_ID As Long              'FBKONid号变量
Dim FBKOF_ID As Long              'FBKOFid号变量
Dim OUTON_ID As Long              'OUTONid号变量
Dim OUTOF_ID As Long              'OUTOFid号变量
Dim OUT_ID As Long                'OUTid号变量

Dim Blok_Tag As String       '块位号
Dim FBKON_Tag As String     'FBKON位号
Dim FBKOF_Tag As String     'FBKOF位号

Dim OUTON_Tag As String     'OUTON位号
Dim OUTOF_Tag As String     'OUTOF位号
Dim OUT_Tag As String        'OUT位号
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
Blok_ID = Element_ID            '块id号
FBKON_ID = Element_ID + 1       'FBKONid号
FBKOF_ID = Element_ID + 2       'FBKOFid号
OUTON_ID = Element_ID + 3        'OUTONid号
OUTOF_ID = Element_ID + 4        'OUTOFid号
OUT_ID = Element_ID + 5          'OUTid号
'03---------位号tag获取
'块位号赋值
Blok_Tag = UDC_arr(UDC_i, UDC("NAME"))

'变量赋值：先转换再赋值
HNPN_TI = UDC_arr(UDC_i, UDC("DISRC(1)")) '待转换变量
Call F2_ConvertPN_TI(HNPN_TI) '转换
FBKON_Tag = M6PN_TI '赋值
HNPN_TI = UDC_arr(UDC_i, UDC("DISRC(2)")) '待转换变量
Call F2_ConvertPN_TI(HNPN_TI) '转换
FBKOF_Tag = M6PN_TI '赋值

If Len(UDC_arr(UDC_i, UDC("DODSTN(1)"))) > 0 And Len(UDC_arr(UDC_i, UDC("DODSTN(2)"))) > 0 Then
    HNPN_TI = UDC_arr(UDC_i, UDC("DODSTN(1)")) '待转换变量
    Call F2_ConvertPN_TI(HNPN_TI) '转换
    OUTON_Tag = M6PN_TI '赋值
    
    HNPN_TI = UDC_arr(UDC_i, UDC("DODSTN(2)")) '待转换变量
    Call F2_ConvertPN_TI(HNPN_TI) '转换
    OUTOF_Tag = M6PN_TI '赋值
Else
    HNPN_TI = UDC_arr(UDC_i, UDC("DODSTN(1)")) '待转换变量
    Call F2_ConvertPN_TI(HNPN_TI) '转换
    OUT_Tag = M6PN_TI '赋值
End If
'04---------写xml
'写块XML:'位号,ID,坐标X,坐标Y,数据流,块名
Call BOX_XML(Blok_Tag, Blok_ID, Element_X, Element_Y, Sort_ID, "MOT2")
'-块输入引脚:写块输入引脚XML: 块引脚项名,块引脚连接的位号,块引脚连接的位号ID,是否显示引脚
Call BoxIn_XML("INON", "", 0, "true")
Call BoxIn_XML("INOF", "", 0, "true")

If Len(FBKON_Tag) > 0 And Len(FBKOF_Tag) > 0 Then '双反馈
    Call BoxIn_XML("FBKON", FBKON_Tag, FBKON_ID, "true") '开反馈
    Call BoxIn_XML("FBKOF", FBKOF_Tag, FBKOF_ID, "true") '关反馈
End If

If Len(FBKOF_Tag) = 0 Then '单反馈
    If UDC_arr(UDC_i, UDC("D1_1")) = "PVSTATE0" Then
       '开取反
       Call BoxIn_XML2("FBKON", FBKON_Tag, FBKON_ID, 0, "true", "true")
       Call BoxIn_XML("FBKOF", FBKON_Tag, FBKON_ID, "true")
    Else
       '关取反
       Call BoxIn_XML("FBKON", FBKON_Tag, FBKON_ID, "true")
       Call BoxIn_XML2("FBKOF", FBKON_Tag, FBKON_ID, 0, "true", "true")
    
    End If
End If


Call BoxIn_XML("RMTOPT", "", 0, "true")
Call BoxIn_XML("ILSW", "", 0, "true")
Call BoxIn_XML("ILPUT", "", 0, "true")
Call BoxIn_XML("ILIN", "", 0, "true")
Call BoxIn_XML("INQ", "", 0, "true")
Call BoxIn_XML("FALOPT", "", 0, "true")
Call BoxIn_XML("ONEN", "", 0, "true")
Call BoxIn_XML("OFFEN", "", 0, "true")
Call BoxIn_XML("TRKFBK", "", 0, "true")
Call BoxIn_XML("FBKALG", "", 0, "true")
Call BoxIn_XML("FBKALGEN", "", 0, "true")
Call BoxIn_XML("FALTYPE", "", 0, "true")
Call BoxIn_XML("AUTOOPT", "", 0, "true")
Call BoxIn_XML("RST", "", 0, "true")
Call BoxIn_XML("RSTEN", "", 0, "true")
'-块输出引脚:写块输出引脚XML: 块引脚项名,是否显示引脚
Call BoxOut_XML("OUTON", "true")
Call BoxOut_XML("OUTOF", "true")
Call BoxOut_XML("OUT", "true")
'--块结束
POU.WriteLine "</element>"

'04-02--输入元件:写输入元件XML: 位号,ID号,坐标X,坐标Y
Call Input_XML(FBKON_Tag, FBKON_ID, Element_X - 2, Element_Y + 3)
Call Input_XML(FBKOF_Tag, FBKOF_ID, Element_X - 2, Element_Y + 4)
'04-03--输出元件:写输出元件XML:'位号,ID,坐标X,坐标Y,数据流,连接的块ID,连接的块输出引脚序号
If Not UDC_arr(UDC_i, UDC("DODSTN(1)")) Like "*PULSE*" Then '待转换变量

    If UDC_arr(UDC_i, UDC("ST0_OP1")) = "OFF" Then
        Call Output_XML2(OUTON_Tag, OUTON_ID, Element_X + 9, Element_Y + 3, Sort_ID + 1, Blok_ID, 2, "false")
        Call Output_XML2(OUT_Tag, OUT_ID, Element_X + 9, Element_Y + 3, Sort_ID + 1, Blok_ID, 2, "false")
    Else
        Call Output_XML2(OUTON_Tag, OUTON_ID, Element_X + 9, Element_Y + 3, Sort_ID + 1, Blok_ID, 2, "true")
        Call Output_XML2(OUT_Tag, OUT_ID, Element_X + 9, Element_Y + 3, Sort_ID + 1, Blok_ID, 2, "true")
    End If
    
    If UDC_arr(UDC_i, UDC("ST0_OP2")) = "OFF" Then
       Call Output_XML2(OUTOF_Tag, OUTOF_ID, Element_X + 9, Element_Y + 4, Sort_ID + 2, Blok_ID, 2, "false")
    Else
        Call Output_XML2(OUTOF_Tag, OUTOF_ID, Element_X + 9, Element_Y + 4, Sort_ID + 2, Blok_ID, 2, "true")
    End If
    
End If



End Sub
