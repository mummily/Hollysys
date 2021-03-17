Attribute VB_Name = "I12_ConvertUREGPVLoop_HILOAVG_"
'ver20190930_by cjt

'ת��HILOAVG
Sub I12_ConvertUREGPVLoop_HILOAVG()

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
Dim P1_ID As Long              'P1id�ű���
Dim P2_ID As Long              'P2id�ű���
Dim P3_ID As Long              'P3id�ű���
Dim P4_ID As Long              'P4id�ű���
Dim P5_ID As Long              'P5id�ű���
Dim P6_ID As Long              'P6id�ű���
Dim P1STS_ID As Long           'P1STSid�ű���
Dim P2STS_ID As Long           'P2STSid�ű���
Dim P3STS_ID As Long           'P3STSid�ű���
Dim P4STS_ID As Long           'P4STSid�ű���
Dim P5STS_ID As Long           'P5STSid�ű���
Dim P6STS_ID As Long           'P6STSid�ű���
Dim FORCE1_ID As Long          'FORCE1id�ű���
'Dim EQU_ID As Long             'EUQid�ű���
Dim PVCALC_ID As Long          'PVCALCid�ű���
'Dim OPEU_ID As Long            'OPid�ű���

'λ��
Dim Blok_Tag As String            '��λ��
'Dim MAN_Tag As String             'MANλ�ű���
'Dim CAS_Tag As String             'CASλ�ű���
Dim P1_Tag As String              'P1λ�ű���
Dim P2_Tag As String              'P2λ�ű���
Dim P3_Tag As String              'P3λ�ű���
Dim P4_Tag As String              'P4λ�ű���
Dim P5_Tag As String              'P5λ�ű���
Dim P6_Tag As String              'P6λ�ű���
Dim P1STS_Tag As String              'P1STSλ�ű���
Dim P2STS_Tag As String              'P2STSλ�ű���
Dim P3STS_Tag As String              'P3STSλ�ű���
Dim P4STS_Tag As String              'P4STSλ�ű���
Dim P5STS_Tag As String              'P5STSλ�ű���
Dim P6STS_Tag As String              'P6STSλ�ű���
'Dim EQU_Tag As String             'EUQλ�ű���
Dim PVCALC_Tag As String          'PVCALCλ�ű���
Dim FORCE1_Tag As String            'FORCE1λ�ű���

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
P1_ID = Element_ID + 1     'P1id��
P1STS_ID = Element_ID + 2  'P1STSid��
P2_ID = Element_ID + 3     'P2id��
P2STS_ID = Element_ID + 4  'P2STSid��
P3_ID = Element_ID + 5     'P3id��
P3STS_ID = Element_ID + 6  'P3STSid��
P4_ID = Element_ID + 7     'P4id��
P4STS_ID = Element_ID + 8  'P4STSid��
P5_ID = Element_ID + 9     'P5id��
P5STS_ID = Element_ID + 10  'P5STSid��
P6_ID = Element_ID + 11     'P6id��
P6STS_ID = Element_ID + 12  'P6STSid��
FORCE1_ID = Element_ID + 13  'FORCE1id��
'EQU_ID = Element_ID + 7    'EQUid��
PVCALC_ID = Element_ID + 14     '��CVid��
'OPEU_ID = Element_ID + 9     'OPid��



'03---------λ��tag��ȡ
'03-01--��λ�Ÿ�ֵ
Blok_Tag = UREGPV_arr(UREGPV_i, UREGPV("NAME")) & "_AVG"

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
If NameType(HNPN) = "UAI" Then
    P1STS_Tag = Replace(P1_Tag, ".AV", ".Q")
Else
    P1STS_Tag = ""
End If
'P2
HNPN_TI = UREGPV_arr(UREGPV_i, UREGPV("PISRC(2)")) '��ת������
If Len(HNPN_TI) > 0 Then
    Call F2_ConvertPN_TI(HNPN_TI) 'ת��
    P2_Tag = M6PN_TI '��ֵ
Else
    P2_Tag = "" '��ֵ
End If
If NameType(HNPN) = "UAI" Then
    P2STS_Tag = Replace(P2_Tag, ".AV", ".Q")
Else
    P2STS_Tag = ""
End If
'P3
HNPN_TI = UREGPV_arr(UREGPV_i, UREGPV("PISRC(3)")) '��ת������
If Len(HNPN_TI) > 0 Then
    Call F2_ConvertPN_TI(HNPN_TI) 'ת��
    P3_Tag = M6PN_TI '��ֵ
Else
    P3_Tag = "" '��ֵ
End If
If NameType(HNPN) = "UAI" Then
    P3STS_Tag = Replace(P3_Tag, ".AV", ".Q")
Else
    P3STS_Tag = ""
End If
'P4
HNPN_TI = UREGPV_arr(UREGPV_i, UREGPV("PISRC(4)")) '��ת������
If Len(HNPN_TI) > 0 Then
    Call F2_ConvertPN_TI(HNPN_TI) 'ת��
    P4_Tag = M6PN_TI '��ֵ
Else
    P4_Tag = "" '��ֵ
End If
If NameType(HNPN) = "UAI" Then
    P4STS_Tag = Replace(P4_Tag, ".AV", ".Q")
Else
    P4STS_Tag = ""
End If
'P5
HNPN_TI = UREGPV_arr(UREGPV_i, UREGPV("PISRC(5)")) '��ת������
If Len(HNPN_TI) > 0 Then
    Call F2_ConvertPN_TI(HNPN_TI) 'ת��
    P5_Tag = M6PN_TI '��ֵ
Else
    P5_Tag = "" '��ֵ
