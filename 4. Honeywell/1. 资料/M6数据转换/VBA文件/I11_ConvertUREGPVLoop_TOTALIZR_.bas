Attribute VB_Name = "I11_ConvertUREGPVLoop_TOTALIZR_"
'ver20190930_by cjt

'ת��TOTALIZR
Sub I11_ConvertUREGPVLoop_TOTALIZR()

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
Dim RS_ID As Long              'RSid�ű���
Dim OUT_ID As Long             'OUTid�ű���
Dim FULLIND_ID As Long         'FULLINDid�ű���
Dim OR_ID As Long              'ORid�ű���

Dim Blok_Tag As String   '��λ��
Dim IN_Tag As String     'INλ��
Dim RS_Tag As String     'RSλ��
Dim OUT_Tag As String     'OUTλ��
Dim FULLIND_Tag As String 'FULLINDλ��
Dim OR_Tag As String      'ORλ��

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
RS_ID = Element_ID + 2       'RSid��
FULLIND_ID = Element_ID + 3  'FULLINDid��
OUT_ID = Element_ID + 4      'OUTid��
OR_ID = Element_ID + 5       'ORid��

'03---------λ��tag��ȡ
'��λ�Ÿ�ֵ
OUT_Tag = UREGPV_arr(UREGPV_i, UREGPV("NAME"))
Blok_Tag = OUT_Tag & "_SUM"
FULLIND_Tag = Blok_Tag & ".FULLIND"
RS_Tag = OUT_Tag & "_RS"
'������ֵ����ת���ٸ�ֵ
HNPN_TI = UREGPV_arr(UREGPV_i, UREGPV("PISRC(1)")) '��ת������
Call F2_ConvertPN_TI(HNPN_TI) 'ת��
IN_Tag = M6PN_TI '��ֵ




'04---------дxml
'д��XML:'λ��,ID,����X,����Y,������,����
Call BOX_XML(Blok_Tag, Blok_ID, Element_X, Element_Y, Sort_ID, "FLOWSUM")
'-����������:д����������XML: ����������,���������ӵ�λ��,���������ӵ�λ��ID,�Ƿ���ʾ����
Call BoxIn_XML("IN", IN_Tag, IN_ID, "true")
Call BoxIn_XML("RST", RS_Tag, OR_ID, "true")
'-���������:д���������XML: ����������,�Ƿ���ʾ����
Call BoxOut_XML("OUT", "true")
'--�����
POU.WriteLine "</element>"

'04-02--����Ԫ��:д����Ԫ��XML: λ��,ID��,����X,����Y
Call Input_XML(IN_Tag, IN_ID, Element_X - 2, Element_Y + 1)

'04-03--���Ԫ��:д���Ԫ��XML:'λ��,ID,����X,����Y,������,���ӵĿ�ID,���ӵĿ�����������
Call Output_XML(OUT_Tag & ".AI", OUT_ID, Element_X + 9, Element_Y + 1, Sort_ID + 1, Blok_ID, 0)

'04-04--�鿪ʼ
'д��XML:'������,����ID,��������X,��������Y,����������,EN���ӵ�Ԫ��id,����1���ӵ�Ԫ��id,����2���ӵ�Ԫ��id,�Ƿ���ʾEN
Call BOX2_XML("OR", OR_ID, Element_X - 6, Element_Y + 3, Sort_ID + 2, -1, RS_ID, FULLIND_ID, False)

'04-05--����Ԫ��:д����Ԫ��XML: λ��,ID��,����X,����Y
Call Input_XML(RS_Tag, RS_ID, Element_X - 7, Element_Y + 4)
Call Input_XML(FULLIND_Tag, FULLIND_ID, Element_X - 7, Element_Y + 5)


End Sub


