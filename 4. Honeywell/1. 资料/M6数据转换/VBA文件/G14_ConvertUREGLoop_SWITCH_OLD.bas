Attribute VB_Name = "G14_ConvertUREGLoop_SWITCH_OLD"
'ver20190821_by cjt

'ת��SWITCH
Sub G14_ConvertUREGLoop_SWITCH_OLD()

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
Dim Blok_ID As Long            '��id�ű���
Dim MAN_ID As Long             'MANid�ű���
Dim CAS_ID As Long             'CASid�ű���
Dim X1_ID As Long              'X1id�ű���
Dim X2_ID As Long              'X2id�ű���
Dim X3_ID As Long              'X3id�ű���
Dim X4_ID As Long              'X4id�ű���
Dim S1_ID As Long              'S1id�ű���
Dim S2_ID As Long              'S2id�ű���
Dim S3_ID As Long              'S3id�ű���
Dim S4_ID As Long              'S4id�ű���
Dim EQU_ID As Long             'EUQid�ű���
Dim OP_ID As Long              'CVid�ű���
Dim OPEU_ID As Long              'OPid�ű���

'λ��
Dim Blok_Tag As String            '��λ��
Dim MAN_Tag As String             'MANλ�ű���
Dim CAS_Tag As String             'CASλ�ű���
Dim X1_Tag As String              'X1λ�ű���
Dim X2_Tag As String              'X2λ�ű���
Dim X3_Tag As String              'X3λ�ű���
Dim X4_Tag As String              'X4λ�ű���
Dim S1_Tag As String              'S1λ�ű���
Dim S2_Tag As String              'S2λ�ű���
Dim S3_Tag As String              'S3λ�ű���
Dim S4_Tag As String              'S4λ�ű���
Dim EQU_Tag As String             'EUQλ�ű���
Dim OP_Tag As String             'OPλ�ű���
Dim OPEU_Tag As String            'OPEUλ�ű���
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
MAN_ID = Element_ID + 1    'MANid��
CAS_ID = Element_ID + 2    'CASid��
X1_ID = Element_ID + 3     'X1id��
X2_ID = Element_ID + 4     'X2id��
X3_ID = Element_ID + 5     'X3id��
X4_ID = Element_ID + 6     'X4id��
S1_ID = Element_ID + 7     'S1id��
S2_ID = Element_ID + 8     'S2id��
S3_ID = Element_ID + 9    'S3id��
S4_ID = Element_ID + 10     'S4id��
EQU_ID = Element_ID + 11    'EQUid��
OP_ID = Element_ID + 12     '��CVid��
OPEU_ID = Element_ID + 13     'OPid��



'03---------λ��tag��ȡ
'03-01--��λ�Ÿ�ֵ
Blok_Tag = UREGC_arr(UREGC_i, UREGC("NAME"))

'03-02--��������ֵ�
Set CISRC = CreateObject("Scripting.Dictionary") 'CIDSTN�ֵ�
CISRC.RemoveAll
With CISRC
    For i = 1 To 4
      If Len(UREGC_arr(UREGC_i, UREGC("CIDSTN(" & i & ")"))) > 0 Then
         .Add UREGC_arr(UREGC_i, UREGC("CIDSTN(" & i & ")")), UREGC_arr(UREGC_i, UREGC("CISRC(" & i & ")")) '����
      Else
         .Add "�հ�" & i, "" '����
      End If
    Next
End With

'-���븳ֵ����ת���ٸ�ֵ
'MAN
If Len(UREGC_arr(UREGC_i, UREGC("CTLEQN"))) = "EQA" Then
    MAN_Tag = "TRUE"
Else
    MAN_Tag = "FALSE"
End If
'CAS
If Len(UREGC_arr(UREGC_i, UREGC("CTLEQN"))) = "EQA" Then
    CAS_Tag = "FALSE"
Else
    CAS_Tag = "TRUE"
End If
'X1
If CISRC.Exists("X1") Then
    HNPN_TI = CISRC("X1") '��ֵ
    Call F2_ConvertPN_TI(HNPN_TI) 'ת��
    X1_Tag = M6PN_TI
Else
    X1_Tag = "0"
End If
'X2
If CISRC.Exists("X2") Then
    HNPN_TI = CISRC("X2") '��ֵ
    Call F2_ConvertPN_TI(HNPN_TI) 'ת��
    X2_Tag = M6PN_TI
Else
    X2_Tag = "0"
End If
'X3
If CISRC.Exists("X3") Then
    HNPN_TI = CISRC("X3") '��ֵ
    Call F2_ConvertPN_TI(HNPN_TI) 'ת��
    X3_Tag = M6PN_TI
Else
    X3_Tag = "0"
End If
'X4
If CISRC.Exists("X4") Then
    HNPN_TI = CISRC("X4") '��ֵ
    Call F2_ConvertPN_TI(HNPN_TI) 'ת��
    X4_Tag = M6PN_TI
Else
    X4_Tag = "0"
End If
'S1
If UREGC1_arr(UREGC1Name(Blok_Tag), UREGC1("$MODESEL(1)")) = "ON" Then
    S1_Tag = "TRUE"
