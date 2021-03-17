Attribute VB_Name = "C3_HNNameType_0226"
'ver20200226_by cjt
Public NameType As Object '数据类型
'HN数据库需要的name的数据类型存到NameType字典
Sub C3_HNNameType()

Dim i As Integer '循环变量

'01-----实例化字典
Set NameType = CreateObject("Scripting.Dictionary") '数据类型字典

'02-----把所有的变量名和类型存到字典
NameType.RemoveAll
With NameType

    'UAI
    For i = 2 To UBound(UAI_arr(), 1)
    
       .Add UAI_arr(i, UAI("NAME")), "UAI" '点名
       
    Next
    
    'UAO
    For i = 2 To UBound(UAO_arr(), 1)
    
       .Add UAO_arr(i, UAO("NAME")), "UAO" '点名
       
    Next
    
    'UDC
    For i = 2 To UBound(UDC_arr(), 1)
    
       .Add UDC_arr(i, UDC("NAME")), "UDC" '点名
       
    Next
    
    'UDI
    For i = 2 To UBound(UDI_arr(), 1)
    
       .Add UDI_arr(i, UDI("NAME")), "UDI" '点名
       
    Next
    
    'UDO
    For i = 2 To UBound(UDO_arr(), 1)
    
       .Add UDO_arr(i, UDO("NAME")), "UDO" '点名
       
    Next
    
    'UREGC
    For i = 2 To UBound(UREGC_arr(), 1)
    
       .Add UREGC_arr(i, UREGC("NAME")), UREGC_arr(i, UREGC("CTLALGID")) '点名
       
    Next
    
    'UNUM
    For i = 2 To UBound(UNUM_arr(), 1)
    
       .Add UNUM_arr(i, UNUM("NAME")), "UNUM" '点名
       
    Next
    
    'UREGPV
    For i = 2 To UBound(UREGPV_arr(), 1)
    
       .Add UREGPV_arr(i, UREGPV("NAME")), "UREGPV" '点名

    Next
    
    'ULOGIC
    For i = 2 To UBound(ULOGIC_arr(), 1)
    
       .Add ULOGIC_arr(i, ULOGIC("NAME")), "ULOGIC" '点名
       
    Next
    
End With



End Sub
