Attribute VB_Name = "C2_HNStationNumberConversion_"
'ver20190814_by cjt
'վ���ֵ�
Public SN As Object 'SN
Public SN_rr() As Variant 'SN����
'��HNվ��ת��Ϊ����ʱվ��SN�ֵ�
Sub C2_HNStationNumberConversion()
Dim i As Integer 'ѭ������

'����UAI,UAO,UDI,UDOȷ��վ�ŷ�ΧΪվ��ת����׼��
'ʵ�����ֵ�
Set SN = CreateObject("Scripting.Dictionary") 'SN�ֵ�

'����UAI,UAO,UDI,UDOȷ��վ�ŷ�ΧΪվ��ת����׼��
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

'վ������
For i = 0 To UBound(SN_rr)
    For j = i + 1 To UBound(SN_rr)
        If Int(SN_rr(j)) < Int(SN_rr(i)) Then
           temp = SN_rr(i)
           SN_rr(i) = SN_rr(j)
           SN_rr(j) = temp
        End If
    Next
Next
'վ��ת���M6��10��ʼ�洢��վ�ֵ�
For i = 0 To UBound(SN_rr())
       SN.Add SN_rr(i), i + 10
Next

End Sub
