Attribute VB_Name = "G14_ConvertUREGLoop_SWITCH_"
'ver20190821_by cjt

'ת��SWITCH
Sub G14_ConvertUREGLoop_SWITCH()

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

'id��
Dim Blok_ID As Long            '��id�ű���
'Dim MAN_ID As Long             'MANid�ű���
'Dim CAS_ID As Long             'CASid�ű���
Dim X1_ID As Long              'X1id�ű���
Dim X2_ID As Long              'X2id�ű���
Dim X3_ID As Long              'X3id�ű���
Dim X4_ID As Long              'X4id�ű���
Dim S1_ID As Long              'S1id�ű���
Dim S2_ID As Long              'S2id�ű���
Dim S3_ID As Long              'S3id�ű���
Dim S4_ID As Long              'S4id�ű���
Dim SELXINP_ID As Long         'EUQid�ű���
Dim CV_ID As Long              'CVid�ű���
Dim OPEU_ID As Long              'OPid�ű���

'λ��
Dim Blok_Tag As String            '��λ��
'Dim MAN_Tag As String             'MANλ�ű���
'Dim CAS_Tag As String             'CASλ�ű���
Dim X1_Tag As String              'X1λ�ű���
Dim X2_Tag As String              'X2λ�ű���
Dim X3_Tag As String              'X3λ�ű���
Dim X4_Tag As String              'X4λ�ű���
Dim S1_Tag As String              'S1λ�ű���
Dim S2_Tag As String              'S2λ�ű���
Dim S3_Tag As String              'S3λ�ű���
Dim S4_Tag As String              'S4λ�ű���
Dim SELXINP_Tag As String         'EUQλ�ű���
Dim CV_Tag As String             'CVλ�ű���
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
'
'��ȡID\ID�Լ�
Blok_ID = Element_ID         '��id��
'MAN_ID = Element_ID + 1     'MANid��
'CAS_ID = Element_ID + 2     'CASid��
X1_ID = Element_ID + 1       'X1id��
X2_ID = Element_ID + 2       'X2id��
X3_ID = Element_ID + 3       'X3id��
X4_ID = Element_ID + 4       'X4id��
S1_ID = Element_ID + 5       'S1id��
S2_ID = Element_ID + 6       'S2id��
S3_ID = Element_ID + 7        'S3id��
S4_ID = Element_ID + 8        'S4id��
SELXINP_ID = Element_ID + 9   'SELXINPid��
CV_ID = Element_ID + 10       '��CVid��
OPEU_ID = Element_ID + 11      'OPid��



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
''MAN
'If Len(UREGC_arr(UREGC_i, UREGC("CTLEQN"))) = "EQA" Then
'    MAN_Tag = "TRUE"
'Else
'    MAN_Tag = "FALSE"
'End If
''CAS
'If Len(UREGC_arr(UREGC_i, UREGC("CTLEQN"))) = "EQA" Then
'    CAS_Tag = "FALSE"
'Else
'    CAS_Tag = "TRUE"
'End If
'X1
If CISRC.Exists("X1") Then
    HNPN_TI = CISRC("X1") '��ֵ
    Call F2_ConvertPN_TI(HNPN_TI) 'ת��
    X1_Tag = M6PN_TI
Else
    X1_Tag = ""
End If
'X2
If CISRC.Exists("X2") Then
    HNPN_TI = CISRC("X2") '��ֵ
    Call F2_ConvertPN_TI(HNPN_TI) 'ת��
    X2_Tag = M6PN_TI
Else
    X2_Tag = ""
End If
'X3
If CISRC.Exists("X3") Then
    HNPN_TI = CISRC("X3") '��ֵ
    Call F2_ConvertPN_TI(HNPN_TI) 'ת��
    X3_Tag = M6PN_TI
Else
    X3_Tag = ""
End If
'X4
If CISRC.Exists("X4") Then
    HNPN_TI = CISRC("X4") '��ֵ
    Call F2_ConvertPN_TI(HNPN_TI) 'ת��
    X4_Tag = M6PN_TI
Else
    X4_Tag = ""
