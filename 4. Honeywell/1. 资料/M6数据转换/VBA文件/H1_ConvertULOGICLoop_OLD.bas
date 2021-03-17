Attribute VB_Name = "H1_ConvertULOGICLoop_OLD"
'ver20190821_by cjt
'UREGCȫ�ֱ�������
Public ULOGIC_i As Long         'ULOGIC�Զ�����ѭ������
Public ULOGIC1Name As Object     'ULOGIC1name�ֵ�
Public ULOGIC2Name As Object     'ULOGIC2name�ֵ�
Public LElement_X As Long       'LOGIC Ԫ��X����
Public LElement_Y As Long       'LOGIC Ԫ��Y����

Public LBox_X As Long            'LOGIC Ԫ��X����
Public LBox_Y As Long            'LOGIC Ԫ��Y����

Public LSort_ID As Long         'LOGIC Sid������������

Public LElement_ID As Long      'LOGIC Ԫ��id�ű���
Public LBox_ID As Long          'LOGIC ��ID
Public LBoxEN_ID As Long       'LOGIC ��EN ID
Public LBoxIn1_ID As Long       'LOGIC ������1ID
Public LBoxIn2_ID As Long       'LOGIC ������2ID
Public LBoxIn3_ID As Long       'LOGIC ������3ID
Public LBoxOut1_ID As Long       'LOGIC �����1ID
Public LBox_type As String        'LOGIC������
'ת��UREGC����
Sub H1_ConvertULOGICLoop()
Dim i As Integer 'ѭ������
Dim Box_type As String '������
Dim NAME As Variant '������

