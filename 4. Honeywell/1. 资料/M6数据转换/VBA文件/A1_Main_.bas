Attribute VB_Name = "A1_Main_"
'ver20190930_by cjt

'����ʼ���:���main������ť����
Sub ���ݿ�ת��_btn()

If MsgBox("��ȷ��Ҫ�������ݿ�ת����?", 4 + 64, "ϵͳ��ʾ") = vbYes Then

'**************************************************************************
    oldStatusBar = Application.DisplayStatusBar
    Application.DisplayStatusBar = True
    Application.StatusBar = "ϵͳ���ڽ������ݿ�ת�������Ժ�..."
    sStart = TIMER
 '---------------------------------------------------
 Application.ScreenUpdating = False
 
 
 
 
 '�������SUB-----------------------------------------
Call B1_Common '��ʼ�������������ж�
Call C1_HNDataBaseRead '��ȡHN��̬���ݿ��ֶν��������������
Call C2_HNStationNumberConversion '��HNվ��ת��Ϊ����ʱվ��SN�ֵ�
Call C3_HNNameType 'HN���ݿ���Ҫ��name���������ʹ浽NameType�ֵ�
Call D1_M6DataBaseRead '��ȡM6��̬���ݿ��ֶν��������������
Call E1_ConvertDataBase 'ת�����ݿ�
 '---------------------------------------------------



 Application.ScreenUpdating = True
'******************************************************************************

    Application.StatusBar = False
    Application.DisplayStatusBar = oldStatusBar
    Send = TIMER
    MsgBox "ִ��ʱ�䣺" & Send - sStart & "s"

End If
End Sub

Sub UREGC�㷨ת��_btn()

If MsgBox("��ȷ��Ҫ���п����㷨ת����?", 4 + 64, "ϵͳ��ʾ") = vbYes Then

'**************************************************************************
    oldStatusBar = Application.DisplayStatusBar
    Application.DisplayStatusBar = True
    Application.StatusBar = "ϵͳ���ڽ��п����㷨ת�������Ժ�..."
    sStart = TIMER
 '---------------------------------------------------
 Application.ScreenUpdating = False
 
 
 
 
'�������SUB-----------------------------------------
Call B1_Common '��ʼ�������������ж�
Call C1_HNDataBaseRead '��ȡHN��̬���ݿ��ֶν��������������
Call C2_HNStationNumberConversion '��HNվ��ת��Ϊ����ʱվ��SN�ֵ�
Call C3_HNNameType 'HN���ݿ���Ҫ��name���������ʹ浽NameType�ֵ�

Call F1_ConvertLoopCommon '���ƻ�·ת������

'ת��UREGC
Call G1_ConvertUREGLoopCommon 'ת��UREGC����
'---------------------------------------------------


 Application.ScreenUpdating = True
'******************************************************************************
    Application.StatusBar = False
    Application.DisplayStatusBar = oldStatusBar
    Send = TIMER
    MsgBox "ִ��ʱ�䣺" & Send - sStart & "s"

End If

End Sub
Sub UREGPV�㷨ת��_btn()

If MsgBox("��ȷ��Ҫ���п����㷨ת����?", 4 + 64, "ϵͳ��ʾ") = vbYes Then

'**************************************************************************
    oldStatusBar = Application.DisplayStatusBar
    Application.DisplayStatusBar = True
    Application.StatusBar = "ϵͳ���ڽ��п����㷨ת�������Ժ�..."
    sStart = TIMER
 '---------------------------------------------------
 Application.ScreenUpdating = False
 
 
 
 
'�������SUB-----------------------------------------
Call B1_Common '��ʼ�������������ж�
Call C1_HNDataBaseRead '��ȡHN��̬���ݿ��ֶν��������������
Call C2_HNStationNumberConversion '��HNվ��ת��Ϊ����ʱվ��SN�ֵ�
Call C3_HNNameType 'HN���ݿ���Ҫ��name���������ʹ浽NameType�ֵ�

Call F1_ConvertLoopCommon '���ƻ�·ת������

'ת��UREGPV
Call I1_ConvertUREGPVLoopCommon 'ת��UREGPV����
'---------------------------------------------------


 Application.ScreenUpdating = True
'******************************************************************************
    Application.StatusBar = False
    Application.DisplayStatusBar = oldStatusBar
    Send = TIMER
    MsgBox "ִ��ʱ�䣺" & Send - sStart & "s"

End If

End Sub
Sub ULOGIC�㷨ת��_btn()

If MsgBox("��ȷ��Ҫ���п����㷨ת����?", 4 + 64, "ϵͳ��ʾ") = vbYes Then

'**************************************************************************
    oldStatusBar = Application.DisplayStatusBar
    Application.DisplayStatusBar = True
    Application.StatusBar = "ϵͳ���ڽ��п����㷨ת�������Ժ�..."
    sStart = TIMER
 '---------------------------------------------------
 Application.ScreenUpdating = False
 
 
 
 
'�������SUB-----------------------------------------
Call B1_Common '��ʼ�������������ж�
Call C1_HNDataBaseRead '��ȡHN��̬���ݿ��ֶν��������������
Call C2_HNStationNumberConversion '��HNվ��ת��Ϊ����ʱվ��SN�ֵ�
Call C3_HNNameType 'HN���ݿ���Ҫ��name���������ʹ浽NameType�ֵ�

Call F1_ConvertLoopCommon '���ƻ�·ת������

'ת��UREGC
Call H2_ConvertULOGICLoop 'ת��ULOGIC
'---------------------------------------------------


 Application.ScreenUpdating = True
'******************************************************************************
    Application.StatusBar = False
    Application.DisplayStatusBar = oldStatusBar
    Send = TIMER
    MsgBox "ִ��ʱ�䣺" & Send - sStart & "s"

End If

End Sub
Sub UDC�㷨ת��_btn()
If MsgBox("��ȷ��Ҫ���п����㷨ת����?", 4 + 64, "ϵͳ��ʾ") = vbYes Then

'**************************************************************************
    oldStatusBar = Application.DisplayStatusBar
    Application.DisplayStatusBar = True
    Application.StatusBar = "ϵͳ���ڽ��п����㷨ת�������Ժ�..."
    sStart = TIMER
 '---------------------------------------------------
 Application.ScreenUpdating = False
 
 
 
 
'�������SUB-----------------------------------------
Call B1_Common '��ʼ�������������ж�
Call C1_HNDataBaseRead '��ȡHN��̬���ݿ��ֶν��������������
Call C2_HNStationNumberConversion '��HNվ��ת��Ϊ����ʱվ��SN�ֵ�
Call C3_HNNameType 'HN���ݿ���Ҫ��name���������ʹ浽NameType�ֵ�

Call F1_ConvertLoopCommon '���ƻ�·ת������

'ת��UREGPV
Call J1_ConvertUDCLoopCommon 'ת��UREGPV����
'---------------------------------------------------


 Application.ScreenUpdating = True
'******************************************************************************
    Application.StatusBar = False
    Application.DisplayStatusBar = oldStatusBar
    Send = TIMER
    MsgBox "ִ��ʱ�䣺" & Send - sStart & "s"

End If

End Sub
