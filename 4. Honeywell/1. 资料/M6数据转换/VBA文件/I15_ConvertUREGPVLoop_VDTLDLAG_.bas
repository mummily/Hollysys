Attribute VB_Name = "I15_ConvertUREGPVLoop_VDTLDLAG_"
'ver20191010_by cjt

'ת��VDTLDLAG
Sub I15_ConvertUREGPVLoop_VDTLDLAG()

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
'Dim MAN_ID As Long             'MANid�ű���
'Dim CAS_ID As Long             'CASid�ű���
Dim P1_ID As Long               'P1id�ű���
Dim TD_ID As Long               'TDid�ű���

Dim PVCALC_ID As Long              'PVCALCid�ű���


'λ��
Dim Blok_Tag As String            '��λ��
'Dim MAN_Tag As String             'MANλ�ű���
'Dim CAS_Tag As String             'CASλ�ű���
Dim P1_Tag As String              'P1λ�ű���
Dim TD_Tag As String              'TDλ�ű���

Dim PVCALC_Tag As String          'PVCALCλ�ű���


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
Blok_ID = Element_ID         '��id��
'MAN_ID = Element_ID + 1    'MANid��
'CAS_ID = Element_ID + 2    'CASid��
P1_ID = Element_ID + 1       'P1id��
TD_ID = Element_ID + 2       'TDid��

PVCALC_ID = Element_ID + 3   'PVCALCid��




'03---------λ��tag��ȡ
'03-01--��λ�Ÿ�ֵ
Blok_Tag = UREGPV_arr(UREGPV_i, UREGPV("NAME")) & "_LAG"

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
'P1
HNPN_TI = UREGPV_arr(UREGPV_i, UREGPV("PISRC(1)")) '��ת������
If Len(HNPN_TI) > 0 Then
    Call F2_ConvertPN_TI(HNPN_TI) 'ת��
    P1_Tag = M6PN_TI '��ֵ
Else
    P1_Tag = "" '��ֵ
End If
'TD
TD_Tag = UREGPV_arr(UREGPV_i, UREGPV("TD"))
'-�����ֵ����ת���ٸ�ֵ
'PVCALC
PVCALC_Tag = UREGPV_arr(UREGPV_i, UREGPV("NAME")) & ".AI"


'04---------дxml

'04-01--�鿪ʼ
'д��XML:'λ��,ID,����X,����Y,������,����
Call BOX_XML(Blok_Tag, Blok_ID, Element_X, Element_Y, Sort_ID, "VDTLDLAG")
'-����������:д����������XML: ����������,���������ӵ�λ��,���������ӵ�λ��ID,�Ƿ���ʾ����
'Call BoxIn_XML("MAN", MAN_Tag, MAN_ID, "true")
'Call BoxIn_XML("CAS", CAS_Tag, CAS_ID, "true")
Call BoxIn_XML("P1", P1_Tag, P1_ID, "true")
Call BoxIn_XML("TD", TD_Tag, TD_ID, "true")

'-���������:д���������XML: ����������,�Ƿ���ʾ����
Call BoxOut_XML("PVCALC", "true")

'--�����
POU.WriteLine "</element>"

'04-02--����Ԫ��:д����Ԫ��XML: λ��,ID��,����X,����Y
'Call Input_XML(MAN_Tag, MAN_ID, Element_X - 2, Element_Y + 1)
'Call Input_XML(CAS_Tag, CAS_ID, Element_X - 2, Element_Y + 2)
Call Input_XML(P1_Tag, P1_ID, Element_X - 2, Element_Y + 1)
Call Input_XML(TD_Tag, TD_ID, Element_X - 2, Element_Y + 2)


'04-03--���Ԫ��:д���Ԫ��XML:'λ��,ID,����X,����Y,������,���ӵĿ�ID,���ӵĿ�����������
Call Output_XML(PVCALC_Tag, PVCALC_ID, Element_X + 12, Element_Y + 1, Sort_ID + 1, Blok_ID, 0)


End Sub

