Attribute VB_Name = "A1_Main_"
'ver20190930_by cjt

'程序开始入口:点击main工作表按钮进入
Sub 数据库转换_btn()

If MsgBox("您确定要进行数据库转换吗?", 4 + 64, "系统提示") = vbYes Then

'**************************************************************************
    oldStatusBar = Application.DisplayStatusBar
    Application.DisplayStatusBar = True
    Application.StatusBar = "系统正在进行数据库转换，请稍候..."
    sStart = TIMER
 '---------------------------------------------------
 Application.ScreenUpdating = False
 
 
 
 
 '调用相关SUB-----------------------------------------
Call B1_Common '初始化与致命错误判断
Call C1_HNDataBaseRead '读取HN组态数据库字段建立数据数组待用
Call C2_HNStationNumberConversion '把HN站号转换为和利时站号SN字典
Call C3_HNNameType 'HN数据库需要的name的数据类型存到NameType字典
Call D1_M6DataBaseRead '读取M6组态数据库字段建立数据数组待用
Call E1_ConvertDataBase '转化数据库
 '---------------------------------------------------



 Application.ScreenUpdating = True
'******************************************************************************

    Application.StatusBar = False
    Application.DisplayStatusBar = oldStatusBar
    Send = TIMER
    MsgBox "执行时间：" & Send - sStart & "s"

End If
End Sub

Sub UREGC算法转换_btn()

If MsgBox("您确定要进行控制算法转换吗?", 4 + 64, "系统提示") = vbYes Then

'**************************************************************************
    oldStatusBar = Application.DisplayStatusBar
    Application.DisplayStatusBar = True
    Application.StatusBar = "系统正在进行控制算法转换，请稍候..."
    sStart = TIMER
 '---------------------------------------------------
 Application.ScreenUpdating = False
 
 
 
 
'调用相关SUB-----------------------------------------
Call B1_Common '初始化与致命错误判断
Call C1_HNDataBaseRead '读取HN组态数据库字段建立数据数组待用
Call C2_HNStationNumberConversion '把HN站号转换为和利时站号SN字典
Call C3_HNNameType 'HN数据库需要的name的数据类型存到NameType字典

Call F1_ConvertLoopCommon '控制回路转化公用

'转化UREGC
Call G1_ConvertUREGLoopCommon '转化UREGC公用
'---------------------------------------------------


 Application.ScreenUpdating = True
'******************************************************************************
    Application.StatusBar = False
    Application.DisplayStatusBar = oldStatusBar
    Send = TIMER
    MsgBox "执行时间：" & Send - sStart & "s"

End If

End Sub
Sub UREGPV算法转换_btn()

If MsgBox("您确定要进行控制算法转换吗?", 4 + 64, "系统提示") = vbYes Then

'**************************************************************************
    oldStatusBar = Application.DisplayStatusBar
    Application.DisplayStatusBar = True
    Application.StatusBar = "系统正在进行控制算法转换，请稍候..."
    sStart = TIMER
 '---------------------------------------------------
 Application.ScreenUpdating = False
 
 
 
 
'调用相关SUB-----------------------------------------
Call B1_Common '初始化与致命错误判断
Call C1_HNDataBaseRead '读取HN组态数据库字段建立数据数组待用
Call C2_HNStationNumberConversion '把HN站号转换为和利时站号SN字典
Call C3_HNNameType 'HN数据库需要的name的数据类型存到NameType字典

Call F1_ConvertLoopCommon '控制回路转化公用

'转化UREGPV
Call I1_ConvertUREGPVLoopCommon '转化UREGPV公用
'---------------------------------------------------


 Application.ScreenUpdating = True
'******************************************************************************
    Application.StatusBar = False
    Application.DisplayStatusBar = oldStatusBar
    Send = TIMER
    MsgBox "执行时间：" & Send - sStart & "s"

End If

End Sub
Sub ULOGIC算法转换_btn()

If MsgBox("您确定要进行控制算法转换吗?", 4 + 64, "系统提示") = vbYes Then

'**************************************************************************
    oldStatusBar = Application.DisplayStatusBar
    Application.DisplayStatusBar = True
    Application.StatusBar = "系统正在进行控制算法转换，请稍候..."
    sStart = TIMER
 '---------------------------------------------------
 Application.ScreenUpdating = False
 
 
 
 
'调用相关SUB-----------------------------------------
Call B1_Common '初始化与致命错误判断
Call C1_HNDataBaseRead '读取HN组态数据库字段建立数据数组待用
Call C2_HNStationNumberConversion '把HN站号转换为和利时站号SN字典
Call C3_HNNameType 'HN数据库需要的name的数据类型存到NameType字典

Call F1_ConvertLoopCommon '控制回路转化公用

'转化UREGC
Call H2_ConvertULOGICLoop '转化ULOGIC
'---------------------------------------------------


 Application.ScreenUpdating = True
'******************************************************************************
    Application.StatusBar = False
    Application.DisplayStatusBar = oldStatusBar
    Send = TIMER
    MsgBox "执行时间：" & Send - sStart & "s"

End If

End Sub
Sub UDC算法转换_btn()
If MsgBox("您确定要进行控制算法转换吗?", 4 + 64, "系统提示") = vbYes Then

'**************************************************************************
    oldStatusBar = Application.DisplayStatusBar
    Application.DisplayStatusBar = True
    Application.StatusBar = "系统正在进行控制算法转换，请稍候..."
    sStart = TIMER
 '---------------------------------------------------
 Application.ScreenUpdating = False
 
 
 
 
'调用相关SUB-----------------------------------------
Call B1_Common '初始化与致命错误判断
Call C1_HNDataBaseRead '读取HN组态数据库字段建立数据数组待用
Call C2_HNStationNumberConversion '把HN站号转换为和利时站号SN字典
Call C3_HNNameType 'HN数据库需要的name的数据类型存到NameType字典

Call F1_ConvertLoopCommon '控制回路转化公用

'转化UREGPV
Call J1_ConvertUDCLoopCommon '转化UREGPV公用
'---------------------------------------------------


 Application.ScreenUpdating = True
'******************************************************************************
    Application.StatusBar = False
    Application.DisplayStatusBar = oldStatusBar
    Send = TIMER
    MsgBox "执行时间：" & Send - sStart & "s"

End If

End Sub
