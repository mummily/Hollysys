Attribute VB_Name = "A0_Function0214"
'ver20190814_by cjt
Function FileExists(FullFileName As String) As Boolean '�жϹ������Ƿ����
    '�������������,�򷵻�True
    FileExists = Len(Dir(FullFileName)) > 0
End Function
Function WorkbookOpen(WorkbookName As String) As Boolean
    '����ù������Ѵ��򷵻���
    WorkbookOpen = False
    On Error GoTo WorkBookNotOpen
    If Len(Application.Workbooks(WorkbookName).NAME) > 0 Then
        WorkbookOpen = True
        Exit Function
    End If
WorkBookNotOpen:
End Function
Function SheetExists(Workbook_name As String, SheetName As String) As Boolean '�жϹ������Ƿ����
    '������������,�򷵻�True
    For Each sht In Workbooks(Workbook_name).Worksheets
    If sht.NAME = SheetName Then
        SheetExists = True
        Workbooks(Workbook_name).Worksheets(SheetName).Activate
        Exit Function
    End If
    
Next
    
    
End Function
Function filefolderExists(PATH As String) As Boolean '�ж��ļ����Ƿ����
    On Error GoTo EarlyExit
    If Not Dir(PATH, vbDirectory) = vbNullString Then
       filefolderExists = True
    End If
    Exit Function
EarlyExit:
    filefolderExists = False
End Function


Function StnNo(ByRef Stationnumber As String) As String  '�ж��ȵ�ż����

If Len(Stationnumber) > 0 Then
     If Stationnumber Like "A1" Then
     StnNo = "10"
     End If
     If Stationnumber Like "A2" Then
     StnNo = "11"
     End If
     If Stationnumber Like "A3" Then
     StnNo = "12"
     End If
     If Stationnumber Like "A4" Then
     StnNo = "13"
     End If
End If
     
End Function


Function PN(var As String) As String '��ȡλ��
    If var Like "*.*" Then '�Ƿ���λ��+����
        PN = Left(var, InStr(var, ".") - 1) 'λ��
    Else
        PN = var
    End If
End Function
Function TI(var As String, Typ As String) As String '��ȡ��������HN����ת��ΪM6������
Dim HN_TI As String 'HN���ݿ�����
   If var Like "*.*" Then '�Ƿ���λ��+����
     HN_TI = Right(var, Len(var) - InStr(var, "."))  'HN����
   Else
     HN_TI = ""
   End If
   
   If Len(HN_TI) > 0 Then '��������
      Select Case Typ '��������ת��
      
        Case "UAI" 'UAI����ת��
              Select Case HN_TI
                     Case "PV" 'HN����תM6
                          TI = ".AV"
              End Select
              
        Case "UAO" 'UAO����ת��
              Select Case HN_TI
                     Case "OP" 'HN����תM6
                          TI = ".AI"
              End Select
              
        Case Else
        
             TI = ""
        
      End Select
        
   End If
   
End Function

Function inputid(Tag As String, ID As Long) As Long 'XMl����ʱ�жϿ�����λ���ǲ�����ȷ���������ǲ���д����λ��ID
    If Len(Tag) > 0 Then
        inputid = ID
    Else
        inputid = 0
    End If
End Function
Function DelDit(PVFORMAT As Variant) As Variant 'HN������ʾС��λ��תM6 Decimal digit
    Select Case PVFORMAT
           Case "D0"
                 DelDit = "%-8.f"
           Case "D1"
                 DelDit = "%-8.1f"
           Case "D2"
                 DelDit = "%-8.2f"
           Case "D3"
                 DelDit = "%-8.3f"
           Case "D4"
                 DelDit = "%-8.4f"
           Case "D5"
                 DelDit = "%-8.5f"
           End Select
End Function

