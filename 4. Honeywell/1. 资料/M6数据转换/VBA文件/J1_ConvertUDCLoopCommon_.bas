Attribute VB_Name = "J1_ConvertUDCLoopCommon_"
'ver20190930_by cjt
'UDC全局变量定义
Public UDC_i As Long         'UDC自动生成循环变量
Public UDC_Type As Object    'UREGC类型字典


'转化UREGC公用
Sub J1_ConvertUDCLoopCommon()
Dim UDC_Type_arr() As Variant


'--------------------------------------------------------------------------------------------------------
'01--初始赋值
'--------------------------------------------------------------------------------------------------------
Lab = """"             '"标示字符串
'实例化字典
Set UDC_Type = CreateObject("Scripting.Dictionary") 'UDC_Type字典

'02--查询MAIN定义要转换的UREGPV算法创建空白的方案页
'查询

UDC_Type.RemoveAll '先清空
UDC_Type.Add "MOT2", "MOT2"
UDC_Type.Add "VAL2", "VAL2"


'03--创建XML文件
'--------------------------------------------------------------------------------------------------------
For UDC_i = 2 To UBound(UDC_arr(), 1)

        POU_Type = UDC_arr(UDC_i, UDC("M6BlockType")) '方案页类型
        
        If UDC_Type.Exists(POU_Type) Then '回路类型字典含此类型则转换
        
                  POU_Name = UDC_arr(UDC_i, UDC("NAME")) & "_" & POU_Type   '方案页名
                  POU_Description = "" 'UDC_arr(UDC_i, UDC("PTDESC"))     '方案页描述
                  POUnamef = PATH & "\工程文件\" & SN(UDC_arr(UDC_i, UDC("NODENUM"))) & "\" & POU_Name & ".xml"   '方案页文件存储路径
                  
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
                  POU.WriteLine "<interface>"
                  POU.WriteLine "<![CDATA[PROGRAM " & POU_Name
                  POU.WriteLine "VAR"
                  POU.WriteLine "END_VAR]]>"
                  POU.WriteLine "</interface>"
                  POU.WriteLine "<cfc>"
                                      
                    Select Case POU_Type '根据类型转化
                    
                      Case "VAL2" '转化
                            Call J11_ConvertUDCLoop_VAL2 '转化VAL2
                      Case "MOT2" '转化
                            Call J12_ConvertUDCLoop_MOT2 '转化MOT2
                    End Select
                  
                  

                  '(*XML文件结束公用部分*)
                  '--------------------------
                  POU.WriteLine "</cfc>"
                  POU.WriteLine "</pou>"
                  
                  '(*方案页文件关闭*)
                  '---------------------------
                 POU.Close
        End If
   
Next UDC_i



End Sub

