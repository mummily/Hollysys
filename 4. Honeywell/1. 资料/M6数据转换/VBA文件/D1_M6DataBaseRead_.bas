Attribute VB_Name = "D1_M6DataBaseRead_"
'ver20190814_by cjt
'M6通用版数据库字段字典
'物理点
Public AI As Object 'AI
Public RTD As Object 'RTD
Public TC As Object 'TC
Public AO As Object 'AO
Public DI As Object 'DI
Public DOV As Object 'DO
'内部点
Public REAL As Object 'REAL
Public AM As Object 'AM
Public DS As Object 'DS
Public DM As Object 'DM
'块-UREGC
Public PIDA As Object 'PIDA
Public MAN As Object 'MAN
Public SWITCH As Object 'SWITCH
Public ORSEL As Object 'ORSEL
Public MULDIV As Object 'MULDIV
Public SUMMER_CTRL As Object 'SUMMER_CTRL
Public MOT2 As Object 'MOT2
Public VAL2 As Object 'VAL2
'块-UREGPV
Public CALCULTR As Object 'CALCULTR
Public FLOWCOMP As Object 'FLOWCOMP
Public GENLIN As Object 'GENLIN
Public ONEFOLD As Object 'ONEFOLD
Public HILOAVG As Object 'HILOAVG
Public MIDOF3 As Object 'MIDOF3
Public TOTALIZR As Object 'TOTALIZR
Public VDTLDLAG As Object 'VDTLDLAG
Public SUMMER As Object 'SUMMER
Public FLOWSUM As Object 'FLOWSUM
'TIMER
Public HTIMER As Object 'TIMER

'M6通用版数据库数组
'物理点
Public AI_arr() As Variant 'AI
Public RTD_arr() As Variant 'RTD
Public TC_arr() As Variant 'TC
Public AO_arr() As Variant 'AO
Public DI_arr() As Variant 'DI
Public DOV_arr() As Variant 'DO
'内部点
Public REAL_arr() As Variant 'REAL
Public AM_arr() As Variant 'AM
Public DS_arr() As Variant 'DS
Public DM_arr() As Variant 'DM
'块-UREGC
Public PIDA_arr() As Variant 'PIDA
Public MAN_arr() As Variant 'MAN
Public SWITCH_arr() As Variant 'SWITCH
Public ORSEL_arr() As Variant 'ORSEL
Public MULDIV_arr() As Variant 'MULDIV
Public SUMMER_CTRL_arr() As Variant 'SUMMER_CTRL
Public MOT2_arr() As Variant 'MOT2
Public VAL2_arr() As Variant 'VAL2
'块-UREGPV
Public CALCULTR_arr() As Variant 'CALCULTR
Public FLOWCOMP_arr() As Variant 'FLOWCOMP
Public GENLIN_arr() As Variant 'GENLIN
Public ONEFOLD_arr() As Variant 'ONEFOLD
Public HILOAVG_arr() As Variant 'HILOAVG
Public MIDOF3_arr() As Variant 'MIDOF3
Public TOTALIZR_arr() As Variant 'TOTALIZR
Public VDTLDLAG_arr() As Variant 'VDTLDLAG
Public SUMMER_arr() As Variant 'SUMMER
Public FLOWSUM_arr() As Variant 'FLOWSUM
'TIMER
Public HTIMER_arr() As Variant 'TIMER


'读取M6组态数据库字段建立数据数组待用
Sub D1_M6DataBaseRead()
Dim xc, xr As Integer '工作表行和列
Dim i, j As Integer '循环变量

 '******************************************************信息栏
Application.StatusBar = "系统正在读取M6标准数据库，请稍候..."

'01-----实例化字典
Set AI = CreateObject("Scripting.Dictionary") 'AI字典
Set RTD = CreateObject("Scripting.Dictionary") 'RTD字典
Set TC = CreateObject("Scripting.Dictionary") 'TC字典
Set AO = CreateObject("Scripting.Dictionary") 'AO字典
Set DI = CreateObject("Scripting.Dictionary") 'DI字典
Set DOV = CreateObject("Scripting.Dictionary") 'DO字典
Set REAL = CreateObject("Scripting.Dictionary") 'REAL字典
Set AM = CreateObject("Scripting.Dictionary") 'AM字典
Set DS = CreateObject("Scripting.Dictionary") 'DS字典
Set DM = CreateObject("Scripting.Dictionary") 'DM字典

