Attribute VB_Name = "C2_HNStationNumberConversion_"
'ver20190814_by cjt
'站号字典
Public SN As Object 'SN
Public SN_rr() As Variant 'SN数组
'把HN站号转换为和利时站号SN字典
Sub C2_HNStationNumberConversion()
Dim i As Integer '循环变量

'沥边UAI,UAO,UDI,UDO确定站号范围为站号转换做准备
'实例化字典
Set SN = CreateObject("Scripting.Dictionary") 'SN字典

'沥边UAI,UAO,UDI,UDO确定站号范围为站号转换做准备
For i = 2 To UBound(UAI_arr(), 1) 'UAI
    If Not SN.Exists(UAI_arr(i, UAI("NODENUM"))) Then
       SN.Add UAI_arr(i, UAI("NODENUM")), ""
   End If
Next

For i = 2 To UBound(UAO_arr(), 1) 'UAO
    If Not SN.Exists(UAO_arr(i, UAO("NODENUM"))) Then
       SN.Add UAI_arr(i, UAO("NODENUM")), ""
   End If
Next

For i = 2 To UBound(UDI_arr(), 1) 'UDI
    If Not SN.Exists(UDI_arr(i, UDI("NODENUM"))) Then
       SN.Add UAI_arr(i, UDI("NODENUM")), ""
   End If
Next

For i = 2 To UBound(UDO_arr(), 1) 'UDO
    If Not SN.Exists(UDO_arr(i, UDO("NODENUM"))) Then
       SN.Add UAI_arr(i, UDO("NODENUM")), ""
   End If
Next
SN_rr = SN.Keys
SN.RemoveAll

'站号排序
For i = 0 To UBound(SN_rr)
    For j = i + 1 To UBound(SN_rr)
        If Int(SN_rr(j)) < Int(SN_rr(i)) Then
           temp = SN_rr(i)
           SN_rr(i) = SN_rr(j)
           SN_rr(j) = temp
        End If
    Next
Next
'站号转变成M6从10开始存储到站字典
For i = 0 To UBound(SN_rr())
       SN.Add SN_rr(i), i + 10
Next

End Sub