End If
''S1
'If UREGC1_arr(UREGC1Name(Blok_Tag), UREGC1("$MODESEL(1)")) = "ON" Then
'    S1_Tag = "TRUE"
'Else
'    S1_Tag = "FALSE"
'End If
''S2
'If UREGC1_arr(UREGC1Name(Blok_Tag), UREGC1("$MODESEL(2)")) = "ON" Then
'    S2_Tag = "TRUE"
'Else
'    S2_Tag = "FALSE"
'End If
''S3
'If UREGC1_arr(UREGC1Name(Blok_Tag), UREGC1("$MODESEL(3)")) = "ON" Then
'    S3_Tag = "TRUE"
'Else
'    S3_Tag = "FALSE"
'End If
''S4
'If UREGC1_arr(UREGC1Name(Blok_Tag), UREGC1("$MODESEL(4)")) = "ON" Then
'    S4_Tag = "TRUE"
'Else
'    S4_Tag = "FALSE"
'End If
''SELXINP
'If UREGC_arr(UREGC_i, UREGC("SELXINP")) = "" Then
'    SELXINP_Tag = "0"
'Else
'    SELXINP_Tag = Replace(UREGC_arr(UREGC_i, UREGC("SELXINP")), "SELECTX", "")
'End If

'-�����ֵ����ת���ٸ�ֵ
'CV
If Len(UREGC_arr(UREGC_i, UREGC("CODSTN(1)"))) > 0 Then
    HNPN_TI = UREGC_arr(UREGC_i, UREGC("CODSTN(1)"))  '��ֵ
    Call F2_ConvertPN_TI(HNPN_TI) 'ת��
    CV_Tag = M6PN_TI
Else
    CV_Tag = ""
End If
'OPEU
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
'Call BoxIn_XML("MAN", MAN_Tag, MAN_ID, "true")
'Call BoxIn_XML("CAS", CAS_Tag, CAS_ID, "true")
Call BoxIn_XML("X1", X1_Tag, X1_ID, "true")
Call BoxIn_XML("X2", X2_Tag, X2_ID, "true")
Call BoxIn_XML("X3", X3_Tag, X3_ID, "true")
Call BoxIn_XML("X4", X4_Tag, X4_ID, "true")
Call BoxIn_XML("SELXINP", SELXINP_Tag, SELXINP_ID, "true")
Call BoxIn_XML("S1", S1_Tag, S1_ID, "true")
Call BoxIn_XML("S2", S2_Tag, S2_ID, "true")
Call BoxIn_XML("S3", S3_Tag, S3_ID, "true")
Call BoxIn_XML("S4", S4_Tag, S4_ID, "true")

'-���������:д���������XML: ����������,�Ƿ���ʾ����
Call BoxOut_XML("CV", "true")
Call BoxOut_XML("PVAUTOST", "true")
'--�����
POU.WriteLine "</element>"

'04-02--����Ԫ��:д����Ԫ��XML: λ��,ID��,����X,����Y
'Call Input_XML(MAN_Tag, MAN_ID, Element_X - 2, Element_Y + 1)
'Call Input_XML(CAS_Tag, CAS_ID, Element_X - 2, Element_Y + 2)
Call Input_XML(X1_Tag, X1_ID, Element_X - 2, Element_Y + 1)
Call Input_XML(X2_Tag, X2_ID, Element_X - 2, Element_Y + 2)
Call Input_XML(X3_Tag, X3_ID, Element_X - 2, Element_Y + 3)
Call Input_XML(X4_Tag, X4_ID, Element_X - 2, Element_Y + 4)
Call Input_XML(SELXINP_Tag, SELXINP_ID, Element_X - 2, Element_Y + 5)
Call Input_XML(S1_Tag, S1_ID, Element_X - 2, Element_Y + 6)
Call Input_XML(S2_Tag, S2_ID, Element_X - 2, Element_Y + 7)
Call Input_XML(S3_Tag, S3_ID, Element_X - 2, Element_Y + 8)
Call Input_XML(S4_Tag, S4_ID, Element_X - 2, Element_Y + 9)


'04-03--���Ԫ��:д���Ԫ��XML:'λ��,ID,����X,����Y,������,���ӵĿ�ID,���ӵĿ�����������
Call Output_XML(CV_Tag, CV_ID, Element_X + 12, Element_Y + 3, Sort_ID + 1, Blok_ID, 2)
Call Output_XML(OPEU_Tag, OPEU_ID, Element_X + 12, Element_Y + 4, Sort_ID + 2, Blok_ID, 2)

End Sub

