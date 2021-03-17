Attribute VB_Name = "I13_ConvertUREGPVLoop_GENLIN_"
'ver20190930_by cjt

'ת��GENLIN
Sub I13_ConvertUREGPVLoop_GENLIN()

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
Dim Blok_ID As Long            '��id�ű���
Dim IN_ID As Long              'INid�ű���
Dim OUT_ID As Long             'OUTid�ű���

Dim Blok_Tag As String   '��λ��
Dim IN_Tag As String     'INλ��
Dim OUT_Tag As String     'OUTλ��

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
IN_ID = Element_ID + 1       'INid��
OUT_ID = Element_ID + 2      'OUTid��

'03---------λ��tag��ȡ
'��λ�Ÿ�ֵ
OUT_Tag = UREGPV_arr(UREGPV_i, UREGPV("NAME"))
Blok_Tag = OUT_Tag & "_FOLD"

'������ֵ����ת���ٸ�ֵ
HNPN_TI = UREGPV_arr(UREGPV_i, UREGPV("PISRC(1)")) '��ת������
Call F2_ConvertPN_TI(HNPN_TI) 'ת��
IN_Tag = M6PN_TI '��ֵ


'04---------дxml
'д��XML:'λ��,ID,����X,����Y,������,����
Call BOX_XML(Blok_Tag, Blok_ID, Element_X, Element_Y, Sort_ID, "ONEFOLD")
'-����������:д����������XML: ����������,���������ӵ�λ��,���������ӵ�λ��ID,�Ƿ���ʾ����
Call BoxIn_XML("IN", IN_Tag, IN_ID, "true")
'-���������:д���������XML: ����������,�Ƿ���ʾ����
Call BoxOut_XML("OUT", "true")
'--�����
POU.WriteLine "</element>"

'04-02--����Ԫ��:д����Ԫ��XML: λ��,ID��,����X,����Y
Call Input_XML(IN_Tag, IN_ID, Element_X - 2, Element_Y + 1)

'04-03--���Ԫ��:д���Ԫ��XML:'λ��,ID,����X,����Y,������,���ӵĿ�ID,���ӵĿ�����������
Call Output_XML(OUT_Tag & ".AI", OUT_ID, Element_X + 9, Element_Y + 1, Sort_ID + 1, Blok_ID, 0)

'04-04--д����X,Y
Dim jj2 As Integer
Dim varX As String
Dim varY As String

'��ʼ����
Element_ID = 10
Sort_ID = 2
Element_X = 20
Element_Y = 20

For jj2 = 0 To 12
     If Len(UREGPV_arr(UREGPV_i, UREGPV("IN" & jj2))) > 0 Then
         varX = UREGPV_arr(UREGPV_i, UREGPV("IN" & jj2))
         varY = UREGPV_arr(UREGPV_i, UREGPV("OUT" & jj2))
        'X��
         Element_Y = Element_Y + 1
         Element_ID = Element_ID + 1
         Call Input_XML(varX, Element_ID, Element_X, Element_Y)
         Element_ID = Element_ID + 1
         Sort_ID = Sort_ID + 1
         Call Output_XML(Blok_Tag & ".XARR[" & jj2 + 1 & "]", Element_ID, Element_X + 1, Element_Y, Sort_ID, Element_ID - 1, 0)

        'Y��
         Element_ID = Element_ID + 1
         Call Input_XML(varY, Element_ID, Element_X + 20, Element_Y)
         Element_ID = Element_ID + 1
         Sort_ID = Sort_ID + 1
         Call Output_XML(Blok_Tag & ".YARR[" & jj2 + 1 & "]", Element_ID, Element_X + 1 + 20, Element_Y, Sort_ID, Element_ID - 1, 0)
         
     End If
Next


End Sub