Set PIDA = CreateObject("Scripting.Dictionary") 'PIDA字典
Set MAN = CreateObject("Scripting.Dictionary") 'MAN字典
Set SWITCH = CreateObject("Scripting.Dictionary") 'SWITCH字典
Set ORSEL = CreateObject("Scripting.Dictionary") 'ORSEL字典
Set MULDIV = CreateObject("Scripting.Dictionary") 'MULDIV字典
Set SUMMER_CTRL = CreateObject("Scripting.Dictionary") 'SUMMER_CTRL字典
Set MOT2 = CreateObject("Scripting.Dictionary") 'MOT2字典
Set VAL2 = CreateObject("Scripting.Dictionary") 'VAL2字典

Set CALCULTR = CreateObject("Scripting.Dictionary") 'CALCULTR字典
Set FLOWCOMP = CreateObject("Scripting.Dictionary") 'FLOWCOMP字典
Set GENLIN = CreateObject("Scripting.Dictionary") 'GENLIN字典
Set ONEFOLD = CreateObject("Scripting.Dictionary") 'ONEFOLD字典
Set HILOAVG = CreateObject("Scripting.Dictionary") 'HILOAVG字典
Set MIDOF3 = CreateObject("Scripting.Dictionary") 'MIDOF3字典
Set TOTALIZR = CreateObject("Scripting.Dictionary") 'TOTALIZR字典
Set VDTLDLAG = CreateObject("Scripting.Dictionary") 'VDTLDLAG字典
Set FLOWSUM = CreateObject("Scripting.Dictionary") 'FLOWSUM字典
Set SUMMER = CreateObject("Scripting.Dictionary") 'SUMMER字典

Set HTIMER = CreateObject("Scripting.Dictionary") 'HTIMER字典

'02-----打开读取源文件夹下通用版组态数据库
If FileExists(PATH & "\源文件\通用版组态数据库.xlsx") Then '判断工作簿是否存在如果存在先判断是否打开如打开就关闭
   If WorkbookOpen("通用版组态数据库.xlsx") Then
      Workbooks("通用版组态数据库.xlsx").Save
      Workbooks("通用版组态数据库.xlsx").Close
   End If
   
   Else
    MsgBox "请确认" & PATH & "\源文件\通用版组态数据库.xlsx" & "是否存在！"
    Exit Sub
