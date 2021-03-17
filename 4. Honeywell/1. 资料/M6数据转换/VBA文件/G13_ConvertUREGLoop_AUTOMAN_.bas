Attribute VB_Name = "G13_ConvertUREGLoop_AUTOMAN_"
'ver20190821_by cjt

'ת��SWITCH
Sub G13_ConvertUREGLoop_AUTOMAN()

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



'id��
Dim Blok_ID As Long           '��id�ű���
Dim IN_ID As Long             'INid�ű���
Dim OUT_ID As Long            'OUTid�ű���


'λ��
Dim Blok_Tag As String            '��λ��
Dim IN_Tag As String              'INλ�ű���
Dim OUT_Tag As String             'OUTλ�ű���

'CISRC�ֵ�
Dim CISRC As Object '����λ���ֵ�

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
IN_ID = Element_ID + 1    'INid��
OUT_ID = Element_ID + 2    'OUTid��

'03---------λ��tag��ȡ
'��λ�Ÿ�ֵ
Blok_Tag = UREGC_arr(UREGC_i, UREGC("NAME"))


'������ֵ����ת���ٸ�ֵ
HNPN_TI = UREGC_arr(UREGC_i, UREGC("CISRC(1)")) '��ת������
Call F2_ConvertPN_TI(HNPN_TI)     'ת��
IN_Tag = M6PN_TI '��ֵ

'������ֵ����ת���ٸ�ֵ
HNPN_TI = UREGC_arr(UREGC_i, UREGC("CODSTN(1)")) '��ת������
Call F2_ConvertPN_TI(HNPN_TI) 'ת��
OUT_Tag = M6PN_TI '��ֵ

'04---------дxml
'д��XML:'λ��,ID,����X,����Y,������,����
Call BOX_XML(Blok_Tag, Blok_ID, Element_X, Element_Y, Sort_ID, "MAN")
'-����������:д����������XML: ����������,���������ӵ�λ��,���������ӵ�λ��ID,�Ƿ���ʾ����
Call BoxIn_XML("IN", IN_Tag, IN_ID, "true")
Call BoxIn_XML("TRKVAL", "", 0, "true")
Call BoxIn_XML("TRKSW", "", 0, "true")
Call BoxIn_XML("PV", "", 0, "true")
Call BoxIn_XML("MODE", "", 0, "true")
'-���������:д���������XML: ����������,�Ƿ���ʾ����
Call BoxOut_XML("OUT", "true")

'--�����
POU.WriteLine "</element>"

'04-02--����Ԫ��:д����Ԫ��XML: λ��,ID��,����X,����Y
Call Input_XML(IN_Tag, IN_ID, Element_X - 2, Element_Y + 1)


'04-03--���Ԫ��:д���Ԫ��XML:'λ��,ID,����X,����Y,������,���ӵĿ�ID,���ӵĿ�����������
Call Output_XML(OUT_Tag, OUT_ID, Element_X + 7, Element_Y + 1, Sort_ID + 1, Blok_ID, 0)


End Sub
