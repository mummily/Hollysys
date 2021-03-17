Attribute VB_Name = "G112_ConvertUREGLoop_PID_"
'ver20190821_by cjt

'转化主副pid
Sub G112_ConvertUREGLoop_PID()

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



'pid用主调
Dim Blok_ID As Long            '块id号变量
Dim PV_ID As Long              'PVid号变量
Dim Q_ID As Long               'Qid号变量
Dim OUT_ID As Long             'OUTid号变量
Dim PV_Q_ID As Long            'PVQid号变量


Dim Blok_Tag As String '块位号
Dim PV_Tag As String 'PV位号
Dim OUT_Tag As String 'OUT位号
Dim PV_Q_Tag As String 'PV_Q位号
'pid用副调
Dim Blok_ID2 As Long            '块id号变量
Dim PV_ID2 As Long              'PVid号变量
Dim Q_ID2 As Long               'Qid号变量
Dim OUT_ID2 As Long             'OUTid号变量
Dim PV_Q_ID2 As Long            'PVQid2号变量

Dim Blok_Tag2 As String '块位号
Dim PV_Tag2 As String 'PV位号
Dim OUT_Tag2 As String 'OUT位号
Dim PV_Q_Tag2 As String 'PV_Q2位号

'pid用主调
Dim SP_Tag As String 'SP位号
Dim OUT2_Tag As String 'OUT2位号

'pid用副调
Dim SP_Tag2 As String 'SP位号
Dim OUT2_Tag2 As String 'OUT2位号

'pid用主调
Dim SP_ID As Long              'SPid号变量
Dim OUT2_ID As Long            'OUT2id号变量

'pid用副调
Dim SP_ID2 As Long              'SPid号变量
Dim OUT2_ID2 As Long            'OUT2id号变量
'*****************************************************


'01---------通用赋值
'初始值
Element_ID = 1         'id号
Sort_ID = 0            'Sid数据流存贮号变量
'块坐标
Element_X = 24         '方案页第一个块X坐标
Element_Y = 15         '方案页第一个块Y坐标

'02---------各种元件id号
'pid用主调
'获取ID\ID自加
Blok_ID = Element_ID      '块id号
PV_ID = Element_ID + 1    'PVid号
Q_ID = Element_ID + 2     'Qid号
OUT_ID = Element_ID + 3  'OUTid号
PV_Q_ID = Element_ID + 8 'PVQid号
'pid用副调
'获取ID\ID自加
Blok_ID2 = Element_ID + 4      '块id号
PV_ID2 = Element_ID + 5    'PVid号
Q_ID2 = Element_ID + 6     'Qid号
OUT_ID2 = Element_ID + 7  'OUTid号
PV_Q_ID2 = Element_ID + 9 'PVQid2号

'pid用主调
SP_ID = Element_ID + 41 'SPid号
OUT2_ID = Element_ID + 42 'OUT2id号

'pid用副调
SP_ID2 = Element_ID + 43 'SPid号
OUT2_ID2 = Element_ID + 44 'OUT2id号

'-------------------------------------------------------主调PID------------------------------------------------------

'03---------位号tag获取
'块位号赋值主调
Blok_Tag = UREGC_arr(UREGC_i, UREGC("NAME"))
'块位号赋值副调
Dim strft As String '中转字符串
strft = UREGC_arr(UREGC_i, UREGC("CODSTN(1)"))
strft = Replace(strft, ".SP", "")
Blok_Tag2 = UREGC_arr(UREGCPIDAux(strft), UREGC("NAME"))

'变量赋值：先转换再赋值
HNPN_TI = UREGC_arr(UREGC_i, UREGC("CISRC(1)")) '待转换变量
Call F2_ConvertPN_TI(HNPN_TI)     '转换
PV_Tag = M6PN_TI '赋值
PV_Q_Tag = Replace(PV_Tag, ".AV", ".Q")

'变量赋值：先转换再赋值-SP
HNPN_TI = UREGC_arr(UREGC_i, UREGC("CISRC(2)")) '待转换变量
Call F2_ConvertPN_TI(HNPN_TI)     '转换
SP_Tag = M6PN_TI '赋值

'变量赋值：先转换再赋值
HNPN_TI = UREGC_arr(UREGC_i, UREGC("CODSTN(1)")) '待转换变量
Call F2_ConvertPN_TI(HNPN_TI) '转换
OUT_Tag = M6PN_TI '赋值

