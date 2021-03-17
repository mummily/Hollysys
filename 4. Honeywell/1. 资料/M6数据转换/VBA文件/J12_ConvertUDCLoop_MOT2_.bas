Attribute VB_Name = "J12_ConvertUDCLoop_MOT2_"
'ver20190930_by cjt

'ת��MOT2
Sub J12_ConvertUDCLoop_MOT2()

'�ֲ�����
'*****************************************************
'ͨ��
Dim i As Integer 'ѭ������
Dim Element_NO As Long      'Ԫ���ź�
Dim Element_X As Long       'Ԫ��X����
Dim Element_Y As Long       'Ԫ��Y����
Dim Element_ID As Long      'Ԫ��id�ű���
Dim Sort_ID As Long         'Sid������������

'pid��
Dim Blok_ID As Long               '��id�ű���
Dim FBKON_ID As Long              'FBKONid�ű���
Dim FBKOF_ID As Long              'FBKOFid�ű���
Dim OUTON_ID As Long              'OUTONid�ű���
Dim OUTOF_ID As Long              'OUTOFid�ű���
Dim OUT_ID As Long                'OUTid�ű���

Dim Blok_Tag As String       '��λ��
Dim FBKON_Tag As String     'FBKONλ��
Dim FBKOF_Tag As String     'FBKOFλ��

Dim OUTON_Tag As String     'OUTONλ��
Dim OUTOF_Tag As String     'OUTOFλ��
Dim OUT_Tag As String        'OUTλ��
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
Blok_ID = Element_ID            '��id��
FBKON_ID = Element_ID + 1       'FBKONid��
FBKOF_ID = Element_ID + 2       'FBKOFid��
OUTON_ID = Element_ID + 3        'OUTONid��
OUTOF_ID = Element_ID + 4        'OUTOFid��
OUT_ID = Element_ID + 5          'OUTid��
'03---------λ��tag��ȡ
'��λ�Ÿ�ֵ
Blok_Tag = UDC_arr(UDC_i, UDC("NAME"))

'������ֵ����ת���ٸ�ֵ
HNPN_TI = UDC_arr(UDC_i, UDC("DISRC(1)")) '��ת������
Call F2_ConvertPN_TI(HNPN_TI) 'ת��
FBKON_Tag = M6PN_TI '��ֵ
HNPN_TI = UDC_arr(UDC_i, UDC("DISRC(2)")) '��ת������
Call F2_ConvertPN_TI(HNPN_TI) 'ת��
FBKOF_Tag = M6PN_TI '��ֵ

If Len(UDC_arr(UDC_i, UDC("DODSTN(1)"))) > 0 And Len(UDC_arr(UDC_i, UDC("DODSTN(2)"))) > 0 Then
    HNPN_TI = UDC_arr(UDC_i, UDC("DODSTN(1)")) '��ת������
    Call F2_ConvertPN_TI(HNPN_TI) 'ת��
    OUTON_Tag = M6PN_TI '��ֵ
    
    HNPN_TI = UDC_arr(UDC_i, UDC("DODSTN(2)")) '��ת������
    Call F2_ConvertPN_TI(HNPN_TI) 'ת��
    OUTOF_Tag = M6PN_TI '��ֵ
Else
    HNPN_TI = UDC_arr(UDC_i, UDC("DODSTN(1)")) '��ת������
    Call F2_ConvertPN_TI(HNPN_TI) 'ת��
    OUT_Tag = M6PN_TI '��ֵ
End If
'04---------дxml
'д��XML:'λ��,ID,����X,����Y,������,����
Call BOX_XML(Blok_Tag, Blok_ID, Element_X, Element_Y, Sort_ID, "MOT2")
'-����������:д����������XML: ����������,���������ӵ�λ��,���������ӵ�λ��ID,�Ƿ���ʾ����
Call BoxIn_XML("INON", "", 0, "true")
Call BoxIn_XML("INOF", "", 0, "true")

