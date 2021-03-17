Attribute VB_Name = "B1_Common_0214"
'ver20190814_by cjt

'程序公共：各种严重错误判断和公共信息取值保证后续程序顺利执行
Sub B1_Common()
Dim folder_arr(1 To 10) As String '文件夹名数组
Dim socf_arr(1 To 10) As String '源文件夹下文件数组

 '******************************************************信息栏
Application.StatusBar = "系统正在进行初始化，请稍候..."


    '000-----局部变量赋值
    Rev = V1 '版本
    folder_arr(1) = "源文件"
    folder_arr(2) = "工程文件"
    folder_arr(3) = "待转換文件"
    
    socf_arr(1) = "电力版组态数据库"
    socf_arr(2) = "通用版组态数据库"

    
    '00-----全局变量赋值
    this_sht_name = ThisWorkbook.NAME '本工作簿名称
    PATH = ThisWorkbook.PATH '时间
    ftime = Replace(Replace(Replace(VBA.Now, "/", "_"), " ", "_"), ":", "_") '时间
    
    
    '01-----程序正常运行条件检查
    
    '01-01-----------判断main工作表是否存在
    wb_name = this_sht_name '工作簿名称
    sht_name = "main" '工作表名称
    If Not SheetExists(wb_name, sht_name) Then
      MsgBox "请确认" & wb_name & "中" & sht_name & "工作表是否存在！"
      Exit Sub
    End If
    
    '01-02-----------判断几个必须的文件夹是否存在无自动建立
    For i = 1 To 10
      If Len(folder_arr(i)) > 0 Then
        If Not filefolderExists(PATH & "\" & folder_arr(i) & "\") Then
        MkDir PATH & "\" & folder_arr(i) & "\"
        End If
      End If
    Next
    
     '01-03-----------判断源文件夹下源文件是否存在
    For i = 1 To 10
      If Len(socf_arr(i)) > 0 Then
        If Not FileExists(PATH & "\源文件\" & socf_arr(i) & ".xlsx") Then
        MsgBox "请确认" & PATH & "\源文件\" & socf_arr(i) & ".xlsx" & "是否存在！"
        Exit Sub
        End If
      End If
    Next
    

    '01-04-----------判断main中待转換文件源文件名是不是正常
    With Workbooks(this_sht_name).Worksheets("main")
         If Len(.Cells(2, 3)) <= 0 Then
            MsgBox "请确认" & wb_name & "中" & sht_name & "工作表 单元格C2待转換文件名 是否存在！"
            Exit Sub
         End If
         soc_sht_name = .Cells(2, 3) '待转換文件源文件工作簿名称
    End With
    
    '01-05-----------判断待转換文件夹下待转换文件是否存在
    If Not FileExists(PATH & "\待转換文件\" & soc_sht_name & ".xls") Then
        MsgBox "请确认" & PATH & "\待转換文件\" & soc_sht_name & ".xls" & "是否存在！"
        Exit Sub
    End If
     
    '01-06-----------获取控制器型号
    With Workbooks(this_sht_name).Worksheets("main")
         If .Cells(3, 5) = "K-CU03" Then
            controllerModel = .Cells(3, 5) '控制器型号
         Else
            controllerModel = "K-CU01/K-CU11" '控制器型号
         End If
         
    End With
     
     
End Sub