Sub BOX_XML(Tag As String, ID As Long, X As Long, Y As Long, Sort_ID As Long, AT_type As String)  'д��XML:'λ��,ID,����X,����Y,������,����
        POU.WriteLine "<element type=" & Lab & "box" & Lab & ">"
        POU.WriteLine "<id>" & ID & "</id>" '��ID
        POU.WriteLine "<AT_position>" & X & "," & Y & "</AT_position>" '��λ������
        POU.WriteLine "<Comment>?????</Comment>"
        
        POU.WriteLine "<isinst>TRUE</isinst>"
        POU.WriteLine "<text>" & Tag & "</text>" '��λ��
        
        POU.WriteLine "<AT_type>" & AT_type & "</AT_type>"
        POU.WriteLine "<typetext>BT_FB</typetext>"
        POU.WriteLine "<ttype>4</ttype>"
        POU.WriteLine "<AT_isen>false</AT_isen>"
        POU.WriteLine "<AT_iseno>false</AT_iseno>"
        POU.WriteLine "<sortid>" & Sort_ID & "</sortid>" 'Sid������������
End Sub
Sub BoxIn_XML(TI As String, Tag As String, ID As Long, Display As String) 'д����������XML: ����������,���������ӵ�λ��,���������ӵ�λ��ID,�Ƿ���ʾ����
    Dim Binputid As Long '��������id
    Dim Lab1 As String '�����ַ��滻
    
    '����ֱ������������ַ�
    Lab1 = """"
    '���λ��û�оͲ�Ҫ����λ��ID
    If Len(Tag) > 0 Then
        Binputid = ID '��������id
    Else
        Binputid = 0 '��������id
    End If
    
    POU.WriteLine "<input inputid=" & Lab1 & Binputid & Lab1 & " inputidx=" & Lab1 & "0" & Lab1 & " negate=" & Lab1 & "false" & Lab1 & " visible=" & Lab1 & Display & Lab1 & " pinname=" & Lab1 & TI & Lab1 & " />"
End Sub
Sub BoxIn_XML2(TI As String, Tag As String, ID As Long, Inputidx As Long, negate As String, Display As String) 'д����������XML: ����������,���������ӵ�λ��,���������ӵ�λ��ID,�����ź����Լ���������ţ��Ƿ�ȡ�����Ƿ���ʾ����
    Dim Binputid As Long '��������id
    Dim Lab1 As String '�����ַ��滻

    
    '����ֱ������������ַ�
    Lab1 = """"
    '���λ��û�оͲ�Ҫ����λ��ID
    If Len(Tag) > 0 Then
        Binputid = ID '��������id
    Else
        Binputid = 0 '��������id
    End If
    
    POU.WriteLine "<input inputid=" & Lab1 & Binputid & Lab1 & " inputidx=" & Lab1 & Inputidx & Lab1 & " negate=" & Lab1 & negate & Lab1 & " visible=" & Lab1 & Display & Lab1 & " pinname=" & Lab1 & TI & Lab1 & " />"
End Sub
Sub BoxOut_XML(TI As String, Display As String) 'д���������XML: ����������,�Ƿ���ʾ����
    Dim Lab1 As String '�����ַ��滻
    '����ֱ������������ַ�
    Lab1 = """"
    POU.WriteLine "<output negate=" & Lab1 & "false" & Lab1 & " visible=" & Lab1 & Display & Lab1 & " pinname=" & Lab1 & TI & Lab1 & "/>"
End Sub
Sub Input_XML(Tag As String, ID As Long, X As Long, Y As Long) 'д����Ԫ��XML: λ��,ID��,����X,����Y
    Dim Lab1 As String '�����ַ��滻
    '����ֱ������������ַ�
    Lab1 = """"
    '���λ��û�оͲ�����
    If Len(Tag) > 0 Then
        POU.WriteLine "<element type=" & Lab1 & "input" & Lab1 & ">"
        POU.WriteLine "<id>" & ID & "</id>" 'ID
        POU.WriteLine "<AT_position>" & X & "," & Y & "</AT_position>" '�ź�����
        POU.WriteLine "<text>" & Tag & "</text>" '�ź�
        POU.WriteLine "<Comment>?????</Comment>"
        POU.WriteLine "<negate>false</negate>"
        POU.WriteLine "<ttype>4</ttype>"
        POU.WriteLine "<Flag>FALSE</Flag>"
        POU.WriteLine "</element>"
    End If
