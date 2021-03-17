Attribute VB_Name = "G11_ConvertUREGLoop_PID_"
'ver20190821_by cjt

'转化pid
Sub G11_ConvertUREGLoop_PID()

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
Dim Binputstr1 As String, Binputstr2 As String, Binputstr3 As String, outputstr1 As String, outputstr2 As String '块输入输出引脚字符串



'pid用
Dim Blok_ID As Long            '块id号变量
Dim PV_ID As Long              'PVid号变量
Dim Q_ID As Long               'Qid号变量
Dim OUT_ID As Long             'OUTid号变量
Dim PV_Q_ID As Long            'PVQid号变量

Dim SP_ID As Long              'SPid号变量
Dim OUT2_ID As Long            'OUT2id号变量


Dim Blok_Tag As String '块位号
Dim PV_Tag As String 'PV位号
Dim OUT_Tag As String 'OUT位号
Dim PV_Q_Tag As String 'PV_Q位号
Dim SP_Tag As String 'SP位号
Dim OUT2_Tag As String 'OUT2位号

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
PV_ID = Element_ID + 1    'PVid号
Q_ID = Element_ID + 2     'Qid号
OUT_ID = Element_ID + 3  'OUTid号
PV_Q_ID = Element_ID + 4 'PVQid号

SP_ID = Element_ID + 5 'SPid号
OUT2_ID = Element_ID + 6 'OUT2id号


'03---------位号tag获取
'块位号赋值
Blok_Tag = UREGC_arr(UREGC_i, UREGC("NAME"))


'变量赋值：先转换再赋值-PV
HNPN_TI = UREGC_arr(UREGC_i, UREGC("CISRC(1)")) '待转换变量
Call F2_ConvertPN_TI(HNPN_TI)     '转换
PV_Tag = M6PN_TI '赋值
PV_Q_Tag = Replace(PV_Tag, ".AV", ".Q")
'变量赋值：先转换再赋值-OUT
HNPN_TI = UREGC_arr(UREGC_i, UREGC("CODSTN(1)")) '待转换变量
Call F2_ConvertPN_TI(HNPN_TI) '转换
OUT_Tag = M6PN_TI '赋值

'变量赋值：先转换再赋值-SP
HNPN_TI = UREGC_arr(UREGC_i, UREGC("CISRC(2)")) '待转换变量
Call F2_ConvertPN_TI(HNPN_TI)     '转换
SP_Tag = M6PN_TI '赋值

'变量赋值：先转换再赋值-OUT2
HNPN_TI = UREGC_arr(UREGC_i, UREGC("CODSTN(2)")) '待转换变量
Call F2_ConvertPN_TI(HNPN_TI)     '转换
OUT2_Tag = M6PN_TI '赋值

'04---------写xml
'写块XML:'位号,ID,坐标X,坐标Y,数据流,块名
Call BOX_XML(Blok_Tag, Blok_ID, Element_X, Element_Y, Sort_ID, "PIDA")
'-块输入引脚:写块输入引脚XML: 块引脚项名,块引脚连接的位号,块引脚连接的位号ID,是否显示引脚
Call BoxIn_XML("PV", PV_Tag, PV_ID, "true")
Call BoxIn_XML("INCOMP", "", 0, "true")
Call BoxIn_XML("OUTCOMP", "", 0, "true")
Call BoxIn_XML("TRKVAL", "", 0, "true")
Call BoxIn_XML("TRKSW", "", 0, "true")
Call BoxIn_XML("PIDTYPE", "", 0, "true")
Call BoxIn_XML("AUXMODE", "", 0, "true")
Call BoxIn_XML("AUXOVE", "", 0, "true")
Call BoxIn_XML("TD", "", 0, "true")
If PV_Tag Like "*.AV*" Then
Call BoxIn_XML("Q", PV_Q_Tag, PV_Q_ID, "true")
Else
Call BoxIn_XML("Q", "", 0, "true")
End If
Call BoxIn_XML("ALMOPT", "", 0, "true")
Call BoxIn_XML("SP", SP_Tag, SP_ID, "true")
Call BoxIn_XML("CYC", "", 0, "true")
Call BoxIn_XML("KP", "", 0, "true")
Call BoxIn_XML("TI", "", 0, "true")
Call BoxIn_XML("KD", "", 0, "true")
Call BoxIn_XML("OUTU", "", 0, "true")
Call BoxIn_XML("OUTL", "", 0, "true")
'-块输出引脚:写块输出引脚XML: 块引脚项名,是否显示引脚
Call BoxOut_XML("OUT", "true")
Call BoxOut_XML("SP", "true")
Call BoxOut_XML("MODE", "false")
Call BoxOut_XML("KP", "false")
Call BoxOut_XML("TI", "false")
Call BoxOut_XML("KD", "false")
Call BoxOut_XML("OUTU", "false")
Call BoxOut_XML("OUTL", "false")
'--块结束
POU.WriteLine "</element>"

'04-02--输入元件:写输入元件XML: 位号,ID号,坐标X,坐标Y
'PV
Call Input_XML(PV_Tag, PV_ID, Element_X - 2, Element_Y + 1)
If PV_Tag Like "*.AV*" Then
Call Input_XML(PV_Q_Tag, PV_Q_ID, Element_X - 2, Element_Y + 10)
End If

'SP
Call Input_XML(SP_Tag, SP_ID, Element_X - 2, Element_Y + 12)


'04-03--输出元件:写输出元件XML:'位号,ID,坐标X,坐标Y,数据流,连接的块ID,连接的块输出引脚序号
'OUT
Call Output_XML(OUT_Tag, OUT_ID, Element_X + 7, Element_Y + 1, Sort_ID + 1, Blok_ID, 0)
Call Output_XML(OUT2_Tag, OUT2_ID, Element_X + 7, Element_Y + 2, Sort_ID + 2, Blok_ID, 0)


End Sub
