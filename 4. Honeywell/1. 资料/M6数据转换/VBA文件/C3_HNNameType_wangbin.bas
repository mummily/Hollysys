Attribute VB_Name = "C3_HNNameType_0226"
'ver20200226_by cjt
Public NameType As Object '��������
'HN���ݿ���Ҫ��name���������ʹ浽NameType�ֵ�
Sub C3_HNNameType()

Dim i As Integer 'ѭ������

'01-----ʵ�����ֵ�
Set NameType = CreateObject("Scripting.Dictionary") '���������ֵ�

'02-----�����еı����������ʹ浽�ֵ�
NameType.RemoveAll
With NameType

    'UAI
    For i = 2 To UBound(UAI_arr(), 1)
    
       .Add UAI_arr(i, UAI("NAME")), "UAI" '����
       
    Next
    
    'UAO
    For i = 2 To UBound(UAO_arr(), 1)
    
       .Add UAO_arr(i, UAO("NAME")), "UAO" '����
       
    Next
    
    'UDC
    For i = 2 To UBound(UDC_arr(), 1)
    
       .Add UDC_arr(i, UDC("NAME")), "UDC" '����
       
    Next
    
    'UDI
    For i = 2 To UBound(UDI_arr(), 1)
    
       .Add UDI_arr(i, UDI("NAME")), "UDI" '����
       
    Next
    
    'UDO
    For i = 2 To UBound(UDO_arr(), 1)
    
       .Add UDO_arr(i, UDO("NAME")), "UDO" '����
       
    Next
    
    'UREGC
    For i = 2 To UBound(UREGC_arr(), 1)
    
       .Add UREGC_arr(i, UREGC("NAME")), UREGC_arr(i, UREGC("CTLALGID")) '����
       
    Next
    
    'UNUM
    For i = 2 To UBound(UNUM_arr(), 1)
    
       .Add UNUM_arr(i, UNUM("NAME")), "UNUM" '����
       
    Next
    
    'UREGPV
    For i = 2 To UBound(UREGPV_arr(), 1)
    
       .Add UREGPV_arr(i, UREGPV("NAME")), "UREGPV" '����

    Next
    
    'ULOGIC
    For i = 2 To UBound(ULOGIC_arr(), 1)
    
       .Add ULOGIC_arr(i, ULOGIC("NAME")), "ULOGIC" '����
       
    Next
    
End With



End Sub