End Sub

Sub Output_XML(Tag As String, ID As Long, X As Long, Y As Long, Sort_ID As Long, Blok_ID As Long, Inputidx As Long) 'д���Ԫ��XML:'λ��,ID,����X,����Y,������,���ӵĿ�ID,���ӵĿ�����������
    Dim Lab1 As String '�����ַ��滻
    Dim mytag As String
    '����ֱ������������ַ�
    Lab1 = """"
    '��ֹ�ո�
    mytag = Replace(Tag, " ", "")
    
If Len(mytag) > 0 Then
    POU.WriteLine "<element type=" & Lab1 & "output" & Lab1 & ">"
    POU.WriteLine "<id>" & ID & "</id>" '�ź�ID
    POU.WriteLine "<position>" & X & "," & Y & "</position>" '�ź�����
    POU.WriteLine "<text>" & mytag & "</text>"  '�ź�
    POU.WriteLine "<Comment>?????/?</Comment>"
    POU.WriteLine "<ttype>4</ttype>"
    POU.WriteLine "<Inputid>" & Blok_ID & "</Inputid>" '���ӿ��ID
    POU.WriteLine "<Inputidx>" & Inputidx & "</Inputidx>"
    POU.WriteLine "<negate>false</negate>"
    POU.WriteLine "<sortid>" & Sort_ID & "</sortid>" 'Sid������������
    POU.WriteLine "</element>"
End If
End Sub
Sub Output_XML2(Tag As String, ID As Long, X As Long, Y As Long, Sort_ID As Long, Blok_ID As Long, Inputidx As Long, negate As String) 'д���Ԫ��XML:'λ��,ID,����X,����Y,������,���ӵĿ�ID,���ӵĿ����������ţ��Ƿ�ȡ��
    Dim Lab1 As String '�����ַ��滻
    Dim mytag As String
    '����ֱ������������ַ�
    Lab1 = """"
    '��ֹ�ո�
    mytag = Replace(Tag, " ", "")
    
If Len(mytag) > 0 Then
    POU.WriteLine "<element type=" & Lab1 & "output" & Lab1 & ">"
    POU.WriteLine "<id>" & ID & "</id>" '�ź�ID
    POU.WriteLine "<position>" & X & "," & Y & "</position>" '�ź�����
    POU.WriteLine "<text>" & mytag & "</text>"  '�ź�
    POU.WriteLine "<Comment>?????/?</Comment>"
    POU.WriteLine "<ttype>4</ttype>"
    POU.WriteLine "<Inputid>" & Blok_ID & "</Inputid>" '���ӿ��ID
    POU.WriteLine "<Inputidx>" & Inputidx & "</Inputidx>"
    POU.WriteLine "<negate>" & negate & "</negate>"
    POU.WriteLine "<sortid>" & Sort_ID & "</sortid>" 'Sid������������
    POU.WriteLine "</element>"
End If
End Sub

