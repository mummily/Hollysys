Attribute VB_Name = "��ʱ"
Sub COM_1()
'1 ��Excelĳһ��������ݶ��뵽������:
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
'2 �����������д�뵽Excel��
'
'wk_data.Range("A1").Resize(UBound(strArray, 1), UBound(strArray, 2)).Value = strArra




Set UAI = CreateObject("Scripting.Dictionary") 'UAI�ֵ�

'��ȡ��ת������UAI����������
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

'��ȡ��ת������UAI����������
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