End If
'打开
Workbooks.Open (PATH & "\源文件\通用版组态数据库.xlsx")
'03-----获取字段建立数据数组
With Workbooks("通用版组态数据库.xlsx")
    '03-101-----AI
    .Sheets("AI").Select
    With .Sheets("AI")
         xc = .UsedRange.Columns.Count
         xr = 3000 '暂时固定为2
         'AI数组
         AI_arr = Sheets("AI").Range(Cells(1, 1), Cells(xr, xc)).Value
         'AI字段字典
         With AI
             For i = 1 To xc
                .Add AI_arr(1, i), i
             Next
         End With
    End With
    '03-102-----RTD
    .Sheets("RTD").Select
    With .Sheets("RTD")
         xc = .UsedRange.Columns.Count
         xr = 3000 '暂时固定为2
         'RTD数组
         RTD_arr = Sheets("RTD").Range(Cells(1, 1), Cells(xr, xc)).Value
         'RTD字段字典
         With RTD
             For i = 1 To xc
                .Add RTD_arr(1, i), i
             Next
         End With
    End With
    '03-103-----TC
    .Sheets("TC").Select
    With .Sheets("TC")
         xc = .UsedRange.Columns.Count
         xr = 3000 '暂时固定为2
         'TC数组
         TC_arr = Sheets("TC").Range(Cells(1, 1), Cells(xr, xc)).Value
         'RTD字段字典
         With TC
             For i = 1 To xc
                .Add TC_arr(1, i), i
             Next
         End With
    End With
    '03-104-----AO
    .Sheets("AO").Select
    With .Sheets("AO")
         xc = .UsedRange.Columns.Count
         xr = 3000 '暂时固定为2
         'AO数组
         AO_arr = Sheets("AO").Range(Cells(1, 1), Cells(xr, xc)).Value
         'AO字段字典
         With AO
             For i = 1 To xc
                .Add AO_arr(1, i), i
             Next
         End With
    End With
    '03-105-----DI
    .Sheets("DI").Select
    With .Sheets("DI")
         xc = .UsedRange.Columns.Count
         xr = 3000 '暂时固定为2
         'DI数组
         DI_arr = Sheets("DI").Range(Cells(1, 1), Cells(xr, xc)).Value
         'AI字段字典
         With DI
             For i = 1 To xc
                .Add DI_arr(1, i), i
             Next
         End With
    End With
    '03-106-----DO
    .Sheets("DOV").Select
    With .Sheets("DOV")
         xc = .UsedRange.Columns.Count
         xr = 3000 '暂时固定为2
         'DOV数组
         DOV_arr = Sheets("DOV").Range(Cells(1, 1), Cells(xr, xc)).Value
         'DO字段字典
         With DOV
             For i = 1 To xc
                .Add DOV_arr(1, i), i
             Next
         End With
    End With
    '03-107-----REAL
    .Sheets("AS").Select
    With .Sheets("AS")
         xc = .UsedRange.Columns.Count
         xr = 30000 '暂时固定为2
         'REAL数组
         REAL_arr = Sheets("AS").Range(Cells(1, 1), Cells(xr, xc)).Value
         'REAL字段字典
         With REAL
             For i = 1 To xc
                .Add REAL_arr(1, i), i
             Next
         End With
    End With
    '03-108-----AM
    .Sheets("AM").Select
    With .Sheets("AM")
         xc = .UsedRange.Columns.Count
         xr = 3000 '暂时固定为2
         'AM数组
         AM_arr = Sheets("AM").Range(Cells(1, 1), Cells(xr, xc)).Value
         'AM字段字典
         With AM
             For i = 1 To xc
                .Add AM_arr(1, i), i
             Next
         End With
    End With
    
    
    '03-110-----DM
    .Sheets("DM").Select
    With .Sheets("DM")
         xc = .UsedRange.Columns.Count
         xr = 3000 '暂时固定为2
         'DM数组
         DM_arr = Sheets("DM").Range(Cells(1, 1), Cells(xr, xc)).Value
         'AM字段字典
         With DM
             For i = 1 To xc
                .Add DM_arr(1, i), i
             Next
         End With
    End With
    
    '03-111-----DS
    .Sheets("DS").Select
    With .Sheets("DS")
         xc = .UsedRange.Columns.Count
         xr = 30000 '暂时固定为2
         'DS数组
         DS_arr = Sheets("DS").Range(Cells(1, 1), Cells(xr, xc)).Value
         'AM字段字典
         With DS
             For i = 1 To xc
                .Add DS_arr(1, i), i
             Next
         End With
    End With
    
    '03-201-----PIDA
    .Sheets("PIDA").Select
    With .Sheets("PIDA")
         xc = .UsedRange.Columns.Count
         xr = 3000 '暂时固定为2
         'PIDA数组
         PIDA_arr = Sheets("PIDA").Range(Cells(1, 1), Cells(xr, xc)).Value
         'PIDA字段字典
         With PIDA
             For i = 1 To xc
                .Add PIDA_arr(1, i), i
             Next
         End With
    End With
    
    '03-202-----MAN
    .Sheets("MAN").Select
    With .Sheets("MAN")
         xc = .UsedRange.Columns.Count
         xr = 3000 '暂时固定为2
         'MAN数组
         MAN_arr = Sheets("MAN").Range(Cells(1, 1), Cells(xr, xc)).Value
         'MAN字段字典
         With MAN
             For i = 1 To xc
                .Add MAN_arr(1, i), i
             Next
         End With
    End With
    
    '03-203-----SWITCH
    .Sheets("SWITCH").Select
    With .Sheets("SWITCH")
         xc = .UsedRange.Columns.Count
         xr = 3000 '暂时固定为2
         'SWITCH数组
         SWITCH_arr = Sheets("SWITCH").Range(Cells(1, 1), Cells(xr, xc)).Value
         'SWITCH字段字典
         With SWITCH
             For i = 1 To xc
                .Add SWITCH_arr(1, i), i
             Next
         End With
    End With
    
    '03-204-----ORSEL
    .Sheets("ORSEL").Select
    With .Sheets("ORSEL")
         xc = .UsedRange.Columns.Count
         xr = 3000 '暂时固定为2
         'ORSEL数组
         ORSEL_arr = Sheets("ORSEL").Range(Cells(1, 1), Cells(xr, xc)).Value
         'ORSEL字段字典
         With ORSEL
             For i = 1 To xc
                .Add ORSEL_arr(1, i), i
             Next
         End With
    End With
     '03-205-----MULDIV
    .Sheets("MULDIV").Select
    With .Sheets("MULDIV")
         xc = .UsedRange.Columns.Count
         xr = 3000 '暂时固定为2
         'MULDIV数组
         MULDIV_arr = Sheets("MULDIV").Range(Cells(1, 1), Cells(xr, xc)).Value
         'MULDIV字段字典
         With MULDIV
             For i = 1 To xc
                .Add MULDIV_arr(1, i), i
             Next
         End With
    End With
     '03-206-----SUMMER
    .Sheets("SUMMER").Select
    With .Sheets("SUMMER")
         xc = .UsedRange.Columns.Count
         xr = 3000 '暂时固定为2
         'SUMMER数组
         SUMMER_arr = Sheets("SUMMER").Range(Cells(1, 1), Cells(xr, xc)).Value
         'SUMMER字段字典
         With SUMMER
             For i = 1 To xc
                .Add SUMMER_arr(1, i), i
             Next
         End With
    End With

     


    '03-301-----MOT2
    .Sheets("MOT2").Select
    With .Sheets("MOT2")
         xc = .UsedRange.Columns.Count
         xr = 3000 '暂时固定为2
         'MOT2数组
         MOT2_arr = Sheets("MOT2").Range(Cells(1, 1), Cells(xr, xc)).Value
         'MOT2字段字典
         With MOT2
             For i = 1 To xc
                .Add MOT2_arr(1, i), i
             Next
         End With
    End With
    
    '03-302-----VAL2
    .Sheets("VAL2").Select
    With .Sheets("VAL2")
         xc = .UsedRange.Columns.Count
         xr = 3000 '暂时固定为2
         'VAL2数组
         VAL2_arr = Sheets("VAL2").Range(Cells(1, 1), Cells(xr, xc)).Value
         'VAL2字段字典
         With VAL2
             For i = 1 To xc
                .Add VAL2_arr(1, i), i
             Next
         End With
    End With
    
    '03-401-----FLOWCOMP
    .Sheets("FLOWCOMP").Select
    With .Sheets("FLOWCOMP")
         xc = .UsedRange.Columns.Count
         xr = 3000 '暂时固定为2
         'FLOWCOMP数组
         FLOWCOMP_arr = Sheets("FLOWCOMP").Range(Cells(1, 1), Cells(xr, xc)).Value
         'FLOWCOMP字段字典
         With FLOWCOMP
             For i = 1 To xc
                .Add FLOWCOMP_arr(1, i), i
             Next
         End With
    End With

