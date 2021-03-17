Attribute VB_Name = "G1_ConvertUREGLoopCommon_"
'ver20190821_by cjt
'UREGC全局变量定义
Public UREGC_i As Long         'UREGC自动生成循环变量
Public UREGC_Type As Object    'UREGC类型字典


'转化UREGC公用
Sub G1_ConvertUREGLoopCommon()
Dim UREGC_Type_arr() As Variant
'01--初始赋值
'--------------------------------------------------------------------------------------------------------
Lab = """"             '"标示字符串
'实例化字典
Set UREGC_Type = CreateObject("Scripting.Dictionary") 'UREGC_Type字典

'02--查询MAIN定义要转换的UREGC-Regulatory Control Point算法创建空白的方案页
'查询

UREGC_Type.RemoveAll '先清空
With Workbooks(this_sht_name).Worksheets("main") '获取设定的回路
     UREGC_Type_arr = .Range("B8:B24").Value
End With
For i = 1 To UBound(UREGC_Type_arr(), 1) '回路类型字典
    If Not UREGC_Type.Exists(UREGC_Type_arr(i, 1)) And Len(UREGC_Type_arr(i, 1)) > 0 Then
       UREGC_Type.Add UREGC_Type_arr(i, 1), UREGC_Type_arr(i, 1)
    End If
Next

'03--创建XML文件
'--------------------------------------------------------------------------------------------------------
For UREGC_i = 2 To UBound(UREGC_arr(), 1)
        POU_Type = UREGC_arr(UREGC_i, UREGC("CTLALGID"))     '方案页类型
        
        If UREGC_Type.Exists(POU_Type) Then '回路类型字典含此类型则转换
        
                  POU_Name = UREGC_arr(UREGC_i, UREGC("NAME")) & "_" & UREGC_arr(UREGC_i, UREGC("CTLALGID"))   '方案页名
                  POU_Description = "" 'UREGC_arr(UREGC_i, UREGC("PTDESC"))     '方案页描述
                  POUnamef = PATH & "\工程文件\" & SN(UREGC_arr(UREGC_i, UREGC("NODENUM"))) & "\" & POU_Name & ".xml"   '方案页文件存储路径
                  
                   '创建文件
                  Set fs = CreateObject("Scripting.FileSystemObject")
                  Set POU = fs.CreateTextFile(POUnamef, True)
                  
                  '(*XML文件开始公用部分*)
                  '--------------------------------------------------------------------------------------------------------
                  POU.WriteLine "<?xml version=" & Lab & "1.0" & Lab & " encoding=" & Lab & "ISO-8859-1" & Lab & "?>"
                  POU.WriteLine "<pou>"
                  If POU_Type = "SUMMER" Then
                  POU.WriteLine "<path><![CDATA[\/" & POU_Type & "_CTR" & "]]></path>"
                  Else
                  POU.WriteLine "<path><![CDATA[\/" & POU_Type & "]]></path>"
                  End If
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
                  POU.WriteLine "<interface>"
                  POU.WriteLine "<![CDATA[PROGRAM " & POU_Name
                  POU.WriteLine "VAR"
                  POU.WriteLine "END_VAR]]>"
                  POU.WriteLine "</interface>"
                  POU.WriteLine "<cfc>"
                  
                  
                  
                    Select Case POU_Type '根据类型转化
                    
                      Case "PID" '转化
                            Dim strft, strzt As String '中转字符串UREGCPIDAux(strft)
                            
                            'PID输出:副调位号
                            strft = UREGC_arr(UREGC_i, UREGC("CODSTN(1)"))
                            strft = Replace(strft, ".SP", "")
                            
                            'PID输出:
                            strzt = UREGC_arr(UREGC_i, UREGC("NAME"))
                            
                            '普通PID：位号
                            If Len(UREGCPIDAux(strzt)) = 0 And Len(UREGCPIDAux(strft)) = 0 Then
                               Call G11_ConvertUREGLoop_PID '转化pid
                            End If
                            
                            '串级PID
                            If Len(UREGCPIDAux(strzt)) = 0 And Len(UREGCPIDAux(strft)) > 0 Then
                               '转化主副pid
                                Call G112_ConvertUREGLoop_PID
                            End If
                            
                            
                      Case "PIDFF" '转化
                            Call G12_ConvertUREGLoop_PIDFF '转化PIDFF
                                                                
                             
                      Case "AUTOMAN" '转化
                            Call G13_ConvertUREGLoop_AUTOMAN '转化AUTOMAN
                            
                       Case "SWITCH" '转化
                            Call G14_ConvertUREGLoop_SWITCH '转化SWITCH
                            
                       Case "ORSEL" '转化
                            Call G15_ConvertUREGLoop_ORSEL '转化ORSEL
                            
                       Case "MULDIV" '转化
                            Call G16_ConvertUREGLoop_MULDIV '转化MULDIV
                            
                       Case "SUMMER" '转化
                            Call G17_ConvertUREGLoop_SUMMER '转化SUMMER
                                                                   
                    End Select
                  
                  

                  '(*XML文件结束公用部分*)
                  '--------------------------
                  POU.WriteLine "</cfc>"
                  POU.WriteLine "</pou>"
                  
                  '(*方案页文件关闭*)
                  '---------------------------
                 POU.Close
        End If
   
Next UREGC_i

End Sub