End If
If NameType(HNPN) = "UAI" Then
    P5STS_Tag = Replace(P5_Tag, ".AV", ".Q")
Else
    P5STS_Tag = ""
End If
'P6
HNPN_TI = UREGPV_arr(UREGPV_i, UREGPV("PISRC(6)")) '��ת������
If Len(HNPN_TI) > 0 Then
    Call F2_ConvertPN_TI(HNPN_TI) 'ת��
    P6_Tag = M6PN_TI '��ֵ
Else
    P6_Tag = "" '��ֵ
End If
If NameType(HNPN) = "UAI" Then
    P6STS_Tag = Replace(P6_Tag, ".AV", ".Q")
Else
    P6STS_Tag = ""
End If
''EQU
'If UREGPV_arr(UREGPV_i, UREGPV("PVEQN")) = "" Then
'    EQU_Tag = "0"
'End If
'If UREGPV_arr(UREGPV_i, UREGPV("PVEQN")) = "EQA" Then
'    EQU_Tag = "1"
'End If
'If UREGPV_arr(UREGPV_i, UREGPV("PVEQN")) = "EQB" Then
'    EQU_Tag = "2"
'End If
'-�����ֵ����ת���ٸ�ֵ
'OP
PVCALC_Tag = UREGPV_arr(UREGPV_i, UREGPV("NAME")) & ".AI"
'OPEU
'OPEU_Tag = ""


'04---------дxml

'04-01--�鿪ʼ
'д��XML:'λ��,ID,����X,����Y,������,����
Call BOX_XML(Blok_Tag, Blok_ID, Element_X, Element_Y, Sort_ID, "HILOAVG")
'-����������:д����������XML: ����������,���������ӵ�λ��,���������ӵ�λ��ID,�Ƿ���ʾ����
'Call BoxIn_XML("MAN", MAN_Tag, MAN_ID, "true")
'Call BoxIn_XML("CAS", CAS_Tag, CAS_ID, "true")
Call BoxIn_XML("P1", P1_Tag, P1_ID, "true")
Call BoxIn_XML("P2", P2_Tag, P2_ID, "true")
Call BoxIn_XML("P3", P3_Tag, P3_ID, "true")
Call BoxIn_XML("P4", P4_Tag, P4_ID, "true")
Call BoxIn_XML("P5", P5_Tag, P5_ID, "true")
Call BoxIn_XML("P6", P6_Tag, P6_ID, "true")

Call BoxIn_XML("P1STS", P1STS_Tag, P1STS_ID, "true")
Call BoxIn_XML("P2STS", P2STS_Tag, P2STS_ID, "true")
Call BoxIn_XML("P3STS", P3STS_Tag, P3STS_ID, "true")
Call BoxIn_XML("P4STS", P4STS_Tag, P4STS_ID, "true")
Call BoxIn_XML("P5STS", P5STS_Tag, P5STS_ID, "true")
Call BoxIn_XML("P6STS", P6STS_Tag, P6STS_ID, "true")
Call BoxIn_XML("FORCE1", FORCE1_Tag, FORCE1_ID, "true")
'Call BoxIn_XML("EQU", EQU_Tag, EQU_ID, "true")
'-���������:д���������XML: ����������,�Ƿ���ʾ����
Call BoxOut_XML("PVCALC", "true")
'Call BoxOut_XML("OPEU", "true")
'--�����
POU.WriteLine "</element>"

'04-02--����Ԫ��:д����Ԫ��XML: λ��,ID��,����X,����Y
'Call Input_XML(MAN_Tag, MAN_ID, Element_X - 2, Element_Y + 1)
'Call Input_XML(CAS_Tag, CAS_ID, Element_X - 2, Element_Y + 2)
Call Input_XML(P1_Tag, P1_ID, Element_X - 2, Element_Y + 1)
Call Input_XML(P1STS_Tag, P1STS_ID, Element_X - 2, Element_Y + 2)
Call Input_XML(P2_Tag, P2_ID, Element_X - 2, Element_Y + 3)
Call Input_XML(P2STS_Tag, P2STS_ID, Element_X - 2, Element_Y + 4)

Call Input_XML(P3_Tag, P3_ID, Element_X - 2, Element_Y + 5)
Call Input_XML(P3STS_Tag, P3STS_ID, Element_X - 2, Element_Y + 6)
Call Input_XML(P4_Tag, P4_ID, Element_X - 2, Element_Y + 7)
Call Input_XML(P4STS_Tag, P4STS_ID, Element_X - 2, Element_Y + 8)

Call Input_XML(P5_Tag, P5_ID, Element_X - 2, Element_Y + 9)
Call Input_XML(P5STS_Tag, P5STS_ID, Element_X - 2, Element_Y + 10)
Call Input_XML(P6_Tag, P6_ID, Element_X - 2, Element_Y + 11)
Call Input_XML(P6STS_Tag, P6STS_ID, Element_X - 2, Element_Y + 12)

Call Input_XML(FORCE1_Tag, FORCE1_ID, Element_X - 2, Element_Y + 13)

'Call Input_XML(EQU_Tag, EQU_ID, Element_X - 2, Element_Y + 7)

'04-03--���Ԫ��:д���Ԫ��XML:'λ��,ID,����X,����Y,������,���ӵĿ�ID,���ӵĿ�����������
Call Output_XML(PVCALC_Tag, PVCALC_ID, Element_X + 12, Element_Y + 1, Sort_ID + 1, Blok_ID, 0)
'Call Output_XML(OPEU_Tag, OPEU_ID, Element_X + 7, Element_Y + 2, Sort_ID + 2, Blok_ID, 1)

End Sub

