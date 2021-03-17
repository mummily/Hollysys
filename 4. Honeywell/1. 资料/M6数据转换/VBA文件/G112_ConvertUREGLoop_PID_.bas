Attribute VB_Name = "G112_ConvertUREGLoop_PID_"
'ver20190821_by cjt

'ת������pid
Sub G112_ConvertUREGLoop_PID()

'�ֲ�����
'*****************************************************
'ͨ��
Dim i As Integer 'ѭ������
Dim Element_NO As Long      'Ԫ���ź�
Dim Element_X As Long       'Ԫ��X����
Dim Element_Y As Long       'Ԫ��Y����
Dim Element_ID As Long      'Ԫ��id�ű���
Dim B_ID As Long            '��id�ű���
Dim Sort_ID As Long         'Sid������������
Dim Binputstr1 As String, Binputstr2 As String, Binputstr3 As String, outputstr1 As String, outputstr2 As String '��������������ַ���



'pid������
Dim Blok_ID As Long            '��id�ű���
Dim PV_ID As Long              'PVid�ű���
Dim Q_ID As Long               'Qid�ű���
Dim OUT_ID As Long             'OUTid�ű���
Dim PV_Q_ID As Long            'PVQid�ű���


Dim Blok_Tag As String '��λ��
Dim PV_Tag As String 'PVλ��
Dim OUT_Tag As String 'OUTλ��
Dim PV_Q_Tag As String 'PV_Qλ��
'pid�ø���
Dim Blok_ID2 As Long            '��id�ű���
Dim PV_ID2 As Long              'PVid�ű���
Dim Q_ID2 As Long               'Qid�ű���
Dim OUT_ID2 As Long             'OUTid�ű���
Dim PV_Q_ID2 As Long            'PVQid2�ű���

Dim Blok_Tag2 As String '��λ��
Dim PV_Tag2 As String 'PVλ��
Dim OUT_Tag2 As String 'OUTλ��
Dim PV_Q_Tag2 As String 'PV_Q2λ��

'pid������
Dim SP_Tag As String 'SPλ��
Dim OUT2_Tag As String 'OUT2λ��

'pid�ø���
Dim SP_Tag2 As String 'SPλ��
Dim OUT2_Tag2 As String 'OUT2λ��

'pid������
Dim SP_ID As Long              'SPid�ű���
Dim OUT2_ID As Long            'OUT2id�ű���

'pid�ø���
Dim SP_ID2 As Long              'SPid�ű���
Dim OUT2_ID2 As Long            'OUT2id�ű���
'*****************************************************


'01---------ͨ�ø�ֵ
'��ʼֵ
Element_ID = 1         'id��
Sort_ID = 0            'Sid�����������ű���
'������
Element_X = 24         '����ҳ��һ����X����
Element_Y = 15         '����ҳ��һ����Y����

'02---------����Ԫ��id��
'pid������
'��ȡID\ID�Լ�
Blok_ID = Element_ID      '��id��
PV_ID = Element_ID + 1    'PVid��
Q_ID = Element_ID + 2     'Qid��
OUT_ID = Element_ID + 3  'OUTid��
PV_Q_ID = Element_ID + 8 'PVQid��
'pid�ø���
'��ȡID\ID�Լ�
Blok_ID2 = Element_ID + 4      '��id��
PV_ID2 = Element_ID + 5    'PVid��
Q_ID2 = Element_ID + 6     'Qid��
OUT_ID2 = Element_ID + 7  'OUTid��
PV_Q_ID2 = Element_ID + 9 'PVQid2��

'pid������
SP_ID = Element_ID + 41 'SPid��
OUT2_ID = Element_ID + 42 'OUT2id��

'pid�ø���
SP_ID2 = Element_ID + 43 'SPid��
OUT2_ID2 = Element_ID + 44 'OUT2id��

'-------------------------------------------------------����PID------------------------------------------------------

