Attribute VB_Name = "G12_ConvertUREGLoop_PIDFF_"
'ver20190821_by cjt

'ת��PIDFF
Sub G12_ConvertUREGLoop_PIDFF()

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



'pid��
Dim Blok_ID As Long            '��id�ű���
Dim PV_ID As Long              'PVid�ű���
Dim INCOMP_ID As Long          'INCOMPid�ű���
Dim Q_ID As Long               'Qid�ű���
Dim OUT_ID As Long             'OUTid�ű���
Dim FFOPT_ID As Long           'FFOPTid�ű���
Dim KFF_ID As Long             'OUTid�ű���
Dim PV_Q_ID As Long            'PVQid�ű���

Dim SP_ID As Long              'SPid�ű���
Dim OUT2_ID As Long            'OUT2id�ű���


Dim Blok_Tag As String '��λ��
Dim PV_Tag As String 'PVλ��
Dim INCOMP_Tag As String 'INCOMPλ��
Dim OUT_Tag As String 'OUTλ��
Dim FFOPT_Tag As String 'INCOMPλ��
Dim KFF_Tag As String 'OUTλ��
Dim PV_Q_Tag As String 'PV_Qλ��

Dim SP_Tag As String 'SPλ��
Dim OUT2_Tag As String 'OUT2λ��
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
PV_ID = Element_ID + 1    'PVid��
INCOMP_ID = Element_ID + 2    'PVid��
Q_ID = Element_ID + 3     'Qid��
OUT_ID = Element_ID + 4  'OUTid��

FFOPT_ID = Element_ID + 5    'FFOPT_IDid��
KFF_ID = Element_ID + 6     'KFFid��
PV_Q_ID = Element_ID + 7 'PVQid��

SP_ID = Element_ID + 8 'SPid��
OUT2_ID = Element_ID + 9 'OUT2id��

'03---------λ��tag��ȡ
'��λ�Ÿ�ֵ
Blok_Tag = UREGC_arr(UREGC_i, UREGC("NAME"))


'������ֵ����ת���ٸ�ֵ
HNPN_TI = UREGC_arr(UREGC_i, UREGC("CISRC(1)")) '��ת������
Call F2_ConvertPN_TI(HNPN_TI) 'ת��
PV_Tag = M6PN_TI '��ֵ
PV_Q_Tag = Replace(PV_Tag, ".AV", ".Q")

'������ֵ����ת���ٸ�ֵ
HNPN_TI = UREGC_arr(UREGC_i, UREGC("CISRC(2)")) '��ת������
Call F2_ConvertPN_TI(HNPN_TI) 'ת��
INCOMP_Tag = M6PN_TI '��ֵ

'������ֵ����ת���ٸ�ֵ
HNPN_TI = UREGC_arr(UREGC_i, UREGC("CODSTN(1)")) '��ת������
Call F2_ConvertPN_TI(HNPN_TI) 'ת��
OUT_Tag = M6PN_TI '��ֵ

'������ֵ
HNPN_TI = UREGC_arr(UREGC_i, UREGC("FFOPT"))
Call F2_ConvertPN_TI(HNPN_TI) 'ת��
FFOPT_Tag = M6PN_TI '��ֵ
KFF_Tag = UREGC_arr(UREGC_i, UREGC("KFF"))

'������ֵ����ת���ٸ�ֵ-SP
HNPN_TI = UREGC_arr(UREGC_i, UREGC("CISRC(2)")) '��ת������
Call F2_ConvertPN_TI(HNPN_TI)     'ת��
SP_Tag = M6PN_TI '��ֵ

'������ֵ����ת���ٸ�ֵ-OUT2
HNPN_TI = UREGC_arr(UREGC_i, UREGC("CODSTN(2)")) '��ת������
Call F2_ConvertPN_TI(HNPN_TI)     'ת��
OUT2_Tag = M6PN_TI '��ֵ

'04---------дxml
'д��XML:'λ��,ID,����X,����Y,������,����
Call BOX_XML(Blok_Tag, Blok_ID, Element_X, Element_Y, Sort_ID, "PIDA")
'-����������:д����������XML: ����������,���������ӵ�λ��,���������ӵ�λ��ID,�Ƿ���ʾ����
Call BoxIn_XML("PV", PV_Tag, PV_ID, "true")
Call BoxIn_XML("INCOMP", INCOMP_Tag, FFOPT_ID, "true")
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
Call Input_XML(PV_Tag, PV_ID, Element_X - 2, Element_Y + 1)
If PV_Tag Like "*.AV*" Then
Call Input_XML(PV_Q_Tag, PV_Q_ID, Element_X - 2, Element_Y + 10)
End If

'SP
Call Input_XML(SP_Tag, SP_ID, Element_X - 2, Element_Y + 12)


'04-03--���Ԫ��:д���Ԫ��XML:'λ��,ID,����X,����Y,������,���ӵĿ�ID,���ӵĿ�����������
Call Output_XML(OUT_Tag, OUT_ID, Element_X + 7, Element_Y + 1, Sort_ID + 1, Blok_ID, 0)
Call Output_XML(OUT2_Tag, OUT2_ID, Element_X + 7, Element_Y + 2, Sort_ID + 2, Blok_ID, 0)


'04-04--�鿪ʼ
'д��XML:'������,����ID,��������X,��������Y,����������,EN���ӵ�Ԫ��id,����1���ӵ�Ԫ��id,����2���ӵ�Ԫ��id,�Ƿ���ʾEN
Call BOX2_XML(FFOPT_Tag, FFOPT_ID, Element_X - 6, Element_Y + 3, Sort_ID + 2, -1, INCOMP_ID, KFF_ID, False)

'04-05--����Ԫ��:д����Ԫ��XML: λ��,ID��,����X,����Y
Call Input_XML(INCOMP_Tag, INCOMP_ID, Element_X - 7, Element_Y + 4)
Call Input_XML(KFF_Tag, KFF_ID, Element_X - 7, Element_Y + 5)


End Sub

