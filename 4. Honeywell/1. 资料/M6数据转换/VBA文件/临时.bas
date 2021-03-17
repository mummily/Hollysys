Attribute VB_Name = "临时"
Sub COM_1()
'1 把Excel某一区域的内容读入到数组中:
'
'Dim strArray() As Variant
'
'Dim wk_data As Variant
'
'Set wk_data = Sheets("Sheet1")
'
'strArray = wk_data.Range("A1:CV100").Value
'
'Print
'
'2 把数组的内容写入到Excel中
'
'wk_data.Range("A1").Resize(UBound(strArray, 1), UBound(strArray, 2)).Value = strArra




Set UAI = CreateObject("Scripting.Dictionary") 'UAI字典

'获取待转换数据UAI工作表到数组
xc = Sheets("AI").UsedRange.Columns.Count
'xr = Sheets("AI").UsedRange.Rows.Count
xr = 1000
Sheets("AI").Activate
AI_arr = Sheets("AI").Range(Cells(1, 1), Cells(xr, xc)).Value

With AI
    For i = 1 To xc
       .Add AI_arr(1, i), i
    Next
End With

'获取待转换数据UAI工作表到数组
xc = Sheets("UAI").UsedRange.Columns.Count
xr = Sheets("UAI").UsedRange.Rows.Count
Sheets("UAI").Activate
UAI_arr = Sheets("UAI").Range(Cells(1, 1), Cells(xr, xc)).Value

With UAI
    For i = 1 To xc
       .Add UAI_arr(1, i), i
    Next
End With
AI_arr(3, AI("PN")) = UAI_arr(3, UAI("NAME"))
C = A

End Sub