'03---------λ��tag��ȡ
'��λ�Ÿ�ֵ����
Blok_Tag = UREGC_arr(UREGC_i, UREGC("NAME"))
'��λ�Ÿ�ֵ����
Dim strft As String '��ת�ַ���
strft = UREGC_arr(UREGC_i, UREGC("CODSTN(1)"))
strft = Replace(strft, ".SP", "")
Blok_Tag2 = UREGC_arr(UREGCPIDAux(strft), UREGC("NAME"))

'������ֵ����ת���ٸ�ֵ
HNPN_TI = UREGC_arr(UREGC_i, UREGC("CISRC(1)")) '��ת������
Call F2_ConvertPN_TI(HNPN_TI)     'ת��
PV_Tag = M6PN_TI '��ֵ
PV_Q_Tag = Replace(PV_Tag, ".AV", ".Q")

'������ֵ����ת���ٸ�ֵ-SP
HNPN_TI = UREGC_arr(UREGC_i, UREGC("CISRC(2)")) '��ת������
Call F2_ConvertPN_TI(HNPN_TI)     'ת��
SP_Tag = M6PN_TI '��ֵ

'������ֵ����ת���ٸ�ֵ
HNPN_TI = UREGC_arr(UREGC_i, UREGC("CODSTN(1)")) '��ת������
Call F2_ConvertPN_TI(HNPN_TI) 'ת��
OUT_Tag = M6PN_TI '��ֵ

'04---------дxml
'д��XML:'λ��,ID,����X,����Y,������,����
Call BOX_XML(Blok_Tag, Blok_ID, Element_X, Element_Y, Sort_ID, "PIDA")
'-����������:д����������XML: ����������,���������ӵ�λ��,���������ӵ�λ��ID,�Ƿ���ʾ����
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
'-���������:д���������XML: ����������,�Ƿ���ʾ����
Call BoxOut_XML("OUT", "true")
Call BoxOut_XML("SP", "true")
Call BoxOut_XML("MODE", "false")
Call BoxOut_XML("KP", "false")
Call BoxOut_XML("TI", "false")
Call BoxOut_XML("KD", "false")
Call BoxOut_XML("OUTU", "false")
Call BoxOut_XML("OUTL", "false")
'--�����
POU.WriteLine "</element>"

'04-02--����Ԫ��:д����Ԫ��XML: λ��,ID��,����X,����Y
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


'04-03--���Ԫ��:д���Ԫ��XML:'λ��,ID,����X,����Y,������,���ӵĿ�ID,���ӵĿ�����������
'Call Output_XML(OUT_Tag, OUT_ID, Element_X + 7, Element_Y + 1, Sort_ID + 1, Blok_ID, 0)

'-------------------------------------------------------����PID------------------------------------------------------

'Y��ƫ��
X = 30
Y = 0
'03---------λ��tag��ȡ
'��λ�Ÿ�ֵ
'Blok_Tag2 = UREGC_arr(UREGCPIDAux(strft), UREGC("NAME"))


'������ֵ����ת���ٸ�ֵ
HNPN_TI = UREGC_arr(UREGCPIDAux(strft), UREGC("CISRC(1)")) '��ת������
Call F2_ConvertPN_TI(HNPN_TI)     'ת��
PV_Tag2 = M6PN_TI '��ֵ
PV_Q_Tag2 = Replace(PV_Tag2, ".AV", ".Q")
'������ֵ����ת���ٸ�ֵ
HNPN_TI = UREGC_arr(UREGCPIDAux(strft), UREGC("CODSTN(1)")) '��ת������
Call F2_ConvertPN_TI(HNPN_TI) 'ת��
OUT_Tag2 = M6PN_TI '��ֵ

'������ֵ����ת���ٸ�ֵ-OUT2
HNPN_TI = UREGC_arr(UREGCPIDAux(strft), UREGC("CODSTN(2)")) '��ת������
Call F2_ConvertPN_TI(HNPN_TI)     'ת��
OUT2_Tag2 = M6PN_TI '��ֵ


