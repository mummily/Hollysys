Attribute VB_Name = "I1_ConvertUREGPVLoopCommon_"
'ver20190930_by cjt
'UREGPV全局变量定义
Public UREGPV_i As Long         'UREGC自动生成循环变量
Public UREGPV_Type As Object    'UREGC类型字典

'转化UREGC公用
Sub I1_ConvertUREGPVLoopCommon()
Dim UREGPV_Type_arr() As Variant
'01--初始赋值
'--------------------------------------------------------------------------------------------------------
Lab = """"             '"标示字符串
'实例化字典
Set UREGPV_Type = CreateObject("Scripting.Dictionary") 'UREGPV_Type字典

'02--查询MAIN定义要转换的UREGPV算法创建空白的方案页
'查询

UREGPV_Type.RemoveAll '先清空
With Workbooks(this_sht_name).Worksheets("main") '获取设定的回路
     UREGPV_Type_arr = .Range("C8:C24").Value
End With
For i = 1 To UBound(UREGPV_Type_arr(), 1) '回路类型字典
    If Not UREGPV_Type.Exists(UREGPV_Type_arr(i, 1)) And Len(UREGPV_Type_arr(i, 1)) > 0 Then
       UREGPV_Type.Add UREGPV_Type_arr(i, 1), UREGPV_Type_arr(i, 1)
    End If
Next

'03--创建XML文件
'--------------------------------------------------------------------------------------------------------

For UREGPV_i = 2 To UBound(UREGPV_arr(), 1)
        POU_Type = UREGPV_arr(UREGPV_i, UREGPV("PVALGID"))     '方案页类型
        
        If UREGPV_Type.Exists(POU_Type) Then '回路类型字典含此类型则转换
        
                  POU_Name = UREGPV_arr(UREGPV_i, UREGPV("NAME")) & "_" & UREGPV_arr(UREGPV_i, UREGPV("PVALGID"))   '方案页名
                  POU_Description = "" 'UREGPV_arr(UREGPV_i, UREGPV("PTDESC"))     '方案页描述
                  POUnamef = PATH & "\工程文件\" & SN(UREGPV_arr(UREGPV_i, UREGPV("NODENUM"))) & "\" & POU_Name & ".xml"   '方案页文件存储路径
                  
                   '创建文件
                  Set fs = CreateObject("Scripting.FileSystemObject")
                  Set POU = fs.CreateTextFile(POUnamef, True)
                  
                  '(*XML文件开始公用部分*)
                  '--------------------------------------------------------------------------------------------------------
                  POU.WriteLine "<?xml version=" & Lab & "1.0" & Lab & " encoding=" & Lab & "ISO-8859-1" & Lab & "?>"
                  POU.WriteLine "<pou>"
                  POU.WriteLine "<path><![CDATA[\/" & POU_Type & "]]></path>"
                  POU.WriteLine "<name>" & POU_Name & "</name>" '方案页名
                  POU.WriteLine "<secondName></secondName>"
                  POU.WriteLine "<description>" & POU_Description & "</description>" '方案页描述
                  POU.WriteLine "<flags>2048</flags>"
                  POU.WriteLine "<POUCycle>500</POUCycle>"
                  POU.WriteLine "<auto-sort>0</auto-sort>"
                  POU.WriteLine "<exporttime>2014-04-29 21:41:00</exporttime>"
                  POU.WriteLine "<amendtime>2014-04-29 21:40:40</amendtime>"
                  POU.WriteLine "<downloadtime></downloadtime>"
                  POU.WriteLine "<modifier></modifier>"
                  POU.WriteLine "<PouPaperSize>A3</PouPaperSize>"
                  POU.WriteLine "<PouPrintType>0</PouPrintType>"

                                      
                    Select Case POU_Type '根据类型转化
                    
                      Case "TOTALIZR" '转化
                            'POU语言
                             POU_Lge = "cfc"
                      
                            POU.WriteLine "<interface>"
                            POU.WriteLine "<![CDATA[PROGRAM " & POU_Name
                            POU.WriteLine "VAR"
'                            POU.WriteLine UREGPV_arr(UREGPV_i, UREGPV("NAME")) & "_SUM" & "(2054): FLOWSUM := ( TOLVAL:=99999999, INSCOF:=0.00013888);(*" & POU_Description & "*)"
                            POU.WriteLine "END_VAR]]>"
                            POU.WriteLine "</interface>"
                            POU.WriteLine "<cfc>"
                            Call I11_ConvertUREGPVLoop_TOTALIZR '转化TOTALIZR
                       Case "HILOAVG" '转化
                            'POU语言
                             POU_Lge = "cfc"
                             
                            POU.WriteLine "<interface>"
                            POU.WriteLine "<![CDATA[PROGRAM " & POU_Name
                            POU.WriteLine "VAR"
'                            POU.WriteLine UREGPV_arr(UREGPV_i, UREGPV("NAME")) & "_AVG" & "(2054): HILOAVG := (X1:=0);(*" & POU_Description & "*)"
                            POU.WriteLine "END_VAR]]>"
                            POU.WriteLine "</interface>"
                            POU.WriteLine "<cfc>"
                            Call I12_ConvertUREGPVLoop_HILOAVG '转化GENLIN
                        Case "GENLIN" '转化
                            'POU语言
                             POU_Lge = "cfc"
                        
'                            Dim XARR As String '折点X
'                            Dim YARR As String '折点Y
'                            Dim PNTNUM As Integer '折点数量
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
                            Call I13_ConvertUREGPVLoop_GENLIN '转化GENLIN
                        Case "MIDOF3" '转化
                            'POU语言
                             POU_Lge = "cfc"
                             
                            POU.WriteLine "<interface>"
                            POU.WriteLine "<![CDATA[PROGRAM " & POU_Name
                            POU.WriteLine "VAR"
'                            POU.WriteLine UREGPV_arr(UREGPV_i, UREGPV("NAME")) & "_OF3" & "(2054): MIDOF3 := (X1:=0);(*" & POU_Description & "*)"
                            POU.WriteLine "END_VAR]]>"
                            POU.WriteLine "</interface>"
                            POU.WriteLine "<cfc>"
                            Call I14_ConvertUREGPVLoop_MIDOF3 '转化MIDOF3
                            
                           Case "VDTLDLAG" '转化
                            'POU语言
                             POU_Lge = "cfc"
                           
                            POU.WriteLine "<interface>"
                            POU.WriteLine "<![CDATA[PROGRAM " & POU_Name
                            POU.WriteLine "VAR"
'                            POU.WriteLine UREGPV_arr(UREGPV_i, UREGPV("NAME")) & "_LAG" & "(2054): VDTLDLAG := (X1:=0);(*" & POU_Description & "*)"
                            POU.WriteLine "END_VAR]]>"
                            POU.WriteLine "</interface>"
                            POU.WriteLine "<cfc>"
                            Call I15_ConvertUREGPVLoop_VDTLDLAG '转化VDTLDLAG
                            
                           Case "FLOWCOMP" '转化
                            'POU语言
                             POU_Lge = "cfc"
                           
                            POU.WriteLine "<interface>"
                            POU.WriteLine "<![CDATA[PROGRAM " & POU_Name
                            POU.WriteLine "VAR"
'                            POU.WriteLine UREGPV_arr(UREGPV_i, UREGPV("NAME")) & "_LAG" & "(2054): FLOWCOMP := (X1:=0);(*" & POU_Description & "*)"
                            POU.WriteLine "END_VAR]]>"
                            POU.WriteLine "</interface>"
                            POU.WriteLine "<cfc>"
                            Call I16_ConvertUREGPVLoop_FLOWCOMP '转化FLOWCOMP
                            
                           Case "CALCULTR" '转化
                            'POU语言
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
                            Call I17_ConvertUREGPVLoop_CALCULTR '转化CALCULTR
                            
                           Case "SUMMER" '转化
                            'POU语言
                             POU_Lge = "cfc"
                           
                            POU.WriteLine "<interface>"
                            POU.WriteLine "<![CDATA[PROGRAM " & POU_Name
                            POU.WriteLine "VAR"
'                            POU.WriteLine UREGPV_arr(UREGPV_i, UREGPV("NAME")) & "_LAG" & "(2054): FLOWCOMP := (X1:=0);(*" & POU_Description & "*)"
                            POU.WriteLine "END_VAR]]>"
                            POU.WriteLine "</interface>"
                            POU.WriteLine "<cfc>"
                            Call I18_ConvertUREGPVLoop_SUMMER '转化SUMMER
                            
                            
                    End Select
                  
                  

                  '(*XML文件结束公用部分*)
                  '--------------------------
                  POU.WriteLine "</" & POU_Lge & ">"
                  POU.WriteLine "</pou>"
                  
                  '(*方案页文件关闭*)
                  '---------------------------
                 POU.Close
        End If
   
Next UREGPV_i

End Sub