'04---------写xml
'写块XML:'位号,ID,坐标X,坐标Y,数据流,块名
Call BOX_XML(Blok_Tag, Blok_ID, Element_X, Element_Y, Sort_ID, "PIDA")
'-块输入引脚:写块输入引脚XML: 块引脚项名,块引脚连接的位号,块引脚连接的位号ID,是否显示引脚
Call BoxIn_XML("PV", PV_Tag, PV_ID, "true")
Call BoxIn_XML("INCOMP", "", 0, "true")
Call BoxIn_XML("OUTCOMP", "", 0, "true")
Call BoxIn_XML("TRKVAL", "", 0, "true")
Call BoxIn_XML("TRKSW", "", 0, "true")

Call BoxIn_XML("PIDTYPE", "1", Element_ID + 10, "true")
Call BoxIn_XML("AUXMODE", Blok_Tag2 & ".MODE", Element_ID + 11, "true")
Call BoxIn_XML("AUXCOMP", Blok_Tag2 & ".COMP", Element_ID + 12, "true")
Call BoxIn_XML("AUXOVE", Blok_Tag2 & ".OVE", Element_ID + 13, "true")


Call BoxIn_XML("TD", "", 0, "true")
If PV_Tag Like "*.AV*" Then
Call BoxIn_XML("Q", PV_Q_Tag, PV_Q_ID, "true")
Else
Call BoxIn_XML("Q", "", 0, "true")
End If
Call BoxIn_XML("ALMOPT", "", 0, "true")
Call BoxIn_XML("SP", SP_Tag, SP_ID, "true")
Call BoxIn_XML("CYC", "", 0, "true")
Call BoxIn_XML("MODE", "", 0, "true")
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
'Q
If PV_Tag Like "*.AV*" Then
Call Input_XML(PV_Q_Tag, PV_Q_ID, Element_X - 2, Element_Y + 11)
End If
'PIDTYPE
Call Input_XML("1", Element_ID + 10, Element_X - 2, Element_Y + 6)
'AUXMODE
Call Input_XML(Blok_Tag2 & ".MODE", Element_ID + 11, Element_X - 2, Element_Y + 7)
'AUXMODE
Call Input_XML(Blok_Tag2 & ".COMP", Element_ID + 12, Element_X - 2, Element_Y + 8)
'AUXOVE
Call Input_XML(Blok_Tag2 & ".OVE", Element_ID + 13, Element_X - 2, Element_Y + 9)

'SP
Call Input_XML(SP_Tag, SP_ID, Element_X - 2, Element_Y + 13)


'04-03--输出元件:写输出元件XML:'位号,ID,坐标X,坐标Y,数据流,连接的块ID,连接的块输出引脚序号
'Call Output_XML(OUT_Tag, OUT_ID, Element_X + 7, Element_Y + 1, Sort_ID + 1, Blok_ID, 0)

'-------------------------------------------------------副调PID------------------------------------------------------

'Y向偏移
X = 30
Y = 0
'03---------位号tag获取
'块位号赋值
'Blok_Tag2 = UREGC_arr(UREGCPIDAux(strft), UREGC("NAME"))


'变量赋值：先转换再赋值
HNPN_TI = UREGC_arr(UREGCPIDAux(strft), UREGC("CISRC(1)")) '待转换变量
Call F2_ConvertPN_TI(HNPN_TI)     '转换
PV_Tag2 = M6PN_TI '赋值
PV_Q_Tag2 = Replace(PV_Tag2, ".AV", ".Q")
'变量赋值：先转换再赋值
HNPN_TI = UREGC_arr(UREGCPIDAux(strft), UREGC("CODSTN(1)")) '待转换变量
Call F2_ConvertPN_TI(HNPN_TI) '转换
OUT_Tag2 = M6PN_TI '赋值

'变量赋值：先转换再赋值-OUT2
HNPN_TI = UREGC_arr(UREGCPIDAux(strft), UREGC("CODSTN(2)")) '待转换变量
Call F2_ConvertPN_TI(HNPN_TI)     '转换
OUT2_Tag2 = M6PN_TI '赋值