Sub BOX2_XML(Box_type As String, Box_ID As Long, Box_X As Long, Box_Y As Long, Box_Sort As Long, EN_ID As Long, Input1_ID As Long, Input2_ID As Long, EN_Sel As Boolean) 'д��XML:'������,����ID,��������X,��������Y,����������,EN���ӵ�Ԫ��id,����1���ӵ�Ԫ��id,����2���ӵ�Ԫ��id,�Ƿ���ʾEN
    Dim Lab1 As String '�����ַ��滻
    '����ֱ������������ַ�
    Lab1 = """"
        POU.WriteLine "<element type=" & Lab1 & "box" & Lab1 & ">"
        POU.WriteLine "<id>" & Box_ID & "</id>" '��ID
        POU.WriteLine "<AT_position>" & Box_X & "," & Box_Y & "</AT_position>" '��λ������
        POU.WriteLine "<AT_type>" & Box_type & "</AT_type>"
        POU.WriteLine "<typetext>BT_OPERATOR</typetext>"
        If EN_Sel Then
        POU.WriteLine "<AT_isen>true</AT_isen>"
        POU.WriteLine "<AT_iseno>true</AT_iseno>"
        Else
        POU.WriteLine "<AT_isen>false</AT_isen>"
        POU.WriteLine "<AT_iseno>false</AT_iseno>"
        End If
        POU.WriteLine "<sortid>" & Box_Sort & "</sortid>" 'Sid������������
        If EN_Sel Then
        POU.WriteLine "<input inputid=" & Lab1 & EN_ID & Lab1 & " inputidx=" & Lab1 & "0" & Lab1 & " negate=" & Lab1 & "false" & Lab1 & " visible=" & Lab1 & "true" & Lab1 & " pinname=" & Lab1 & "EN" & Lab1 & "/>"
        End If
        POU.WriteLine "<input inputid=" & Lab1 & Input1_ID & Lab1 & " inputidx=" & Lab1 & "0" & Lab1 & " negate=" & Lab1 & "false" & Lab1 & " visible=" & Lab1 & "true" & Lab1 & " pinname=" & Lab1 & "" & Lab1 & "/>"
        POU.WriteLine "<input inputid=" & Lab1 & Input2_ID & Lab1 & " inputidx=" & Lab1 & "0" & Lab1 & " negate=" & Lab1 & "false" & Lab1 & " visible=" & Lab1 & "true" & Lab1 & " pinname=" & Lab1 & "" & Lab1 & "/>"
        If EN_Sel Then
        POU.WriteLine "<output negate=" & Lab1 & "false" & Lab1 & " visible=" & Lab1 & "true" & Lab1 & " pinname=" & Lab1 & "ENO" & Lab1 & "/>"
        End If
        POU.WriteLine "<output negate=" & Lab1 & "false" & Lab1 & " visible=" & Lab1 & "true" & Lab1 & " pinname=" & Lab1 & "" & Lab1 & "/>"
        POU.WriteLine "</element>"
        
End Sub
Sub BOX3_XML(Box_type As String, Box_ID As Long, Box_X As Long, Box_Y As Long, Box_Sort As Long, EN_ID As Long, Input1_ID As Long, Input2_ID As Long, Input3_ID As Long, EN_Sel As Boolean) 'д��XML:'������,����ID,��������X,��������Y,����������,EN���ӵ�Ԫ��id,����1���ӵ�Ԫ��id,����2���ӵ�Ԫ��id,�Ƿ���ʾEN
    Dim Lab1 As String '�����ַ��滻
    '����ֱ������������ַ�
    Lab1 = """"
        POU.WriteLine "<element type=" & Lab1 & "box" & Lab1 & ">"
        POU.WriteLine "<id>" & Box_ID & "</id>" '��ID
        POU.WriteLine "<AT_position>" & Box_X & "," & Box_Y & "</AT_position>" '��λ������
        POU.WriteLine "<AT_type>" & Box_type & "</AT_type>"
        POU.WriteLine "<typetext>BT_OPERATOR</typetext>"
        If EN_Sel Then
        POU.WriteLine "<AT_isen>true</AT_isen>"
        POU.WriteLine "<AT_iseno>true</AT_iseno>"
        Else
        POU.WriteLine "<AT_isen>false</AT_isen>"
        POU.WriteLine "<AT_iseno>false</AT_iseno>"
        End If
        POU.WriteLine "<sortid>" & Box_Sort & "</sortid>" 'Sid������������
        If EN_Sel Then
        POU.WriteLine "<input inputid=" & Lab1 & EN_ID & Lab1 & " inputidx=" & Lab1 & "0" & Lab1 & " negate=" & Lab1 & "false" & Lab1 & " visible=" & Lab1 & "true" & Lab1 & " pinname=" & Lab1 & "EN" & Lab1 & "/>"
        End If
        POU.WriteLine "<input inputid=" & Lab1 & Input1_ID & Lab1 & " inputidx=" & Lab1 & "0" & Lab1 & " negate=" & Lab1 & "false" & Lab1 & " visible=" & Lab1 & "true" & Lab1 & " pinname=" & Lab1 & "" & Lab1 & "/>"
        POU.WriteLine "<input inputid=" & Lab1 & Input2_ID & Lab1 & " inputidx=" & Lab1 & "0" & Lab1 & " negate=" & Lab1 & "false" & Lab1 & " visible=" & Lab1 & "true" & Lab1 & " pinname=" & Lab1 & "" & Lab1 & "/>"
        POU.WriteLine "<input inputid=" & Lab1 & Input3_ID & Lab1 & " inputidx=" & Lab1 & "0" & Lab1 & " negate=" & Lab1 & "false" & Lab1 & " visible=" & Lab1 & "true" & Lab1 & " pinname=" & Lab1 & "" & Lab1 & "/>"
        If EN_Sel Then
        POU.WriteLine "<output negate=" & Lab1 & "false" & Lab1 & " visible=" & Lab1 & "true" & Lab1 & " pinname=" & Lab1 & "ENO" & Lab1 & "/>"
        End If
        POU.WriteLine "<output negate=" & Lab1 & "false" & Lab1 & " visible=" & Lab1 & "true" & Lab1 & " pinname=" & Lab1 & "" & Lab1 & "/>"
        POU.WriteLine "</element>"
        