'    '03-402-----GENLIN
'    .Sheets("GENLIN").Select
'    With .Sheets("GENLIN")
'         xc = .UsedRange.Columns.Count
'         xr = 3000 '暂时固定为2
'         'GENLIN数组
'         GENLIN_arr = Sheets("GENLIN").Range(Cells(1, 1), Cells(xr, xc)).Value
'         'GENLIN字段字典
'         With GENLIN
'             For i = 1 To xc
'                .Add GENLIN_arr(1, i), i
'             Next
'         End With
'    End With

    '03-402-----ONEFOLD
    .Sheets("ONEFOLD").Select
    With .Sheets("ONEFOLD")
         xc = .UsedRange.Columns.Count
         xr = 3000 '暂时固定为2
         'ONEFOLD数组
         ONEFOLD_arr = Sheets("ONEFOLD").Range(Cells(1, 1), Cells(xr, xc)).Value
         'ONEFOLD字段字典
         With ONEFOLD
             For i = 1 To xc
                .Add ONEFOLD_arr(1, i), i
             Next
         End With
    End With



     '03-403-----HILOAVG
    .Sheets("HILOAVG").Select
    With .Sheets("HILOAVG")
         xc = .UsedRange.Columns.Count
         xr = 3000 '暂时固定为2
         'HILOAVG数组
         HILOAVG_arr = Sheets("HILOAVG").Range(Cells(1, 1), Cells(xr, xc)).Value
         'HILOAVG字段字典
         With HILOAVG
             For i = 1 To xc
                .Add HILOAVG_arr(1, i), i
             Next
         End With
    End With

    '03-404-----MIDOF3
    .Sheets("MIDOF3").Select
    With .Sheets("MIDOF3")
         xc = .UsedRange.Columns.Count
         xr = 3000 '暂时固定为2
         'MIDOF3数组
         MIDOF3_arr = Sheets("MIDOF3").Range(Cells(1, 1), Cells(xr, xc)).Value
         'MIDOF3字段字典
         With MIDOF3
             For i = 1 To xc
                .Add MIDOF3_arr(1, i), i
             Next
         End With
    End With

