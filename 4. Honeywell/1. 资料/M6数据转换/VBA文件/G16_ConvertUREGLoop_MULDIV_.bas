Attribute VB_Name = "G16_ConvertUREGLoop_MULDIV_"
'ver20190821_by cjt

'ת��SWITCH
Sub G16_ConvertUREGLoop_MULDIV()

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
Dim X1_ID As Long              'X1id�ű���
Dim X2_ID As Long              'X2id�ű���
Dim X3_ID As Long              'X3id�ű���
'Dim X4_ID As Long              'X4id�ű���
'Dim B_ID As Long               'Bid�ű���
'Dim B1_ID As Long              'B1id�ű���
'Dim B2_ID As Long              'B2id�ű���
'Dim B3_ID As Long              'B3id�ű���
'Dim K_ID As Long               'Kid�ű���
'Dim K1_ID As Long              'K1id�ű���
'Dim K2_ID As Long              'K2id�ű���
'Dim K3_ID As Long              'K3id�ű���
'Dim K4_ID As Long              'K4id�ű���
'Dim EQU_ID As Long             'EUQid�ű���
Dim CV_ID As Long               'CVid�ű���
Dim OPEU_ID As Long              'OPid�ű���

'λ��
Dim Blok_Tag As String            '��λ��
'Dim MAN_Tag As String             'MANλ�ű���
'Dim CAS_Tag As String             'CASλ�ű���
Dim X1_Tag As String              'X1λ�ű���
Dim X2_Tag As String              'X2λ�ű���
Dim X3_Tag As String              'X3λ�ű���
'Dim X4_Tag As String              'X4λ�ű���
'Dim B_Tag As String               'Bλ�ű���
'Dim B1_Tag As String              'B1λ�ű���
'Dim B2_Tag As String              'B2λ�ű���
'Dim B3_Tag As String              'B3λ�ű���
'Dim K_Tag As String               'Kλ�ű���
'Dim K1_Tag As String              'K1λ�ű���
'Dim K2_Tag As String              'K2λ�ű���
'Dim K3_Tag As String              'K3λ�ű���
'Dim K4_Tag As String              'K4λ�ű���
'Dim EQU_Tag As String             'EUQλ�ű���
Dim CV_Tag As String               'CVλ�ű���
Dim OPEU_Tag As String             'OPEUλ�ű���
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
'MAN_ID = Element_ID + 1    'MANid��
'CAS_ID = Element_ID + 2    'CASid��
X1_ID = Element_ID + 1     'X1id��
X2_ID = Element_ID + 2     'X2id��
X3_ID = Element_ID + 3     'X3id��
X4_ID = Element_ID + 4     'X4id��
'B_ID = Element_ID + 7      'Bid��
'B1_ID = Element_ID + 8     'B1id��
'B2_ID = Element_ID + 9     'B2id��
'B3_ID = Element_ID + 10    'B3id��
'K_ID = Element_ID + 11      'Kid��
'K1_ID = Element_ID + 12     'K1id��
'K2_ID = Element_ID + 13     'K2id��
'K3_ID = Element_ID + 14    'K3id��
'K4_ID = Element_ID + 15    'K4id��
'EQU_ID = Element_ID + 16    'EQUid��
CV_ID = Element_ID + 5     'OPid��
OPEU_ID = Element_ID + 6    'OPEUid��



