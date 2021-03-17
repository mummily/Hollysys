Attribute VB_Name = "F2_ConvertPN_TI_"
'ver20190821_by cjt
Public M6PN_TI As String           'M6位号+项名
Public HNPN_TI As String           'HN位号+项名
Public HNPN As String 'HN位号
Public HNTI As String 'HNH项名
'HN位号+项名转化成M6位号+项名
Sub F2_ConvertPN_TI(HNPN_TI As String)

Dim M6TI As String 'M6项名

'01-----清空备用
M6PN_TI = "" '清空备用

'02-----HN拆分成位号和项名
If HNPN_TI Like "*.*" Then 'HN是否是位号+项名
   If HNPN_TI Like "*(*" Then
        HNPN_TI = Replace(HNPN_TI, "(", "")
        HNPN_TI = Replace(HNPN_TI, ")", "")
   End If
    HNPN = Left(HNPN_TI, InStr(HNPN_TI, ".") - 1) 'HN位号
    HNTI = Right(HNPN_TI, Len(HNPN_TI) - InStr(HNPN_TI, "."))  'HN项名
Else
    HNPN = HNPN_TI
    HNTI = ""
End If
    
'03-----HN项名转M6
If Len(HNTI) > 0 Then '存在项名
   Select Case NameType(HNPN) '根据类型转化
   
     Case "UAI" 'UAI类型转化
           Select Case HNTI
                  Case "PV" 'HN项名转M6
                       M6TI = ".AV"
           End Select
           
     Case "UAO" 'UAO类型转化
           Select Case HNTI
                  Case "OP" 'HN项名转M6
                       M6TI = ".AI"
           End Select
           
     Case "UNUM" 'UNUM类型转化
           Select Case HNTI
                  Case "PV" 'HN项名转M6
                       M6TI = ""
           End Select
           
'     Case "UREGPV" 'UREGPV类型转化
'           Select Case HTI
'                  Case "PV" 'HN项名转M6
'                       M6TI = ""
'           End Select
           
     Case "PID" 'PID类型转化
           Select Case HNTI
                  Case "OP" 'HN项名转M6
                       M6TI = ".OUT"
                  Case "SP" 'HN项名转M6
                       M6TI = ".SP"
           End Select
           
      Case "AUTOMAN" 'MAN类型转化
           Select Case HNTI
                  Case "X1" 'HN项名转M6
                       M6TI = ".IN"
           End Select
           
     Case "UDI" 'UDI类型转化
           Select Case HNTI
                  Case "PVFL" 'HN项名转M6
                       M6TI = ".DV"
           End Select
           
     Case "UDO" 'UDO类型转化
           Select Case HNTI
                  Case "SO" 'HN项名转M6
                       M6TI = ".DI"
           End Select
           
     Case "ULOGIC" 'ULOGIC类型转化
           M6TI = "_" & HNTI
     
     Case "UREGPV" 'UREGPV类型转化
           M6TI = ".AI"
           
     Case "SWITCH" 'UREGC类型转化
           Select Case HNTI
                  Case "OP" 'HN项名转M6
                       M6TI = ".CV"
                  Case Else
                       M6TI = "." & HNTI
           End Select

     Case "ORSEL" 'UREGC类型转化
           Select Case HNTI
                  Case "OP" 'HN项名转M6
                       M6TI = ".CV"
                  Case Else
                       M6TI = "." & HNTI
           End Select
           
     Case "MULDIV" 'UREGC类型转化
           Select Case HNTI
                  Case "OP" 'HN项名转M6
                       M6TI = ".CV"
                  Case Else
                       M6TI = "." & HNTI
           End Select
           
       Case "SUMMER" 'UREGC类型转化
           Select Case HNTI
                  Case "OP" 'HN项名转M6
                       M6TI = ".CV"
                  Case Else
                       M6TI = "." & HNTI
           End Select
           
      Case Else
            M6TI = "." & HNTI
     
   End Select
     
End If
    
'M6位号+项名
M6PN_TI = Replace(HNPN & M6TI, " ", "")

'04-----清空备用
HNPN_TI = "" '清空备用

End Sub