'     '03-405-----TOTALIZR
'    .Sheets("TOTALIZR").Select
'    With .Sheets("TOTALIZR")
'         xc = .UsedRange.Columns.Count
'         xr = 3000 '暂时固定为2
'         'TOTALIZR数组
'         TOTALIZR_arr = Sheets("TOTALIZR").Range(Cells(1, 1), Cells(xr, xc)).Value
'         'TOTALIZR字段字典
'         With TOTALIZR
'             For i = 1 To xc
'                .Add TOTALIZR_arr(1, i), i
'             Next
'         End With
'    End With

    '03-406-----VDTLDLAG
    .Sheets("VDTLDLAG").Select
    With .Sheets("VDTLDLAG")
         xc = .UsedRange.Columns.Count
         xr = 3000 '暂时固定为2
         'VDTLDLAG数组
         VDTLDLAG_arr = Sheets("VDTLDLAG").Range(Cells(1, 1), Cells(xr, xc)).Value
         'VDTLDLAG字段字典
         With VDTLDLAG
             For i = 1 To xc
                .Add VDTLDLAG_arr(1, i), i
             Next
         End With
    End With
    
    '03-407-----FLOWSUM
    .Sheets("FLOWSUM").Select
    With .Sheets("FLOWSUM")
         xc = .UsedRange.Columns.Count
         xr = 3000 '暂时固定为2
         'FLOWSUM数组
         FLOWSUM_arr = Sheets("FLOWSUM").Range(Cells(1, 1), Cells(xr, xc)).Value
         'FLOWSUM字段字典
         With FLOWSUM
             For i = 1 To xc
                .Add FLOWSUM_arr(1, i), i
             Next
         End With
    End With
    
    '03-408-----SUMMER_CTRL
    .Sheets("SUMMER_CTRL").Select
    With .Sheets("SUMMER_CTRL")
         xc = .UsedRange.Columns.Count
         xr = 3000 '暂时固定为2
         'SUMMER_CTRL数组
         SUMMER_CTRL_arr = Sheets("SUMMER_CTRL").Range(Cells(1, 1), Cells(xr, xc)).Value
         'FLOWSUM字段字典
         With SUMMER_CTRL
             For i = 1 To xc
                .Add SUMMER_CTRL_arr(1, i), i
             Next
         End With
    End With
    
    '03-409-----TIMER
    .Sheets("TIMER").Select
    With .Sheets("TIMER")
         xc = .UsedRange.Columns.Count
         xr = 3000 '暂时固定为2
         'TIMER数组
         HTIMER_arr = Sheets("TIMER").Range(Cells(1, 1), Cells(xr, xc)).Value
         'FLOWSUM字段字典
         With HTIMER
             For i = 1 To xc
                .Add HTIMER_arr(1, i), i
             Next
         End With
    End With
    
End With
'03-----关闭
Workbooks("通用版组态数据库.xlsx").Close


End Sub

