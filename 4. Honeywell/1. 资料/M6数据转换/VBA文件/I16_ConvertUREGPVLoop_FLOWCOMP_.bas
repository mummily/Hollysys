Attribute VB_Name = "I16_ConvertUREGPVLoop_FLOWCOMP_"
'ver20191010_by cjt

'转化FLOWCOMP
Sub I16_ConvertUREGPVLoop_FLOWCOMP()

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
'Dim MAN_ID As Long            'MANid号变量
'Dim CAS_ID As Long            'CASid号变量
Dim P_ID As Long               'Pid号变量
Dim G_ID As Long               'Gid号变量
Dim Q_ID As Long               'Qid号变量
Dim X_ID As Long               'Xid号变量
Dim T_ID As Long               'Tid号变量
Dim F_ID As Long               'Fid号变量

Dim FSTS_ID As Long             'FSTSid号变量
Dim PSTS_ID As Long             'PSTSid号变量
Dim GSTS_ID As Long             'GSTSid号变量
Dim QSTS_ID As Long             'QSTSid号变量
Dim XSTS_ID As Long             'XSTSid号变量
Dim TSTS_ID As Long             'TSTSid号变量

Dim PVCALC_ID As Long           'PVCALCid号变量


'位号
Dim Blok_Tag As String            '块Tag号变量
'Dim MAN_Tag As String            'MANTag号变量
'Dim CAS_Tag As String            'CASTag号变量
Dim P_Tag As String               'PTag号变量
Dim G_Tag As String               'GTag号变量
Dim Q_Tag As String               'QTag号变量
Dim X_Tag As String               'XTag号变量
Dim T_Tag As String               'TTag号变量
Dim F_Tag As String               'FTag号变量

Dim FSTS_Tag As String             'FSTSTag号变量
Dim PSTS_Tag As String             'PSTSTag号变量
Dim GSTS_Tag As String             'GSTSTag号变量
Dim QSTS_Tag As String             'QSTSTag号变量
Dim XSTS_Tag As String             'XSTSTag号变量
Dim TSTS_Tag As String             'TSTSTag号变量

Dim PVCALC_Tag As String           'PVCALCTag号变量


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
P_ID = Element_ID + 1             'Pid号
G_ID = Element_ID + 2             'Gid号
Q_ID = Element_ID + 3             'Qid号
X_ID = Element_ID + 4             'Xid号
T_ID = Element_ID + 5             'Tid号
F_ID = Element_ID + 6             'Fid号

FSTS_ID = Element_ID + 7           'FSTSid号
PSTS_ID = Element_ID + 8           'PSTSid号
GSTS_ID = Element_ID + 9           'GSTSid号
QSTS_ID = Element_ID + 10          'QSTSid号
XSTS_ID = Element_ID + 11          'XSTSid号
TSTS_ID = Element_ID + 12          'TSTSid号
PVCALC_ID = Element_ID + 13        'PVCALCid号




'03---------位号tag获取
'03-01--块位号赋值
Blok_Tag = UREGPV_arr(UREGPV_i, UREGPV("NAME")) & "_COMP"

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
'    P:REAL:=0;(*测量的实际表压*)
'    G:REAL:=0;(*测量或计算的比重/分子量*)
'    Q:REAL:=0;(*测量的实际水蒸气的干度系数*)
'    X:REAL:=0;(*测量的实际水蒸气的压缩系数*)
'    T:REAL:=0;(*测量的实际摄氏温度*)
'    F:REAL:=0;(*未补偿的测量流量*)
'    FSTS:WORD:=0;(*测量流量的品质0-坏非0正常*)
'    PSTS:WORD:=0;(*测量的实际表压品质0-坏非0正常*)
'    GSTS:WORD:=0;(*测量或计算的比重/分子量品质0-坏非0正常*)
'    QSTS:WORD:=0;(*测量的实际水蒸气的干度系数品质0-坏非0正常*)
'    XSTS:WORD:=0;(*测量的实际水蒸气的压缩系数品质0-坏非0正常*)
'    TSTS:WORD:=0;(*测量的实际摄氏温度品质0-坏非0正常*)
'P
HNPN_TI = UREGPV_arr(UREGPV_i, UREGPV("PISRC(2)")) '待转换变量
If Len(HNPN_TI) > 0 Then
    Call F2_ConvertPN_TI(HNPN_TI) '转换
    P_Tag = M6PN_TI '赋值
Else
    P_Tag = "" '赋值
End If
'品质STS
If NameType(HNPN) = "UAI" Then
    PSTS_Tag = HNPN & ".Q"
Else
    PSTS_Tag = ""
End If

