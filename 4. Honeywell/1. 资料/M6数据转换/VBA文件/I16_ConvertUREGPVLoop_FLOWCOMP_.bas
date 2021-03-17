Attribute VB_Name = "I16_ConvertUREGPVLoop_FLOWCOMP_"
'ver20191010_by cjt

'ת��FLOWCOMP
Sub I16_ConvertUREGPVLoop_FLOWCOMP()

'�ֲ�����
'*****************************************************
'ͨ��
Dim i As Integer 'ѭ������
Dim Element_NO As Long      'Ԫ���ź�
Dim Element_X As Long       'Ԫ��X����
Dim Element_Y As Long       'Ԫ��Y����
Dim Element_ID As Long      'Ԫ��id�ű���
Dim Sort_ID As Long         'Sid������������
Dim Binputstr1 As String, Binputstr2 As String, Binputstr3 As String, outputstr1 As String, outputstr2 As String '��������������ַ���



'id��
Dim Blok_ID As Long            '��id�ű���
'Dim MAN_ID As Long            'MANid�ű���
'Dim CAS_ID As Long            'CASid�ű���
Dim P_ID As Long               'Pid�ű���
Dim G_ID As Long               'Gid�ű���
Dim Q_ID As Long               'Qid�ű���
Dim X_ID As Long               'Xid�ű���
Dim T_ID As Long               'Tid�ű���
Dim F_ID As Long               'Fid�ű���

Dim FSTS_ID As Long             'FSTSid�ű���
Dim PSTS_ID As Long             'PSTSid�ű���
Dim GSTS_ID As Long             'GSTSid�ű���
Dim QSTS_ID As Long             'QSTSid�ű���
Dim XSTS_ID As Long             'XSTSid�ű���
Dim TSTS_ID As Long             'TSTSid�ű���

Dim PVCALC_ID As Long           'PVCALCid�ű���


'λ��
Dim Blok_Tag As String            '��Tag�ű���
'Dim MAN_Tag As String            'MANTag�ű���
'Dim CAS_Tag As String            'CASTag�ű���
Dim P_Tag As String               'PTag�ű���
Dim G_Tag As String               'GTag�ű���
Dim Q_Tag As String               'QTag�ű���
Dim X_Tag As String               'XTag�ű���
Dim T_Tag As String               'TTag�ű���
Dim F_Tag As String               'FTag�ű���

Dim FSTS_Tag As String             'FSTSTag�ű���
Dim PSTS_Tag As String             'PSTSTag�ű���
Dim GSTS_Tag As String             'GSTSTag�ű���
Dim QSTS_Tag As String             'QSTSTag�ű���
Dim XSTS_Tag As String             'XSTSTag�ű���
Dim TSTS_Tag As String             'TSTSTag�ű���

Dim PVCALC_Tag As String           'PVCALCTag�ű���


'*****************************************************


'01---------ͨ�ø�ֵ
'��ʼֵ
Element_ID = 1         'id��
Sort_ID = 0            'Sid�����������ű���
'������
Element_X = 34         '����ҳ��һ����X����
Element_Y = 15         '����ҳ��һ����Y����


'02---------����Ԫ��id��
'pid��
'��ȡID\ID�Լ�
Blok_ID = Element_ID      '��id��
'MAN_ID = Element_ID + 1    'MANid��
'CAS_ID = Element_ID + 2    'CASid��
P_ID = Element_ID + 1             'Pid��
G_ID = Element_ID + 2             'Gid��
Q_ID = Element_ID + 3             'Qid��
X_ID = Element_ID + 4             'Xid��
T_ID = Element_ID + 5             'Tid��
F_ID = Element_ID + 6             'Fid��

FSTS_ID = Element_ID + 7           'FSTSid��
PSTS_ID = Element_ID + 8           'PSTSid��
GSTS_ID = Element_ID + 9           'GSTSid��
QSTS_ID = Element_ID + 10          'QSTSid��
XSTS_ID = Element_ID + 11          'XSTSid��
TSTS_ID = Element_ID + 12          'TSTSid��
PVCALC_ID = Element_ID + 13        'PVCALCid��




