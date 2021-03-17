VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "HND排序"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Property Set 排序(sh As Worksheet)
  '字段字典
  Dim Field As Object '表格字段字典
  Dim Field_arr() As Variant '表格字段数组
  Dim i As Integer '循环变量
  Dim xc, xr As Integer '工作表行和列
  '实例化字典
  Set Field = CreateObject("Scripting.Dictionary") '表格字段
  xc = sh.[IV1].End(xlToLeft).Column '字段列数
    '数组
    Field_arr = sh.Range(Cells(1, 1), Cells(2, xc)).Value
    '字段字典
    With Field
        For i = 1 To xc
           .Add Field_arr(1, i), i
        Next
    End With
 xr = sh.Range(Cells(65535, Field("UNIT")), Cells(65535, Field("UNIT"))).End(xlUp).Row '数据行数
 '排序 站，设备号，通道号
 With sh
    .Sort.SortFields.Clear
    .Sort.SortFields.Add2 Key:=Range(Cells(2, Field("NODENUM")), Cells(xr, Field("NODENUM"))), SortOn:=xlSortOnValues, Order:=xlAscending, DataOption:=xlSortNormal
    .Sort.SortFields.Add2 Key:=Range(Cells(2, Field("MODNUM")), Cells(xr, Field("MODNUM"))), SortOn:=xlSortOnValues, Order:=xlAscending, DataOption:=xlSortTextAsNumbers
    .Sort.SortFields.Add2 Key:=Range(Cells(2, Field("SLOTNUM")), Cells(xr, Field("SLOTNUM"))), SortOn:=xlSortOnValues, Order:=xlAscending, DataOption:=xlSortTextAsNumbers
    With .Sort
        .SetRange Range(Cells(1, 1), Cells(xr, xc))
        .Header = xlYes
        .MatchCase = False
        .Orientation = xlTopToBottom
        .SortMethod = xlPinYin
        .Apply
    End With
End With

End Property

