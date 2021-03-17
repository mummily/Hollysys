Attribute VB_Name = "G1_ConvertUREGLoopCommon_"
'ver20190821_by cjt
'UREGCȫ�ֱ�������
Public UREGC_i As Long         'UREGC�Զ�����ѭ������
Public UREGC_Type As Object    'UREGC�����ֵ�


'ת��UREGC����
Sub G1_ConvertUREGLoopCommon()
Dim UREGC_Type_arr() As Variant
'01--��ʼ��ֵ
'--------------------------------------------------------------------------------------------------------
Lab = """"             '"��ʾ�ַ���
'ʵ�����ֵ�
Set UREGC_Type = CreateObject("Scripting.Dictionary") 'UREGC_Type�ֵ�

'02--��ѯMAIN����Ҫת����UREGC-Regulatory Control Point�㷨�����հ׵ķ���ҳ
'��ѯ

UREGC_Type.RemoveAll '�����
With Workbooks(this_sht_name).Worksheets("main") '��ȡ�趨�Ļ�·
     UREGC_Type_arr = .Range("B8:B24").Value
End With
For i = 1 To UBound(UREGC_Type_arr(), 1) '��·�����ֵ�
    If Not UREGC_Type.Exists(UREGC_Type_arr(i, 1)) And Len(UREGC_Type_arr(i, 1)) > 0 Then
       UREGC_Type.Add UREGC_Type_arr(i, 1), UREGC_Type_arr(i, 1)
    End If
Next

'03--����XML�ļ�
'--------------------------------------------------------------------------------------------------------
For UREGC_i = 2 To UBound(UREGC_arr(), 1)
        POU_Type = UREGC_arr(UREGC_i, UREGC("CTLALGID"))     '����ҳ����
        
        If UREGC_Type.Exists(POU_Type) Then '��·�����ֵ京��������ת��
        
                  POU_Name = UREGC_arr(UREGC_i, UREGC("NAME")) & "_" & UREGC_arr(UREGC_i, UREGC("CTLALGID"))   '����ҳ��
                  POU_Description = "" 'UREGC_arr(UREGC_i, UREGC("PTDESC"))     '����ҳ����
                  POUnamef = PATH & "\�����ļ�\" & SN(UREGC_arr(UREGC_i, UREGC("NODENUM"))) & "\" & POU_Name & ".xml"   '����ҳ�ļ��洢·��
                  
                   '�����ļ�
                  Set fs = CreateObject("Scripting.FileSystemObject")
                  Set POU = fs.CreateTextFile(POUnamef, True)
                  
                  '(*XML�ļ���ʼ���ò���*)
                  '--------------------------------------------------------------------------------------------------------
                  POU.WriteLine "<?xml version=" & Lab & "1.0" & Lab & " encoding=" & Lab & "ISO-8859-1" & Lab & "?>"
                  POU.WriteLine "<pou>"
                  If POU_Type = "SUMMER" Then
                  POU.WriteLine "<path><![CDATA[\/" & POU_Type & "_CTR" & "]]></path>"
                  Else
                  POU.WriteLine "<path><![CDATA[\/" & POU_Type & "]]></path>"
                  End If
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
                    
                      Case "PID" 'ת��
                            Dim strft, strzt As String '��ת�ַ���UREGCPIDAux(strft)
                            
                            'PID���:����λ��
                            strft = UREGC_arr(UREGC_i, UREGC("CODSTN(1)"))
                            strft = Replace(strft, ".SP", "")
                            
                            'PID���:
                            strzt = UREGC_arr(UREGC_i, UREGC("NAME"))
                            
                            '��ͨPID��λ��
                            If Len(UREGCPIDAux(strzt)) = 0 And Len(UREGCPIDAux(strft)) = 0 Then
                               Call G11_ConvertUREGLoop_PID 'ת��pid
                            End If
                            
                            '����PID
                            If Len(UREGCPIDAux(strzt)) = 0 And Len(UREGCPIDAux(strft)) > 0 Then
                               'ת������pid
                                Call G112_ConvertUREGLoop_PID
                            End If
                            
                            
                      Case "PIDFF" 'ת��
                            Call G12_ConvertUREGLoop_PIDFF 'ת��PIDFF
                                                                
                             
                      Case "AUTOMAN" 'ת��
                            Call G13_ConvertUREGLoop_AUTOMAN 'ת��AUTOMAN
                            
                       Case "SWITCH" 'ת��
                            Call G14_ConvertUREGLoop_SWITCH 'ת��SWITCH
                            
                       Case "ORSEL" 'ת��
                            Call G15_ConvertUREGLoop_ORSEL 'ת��ORSEL
                            
                       Case "MULDIV" 'ת��
                            Call G16_ConvertUREGLoop_MULDIV 'ת��MULDIV
                            
                       Case "SUMMER" 'ת��
                            Call G17_ConvertUREGLoop_SUMMER 'ת��SUMMER
                                                                   
                    End Select
                  
                  

                  '(*XML�ļ��������ò���*)
                  '--------------------------
                  POU.WriteLine "</cfc>"
                  POU.WriteLine "</pou>"
                  
                  '(*����ҳ�ļ��ر�*)
                  '---------------------------
                 POU.Close
        End If
   
Next UREGC_i

End Sub