'03---------λ��tag��ȡ
'03-01--��λ�Ÿ�ֵ
Blok_Tag = UREGPV_arr(UREGPV_i, UREGPV("NAME")) & "_COMP"

'-���븳ֵ����ת���ٸ�ֵ
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
'    P:REAL:=0;(*������ʵ�ʱ�ѹ*)
'    G:REAL:=0;(*���������ı���/������*)
'    Q:REAL:=0;(*������ʵ��ˮ�����ĸɶ�ϵ��*)
'    X:REAL:=0;(*������ʵ��ˮ������ѹ��ϵ��*)
'    T:REAL:=0;(*������ʵ�������¶�*)
'    F:REAL:=0;(*δ�����Ĳ�������*)
'    FSTS:WORD:=0;(*����������Ʒ��0-����0����*)
'    PSTS:WORD:=0;(*������ʵ�ʱ�ѹƷ��0-����0����*)
'    GSTS:WORD:=0;(*���������ı���/������Ʒ��0-����0����*)
'    QSTS:WORD:=0;(*������ʵ��ˮ�����ĸɶ�ϵ��Ʒ��0-����0����*)
'    XSTS:WORD:=0;(*������ʵ��ˮ������ѹ��ϵ��Ʒ��0-����0����*)
'    TSTS:WORD:=0;(*������ʵ�������¶�Ʒ��0-����0����*)
'P
HNPN_TI = UREGPV_arr(UREGPV_i, UREGPV("PISRC(2)")) '��ת������
If Len(HNPN_TI) > 0 Then
    Call F2_ConvertPN_TI(HNPN_TI) 'ת��
    P_Tag = M6PN_TI '��ֵ
Else
    P_Tag = "" '��ֵ
End If
'Ʒ��STS
If NameType(HNPN) = "UAI" Then
    PSTS_Tag = HNPN & ".Q"
Else
    PSTS_Tag = ""
End If

'T
HNPN_TI = UREGPV_arr(UREGPV_i, UREGPV("PISRC(3)")) '��ת������
If Len(HNPN_TI) > 0 Then
    Call F2_ConvertPN_TI(HNPN_TI) 'ת��
    T_Tag = M6PN_TI '��ֵ
Else
    T_Tag = "" '��ֵ
End If
'Ʒ��STS
If NameType(HNPN) = "UAI" Then
    TSTS_Tag = HNPN & ".Q"
Else
    TSTS_Tag = ""
End If

'F
HNPN_TI = UREGPV_arr(UREGPV_i, UREGPV("PISRC(1)")) '��ת������
If Len(HNPN_TI) > 0 Then
    Call F2_ConvertPN_TI(HNPN_TI) 'ת��
    F_Tag = M6PN_TI '��ֵ
Else
    F_Tag = "" '��ֵ
End If
'Ʒ��STS
If NameType(HNPN) = "UAI" Then
    FSTS_Tag = HNPN & ".Q"
Else
    FSTS_Tag = ""
End If

'-�����ֵ����ת���ٸ�ֵ
'PVCALC
PVCALC_Tag = UREGPV_arr(UREGPV_i, UREGPV("NAME")) & ".AI"



'04---------дxml

'04-01--�鿪ʼ
'д��XML:'λ��,ID,����X,����Y,������,����
Call BOX_XML(Blok_Tag, Blok_ID, Element_X, Element_Y, Sort_ID, "FLOWCOMP")
'-����������:д����������XML: ����������,���������ӵ�λ��,���������ӵ�λ��ID,�Ƿ���ʾ����
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

'-���������:д���������XML: ����������,�Ƿ���ʾ����
Call BoxOut_XML("OP", "true")
'--�����
POU.WriteLine "</element>"

'04-02--����Ԫ��:д����Ԫ��XML: λ��,ID��,����X,����Y
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


'04-03--���Ԫ��:д���Ԫ��XML:'λ��,ID,����X,����Y,������,���ӵĿ�ID,���ӵĿ�����������
Call Output_XML(PVCALC_Tag, PVCALC_ID, Element_X + 12, Element_Y + 1, Sort_ID + 1, Blok_ID, 0)

End Sub
