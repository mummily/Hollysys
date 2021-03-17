Attribute VB_Name = "J1_ConvertUDCLoopCommon_"
'ver20190930_by cjt
'UDCȫ�ֱ�������
Public UDC_i As Long         'UDC�Զ�����ѭ������
Public UDC_Type As Object    'UREGC�����ֵ�


'ת��UREGC����
Sub J1_ConvertUDCLoopCommon()
Dim UDC_Type_arr() As Variant


'--------------------------------------------------------------------------------------------------------
'01--��ʼ��ֵ
'--------------------------------------------------------------------------------------------------------
Lab = """"             '"��ʾ�ַ���
'ʵ�����ֵ�
Set UDC_Type = CreateObject("Scripting.Dictionary") 'UDC_Type�ֵ�

'02--��ѯMAIN����Ҫת����UREGPV�㷨�����հ׵ķ���ҳ
'��ѯ

UDC_Type.RemoveAll '�����
UDC_Type.Add "MOT2", "MOT2"
UDC_Type.Add "VAL2", "VAL2"


'03--����XML�ļ�
'--------------------------------------------------------------------------------------------------------
For UDC_i = 2 To UBound(UDC_arr(), 1)

        POU_Type = UDC_arr(UDC_i, UDC("M6BlockType")) '����ҳ����
        
        If UDC_Type.Exists(POU_Type) Then '��·�����ֵ京��������ת��
        
                  POU_Name = UDC_arr(UDC_i, UDC("NAME")) & "_" & POU_Type   '����ҳ��
                  POU_Description = "" 'UDC_arr(UDC_i, UDC("PTDESC"))     '����ҳ����
                  POUnamef = PATH & "\�����ļ�\" & SN(UDC_arr(UDC_i, UDC("NODENUM"))) & "\" & POU_Name & ".xml"   '����ҳ�ļ��洢·��
                  
                   '�����ļ�
                  Set fs = CreateObject("Scripting.FileSystemObject")
                  Set POU = fs.CreateTextFile(POUnamef, True)
                  
                  '(*XML�ļ���ʼ���ò���*)
                  '--------------------------------------------------------------------------------------------------------
                  POU.WriteLine "<?xml version=" & Lab & "1.0" & Lab & " encoding=" & Lab & "ISO-8859-1" & Lab & "?>"
                  POU.WriteLine "<pou>"
                  POU.WriteLine "<path><![CDATA[\/" & POU_Type & "]]></path>"
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
                  POU.WriteLine "<PouPaperSize>A3</PouPaperSize>"
                  POU.WriteLine "<PouPrintType>0</PouPrintType>"
                  POU.WriteLine "<interface>"
                  POU.WriteLine "<![CDATA[PROGRAM " & POU_Name
                  POU.WriteLine "VAR"
                  POU.WriteLine "END_VAR]]>"
                  POU.WriteLine "</interface>"
                  POU.WriteLine "<cfc>"
                                      
                    Select Case POU_Type '��������ת��
                    
                      Case "VAL2" 'ת��
                            Call J11_ConvertUDCLoop_VAL2 'ת��VAL2
                      Case "MOT2" 'ת��
                            Call J12_ConvertUDCLoop_MOT2 'ת��MOT2
                    End Select
                  
                  

                  '(*XML�ļ��������ò���*)
                  '--------------------------
                  POU.WriteLine "</cfc>"
                  POU.WriteLine "</pou>"
                  
                  '(*����ҳ�ļ��ر�*)
                  '---------------------------
                 POU.Close
        End If
   
Next UDC_i



End Sub