Else
    S1_Tag = "FALSE"
End If
'S2
If UREGC1_arr(UREGC1Name(Blok_Tag), UREGC1("$MODESEL(2)")) = "ON" Then
    S2_Tag = "TRUE"
Else
    S2_Tag = "FALSE"
End If
'S3
If UREGC1_arr(UREGC1Name(Blok_Tag), UREGC1("$MODESEL(3)")) = "ON" Then
    S3_Tag = "TRUE"
Else
    S3_Tag = "FALSE"
End If
'S4
If UREGC1_arr(UREGC1Name(Blok_Tag), UREGC1("$MODESEL(4)")) = "ON" Then
    S4_Tag = "TRUE"
Else
    S4_Tag = "FALSE"
End If
'EQU
If UREGC_arr(UREGC_i, UREGC("CTLEQN")) = "" Then
    EQU_Tag = "0"
End If
If UREGC_arr(UREGC_i, UREGC("CTLEQN")) = "EQA" Then
    EQU_Tag = "1"
End If
If UREGC_arr(UREGC_i, UREGC("CTLEQN")) = "EQB" Then
    EQU_Tag = "2"
End If
'-�����ֵ����ת���ٸ�ֵ
'CV
If Len(UREGC_arr(UREGC_i, UREGC("CODSTN(1)"))) > 0 Then
    HNPN_TI = UREGC_arr(UREGC_i, UREGC("CODSTN(1)"))  '��ֵ
    Call F2_ConvertPN_TI(HNPN_TI) 'ת��
    OP_Tag = M6PN_TI
Else
    OP_Tag = ""
End If
'OP
If Len(UREGC_arr(UREGC_i, UREGC("CODSTN(2)"))) > 0 Then
    HNPN_TI = UREGC_arr(UREGC_i, UREGC("CODSTN(2)"))  '��ֵ
    Call F2_ConvertPN_TI(HNPN_TI) 'ת��
    OPEU_Tag = M6PN_TI
Else
    OPEU_Tag = ""
End If

'04---------дxml

'04-01--�鿪ʼ
'д��XML:'λ��,ID,����X,����Y,������,����
Call BOX_XML(Blok_Tag, Blok_ID, Element_X, Element_Y, Sort_ID, "SWITCH")
'-����������:д����������XML: ����������,���������ӵ�λ��,���������ӵ�λ��ID,�Ƿ���ʾ����
Call BoxIn_XML("MAN", MAN_Tag, MAN_ID, "true")
Call BoxIn_XML("CAS", CAS_Tag, CAS_ID, "true")
Call BoxIn_XML("X1", X1_Tag, X1_ID, "true")
Call BoxIn_XML("X2", X2_Tag, X2_ID, "true")
Call BoxIn_XML("X3", X3_Tag, X3_ID, "true")
Call BoxIn_XML("X4", X4_Tag, X4_ID, "true")
Call BoxIn_XML("S1", S1_Tag, S1_ID, "true")
Call BoxIn_XML("S2", S2_Tag, S2_ID, "true")
Call BoxIn_XML("S3", S3_Tag, S3_ID, "true")
Call BoxIn_XML("S4", S4_Tag, S4_ID, "true")
Call BoxIn_XML("EQU", EQU_Tag, EQU_ID, "true")
'-���������:д���������XML: ����������,�Ƿ���ʾ����
Call BoxOut_XML("OP", "true")
Call BoxOut_XML("OPEU", "true")
'--�����
POU.WriteLine "</element>"

'04-02--����Ԫ��:д����Ԫ��XML: λ��,ID��,����X,����Y
Call Input_XML(MAN_Tag, MAN_ID, Element_X - 2, Element_Y + 1)
Call Input_XML(CAS_Tag, CAS_ID, Element_X - 2, Element_Y + 2)
Call Input_XML(X1_Tag, X1_ID, Element_X - 2, Element_Y + 3)
Call Input_XML(X2_Tag, X2_ID, Element_X - 2, Element_Y + 4)
Call Input_XML(X3_Tag, X3_ID, Element_X - 2, Element_Y + 5)
Call Input_XML(X4_Tag, X4_ID, Element_X - 2, Element_Y + 6)
Call Input_XML(S1_Tag, S1_ID, Element_X - 2, Element_Y + 7)
Call Input_XML(S2_Tag, S2_ID, Element_X - 2, Element_Y + 8)
Call Input_XML(S3_Tag, S3_ID, Element_X - 2, Element_Y + 9)
Call Input_XML(S4_Tag, S4_ID, Element_X - 2, Element_Y + 10)
Call Input_XML(EQU_Tag, EQU_ID, Element_X - 2, Element_Y + 11)

'04-03--���Ԫ��:д���Ԫ��XML:'λ��,ID,����X,����Y,������,���ӵĿ�ID,���ӵĿ�����������
Call Output_XML(OP_Tag, OP_ID, Element_X + 7, Element_Y + 1, Sort_ID + 1, Blok_ID, 0)
Call Output_XML(OPEU_Tag, OPEU_ID, Element_X + 7, Element_Y + 2, Sort_ID + 2, Blok_ID, 1)

End Sub