End Sub
Function UDCType(NAME As Variant, DISRC1 As Variant, DISRC2 As Variant, DODSTN1 As Variant, DODSTN2 As Variant, DODSTN3 As Variant) As String '�ж�UDC����
Dim str1 As Variant
Dim str2 As Variant
str1 = DISRC1 & DISRC2
str2 = DODSTN1 & DODSTN2 & DODSTN3
If Len(str1) > 0 And Len(str2) > 0 Then
 If NAME Like "*V*" Then
    UDCType = "VAL2"
 End If
 If NAME Like "*P*" Or NAME Like "*M*" Then
    UDCType = "MOT2"
 End If
Else
    UDCType = ""
End If
End Function

'-----------------------------------------------------------------------------------------------------------
'Purpose:����������
'History: 18-12-2019
'Author:ChengJiangtao
'-----------------------------------------------------------------------------------------------------------
Function AlMLVl(HN As Variant) As Variant  '�ж�UDC����
Select Case HN
       Case "LOW"
            AlMLVl = "1"
       Case "HIGH"
            AlMLVl = "2"
       Case "EMERGENCY"
            AlMLVl = "3"
       Case "NOACTION"
            AlMLVl = "0"
       Case Else
           AlMLVl = "0"
End Select
End Function

'-----------------------------------------------------------------------------------------------------------
'Purpose:AI�Ƿ񿪷�����
'History: 18-12-2019
'Author:ChengJiangtao
'-----------------------------------------------------------------------------------------------------------
Function SQRTOPT(HN As Variant) As Variant  '�ж�UDC����
Select Case HN
       Case "SQRROOT"
            SQRTOPT = "1"
       Case "LINEAR"
            SQRTOPT = "0"
       Case Else
           SQRTOPT = ""
End Select
End Function
'-----------------------------------------------------------------------------------------------------------
'Purpose:������������
'History: 18-12-2019
'Author:ChengJiangtao
'-----------------------------------------------------------------------------------------------------------
Function ALMDB(HN As Variant, PVALDBEU As Variant, PVEUHI As Variant, PVEULO As Variant) As Variant
Select Case HN
       Case "EU"
            If VBA.IsNumeric(PVALDBEU) Then
               ALMDB = PVALDBEU
            End If
       Case "HALF"
            ALMDB = 0.005 * (PVEUHI - PVEULO)
       Case "ONE"
            ALMDB = 0.01 * (PVEUHI - PVEULO)
       Case "TWO"
            ALMDB = 0.02 * (PVEUHI - PVEULO)
       Case "TREE"
            ALMDB = 0.03 * (PVEUHI - PVEULO)
       Case "FOUR"
            ALMDB = 0.04 * (PVEUHI - PVEULO)
       Case "FIVE"
            ALMDB = 0.05 * (PVEUHI - PVEULO)
       Case Else
           ALMDB = ""