'04---------дxml
'д��XML:'λ��,ID,����X,����Y,������,����
Call BOX_XML(Blok_Tag2, Blok_ID2, Element_X + X, Element_Y + Y, Sort_ID + 2, "PIDA")
'-����������:д����������XML: ����������,���������ӵ�λ��,���������ӵ�λ��ID,�Ƿ���ʾ����
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
'-���������:д���������XML: ����������,�Ƿ���ʾ����
Call BoxOut_XML("OUT", "true")
Call BoxOut_XML("SP", "true")
Call BoxOut_XML("MODE", "false")
Call BoxOut_XML("KP", "false")
Call BoxOut_XML("TI", "false")
Call BoxOut_XML("KD", "false")
Call BoxOut_XML("OUTU", "false")
Call BoxOut_XML("OUTL", "false")
'--�����
POU.WriteLine "</element>"

'04-02--����Ԫ��:д����Ԫ��XML: λ��,ID��,����X,����Y
'PV
Call Input_XML(PV_Tag2, PV_ID2, Element_X - 2 + X, Element_Y + 1 + Y)
'Q
If PV_Tag2 Like "*.AV*" Then
Call Input_XML(PV_Q_Tag2, PV_Q_ID2, Element_X - 2 + X, Element_Y + 11 + Y)
End If
'PIDTYPE
Call Input_XML("2", Element_ID + 14, Element_X - 2 + X, Element_Y + 6 + Y)
'04-03--���Ԫ��:д���Ԫ��XML:'λ��,ID,����X,����Y,������,���ӵĿ�ID,���ӵĿ�����������
Call Output_XML(OUT_Tag2, OUT_ID2, Element_X + 7 + X, Element_Y + 1 + Y, Sort_ID + 3, Blok_ID2, 0)
Call Output_XML(OUT2_Tag2, OUT2_ID2, Element_X + 7 + X, Element_Y + 1 + Y + 1, Sort_ID + 4, Blok_ID2, 0)

'XY��ƫ��
X = 0
Y = 27
'04-04--NE�鿪ʼ
'д��XML:'������,����ID,��������X,��������Y,����������,EN���ӵ�Ԫ��id,����1���ӵ�Ԫ��id,����2���ӵ�Ԫ��id,�Ƿ���ʾEN
Call BOX2_XML("NE", Element_ID + 15, Element_X + X, Element_Y + Y, Sort_ID + 4, -1, Element_ID + 16, Element_ID + 17, False)

'04-05--NE����Ԫ��:д����Ԫ��XML: λ��,ID��,����X,����Y
Call Input_XML(Blok_Tag2 & ".MODE", Element_ID + 16, Element_X + X - 2, Element_Y + Y + 1)
Call Input_XML("2", Element_ID + 17, Element_X + X - 2, Element_Y + Y + 2)

'XY��ƫ��
X = 29
Y = 27
'04-06--SEL�鿪ʼ
'д��XML:'������,����ID,��������X,��������Y,����������,EN���ӵ�Ԫ��id,����1���ӵ�Ԫ��id,����2���ӵ�Ԫ��id,�Ƿ���ʾEN
Call BOX3_XML("SEL", Element_ID + 18, Element_X + X, Element_Y + Y, Sort_ID + 5, -1, Element_ID + 15, Element_ID + 20, Element_ID + 21, False)

'04-07--SEL����Ԫ��:д����Ԫ��XML: λ��,ID��,����X,����Y
Call Input_XML(Blok_Tag & ".MODE", Element_ID + 20, Element_X + X - 2, Element_Y + Y + 2)
Call Input_XML("0", Element_ID + 21, Element_X + X - 2, Element_Y + Y + 3)

'04-08--���Ԫ��SEL:д���Ԫ��XML:'λ��,ID,����X,����Y,������,���ӵĿ�ID,���ӵĿ�����������
Call Output_XML(Blok_Tag & ".MODE", Element_ID + 22, Element_X + X + 4, Element_Y + Y + 1, Sort_ID + 3, Element_ID + 18, 0)
End Sub
