Attribute VB_Name = "F2_ConvertPN_TI_"
'ver20190821_by cjt
Public M6PN_TI As String           'M6λ��+����
Public HNPN_TI As String           'HNλ��+����
Public HNPN As String 'HNλ��
Public HNTI As String 'HNH����
'HNλ��+����ת����M6λ��+����
Sub F2_ConvertPN_TI(HNPN_TI As String)

Dim M6TI As String 'M6����

'01-----��ձ���
M6PN_TI = "" '��ձ���

'02-----HN��ֳ�λ�ź�����
If HNPN_TI Like "*.*" Then 'HN�Ƿ���λ��+����
   If HNPN_TI Like "*(*" Then
        HNPN_TI = Replace(HNPN_TI, "(", "")
        HNPN_TI = Replace(HNPN_TI, ")", "")
   End If
    HNPN = Left(HNPN_TI, InStr(HNPN_TI, ".") - 1) 'HNλ��
    HNTI = Right(HNPN_TI, Len(HNPN_TI) - InStr(HNPN_TI, "."))  'HN����
Else
    HNPN = HNPN_TI
    HNTI = ""
End If
    
'03-----HN����תM6
If Len(HNTI) > 0 Then '��������
   Select Case NameType(HNPN) '��������ת��
   
     Case "UAI" 'UAI����ת��
           Select Case HNTI
                  Case "PV" 'HN����תM6
                       M6TI = ".AV"
           End Select
           
     Case "UAO" 'UAO����ת��
           Select Case HNTI
                  Case "OP" 'HN����תM6
                       M6TI = ".AI"
           End Select
           
     Case "UNUM" 'UNUM����ת��
           Select Case HNTI
                  Case "PV" 'HN����תM6
                       M6TI = ""
           End Select
           
'     Case "UREGPV" 'UREGPV����ת��
'           Select Case HTI
'                  Case "PV" 'HN����תM6
'                       M6TI = ""
'           End Select
           
     Case "PID" 'PID����ת��
           Select Case HNTI
                  Case "OP" 'HN����תM6
                       M6TI = ".OUT"
                  Case "SP" 'HN����תM6
                       M6TI = ".SP"
           End Select
           
      Case "AUTOMAN" 'MAN����ת��
           Select Case HNTI
                  Case "X1" 'HN����תM6
                       M6TI = ".IN"
           End Select
           
     Case "UDI" 'UDI����ת��
           Select Case HNTI
                  Case "PVFL" 'HN����תM6
                       M6TI = ".DV"
           End Select
           
     Case "UDO" 'UDO����ת��
           Select Case HNTI
                  Case "SO" 'HN����תM6
                       M6TI = ".DI"
           End Select
           
     Case "ULOGIC" 'ULOGIC����ת��
           M6TI = "_" & HNTI
     
     Case "UREGPV" 'UREGPV����ת��
           M6TI = ".AI"
           
     Case "SWITCH" 'UREGC����ת��
           Select Case HNTI
                  Case "OP" 'HN����תM6
                       M6TI = ".CV"
                  Case Else
                       M6TI = "." & HNTI
           End Select

     Case "ORSEL" 'UREGC����ת��
           Select Case HNTI
                  Case "OP" 'HN����תM6
                       M6TI = ".CV"
                  Case Else
                       M6TI = "." & HNTI
           End Select
           
     Case "MULDIV" 'UREGC����ת��
           Select Case HNTI
                  Case "OP" 'HN����תM6
                       M6TI = ".CV"
                  Case Else
                       M6TI = "." & HNTI
           End Select
           
       Case "SUMMER" 'UREGC����ת��
           Select Case HNTI
                  Case "OP" 'HN����תM6
                       M6TI = ".CV"
                  Case Else
                       M6TI = "." & HNTI
           End Select
           
      Case Else
            M6TI = "." & HNTI
     
   End Select
     
End If
    
'M6λ��+����
M6PN_TI = Replace(HNPN & M6TI, " ", "")

'04-----��ձ���
HNPN_TI = "" '��ձ���

End Sub

