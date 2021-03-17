Attribute VB_Name = "I17_ConvertUREGPVLoop_CALCULTR_"
'ver20200110_by cjt

'转化CALCULTR
Sub I17_ConvertUREGPVLoop_CALCULTR()
'局部变量
'*****************************************************
'通用
Dim i As Integer '循环变量
Dim HNCALCEXP As String '霍尼运算表达式字符串
Dim M6CALCEXP As String 'M6运算表达式字符串
Dim Par_dic As Object '参数字典P1~P4,C1~C4
Dim CalFun_dic As Object '算法函数名转化字典

'*****************************************************


'01---------初始赋值与实例化
'实例化字典并初始化
Set Par_dic = CreateObject("Scripting.Dictionary")
Par_dic.RemoveAll
Set CalFun_dic = CreateObject("Scripting.Dictionary")

'02---------初始赋值与实例化-参数字典P1~P4,C1~C4
'P
Dim AA As String

'HNPN_TI = "12PDY0128_6"
'Call F2_ConvertPN_TI(HNPN_TI)   '转换

HNPN_TI = UREGPV_arr(UREGPV_i, UREGPV("PISRC(1)"))
Call F2_ConvertPN_TI(HNPN_TI)   '转换
Par_dic.Add "P1", M6PN_TI

HNPN_TI = UREGPV_arr(UREGPV_i, UREGPV("PISRC(2)"))
Call F2_ConvertPN_TI(HNPN_TI)   '转换
Par_dic.Add "P2", M6PN_TI

HNPN_TI = UREGPV_arr(UREGPV_i, UREGPV("PISRC(3)"))
Call F2_ConvertPN_TI(HNPN_TI)   '转换
Par_dic.Add "P3", M6PN_TI

HNPN_TI = UREGPV_arr(UREGPV_i, UREGPV("PISRC(4)"))
Call F2_ConvertPN_TI(HNPN_TI)   '转换
Par_dic.Add "P4", M6PN_TI

HNPN_TI = UREGPV_arr(UREGPV_i, UREGPV("PISRC(5)"))
Call F2_ConvertPN_TI(HNPN_TI)   '转换
Par_dic.Add "P5", M6PN_TI

HNPN_TI = UREGPV_arr(UREGPV_i, UREGPV("PISRC(6)"))
Call F2_ConvertPN_TI(HNPN_TI)   '转换
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

'03---------初始赋值与实例化-算法函数名转化字典
With CalFun_dic
   .Add "SQR", "SQRT"
End With

'04---------霍尼运算表达式字符串
HNCALCEXP = UREGPV_arr(UREGPV_i, UREGPV("CALCEXP"))
'小写P,C换成大写
HNCALCEXP = Replace(HNCALCEXP, "p", "P")
HNCALCEXP = Replace(HNCALCEXP, "c", "C")

'05---------沥遍运算函数转换函数
For Each k In CalFun_dic.Keys()
   If HNCALCEXP Like "*" & k & "*" Then
      HNCALCEXP = Replace(HNCALCEXP, k, CalFun_dic(k))
   End If
Next
'去除SQRTT
HNCALCEXP = Replace(HNCALCEXP, "SQRTT", "SQRT")
'06---------确认PVCLAMP属性
Dim IsCLAMP As String
If UREGPV_arr(UREGPV_i, UREGPV("PVCLAMP")) = "CLAMP" Then
   IsCLAMP = "TRUE"
Else
   IsCLAMP = "FALSE"
End If



'08---------M6运算表达式字符串写到XML   UREGPV_arr(UREGPV_i, UREGPV("NAME")) & ".AI" & ":=" & HNCALCEXP & ";"
POU.WriteLine "<body>"
POU.WriteLine "<![CDATA["
POU.WriteLine "(************************************************************************)"
POU.WriteLine "(*P1~P6、C1~C6、Result、CLAMP为内部量*)"

'说明
POU.WriteLine "(*P1~P6，C1~C6赋值*)"
'赋值
For Each k In Par_dic.Keys()
   If Len(Par_dic(k)) > 0 Then
      POU.WriteLine k & ":=" & Par_dic(k) & ";"
   Else
      POU.WriteLine k & ":=" & "0.000000" & ";"
   End If
Next
POU.WriteLine ""

'说明
POU.WriteLine "(*是否限制上下限*)"
POU.WriteLine "CLAMP:=" & IsCLAMP & ";"
POU.WriteLine ""
'说明
POU.WriteLine "(*计算式*)"
'计算式
POU.WriteLine "Result:=" & HNCALCEXP & ";"
POU.WriteLine "(************************************************************************)"
POU.WriteLine ""
'说明
POU.WriteLine "(*" & UREGPV_arr(UREGPV_i, UREGPV("PTDESC")) & "*)"

'说明
POU.WriteLine "IF " & "CLAMP" & " THEN"

                    POU.WriteLine "      (*上限*)"
                    POU.WriteLine "      IF " & "Result" & ">" & UREGPV_arr(UREGPV_i, UREGPV("PVEXEUHI")) & " THEN"
                    POU.WriteLine "         " & UREGPV_arr(UREGPV_i, UREGPV("NAME")) & ".AI" & ":=" & UREGPV_arr(UREGPV_i, UREGPV("PVEXEUHI")) & ";"
                    POU.WriteLine "      (*下限*)"
                    POU.WriteLine "      ELSIF " & "Result" & "<" & UREGPV_arr(UREGPV_i, UREGPV("PVEXEULO")) & " THEN"
                    POU.WriteLine "         " & UREGPV_arr(UREGPV_i, UREGPV("NAME")) & ".AI" & ":=" & UREGPV_arr(UREGPV_i, UREGPV("PVEXEULO")) & ";"
                    POU.WriteLine "      (*正常*)"
                    POU.WriteLine "       ELSE "
                    POU.WriteLine "         " & UREGPV_arr(UREGPV_i, UREGPV("NAME")) & ".AI" & ":=Result;"
                    POU.WriteLine "      END_IF"
                    
POU.WriteLine "ELSE "
POU.WriteLine "        " & UREGPV_arr(UREGPV_i, UREGPV("NAME")) & ".AI" & ":=Result;"
POU.WriteLine "END_IF"

POU.WriteLine "]]>"
POU.WriteLine "</body>"


End Sub

