Attribute VB_Name = "I17_ConvertUREGPVLoop_CALCULTR_"
'ver20200110_by cjt

'ת��CALCULTR
Sub I17_ConvertUREGPVLoop_CALCULTR()
'�ֲ�����
'*****************************************************
'ͨ��
Dim i As Integer 'ѭ������
Dim HNCALCEXP As String '����������ʽ�ַ���
Dim M6CALCEXP As String 'M6������ʽ�ַ���
Dim Par_dic As Object '�����ֵ�P1~P4,C1~C4
Dim CalFun_dic As Object '�㷨������ת���ֵ�

'*****************************************************


'01---------��ʼ��ֵ��ʵ����
'ʵ�����ֵ䲢��ʼ��
Set Par_dic = CreateObject("Scripting.Dictionary")
Par_dic.RemoveAll
Set CalFun_dic = CreateObject("Scripting.Dictionary")

'02---------��ʼ��ֵ��ʵ����-�����ֵ�P1~P4,C1~C4
'P
Dim AA As String

'HNPN_TI = "12PDY0128_6"
'Call F2_ConvertPN_TI(HNPN_TI)   'ת��

HNPN_TI = UREGPV_arr(UREGPV_i, UREGPV("PISRC(1)"))
Call F2_ConvertPN_TI(HNPN_TI)   'ת��
Par_dic.Add "P1", M6PN_TI

HNPN_TI = UREGPV_arr(UREGPV_i, UREGPV("PISRC(2)"))
Call F2_ConvertPN_TI(HNPN_TI)   'ת��
Par_dic.Add "P2", M6PN_TI

HNPN_TI = UREGPV_arr(UREGPV_i, UREGPV("PISRC(3)"))
Call F2_ConvertPN_TI(HNPN_TI)   'ת��
Par_dic.Add "P3", M6PN_TI

HNPN_TI = UREGPV_arr(UREGPV_i, UREGPV("PISRC(4)"))
Call F2_ConvertPN_TI(HNPN_TI)   'ת��
Par_dic.Add "P4", M6PN_TI

HNPN_TI = UREGPV_arr(UREGPV_i, UREGPV("PISRC(5)"))
Call F2_ConvertPN_TI(HNPN_TI)   'ת��
Par_dic.Add "P5", M6PN_TI

HNPN_TI = UREGPV_arr(UREGPV_i, UREGPV("PISRC(6)"))
Call F2_ConvertPN_TI(HNPN_TI)   'ת��
Par_dic.Add "P6", M6PN_TI

'C
HNPN_TI = UREGPV_arr(UREGPV_i, UREGPV("C1"))
Par_dic.Add "C1", HNPN_TI

HNPN_TI = UREGPV_arr(UREGPV_i, UREGPV("C2"))
Par_dic.Add "C2", HNPN_TI

HNPN_TI = UREGPV_arr(UREGPV_i, UREGPV("C3"))
Par_dic.Add "C3", HNPN_TI

HNPN_TI = UREGPV_arr(UREGPV_i, UREGPV("C4"))
Par_dic.Add "C4", HNPN_TI

HNPN_TI = UREGPV_arr(UREGPV_i, UREGPV("C5"))
Par_dic.Add "C5", HNPN_TI

HNPN_TI = UREGPV_arr(UREGPV_i, UREGPV("C6"))
Par_dic.Add "C6", HNPN_TI

'03---------��ʼ��ֵ��ʵ����-�㷨������ת���ֵ�
With CalFun_dic
   .Add "SQR", "SQRT"
End With

'04---------����������ʽ�ַ���
HNCALCEXP = UREGPV_arr(UREGPV_i, UREGPV("CALCEXP"))
'СдP,C���ɴ�д
HNCALCEXP = Replace(HNCALCEXP, "p", "P")
HNCALCEXP = Replace(HNCALCEXP, "c", "C")

'05---------�������㺯��ת������
For Each k In CalFun_dic.Keys()
   If HNCALCEXP Like "*" & k & "*" Then
      HNCALCEXP = Replace(HNCALCEXP, k, CalFun_dic(k))
   End If
Next
'ȥ��SQRTT
HNCALCEXP = Replace(HNCALCEXP, "SQRTT", "SQRT")
'06---------ȷ��PVCLAMP����
Dim IsCLAMP As String
If UREGPV_arr(UREGPV_i, UREGPV("PVCLAMP")) = "CLAMP" Then
   IsCLAMP = "TRUE"
Else
   IsCLAMP = "FALSE"
End If



'08---------M6������ʽ�ַ���д��XML   UREGPV_arr(UREGPV_i, UREGPV("NAME")) & ".AI" & ":=" & HNCALCEXP & ";"
POU.WriteLine "<body>"
POU.WriteLine "<![CDATA["
POU.WriteLine "(************************************************************************)"
POU.WriteLine "(*P1~P6��C1~C6��Result��CLAMPΪ�ڲ���*)"

'˵��
POU.WriteLine "(*P1~P6��C1~C6��ֵ*)"
'��ֵ
For Each k In Par_dic.Keys()
   If Len(Par_dic(k)) > 0 Then
      POU.WriteLine k & ":=" & Par_dic(k) & ";"
   Else
      POU.WriteLine k & ":=" & "0.000000" & ";"
   End If
Next
POU.WriteLine ""

'˵��
POU.WriteLine "(*�Ƿ�����������*)"
POU.WriteLine "CLAMP:=" & IsCLAMP & ";"
POU.WriteLine ""
'˵��
POU.WriteLine "(*����ʽ*)"
'����ʽ
POU.WriteLine "Result:=" & HNCALCEXP & ";"
POU.WriteLine "(************************************************************************)"
POU.WriteLine ""
'˵��
POU.WriteLine "(*" & UREGPV_arr(UREGPV_i, UREGPV("PTDESC")) & "*)"

'˵��
POU.WriteLine "IF " & "CLAMP" & " THEN"

                    POU.WriteLine "      (*����*)"
                    POU.WriteLine "      IF " & "Result" & ">" & UREGPV_arr(UREGPV_i, UREGPV("PVEXEUHI")) & " THEN"
                    POU.WriteLine "         " & UREGPV_arr(UREGPV_i, UREGPV("NAME")) & ".AI" & ":=" & UREGPV_arr(UREGPV_i, UREGPV("PVEXEUHI")) & ";"
                    POU.WriteLine "      (*����*)"
                    POU.WriteLine "      ELSIF " & "Result" & "<" & UREGPV_arr(UREGPV_i, UREGPV("PVEXEULO")) & " THEN"
                    POU.WriteLine "         " & UREGPV_arr(UREGPV_i, UREGPV("NAME")) & ".AI" & ":=" & UREGPV_arr(UREGPV_i, UREGPV("PVEXEULO")) & ";"
                    POU.WriteLine "      (*����*)"
                    POU.WriteLine "       ELSE "
                    POU.WriteLine "         " & UREGPV_arr(UREGPV_i, UREGPV("NAME")) & ".AI" & ":=Result;"
                    POU.WriteLine "      END_IF"
                    
POU.WriteLine "ELSE "
POU.WriteLine "        " & UREGPV_arr(UREGPV_i, UREGPV("NAME")) & ".AI" & ":=Result;"
POU.WriteLine "END_IF"

POU.WriteLine "]]>"
POU.WriteLine "</body>"


End Sub