'T
HNPN_TI = UREGPV_arr(UREGPV_i, UREGPV("PISRC(3)")) '待转换变量
If Len(HNPN_TI) > 0 Then
    Call F2_ConvertPN_TI(HNPN_TI) '转换
    T_Tag = M6PN_TI '赋值
Else
    T_Tag = "" '赋值
End If
'品质STS
If NameType(HNPN) = "UAI" Then
    TSTS_Tag = HNPN & ".Q"
Else
    TSTS_Tag = ""
End If

'F
HNPN_TI = UREGPV_arr(UREGPV_i, UREGPV("PISRC(1)")) '待转换变量
If Len(HNPN_TI) > 0 Then
    Call F2_ConvertPN_TI(HNPN_TI) '转换
    F_Tag = M6PN_TI '赋值
Else
    F_Tag = "" '赋值
End If
'品质STS
If NameType(HNPN) = "UAI" Then
    FSTS_Tag = HNPN & ".Q"
Else
    FSTS_Tag = ""
End If

'-输出赋值：先转换再赋值
'PVCALC
PVCALC_Tag = UREGPV_arr(UREGPV_i, UREGPV("NAME")) & ".AI"



'04---------写xml

'04-01--块开始
'写块XML:'位号,ID,坐标X,坐标Y,数据流,块名
Call BOX_XML(Blok_Tag, Blok_ID, Element_X, Element_Y, Sort_ID, "FLOWCOMP")
'-块输入引脚:写块输入引脚XML: 块引脚项名,块引脚连接的位号,块引脚连接的位号ID,是否显示引脚
'Call BoxIn_XML("MAN", MAN_Tag, MAN_ID, "true")
'Call BoxIn_XML("CAS", CAS_Tag, CAS_ID, "true")
Call BoxIn_XML("P", P_Tag, P_ID, "true")
Call BoxIn_XML("G", G_Tag, G_ID, "true")
Call BoxIn_XML("Q", Q_Tag, Q_ID, "true")
Call BoxIn_XML("X", X_Tag, X_ID, "true")
Call BoxIn_XML("T", T_Tag, T_ID, "true")
Call BoxIn_XML("F", F_Tag, F_ID, "true")
Call BoxIn_XML("FSTS", FSTS_Tag, FSTS_ID, "true")
Call BoxIn_XML("PSTS", PSTS_Tag, PSTS_ID, "true")
Call BoxIn_XML("GSTS", GSTS_Tag, GSTS_ID, "true")
Call BoxIn_XML("QSTS", QSTS_Tag, QSTS_ID, "true")
Call BoxIn_XML("XSTS", XSTS_Tag, XSTS_ID, "true")
Call BoxIn_XML("TSTS", TSTS_Tag, TSTS_ID, "true")

'-块输出引脚:写块输出引脚XML: 块引脚项名,是否显示引脚
Call BoxOut_XML("OP", "true")
'--块结束
POU.WriteLine "</element>"

'04-02--输入元件:写输入元件XML: 位号,ID号,坐标X,坐标Y
'Call Input_XML(MAN_Tag, MAN_ID, Element_X - 2, Element_Y + 1)
'Call Input_XML(CAS_Tag, CAS_ID, Element_X - 2, Element_Y + 2)
Call Input_XML(P_Tag, P_ID, Element_X - 2, Element_Y + 1)
Call Input_XML(G_Tag, G_ID, Element_X - 2, Element_Y + 2)
Call Input_XML(Q_Tag, Q_ID, Element_X - 2, Element_Y + 3)
Call Input_XML(X_Tag, X_ID, Element_X - 2, Element_Y + 4)
Call Input_XML(T_Tag, T_ID, Element_X - 2, Element_Y + 5)
Call Input_XML(F_Tag, F_ID, Element_X - 2, Element_Y + 6)
Call Input_XML(FSTS_Tag, FSTS_ID, Element_X - 2, Element_Y + 7)
Call Input_XML(PSTS_Tag, PSTS_ID, Element_X - 2, Element_Y + 8)
Call Input_XML(GSTS_Tag, GSTS_ID, Element_X - 2, Element_Y + 9)
Call Input_XML(QSTS_Tag, QSTS_ID, Element_X - 2, Element_Y + 10)
Call Input_XML(XSTS_Tag, XSTS_ID, Element_X - 2, Element_Y + 11)
Call Input_XML(TSTS_Tag, TSTS_ID, Element_X - 2, Element_Y + 12)


'04-03--输出元件:写输出元件XML:'位号,ID,坐标X,坐标Y,数据流,连接的块ID,连接的块输出引脚序号
Call Output_XML(PVCALC_Tag, PVCALC_ID, Element_X + 12, Element_Y + 1, Sort_ID + 1, Blok_ID, 0)

End Sub