If Len(FBKON_Tag) > 0 And Len(FBKOF_Tag) > 0 Then '˫����
    Call BoxIn_XML("FBKON", FBKON_Tag, FBKON_ID, "true") '������
    Call BoxIn_XML("FBKOF", FBKOF_Tag, FBKOF_ID, "true") '�ط���
End If

If Len(FBKOF_Tag) = 0 Then '������
    If UDC_arr(UDC_i, UDC("D1_1")) = "PVSTATE0" Then
       '��ȡ��
       Call BoxIn_XML2("FBKON", FBKON_Tag, FBKON_ID, 0, "true", "true")
       Call BoxIn_XML("FBKOF", FBKON_Tag, FBKON_ID, "true")
    Else
       '��ȡ��
       Call BoxIn_XML("FBKON", FBKON_Tag, FBKON_ID, "true")
       Call BoxIn_XML2("FBKOF", FBKON_Tag, FBKON_ID, 0, "true", "true")
    
    End If
End If


Call BoxIn_XML("RMTOPT", "", 0, "true")
Call BoxIn_XML("ILSW", "", 0, "true")
Call BoxIn_XML("ILPUT", "", 0, "true")
Call BoxIn_XML("ILIN", "", 0, "true")
Call BoxIn_XML("INQ", "", 0, "true")
Call BoxIn_XML("FALOPT", "", 0, "true")
Call BoxIn_XML("ONEN", "", 0, "true")
Call BoxIn_XML("OFFEN", "", 0, "true")
Call BoxIn_XML("TRKFBK", "", 0, "true")
Call BoxIn_XML("FBKALG", "", 0, "true")
Call BoxIn_XML("FBKALGEN", "", 0, "true")
Call BoxIn_XML("FALTYPE", "", 0, "true")
Call BoxIn_XML("AUTOOPT", "", 0, "true")
Call BoxIn_XML("RST", "", 0, "true")
Call BoxIn_XML("RSTEN", "", 0, "true")
'-���������:д���������XML: ����������,�Ƿ���ʾ����
Call BoxOut_XML("OUTON", "true")
Call BoxOut_XML("OUTOF", "true")
Call BoxOut_XML("OUT", "true")
'--�����
POU.WriteLine "</element>"

'04-02--����Ԫ��:д����Ԫ��XML: λ��,ID��,����X,����Y
Call Input_XML(FBKON_Tag, FBKON_ID, Element_X - 2, Element_Y + 3)
Call Input_XML(FBKOF_Tag, FBKOF_ID, Element_X - 2, Element_Y + 4)
'04-03--���Ԫ��:д���Ԫ��XML:'λ��,ID,����X,����Y,������,���ӵĿ�ID,���ӵĿ�����������
If Not UDC_arr(UDC_i, UDC("DODSTN(1)")) Like "*PULSE*" Then '��ת������

    If UDC_arr(UDC_i, UDC("ST0_OP1")) = "OFF" Then
        Call Output_XML2(OUTON_Tag, OUTON_ID, Element_X + 9, Element_Y + 3, Sort_ID + 1, Blok_ID, 2, "false")
        Call Output_XML2(OUT_Tag, OUT_ID, Element_X + 9, Element_Y + 3, Sort_ID + 1, Blok_ID, 2, "false")
    Else
        Call Output_XML2(OUTON_Tag, OUTON_ID, Element_X + 9, Element_Y + 3, Sort_ID + 1, Blok_ID, 2, "true")
        Call Output_XML2(OUT_Tag, OUT_ID, Element_X + 9, Element_Y + 3, Sort_ID + 1, Blok_ID, 2, "true")
    End If
    
    If UDC_arr(UDC_i, UDC("ST0_OP2")) = "OFF" Then
       Call Output_XML2(OUTOF_Tag, OUTOF_ID, Element_X + 9, Element_Y + 4, Sort_ID + 2, Blok_ID, 2, "false")
    Else
        Call Output_XML2(OUTOF_Tag, OUTOF_ID, Element_X + 9, Element_Y + 4, Sort_ID + 2, Blok_ID, 2, "true")
    End If
    
End If



End Sub