'01--��ʼ��ֵ
'--------------------------------------------------------------------------------------------------------
Lab = """"             '"��ʾ�ַ���

'ʵ�����ֵ�
Set ULOGIC1Name = CreateObject("Scripting.Dictionary") 'UREGC1name�ֵ�
Set ULOGIC2Name = CreateObject("Scripting.Dictionary") 'UREGC2name�ֵ�
'02--��ULOGIC1~2name���кŴ浽�ֵ����
For i = 2 To UBound(ULOGIC1_arr(), 1) 'ULOGICname1�ֵ�
    ULOGIC1Name.Add ULOGIC1_arr(i, ULOGIC1("NAME")), i
Next
For i = 2 To UBound(ULOGIC2_arr(), 1) 'ULOGICname1�ֵ�
    ULOGIC2Name.Add ULOGIC2_arr(i, ULOGIC2("NAME")), i
Next
'03--����XML�ļ�
'--------------------------------------------------------------------------------------------------------
For ULOGIC_i = 2 To UBound(ULOGIC_arr(), 1)
        LElement_X = 34
        LElement_Y = 15
        LElement_ID = 1
        LSort_ID = 0
        
        NAME = ULOGIC_arr(ULOGIC_i, ULOGIC("NAME")) '����λ��
        If Len(NAME) > 0 Then '���ƴ�����ת��
        
                  POU_Name = NAME & "_LG" '����ҳ��
                  POU_Description = ULOGIC_arr(ULOGIC_i, ULOGIC("PTDESC"))     '����ҳ����
                  POUnamef = PATH & "\�����ļ�\" & SN(ULOGIC_arr(ULOGIC_i, ULOGIC("NODENUM"))) & "\" & POU_Name & ".xml"   '����ҳ�ļ��洢·��
                  
                   '�����ļ�
                  Set fs = CreateObject("Scripting.FileSystemObject")
                  Set POU = fs.CreateTextFile(POUnamef, True)
                  
                  '(*XML�ļ���ʼ���ò���*)
                  '--------------------------------------------------------------------------------------------------------
                  POU.WriteLine "<?xml version=" & Lab & "1.0" & Lab & " encoding=" & Lab & "ISO-8859-1" & Lab & "?>"
                  POU.WriteLine "<pou>"
                  POU.WriteLine "<path><![CDATA[\/" & "ULOGIC" & "]]></path>"
                  POU.WriteLine "<name>" & POU_Name & "</name>" '����ҳ��
                  POU.WriteLine "<secondName></secondName>"
                  POU.WriteLine "<description>" & POU_Description & "</description>" '����ҳ����
                  POU.WriteLine "<flags>2048</flags>"
                  POU.WriteLine "<POUCycle>500</POUCycle>"
                  POU.WriteLine "<auto-sort>0</auto-sort>"
                  POU.WriteLine "<exporttime>2014-04-29 21:41:00</exporttime>"
                  POU.WriteLine "<amendtime>2014-04-29 21:40:40</amendtime>"
                  POU.WriteLine "<downloadtime></downloadtime>"
                  POU.WriteLine "<modifier></modifier>"
                  POU.WriteLine "<PouPaperSize>AX</PouPaperSize>"
                  POU.WriteLine "<PouPrintType>0</PouPrintType>"
                  POU.WriteLine "<interface>"
                  POU.WriteLine "<![CDATA[PROGRAM " & POU_Name
                  POU.WriteLine "VAR"
                  POU.WriteLine "NN1(2070): REAL := 0;       (*NN1����*)"
                  POU.WriteLine "NN2(2070): REAL := 0;       (*NN2����*)"
                  POU.WriteLine "NN3(2070): REAL := 0;       (*NN3����*)"
                  POU.WriteLine "NN4(2070): REAL := 0;       (*NN4����*)"
                  POU.WriteLine "NN5(2070): REAL := 0;       (*NN5����*)"
                  POU.WriteLine "NN6(2070): REAL := 0;       (*NN6����*)"
                  POU.WriteLine "NN7(2070): REAL := 0;       (*NN7����*)"
                  POU.WriteLine "NN8(2070): REAL := 0;       (*NN8����*)"
                  POU.WriteLine "TPXX(2070): TP := ( IN:=FALSE, PT:=T#2S, Q:=FALSE, ET:=T#0S, StartTime:=T#0S );       (*TPXXX*)"
                  POU.WriteLine "END_VAR]]>"
                  POU.WriteLine "</interface>"
                  POU.WriteLine "<cfc>"
                  
                'ULOGIC1�ֶ�����
                For i = 1 To UBound(ULOGIC1_arr(), 2)
                    If ULOGIC1_arr(1, i) Like "*LOGALGID*" Then
                       Box_type = ULOGIC1_arr(ULOGIC1Name(NAME), i)
                    End If
                    Select Case Box_type '��������ת��
                      Case "AND" 'ת��
                            LBox_type = "ADD"
                            Call ULOGIC_AND 'ת��AND
                            
                      Case "PULSE" 'ת��
                            LBox_type = "TP"
                            Call ULOGIC_TP 'ת��TP
                            
                     End Select
                  
                Next

                  '(*XML�ļ��������ò���*)
                  '--------------------------
                  POU.WriteLine "</cfc>"
                  POU.WriteLine "</pou>"
                  
                  '(*����ҳ�ļ��ر�*)
                  '---------------------------
                 POU.Close
        End If
   
Next ULOGIC_i

End Sub
Sub ULOGIC_AND()

Dim TagTest As String
'ID
LBox_ID = LElement_ID
LElement_ID = LElement_ID + 1
LBoxEN_ID = LElement_ID
LElement_ID = LElement_ID + 1
LBoxIn1_ID = LElement_ID
LElement_ID = LElement_ID + 1
LBoxIn2_ID = LElement_ID
LElement_ID = LElement_ID + 1
LBoxIn3_ID = LElement_ID
LElement_ID = LElement_ID + 1
LBoxOut1_ID = LElement_ID
LElement_ID = LElement_ID + 1
'����
LBox_X = LElement_X
LBox_Y = LElement_Y

LElement_X = LElement_X + 0
LElement_Y = LElement_Y + 10
'-------��Ԫ��
'д��XML:'������,����ID,��������X,��������Y,����������,EN���ӵ�Ԫ��id,����1���ӵ�Ԫ��id,����2���ӵ�Ԫ��id,�Ƿ���ʾEN
Call BOX2_XML(LBox_type, LBox_ID, LBox_X, LBox_Y, LSort_ID, LBoxEN_ID, LBoxIn1_ID, LBoxIn2_ID, False)
LSort_ID = LSort_ID + 1
'-------����Ԫ��
'д����Ԫ��XML: λ��,ID��,����X,����Y
TagTest = "13GSO0011A.PVFL"
Call F2_ConvertPN_TI(TagTest) 'ת��
TagTest = M6PN_TI '��ֵ

Call Input_XML(TagTest, LBoxIn1_ID, LBox_X - 2, LBox_Y + 1)
Call Input_XML("BB", LBoxIn2_ID, LBox_X - 2, LBox_Y + 2)
'-------���Ԫ��
'д���Ԫ��XML:'λ��,ID,����X,����Y,������,���ӵĿ�ID,���ӵĿ�����������
Call Output_XML("CC", LBoxOut1_ID, LBox_X + 6, LBox_Y + 1, LSort_ID, LBox_ID, 0)
LSort_ID = LSort_ID + 1
End Sub
  
Sub ULOGIC_TP()
'ID
LBox_ID = LElement_ID
LElement_ID = LElement_ID + 1
LBoxEN_ID = LElement_ID
LElement_ID = LElement_ID + 1
LBoxIn1_ID = LElement_ID
LElement_ID = LElement_ID + 1
LBoxIn2_ID = LElement_ID
LElement_ID = LElement_ID + 1
LBoxIn3_ID = LElement_ID
LElement_ID = LElement_ID + 1
LBoxOut1_ID = LElement_ID
LElement_ID = LElement_ID + 1
'����
LBox_X = LElement_X
LBox_Y = LElement_Y

LElement_X = LElement_X + 0
LElement_Y = LElement_Y + 10
'-------��Ԫ��
''д��XML:'λ��,ID,����X,����Y,������,����
Call BOX_XML("TPXX", LBox_ID, LBox_X, LBox_Y, LSort_ID, LBox_type)
'-����������:д����������XML: ����������,���������ӵ�λ��,���������ӵ�λ��ID,�Ƿ���ʾ����
Call BoxIn_XML("IN", "AA", LBoxIn1_ID, "true")
Call BoxIn_XML("PT", "BB", LBoxIn2_ID, "true")
'-���������:д���������XML: ����������,�Ƿ���ʾ����
Call BoxOut_XML("Q", "true")
'-���������:д���������XML: ����������,�Ƿ���ʾ����
Call BoxOut_XML("ET", "true")
'--�����
POU.WriteLine "</element>"
LSort_ID = LSort_ID + 1
'-------����Ԫ��
'д����Ԫ��XML: λ��,ID��,����X,����Y
Call Input_XML("AA", LBoxIn1_ID, LBox_X - 2, LBox_Y + 1)
Call Input_XML("T#3S", LBoxIn2_ID, LBox_X - 2, LBox_Y + 2)
'-------���Ԫ��
'д���Ԫ��XML:'λ��,ID,����X,����Y,������,���ӵĿ�ID,���ӵĿ�����������
Call Output_XML("CC", LBoxOut1_ID, LBox_X + 6, LBox_Y + 1, LSort_ID, LBox_ID, 0)
LSort_ID = LSort_ID + 1
End Sub
