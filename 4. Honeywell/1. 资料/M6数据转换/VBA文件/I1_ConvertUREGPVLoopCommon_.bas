Attribute VB_Name = "I1_ConvertUREGPVLoopCommon_"
'ver20190930_by cjt
'UREGPVȫ�ֱ�������
Public UREGPV_i As Long         'UREGC�Զ�����ѭ������
Public UREGPV_Type As Object    'UREGC�����ֵ�

'ת��UREGC����
Sub I1_ConvertUREGPVLoopCommon()
Dim UREGPV_Type_arr() As Variant
'01--��ʼ��ֵ
'--------------------------------------------------------------------------------------------------------
Lab = """"             '"��ʾ�ַ���
'ʵ�����ֵ�
Set UREGPV_Type = CreateObject("Scripting.Dictionary") 'UREGPV_Type�ֵ�

'02--��ѯMAIN����Ҫת����UREGPV�㷨�����հ׵ķ���ҳ
'��ѯ

UREGPV_Type.RemoveAll '�����
With Workbooks(this_sht_name).Worksheets("main") '��ȡ�趨�Ļ�·
     UREGPV_Type_arr = .Range("C8:C24").Value
End With
For i = 1 To UBound(UREGPV_Type_arr(), 1) '��·�����ֵ�
    If Not UREGPV_Type.Exists(UREGPV_Type_arr(i, 1)) And Len(UREGPV_Type_arr(i, 1)) > 0 Then
       UREGPV_Type.Add UREGPV_Type_arr(i, 1), UREGPV_Type_arr(i, 1)
    End If
Next

'03--����XML�ļ�
'--------------------------------------------------------------------------------------------------------

For UREGPV_i = 2 To UBound(UREGPV_arr(), 1)
        POU_Type = UREGPV_arr(UREGPV_i, UREGPV("PVALGID"))     '����ҳ����
        
        If UREGPV_Type.Exists(POU_Type) Then '��·�����ֵ京��������ת��
        
                  POU_Name = UREGPV_arr(UREGPV_i, UREGPV("NAME")) & "_" & UREGPV_arr(UREGPV_i, UREGPV("PVALGID"))   '����ҳ��
                  POU_Description = "" 'UREGPV_arr(UREGPV_i, UREGPV("PTDESC"))     '����ҳ����
                  POUnamef = PATH & "\�����ļ�\" & SN(UREGPV_arr(UREGPV_i, UREGPV("NODENUM"))) & "\" & POU_Name & ".xml"   '����ҳ�ļ��洢·��
                  
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

                                      
                    Select Case POU_Type '��������ת��
                    
                      Case "TOTALIZR" 'ת��
                            'POU����
                             POU_Lge = "cfc"
                      
                            POU.WriteLine "<interface>"
                            POU.WriteLine "<![CDATA[PROGRAM " & POU_Name
                            POU.WriteLine "VAR"
'                            POU.WriteLine UREGPV_arr(UREGPV_i, UREGPV("NAME")) & "_SUM" & "(2054): FLOWSUM := ( TOLVAL:=99999999, INSCOF:=0.00013888);(*" & POU_Description & "*)"
                            POU.WriteLine "END_VAR]]>"
                            POU.WriteLine "</interface>"
                            POU.WriteLine "<cfc>"
                            Call I11_ConvertUREGPVLoop_TOTALIZR 'ת��TOTALIZR
                       Case "HILOAVG" 'ת��
                            'POU����
                             POU_Lge = "cfc"
                             
                            POU.WriteLine "<interface>"
                            POU.WriteLine "<![CDATA[PROGRAM " & POU_Name
                            POU.WriteLine "VAR"
'                            POU.WriteLine UREGPV_arr(UREGPV_i, UREGPV("NAME")) & "_AVG" & "(2054): HILOAVG := (X1:=0);(*" & POU_Description & "*)"
                            POU.WriteLine "END_VAR]]>"
                            POU.WriteLine "</interface>"
                            POU.WriteLine "<cfc>"
                            Call I12_ConvertUREGPVLoop_HILOAVG 'ת��GENLIN
                        Case "GENLIN" 'ת��
                            'POU����
                             POU_Lge = "cfc"
                        
'                            Dim XARR As String '�۵�X
'                            Dim YARR As String '�۵�Y
'                            Dim PNTNUM As Integer '�۵�����
'
'                                XARR = ""
'                                YARR = ""
'                                PNTNUM = 0
'
'                            If Len(UREGPV_arr(UREGPV_i, UREGPV("IN0"))) > 0 Then
'                                XARR = XARR & UREGPV_arr(UREGPV_i, UREGPV("IN0"))
'                                YARR = YARR & UREGPV_arr(UREGPV_i, UREGPV("OUT0"))
'                                PNTNUM = PNTNUM + 1
'                            End If
'                             If Len(UREGPV_arr(UREGPV_i, UREGPV("IN1"))) > 0 Then
'                                XARR = XARR & "," & UREGPV_arr(UREGPV_i, UREGPV("IN1"))
'                                YARR = YARR & "," & UREGPV_arr(UREGPV_i, UREGPV("OUT1"))
'                                PNTNUM = PNTNUM + 1
'                            End If
'                             If Len(UREGPV_arr(UREGPV_i, UREGPV("IN2"))) > 0 Then
'                                XARR = XARR & "," & UREGPV_arr(UREGPV_i, UREGPV("IN2"))
'                                YARR = YARR & "," & UREGPV_arr(UREGPV_i, UREGPV("OUT2"))
'                                PNTNUM = PNTNUM + 1
'                            End If
'                             If Len(UREGPV_arr(UREGPV_i, UREGPV("IN3"))) > 0 Then
'                                XARR = XARR & "," & UREGPV_arr(UREGPV_i, UREGPV("IN3"))
'                                YARR = YARR & "," & UREGPV_arr(UREGPV_i, UREGPV("OUT3"))
'                                PNTNUM = PNTNUM + 1
'                            End If
'                            If Len(UREGPV_arr(UREGPV_i, UREGPV("IN4"))) > 0 Then
'                                XARR = XARR & "," & UREGPV_arr(UREGPV_i, UREGPV("IN4"))
'                                YARR = YARR & "," & UREGPV_arr(UREGPV_i, UREGPV("OUT4"))
'                                PNTNUM = PNTNUM + 1
'                            End If
'                             If Len(UREGPV_arr(UREGPV_i, UREGPV("IN5"))) > 0 Then
'                                XARR = XARR & "," & UREGPV_arr(UREGPV_i, UREGPV("IN5"))
'                                YARR = YARR & "," & UREGPV_arr(UREGPV_i, UREGPV("OUT5"))
'                                PNTNUM = PNTNUM + 1
'                            End If
'                             If Len(UREGPV_arr(UREGPV_i, UREGPV("IN6"))) > 0 Then
'                                XARR = XARR & "," & UREGPV_arr(UREGPV_i, UREGPV("IN6"))
'                                YARR = YARR & "," & UREGPV_arr(UREGPV_i, UREGPV("OUT6"))
'                                PNTNUM = PNTNUM + 1
'                            End If
'                             If Len(UREGPV_arr(UREGPV_i, UREGPV("IN7"))) > 0 Then
'                                XARR = XARR & "," & UREGPV_arr(UREGPV_i, UREGPV("IN7"))
'                                YARR = YARR & "," & UREGPV_arr(UREGPV_i, UREGPV("OUT7"))
'                                PNTNUM = PNTNUM + 1
'                            End If
'                            If Len(UREGPV_arr(UREGPV_i, UREGPV("IN8"))) > 0 Then
'                                XARR = XARR & "," & UREGPV_arr(UREGPV_i, UREGPV("IN8"))
'                                YARR = YARR & "," & UREGPV_arr(UREGPV_i, UREGPV("OUT8"))
'                                PNTNUM = PNTNUM + 1
'                            End If
'                             If Len(UREGPV_arr(UREGPV_i, UREGPV("IN9"))) > 0 Then
'                                XARR = XARR & "," & UREGPV_arr(UREGPV_i, UREGPV("IN9"))
'                                YARR = YARR & "," & UREGPV_arr(UREGPV_i, UREGPV("OUT9"))
'                                PNTNUM = PNTNUM + 1
'                            End If
'                             If Len(UREGPV_arr(UREGPV_i, UREGPV("IN10"))) > 0 Then
'                                XARR = XARR & "," & UREGPV_arr(UREGPV_i, UREGPV("IN10"))
'                                YARR = YARR & "," & UREGPV_arr(UREGPV_i, UREGPV("OUT10"))
'                                PNTNUM = PNTNUM + 1
'                            End If
'                             If Len(UREGPV_arr(UREGPV_i, UREGPV("IN11"))) > 0 Then
'                                XARR = XARR & "," & UREGPV_arr(UREGPV_i, UREGPV("IN11"))
'                                YARR = YARR & "," & UREGPV_arr(UREGPV_i, UREGPV("OUT11"))
'                                PNTNUM = PNTNUM + 1
'                            End If
'                            If Len(UREGPV_arr(UREGPV_i, UREGPV("IN12"))) > 0 Then
'                                XARR = XARR & "," & UREGPV_arr(UREGPV_i, UREGPV("IN12"))
'                                YARR = YARR & "," & UREGPV_arr(UREGPV_i, UREGPV("OUT12"))
'                                PNTNUM = PNTNUM + 1
'                            End If

                            POU.WriteLine "<interface>"
                            POU.WriteLine "<![CDATA[PROGRAM " & POU_Name
                            POU.WriteLine "VAR"
'                            POU.WriteLine UREGPV_arr(UREGPV_i, UREGPV("NAME")) & "_FOLD" & "(2054): ONEFOLD := ( PNTNUM:=" & PNTNUM & ",XARR:=" & XARR & ",YARR:=" & YARR & ");(*" & POU_Description & "*)"
                            POU.WriteLine "END_VAR]]>"
                            POU.WriteLine "</interface>"
                            POU.WriteLine "<cfc>"
                            Call I13_ConvertUREGPVLoop_GENLIN 'ת��GENLIN
                        Case "MIDOF3" 'ת��
                            'POU����
                             POU_Lge = "cfc"
                             
                            POU.WriteLine "<interface>"
                            POU.WriteLine "<![CDATA[PROGRAM " & POU_Name
                            POU.WriteLine "VAR"
'                            POU.WriteLine UREGPV_arr(UREGPV_i, UREGPV("NAME")) & "_OF3" & "(2054): MIDOF3 := (X1:=0);(*" & POU_Description & "*)"
                            POU.WriteLine "END_VAR]]>"
                            POU.WriteLine "</interface>"
                            POU.WriteLine "<cfc>"
                            Call I14_ConvertUREGPVLoop_MIDOF3 'ת��MIDOF3
                            
                           Case "VDTLDLAG" 'ת��
                            'POU����
                             POU_Lge = "cfc"
                           
                            POU.WriteLine "<interface>"
                            POU.WriteLine "<![CDATA[PROGRAM " & POU_Name
                            POU.WriteLine "VAR"
'                            POU.WriteLine UREGPV_arr(UREGPV_i, UREGPV("NAME")) & "_LAG" & "(2054): VDTLDLAG := (X1:=0);(*" & POU_Description & "*)"
                            POU.WriteLine "END_VAR]]>"
                            POU.WriteLine "</interface>"
                            POU.WriteLine "<cfc>"
                            Call I15_ConvertUREGPVLoop_VDTLDLAG 'ת��VDTLDLAG
                            
                           Case "FLOWCOMP" 'ת��
                            'POU����
                             POU_Lge = "cfc"
                           
                            POU.WriteLine "<interface>"
                            POU.WriteLine "<![CDATA[PROGRAM " & POU_Name
                            POU.WriteLine "VAR"
'                            POU.WriteLine UREGPV_arr(UREGPV_i, UREGPV("NAME")) & "_LAG" & "(2054): FLOWCOMP := (X1:=0);(*" & POU_Description & "*)"
                            POU.WriteLine "END_VAR]]>"
                            POU.WriteLine "</interface>"
                            POU.WriteLine "<cfc>"
                            Call I16_ConvertUREGPVLoop_FLOWCOMP 'ת��FLOWCOMP
                            
                           Case "CALCULTR" 'ת��
                            'POU����
                             POU_Lge = "st"
                           
                            POU.WriteLine "<interface>"
                            POU.WriteLine "<![CDATA[PROGRAM " & POU_Name
                            POU.WriteLine "VAR"
                            POU.WriteLine "C1(2070): REAL := 0;"
                            POU.WriteLine "C2(2070): REAL := 0;"
                            POU.WriteLine "C3(2070): REAL := 0;"
                            POU.WriteLine "C4(2070): REAL := 0;"
                            POU.WriteLine "C5(2070): REAL := 0;"
                            POU.WriteLine "C6(2070): REAL := 0;"
                            POU.WriteLine "P1(2070): REAL := 0;"
                            POU.WriteLine "P2(2070): REAL := 0;"
                            POU.WriteLine "P3(2070): REAL := 0;"
                            POU.WriteLine "P4(2070): REAL := 0;"
                            POU.WriteLine "P5(2070): REAL := 0;"
                            POU.WriteLine "P6(2070): REAL := 0;"
                            POU.WriteLine "Result(2070): REAL := 0;"
                            POU.WriteLine "CLAMP(2070): BOOL := FALSE;"
                            POU.WriteLine "END_VAR]]>"
                            POU.WriteLine "</interface>"
                            POU.WriteLine "<st>"
                            Call I17_ConvertUREGPVLoop_CALCULTR 'ת��CALCULTR
                            
                           Case "SUMMER" 'ת��
                            'POU����
                             POU_Lge = "cfc"
                           
                            POU.WriteLine "<interface>"
                            POU.WriteLine "<![CDATA[PROGRAM " & POU_Name
                            POU.WriteLine "VAR"
'                            POU.WriteLine UREGPV_arr(UREGPV_i, UREGPV("NAME")) & "_LAG" & "(2054): FLOWCOMP := (X1:=0);(*" & POU_Description & "*)"
                            POU.WriteLine "END_VAR]]>"
                            POU.WriteLine "</interface>"
                            POU.WriteLine "<cfc>"
                            Call I18_ConvertUREGPVLoop_SUMMER 'ת��SUMMER
                            
                            
                    End Select
                  
                  

                  '(*XML�ļ��������ò���*)
                  '--------------------------
                  POU.WriteLine "</" & POU_Lge & ">"
                  POU.WriteLine "</pou>"
                  
                  '(*����ҳ�ļ��ر�*)
                  '---------------------------
                 POU.Close
        End If
   
Next UREGPV_i

End Sub