'04---------写xml
'写块XML:'位号,ID,坐标X,坐标Y,数据流,块名
Call BOX_XML(Blok_Tag2, Blok_ID2, Element_X + X, Element_Y + Y, Sort_ID + 2, "PIDA")
'-块输入引脚:写块输入引脚XML: 块引脚项名,块引脚连接的位号,块引脚连接的位号ID,是否显示引脚
Call BoxIn_XML("PV", PV_Tag2, PV_ID2, "true")
Call BoxIn_XML("INCOMP", "", 0, "true")
Call BoxIn_XML("OUTCOMP", "", 0, "true")
Call BoxIn_XML("TRKVAL", "", 0, "true")
Call BoxIn_XML("TRKSW", "", 0, "true")
Call BoxIn_XML("PIDTYPE", "2", Element_ID + 14, "true")
Call BoxIn_XML("AUXMODE", "", 0, "true")
Call BoxIn_XML("AUXCOMP", "", 0, "true")
Call BoxIn_XML("AUXOVE", "", 0, "true")
Call BoxIn_XML("TD", "", 0, "true")
If PV_Tag2 Like "*.AV*" Then
Call BoxIn_XML("Q", PV_Q_Tag2, PV_Q_ID2, "true")
Else
Call BoxIn_XML("Q", "", 0, "true")
End If
Call BoxIn_XML("ALMOPT", "", 0, "true")
Call BoxIn_XML("SP", Blok_Tag, Blok_ID, "true")
Call BoxIn_XML("CYC", "", 0, "true")
Call BoxIn_XML("MODE", "", 0, "true")
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
Call Input_XML(PV_Tag2, PV_ID2, Element_X - 2 + X, Element_Y + 1 + Y)
'Q
If PV_Tag2 Like "*.AV*" Then
Call Input_XML(PV_Q_Tag2, PV_Q_ID2, Element_X - 2 + X, Element_Y + 11 + Y)
End If
'PIDTYPE
Call Input_XML("2", Element_ID + 14, Element_X - 2 + X, Element_Y + 6 + Y)
'04-03--输出元件:写输出元件XML:'位号,ID,坐标X,坐标Y,数据流,连接的块ID,连接的块输出引脚序号
Call Output_XML(OUT_Tag2, OUT_ID2, Element_X + 7 + X, Element_Y + 1 + Y, Sort_ID + 3, Blok_ID2, 0)
Call Output_XML(OUT2_Tag2, OUT2_ID2, Element_X + 7 + X, Element_Y + 1 + Y + 1, Sort_ID + 4, Blok_ID2, 0)

'XY向偏移
X = 0
Y = 27
'04-04--NE块开始
'写块XML:'块类型,块类ID,块类坐标X,块类坐标Y,块类数据流,EN连接的元件id,输入1连接的元件id,输入2连接的元件id,是否显示EN
Call BOX2_XML("NE", Element_ID + 15, Element_X + X, Element_Y + Y, Sort_ID + 4, -1, Element_ID + 16, Element_ID + 17, False)

'04-05--NE输入元件:写输入元件XML: 位号,ID号,坐标X,坐标Y
Call Input_XML(Blok_Tag2 & ".MODE", Element_ID + 16, Element_X + X - 2, Element_Y + Y + 1)
Call Input_XML("2", Element_ID + 17, Element_X + X - 2, Element_Y + Y + 2)

'XY向偏移
X = 29
Y = 27
'04-06--SEL块开始
'写块XML:'块类型,块类ID,块类坐标X,块类坐标Y,块类数据流,EN连接的元件id,输入1连接的元件id,输入2连接的元件id,是否显示EN
Call BOX3_XML("SEL", Element_ID + 18, Element_X + X, Element_Y + Y, Sort_ID + 5, -1, Element_ID + 15, Element_ID + 20, Element_ID + 21, False)

'04-07--SEL输入元件:写输入元件XML: 位号,ID号,坐标X,坐标Y
Call Input_XML(Blok_Tag & ".MODE", Element_ID + 20, Element_X + X - 2, Element_Y + Y + 2)
Call Input_XML("0", Element_ID + 21, Element_X + X - 2, Element_Y + Y + 3)

'04-08--输出元件SEL:写输出元件XML:'位号,ID,坐标X,坐标Y,数据流,连接的块ID,连接的块输出引脚序号
Call Output_XML(Blok_Tag & ".MODE", Element_ID + 22, Element_X + X + 4, Element_Y + Y + 1, Sort_ID + 3, Element_ID + 18, 0)
End Sub
