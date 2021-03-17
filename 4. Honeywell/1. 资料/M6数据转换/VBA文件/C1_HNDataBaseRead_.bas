Attribute VB_Name = "C1_HNDataBaseRead_"
'ver20190814_by cjt
'HN数据库字段字典
'物理点
Public UAI As Object 'AI\RTD\TC
Public UAO As Object 'AO
Public UDI As Object 'DI
Public UDO As Object 'DO
'内部量
Public UFLG As Object '内部开关量点
Public UPM As Object '内部开关量点
Public UNUM As Object '内部模拟量点
'逻辑控制
Public UDC As Object '电机阀门逻辑点
Public ULOGIC As Object '逻辑点
Public ULOGIC1 As Object '逻辑关系
Public ULOGIC2 As Object '逻辑关系
'监控模拟量控制回路
Public UREGC As Object 'Regulatory Control Point监控点含PID等
Public UREGC1 As Object 'Regulatory Control Point监控点含PID等
Public UREGC1Name As Object 'Regulatory Control Point监控点含PID等

Public UREGCPIDType As Object 'Regulatory Control Point监控点含PID名称字典
Public UREGCPIDAux As Object 'Regulatory Control Point监控点含副调PID所在的行
'模拟量计算UREGPV
Public UREGPV As Object '模拟运算
'定时器
Public UTIM As Object '定时器

'HN数据库数组
Public UAI_arr() As Variant 'AI
Public UAO_arr() As Variant 'AO
Public UDI_arr() As Variant 'DI
Public UDO_arr() As Variant 'DO
'内部量
Public UFLG_arr() As Variant '内部开关量点
Public UPM_arr() As Variant '内部开关量点
Public UNUM_arr() As Variant '内部模拟量点
'逻辑控制
Public UDC_arr() As Variant '电机阀门逻辑点
Public ULOGIC_arr() As Variant '逻辑点
Public ULOGIC1_arr() As Variant '逻辑关系
Public ULOGIC2_arr() As Variant '逻辑关系
'监控模拟量控制回路
Public UREGC_arr() As Variant 'Regulatory Control Point监控点含PID等
Public UREGC1_arr() As Variant 'Regulatory Control Point监控点含PID等
'模拟量计算UREGPV
Public UREGPV_arr() As Variant '模拟运算
'定时器
Public UTIM_arr() As Variant '定时器

'模块冗余相关
Public UPMCONFIG As Object 'UPMCONFIG字段
Public UPMCONFIG1 As Object 'UPMCONFIG1字段

Public UPMCONFIGSN As Object 'UPMCONFIG站号
Public UPMCONFIG1SN As Object 'UPMCONFIG1站号

Public UPMCONFIG_arr() As Variant 'UPMCONFIG
Public UPMCONFIG1_arr() As Variant 'UPMCONFIG1

'读取HN组态数据库字段建立数据数组待用
Sub C1_HNDataBaseRead()
Dim xc, xr As Integer '工作表行和列
Dim i, j As Integer '循环变量
Dim shh As New HND排序 '创建排序类的实例
 '******************************************************信息栏
Application.StatusBar = "系统正在读取HN数据库，请稍候..."