'03---------λ��tag��ȡ
'03-01--��λ�Ÿ�ֵ
Blok_Tag = UREGC_arr(UREGC_i, UREGC("NAME"))

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
HNPN_TI = UREGC_arr(UREGC_i, UREGC("CISRC(1)")) '��ֵ
Call F2_ConvertPN_TI(HNPN_TI) 'ת��
X1_Tag = M6PN_TI
'X2
HNPN_TI = UREGC_arr(UREGC_i, UREGC("CISRC(2)")) '��ֵ
Call F2_ConvertPN_TI(HNPN_TI) 'ת��
X2_Tag = M6PN_TI
'X3
HNPN_TI = UREGC_arr(UREGC_i, UREGC("CISRC(3)")) '��ֵ
Call F2_ConvertPN_TI(HNPN_TI) 'ת��
X3_Tag = M6PN_TI
''X4
'HNPN_TI = UREGC_arr(UREGC_i, UREGC("CISRC(4)")) '��ֵ
'Call F2_ConvertPN_TI(HNPN_TI) 'ת��
'X4_Tag = M6PN_TI
''B
'HNPN_TI = UREGC_arr(UREGC_i, UREGC("B")) '��ֵ
'Call F2_ConvertPN_TI(HNPN_TI) 'ת��
'B_Tag = M6PN_TI
''B1
'HNPN_TI = UREGC_arr(UREGC_i, UREGC("B1")) '��ֵ
'Call F2_ConvertPN_TI(HNPN_TI) 'ת��
'B1_Tag = M6PN_TI
''B2
'HNPN_TI = UREGC_arr(UREGC_i, UREGC("B2")) '��ֵ
'Call F2_ConvertPN_TI(HNPN_TI) 'ת��
'B2_Tag = M6PN_TI
''B3
'HNPN_TI = UREGC_arr(UREGC_i, UREGC("B3")) '��ֵ
'Call F2_ConvertPN_TI(HNPN_TI) 'ת��
'B3_Tag = M6PN_TI
''K
'HNPN_TI = UREGC_arr(UREGC_i, UREGC("K")) '��ֵ
'Call F2_ConvertPN_TI(HNPN_TI) 'ת��
'K_Tag = M6PN_TI
''K1
'HNPN_TI = UREGC_arr(UREGC_i, UREGC("K1")) '��ֵ
'Call F2_ConvertPN_TI(HNPN_TI) 'ת��
'K1_Tag = M6PN_TI
''K2
'HNPN_TI = UREGC_arr(UREGC_i, UREGC("K2")) '��ֵ
'Call F2_ConvertPN_TI(HNPN_TI) 'ת��
'K2_Tag = M6PN_TI
''K3
'HNPN_TI = UREGC_arr(UREGC_i, UREGC("K3")) '��ֵ
'Call F2_ConvertPN_TI(HNPN_TI) 'ת��
'K3_Tag = M6PN_TI
''K4
'HNPN_TI = UREGC_arr(UREGC_i, UREGC("K4")) '��ֵ
'Call F2_ConvertPN_TI(HNPN_TI) 'ת��
'K4_Tag = M6PN_TI
''EQU
'If UREGC_arr(UREGC_i, UREGC("CTLEQN")) = "" Then
'    EQU_Tag = "0"
'End If
'If UREGC_arr(UREGC_i, UREGC("CTLEQN")) = "EQA" Then
'    EQU_Tag = "1"
'End If
'If UREGC_arr(UREGC_i, UREGC("CTLEQN")) = "EQB" Then
'    EQU_Tag = "2"
'End If
'-�����ֵ����ת���ٸ�ֵ
'CV
If Len(UREGC_arr(UREGC_i, UREGC("CODSTN(1)"))) > 0 Then
    HNPN_TI = UREGC_arr(UREGC_i, UREGC("CODSTN(1)"))  '��ֵ
    Call F2_ConvertPN_TI(HNPN_TI) 'ת��
    CV_Tag = M6PN_TI
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
Call BOX_XML(Blok_Tag, Blok_ID, Element_X, Element_Y, Sort_ID, "MULDIV")
'-����������:д����������XML: ����������,���������ӵ�λ��,���������ӵ�λ��ID,�Ƿ���ʾ����
'Call BoxIn_XML("MAN", MAN_Tag, MAN_ID, "true")
'Call BoxIn_XML("CAS", CAS_Tag, CAS_ID, "true")
Call BoxIn_XML("X1", X1_Tag, X1_ID, "true")
Call BoxIn_XML("X2", X2_Tag, X2_ID, "true")
Call BoxIn_XML("X3", X3_Tag, X3_ID, "true")
'Call BoxIn_XML("X4", X4_Tag, X4_ID, "true")
'Call BoxIn_XML("B", B_Tag, B_ID, "true")
'Call BoxIn_XML("B1", B1_Tag, B1_ID, "true")
'Call BoxIn_XML("B2", B2_Tag, B2_ID, "true")
'Call BoxIn_XML("B3", B3_Tag, B3_ID, "true")
'Call BoxIn_XML("K", K_Tag, K_ID, "true")
'Call BoxIn_XML("K1", K1_Tag, K1_ID, "true")
'Call BoxIn_XML("K2", K2_Tag, K2_ID, "true")
'Call BoxIn_XML("K3", K3_Tag, K3_ID, "true")
'Call BoxIn_XML("K4", K4_Tag, K4_ID, "true")
'Call BoxIn_XML("EQU", EQU_Tag, EQU_ID, "true")
'-���������:д���������XML: ����������,�Ƿ���ʾ����
Call BoxOut_XML("CV", "true")
'Call BoxOut_XML("OPEU", "true")
'--�����
POU.WriteLine "</element>"

'04-02--����Ԫ��:д����Ԫ��XML: λ��,ID��,����X,����Y
'Call Input_XML(MAN_Tag, MAN_ID, Element_X - 2, Element_Y + 1)
'Call Input_XML(CAS_Tag, CAS_ID, Element_X - 2, Element_Y + 2)
Call Input_XML(X1_Tag, X1_ID, Element_X - 2, Element_Y + 1)
Call Input_XML(X2_Tag, X2_ID, Element_X - 2, Element_Y + 2)
Call Input_XML(X3_Tag, X3_ID, Element_X - 2, Element_Y + 3)
'Call Input_XML(X4_Tag, X4_ID, Element_X - 2, Element_Y + 6)
'Call Input_XML(B_Tag, B_ID, Element_X - 2, Element_Y + 7)
'Call Input_XML(B1_Tag, B1_ID, Element_X - 2, Element_Y + 8)
'Call Input_XML(B2_Tag, B2_ID, Element_X - 2, Element_Y + 9)
'Call Input_XML(B3_Tag, B3_ID, Element_X - 2, Element_Y + 10)
'Call Input_XML(K_Tag, K_ID, Element_X - 2, Element_Y + 11)
'Call Input_XML(K1_Tag, K1_ID, Element_X - 2, Element_Y + 12)
'Call Input_XML(K2_Tag, K2_ID, Element_X - 2, Element_Y + 13)
'Call Input_XML(K3_Tag, K3_ID, Element_X - 2, Element_Y + 14)
'Call Input_XML(K4_Tag, K4_ID, Element_X - 2, Element_Y + 15)
'Call Input_XML(EQU_Tag, EQU_ID, Element_X - 2, Element_Y + 16)

'04-03--���Ԫ��:д���Ԫ��XML:'λ��,ID,����X,����Y,������,���ӵĿ�ID,���ӵĿ�����������
Call Output_XML(CV_Tag, CV_ID, Element_X + 12, Element_Y + 2, Sort_ID + 1, Blok_ID, 1)
Call Output_XML(OPEU_Tag, OPEU_ID, Element_X + 12, Element_Y + 3, Sort_ID + 2, Blok_ID, 1)


End Sub