End Select
End Function
'-----------------------------------------------------------------------------------------------------------
'Purpose:DI��������
'History: 18-12-2019
'Author:ChengJiangtao
'-----------------------------------------------------------------------------------------------------------
Function DAMOPT(ALMOPT As Variant, PVNORMAL As Variant) As Variant '�ж�UDC����
         If ALMOPT = "NONE" And PVNORMAL = "" Then
                 DAMOPT = "0"
         ElseIf ALMOPT = "OFFNORML" And PVNORMAL = "OFF" Then
                DAMOPT = "1"
         ElseIf ALMOPT = "OFFNORML" And PVNORMAL = "ON" Then
                DAMOPT = "2"
         ElseIf ALMOPT = "CHNGOFST" Then
                DAMOPT = "3"
         Else
                DAMOPT = "0"
         End If
End Function
'-----------------------------------------------------------------------------------------------------------
'Purpose:DI��������
'History: 18-12-2019
'Author:ChengJiangtao
'-----------------------------------------------------------------------------------------------------------
Function RD(NODENUM As Variant, MODNUM As Variant) As Variant '�ж�ģ���Ƿ����࣬����վ�ź��豸�Ų���UPMCONFIG
Dim NAME As Variant
Dim IOREDOPT As Variant
         If NODENUM < 10 Then
            NAME = "$NM01B0" & NODENUM 'վ��
         Else
            NAME = "$NM01B" & NODENUM 'վ��
         End If
         IOREDOPT = "IOREDOPT" & "(" & MODNUM & ")" '�豸��
         
                If 0 < MODNUM And MODNUM <= 20 Then
                       If UPMCONFIG_arr(UPMCONFIGSN(NAME), UPMCONFIG(IOREDOPT)) = "REDUN" Then
                          RD = "1"
                       Else
                          RD = "0"
                       End If
                End If
                If 20 < MODNUM Then
                       If UPMCONFIG1_arr(UPMCONFIG1SN(NAME), UPMCONFIG1(IOREDOPT)) = "REDUN" Then
                          RD = "1"
                       Else
                          RD = "0"
                       End If
                 End If

         

End Function
'-----------------------------------------------------------------------------------------------------------
'Purpose:����������
'History: 14-2-2020
'Author:ChengJiangtao
'-----------------------------------------------------------------------------------------------------------
'DAMOPT    INHDAM          DAMLV
'��������  ��������         ������
'2(0����)      0(������)       0(������)
'1(1����)      1(����)         1(��ͨ)
'3(˫�򱨾�)   0               2��һ��)
'0(������)     0               3(����)
'0             0               4(�ؽ�)
Function DAMLV(OFFNRMPR As Variant) As Variant

Select Case OFFNRMPR
       Case "LOW"
             DAMLV = "1"
       Case "EMERGNCY"
             DAMLV = "3"
       Case Else
             DAMLV = "0"
End Select

End Function

'-----------------------------------------------------------------------------------------------------------
'Purpose:CTLEQNת��
'History: 14-2-2020
'Author:ChengJiangtao
'-----------------------------------------------------------------------------------------------------------
'ģʽѡ��0-EQA,1-EQB,2-EQC,3-EQD,4-EQE
Function CTLEQN(EQX As Variant) As Variant

Select Case EQX
       Case "EQA"
             CTLEQN = "0"
       Case "EQB"
             CTLEQN = "1"
       Case "EQC"
             CTLEQN = "2"
       Case "EQD"
             CTLEQN = "3"
       Case "EQE"
             CTLEQN = "4"
       Case Else
             CTLEQN = ""
End Select

End Function