'01-----实例化字典
'物理点
Set UAI = CreateObject("Scripting.Dictionary") 'UAI字典
Set UAO = CreateObject("Scripting.Dictionary") 'UAO字典
Set UDI = CreateObject("Scripting.Dictionary") 'UDI字典
Set UDO = CreateObject("Scripting.Dictionary") 'UDO字典
'内部量
Set UFLG = CreateObject("Scripting.Dictionary") '内部开关量点字典
Set UPM = CreateObject("Scripting.Dictionary") '内部开关量点字典
Set UNUM = CreateObject("Scripting.Dictionary") '内部模拟量点字典
'逻辑控制
Set UDC = CreateObject("Scripting.Dictionary") '逻辑点字典
Set ULOGIC = CreateObject("Scripting.Dictionary") '逻辑点字典
Set ULOGIC1 = CreateObject("Scripting.Dictionary") '逻辑关系字典
Set ULOGIC2 = CreateObject("Scripting.Dictionary") '逻辑关系字典
'监控模拟量控制回路
Set UREGC = CreateObject("Scripting.Dictionary")  'Regulatory Control Point监控点含PID等字典
Set UREGC1 = CreateObject("Scripting.Dictionary")  'Regulatory Control Point监控点含PID等字典
Set UREGC1Name = CreateObject("Scripting.Dictionary")  'Regulatory Control Point监控点含PID等字典
Set UREGCPIDType = CreateObject("Scripting.Dictionary") 'Regulatory Control Point监控点含PID的类型主调还是副调
Set UREGCPIDAux = CreateObject("Scripting.Dictionary") 'Regulatory Control PointPoint监控点含副调PID所在的行
'模拟量计算UREGPV
Set UREGPV = CreateObject("Scripting.Dictionary")  '模拟运算字典
'定时器
Set UTIM = CreateObject("Scripting.Dictionary")  '定时器字典
'模块冗余相关
Set UPMCONFIG = CreateObject("Scripting.Dictionary") 'UPMCONFIG
Set UPMCONFIG1 = CreateObject("Scripting.Dictionary") 'UPMCONFIG1
Set UPMCONFIGSN = CreateObject("Scripting.Dictionary") 'UPMCONFIG
Set UPMCONFIG1SN = CreateObject("Scripting.Dictionary") 'UPMCONFIG1
'02-----打开读取待转換文件夹下UCN01all数据库
If FileExists(PATH & "\待转換文件\" & soc_sht_name & ".xls") Then '判断工作簿是否存在如果存在先判断是否打开如打开就关闭
   If WorkbookOpen(soc_sht_name & ".xls") Then
      Workbooks(soc_sht_name & ".xls").Save
      Workbooks(soc_sht_name & ".xls").Close
   End If
   
   Else
    MsgBox "请确认" & PATH & "\待转換文件\" & soc_sht_name & ".xls" & "是否存在！"
    Exit Sub
End If
'打开
Workbooks.Open (PATH & "\待转換文件\" & soc_sht_name & ".xls")
'03-----获取字段建立数据数组
With Workbooks(soc_sht_name & ".xls")
    '03-01-----UAI
    .Sheets("UAI").Select
    'Set shh.排序 = .Sheets("UAI")
    With .Sheets("UAI")
         xc = .UsedRange.Columns.Count
         xr = .UsedRange.Rows.Count
         'UAI数组
         UAI_arr = Sheets("UAI").Range(Cells(1, 1), Cells(xr, xc)).Value
         'UAI字段字典
         With UAI
             For i = 1 To xc
                .Add UAI_arr(1, i), i
             Next
         End With
    End With
    
    '03-02-----UAO
    .Sheets("UAO").Select
    'Set shh.排序 = .Sheets("UAO")
    With .Sheets("UAO")
         xc = .UsedRange.Columns.Count
         xr = .UsedRange.Rows.Count
         'UAO数组
         UAO_arr = Sheets("UAO").Range(Cells(1, 1), Cells(xr, xc)).Value
         'UAO字段字典
         With UAO
             For i = 1 To xc
                .Add UAO_arr(1, i), i
             Next
         End With
    End With
    
    '03-02-----UDI
    .Sheets("UDI").Select
    'Set shh.排序 = .Sheets("UDI")
    With .Sheets("UDI")
         xc = .UsedRange.Columns.Count
         xr = .UsedRange.Rows.Count
         'UDI数组
         UDI_arr = Sheets("UDI").Range(Cells(1, 1), Cells(xr, xc)).Value
         'UDI字段字典
         With UDI
             For i = 1 To xc
                .Add UDI_arr(1, i), i
             Next
         End With
    End With
    
    
    '03-02-----UDO
    .Sheets("UDO").Select
    'Set shh.排序 = .Sheets("UDO")
    With .Sheets("UDO")
         xc = .UsedRange.Columns.Count
         xr = .UsedRange.Rows.Count
         'UDO数组
         UDO_arr = Sheets("UDO").Range(Cells(1, 1), Cells(xr, xc)).Value
         'UDO字段字典
         With UDO
             For i = 1 To xc
                .Add UDO_arr(1, i), i
             Next
         End With
    End With
    
    '03-03-----UREGC
    '-UREGC
    .Sheets("UREGC").Select
    'Set shh.排序 = .Sheets("UREGC")
    With .Sheets("UREGC")
         xc = .UsedRange.Columns.Count
         xr = .UsedRange.Rows.Count
         'UREGC数组
         UREGC_arr = Sheets("UREGC").Range(Cells(1, 1), Cells(xr, xc)).Value
         'UREGC字段字典
         With UREGC
             For i = 1 To xc
                .Add UREGC_arr(1, i), i
             Next
         End With
    End With
     '把所有的PID装到UREGCPIDType字典待用，关键字为PID位号，条目为UREGC行号
    For j = 2 To xr
        If UREGC_arr(j, UREGC("CTLALGID")) = "PID" Then
           With UREGCPIDType
                If Not .Exists(UREGC_arr(j, UREGC("NAME"))) Then
                   .Add UREGC_arr(j, UREGC("NAME")), j
                End If
           End With
        End If
    Next
    '中转字符串
    Dim str1 As String
    
     '把副调PID装到UREGCPIDAux字典，关键字为PID位号，条目为UREGC行号
    For j = 2 To xr
        If UREGC_arr(j, UREGC("CTLALGID")) = "PID" Then '查找PID
           str1 = UREGC_arr(j, UREGC("CODSTN(1)")) 'PID输出连接的变量
           If str1 Like "*.SP*" Then '判断是不是连接的PID的SP,获得其PID所在的行字典
               str1 = Replace(str1, ".SP", "")
               If UREGCPIDType.Exists(str1) Then
                    With UREGCPIDAux
                            If Not .Exists(UREGC_arr(j, UREGC("CODSTN(1)"))) Then
                               .Add str1, UREGCPIDType(str1)
                            End If
                    End With
               End If
           End If
        End If
    Next
    
    
    '-UREGC1
    .Sheets("UREGC1").Select
    With .Sheets("UREGC1")
         xc = .UsedRange.Columns.Count
         xr = .UsedRange.Rows.Count
         'UREGC1数组
         UREGC1_arr = Sheets("UREGC1").Range(Cells(1, 1), Cells(xr, xc)).Value
         'UREGC1字段字典
         With UREGC1
             For i = 1 To xc
                .Add UREGC1_arr(1, i), i
             Next
         End With
         With UREGC1Name
             For i = 1 To xr
                .Add UREGC1_arr(i, UREGC1("NAME")), i
             Next
         End With
    End With
    
    '03-04内部模拟量点
    .Sheets("UNUM").Select
    'Set shh.排序 = .Sheets("UNUM")
    With .Sheets("UNUM")
         xc = .UsedRange.Columns.Count
         xr = .UsedRange.Rows.Count
         'UNUM数组
         UNUM_arr = Sheets("UNUM").Range(Cells(1, 1), Cells(xr, xc)).Value
         'UNUM字段字典
         With UNUM
             For i = 1 To xc
                .Add UNUM_arr(1, i), i
             Next
         End With
    End With
    
    '03-05模拟量计算
    .Sheets("UREGPV").Select
    'Set shh.排序 = .Sheets("UREGPV")
    With .Sheets("UREGPV")
         xc = .UsedRange.Columns.Count
         xr = .UsedRange.Rows.Count
         'UREGPV数组
         UREGPV_arr = Sheets("UREGPV").Range(Cells(1, 1), Cells(xr, xc)).Value
         'UREGPV字段字典
         With UREGPV
             For i = 1 To xc
                .Add UREGPV_arr(1, i), i
             Next
         End With
    End With
    
    '03-06UDC
    .Sheets("UDC").Select
    'Set shh.排序 = .Sheets("UDC")
    With .Sheets("UDC")
         xc = .UsedRange.Columns.Count
         xr = .UsedRange.Rows.Count
         'UDC数组
         UDC_arr = Sheets("UDC").Range(Cells(1, 1), Cells(xr, xc)).Value
         'UDC字段字典
         With UDC
             For i = 1 To xc
                .Add UDC_arr(1, i), i
             Next
         End With
         
        If Not UDC.Exists("M6BlockType") Then
            .Columns("B:B").Insert Shift:=xlToRight
            .Cells(1, 2) = "M6BlockType"
            MsgBox ("待转换文件补充 M6BlockType 列 内容否则UDC不能完成转化")
            '重读
            xc = .UsedRange.Columns.Count
            xr = .UsedRange.Rows.Count
            'UDC数组
             Erase UDC_arr
             UDC_arr = Sheets("UDC").Range(Cells(1, 1), Cells(xr, xc)).Value
             'UDC字段字典
             UDC.RemoveAll
             With UDC
                 For i = 1 To xc
                    .Add UDC_arr(1, i), i
                 Next
         End With
            
         End If
         
    End With


    '03-07UFLG
    .Sheets("UFLG").Select
    'Set shh.排序 = .Sheets("UFLG")
    With .Sheets("UFLG")
         xc = .UsedRange.Columns.Count
         xr = .UsedRange.Rows.Count
         'UFLG数组
         UFLG_arr = Sheets("UFLG").Range(Cells(1, 1), Cells(xr, xc)).Value
         'UFLG字段字典
         With UFLG
             For i = 1 To xc
                .Add UFLG_arr(1, i), i
             Next
         End With
    End With
    
    '03-08ULOGIC
    .Sheets("ULOGIC").Select
    'Set shh.排序 = .Sheets("ULOGIC")
    With .Sheets("ULOGIC")
         xc = .UsedRange.Columns.Count
         xr = .UsedRange.Rows.Count
         'ULOGIC数组
         ULOGIC_arr = Sheets("ULOGIC").Range(Cells(1, 1), Cells(xr, xc)).Value
         'ULOGIC字段字典
         With ULOGIC
             For i = 1 To xc
                .Add ULOGIC_arr(1, i), i
             Next
         End With
    End With
    
     .Sheets("ULOGIC1").Select
    With .Sheets("ULOGIC1")
         xc = .UsedRange.Columns.Count
         xr = .UsedRange.Rows.Count
         'ULOGIC1数组
         ULOGIC1_arr = Sheets("ULOGIC1").Range(Cells(1, 1), Cells(xr, xc)).Value
         'ULOGIC1字段字典
         With ULOGIC1
             For i = 1 To xc
                .Add ULOGIC1_arr(1, i), i
             Next
         End With
    End With
    
     .Sheets("ULOGIC2").Select
    With .Sheets("ULOGIC2")
         xc = .UsedRange.Columns.Count
         xr = .UsedRange.Rows.Count
         'ULOGIC2数组
         ULOGIC2_arr = Sheets("ULOGIC2").Range(Cells(1, 1), Cells(xr, xc)).Value
         'ULOGIC2字段字典
         With ULOGIC2
             For i = 1 To xc
                .Add ULOGIC2_arr(1, i), i
             Next
         End With
    End With
    
    '03-09UPM
    .Sheets("UPM").Select
    'Set shh.排序 = .Sheets("UPM")
    With .Sheets("UPM")
         xc = .UsedRange.Columns.Count
         xr = .UsedRange.Rows.Count
         'UPM数组
         UPM_arr = Sheets("UPM").Range(Cells(1, 1), Cells(xr, xc)).Value
         'UPM字段字典
         With UPM
             For i = 1 To xc
                .Add UPM_arr(1, i), i
             Next
         End With
    End With
    
    '03-10UTIM
    .Sheets("UTIM").Select
    'Set shh.排序 = .Sheets("UTIM")
    With .Sheets("UTIM")
         xc = .UsedRange.Columns.Count
         xr = .UsedRange.Rows.Count
         'UTIM数组
        UTIM_arr = Sheets("UTIM").Range(Cells(1, 1), Cells(xr, xc)).Value
         'UTIM字段字典
         With UTIM
             For i = 1 To xc
                .Add UTIM_arr(1, i), i
             Next
         End With
    End With
    
    '03-11模块信息
    .Sheets("UPMCONFIG").Select
    With .Sheets("UPMCONFIG")
         xc = .UsedRange.Columns.Count
         xr = .UsedRange.Rows.Count
         'UTIM数组
        UPMCONFIG_arr = Sheets("UPMCONFIG").Range(Cells(1, 1), Cells(xr, xc)).Value
         'UTIM字段字典
         With UPMCONFIG
             For i = 1 To xc
                .Add UPMCONFIG_arr(1, i), i
             Next
         End With
         
         '站号字典
         With UPMCONFIGSN
             For i = 2 To xr
                .Add UPMCONFIG_arr(i, UPMCONFIG("NAME")), i
             Next
         End With
         
    End With
    
    .Sheets("UPMCONFIG1").Select
    With .Sheets("UPMCONFIG1")
         xc = .UsedRange.Columns.Count
         xr = .UsedRange.Rows.Count
         'UTIM数组
        UPMCONFIG1_arr = Sheets("UPMCONFIG1").Range(Cells(1, 1), Cells(xr, xc)).Value
         'UTIM字段字典
         With UPMCONFIG1
             For i = 1 To xc
                .Add UPMCONFIG1_arr(1, i), i
             Next
         End With
         
         '站号字典
         With UPMCONFIG1SN
             For i = 2 To xr
                .Add UPMCONFIG1_arr(i, UPMCONFIG1("NAME")), i
             Next
         End With
         
    End With
    
End With


'03-----关闭
Workbooks(soc_sht_name & ".xls").Close savechanges:=True


End Sub
