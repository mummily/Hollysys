Attribute VB_Name = "D1_M6DataBaseRead_"
'ver20190814_by cjt
'M6ͨ�ð����ݿ��ֶ��ֵ�
'�����
Public AI As Object 'AI
Public RTD As Object 'RTD
Public TC As Object 'TC
Public AO As Object 'AO
Public DI As Object 'DI
Public DOV As Object 'DO
'�ڲ���
Public REAL As Object 'REAL
Public AM As Object 'AM
Public DS As Object 'DS
Public DM As Object 'DM
'��-UREGC
Public PIDA As Object 'PIDA
Public MAN As Object 'MAN
Public SWITCH As Object 'SWITCH
Public ORSEL As Object 'ORSEL
Public MULDIV As Object 'MULDIV
Public SUMMER_CTRL As Object 'SUMMER_CTRL
Public MOT2 As Object 'MOT2
Public VAL2 As Object 'VAL2
'��-UREGPV
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

'M6ͨ�ð����ݿ�����
'�����
Public AI_arr() As Variant 'AI
Public RTD_arr() As Variant 'RTD
Public TC_arr() As Variant 'TC
Public AO_arr() As Variant 'AO
Public DI_arr() As Variant 'DI
Public DOV_arr() As Variant 'DO
'�ڲ���
Public REAL_arr() As Variant 'REAL
Public AM_arr() As Variant 'AM
Public DS_arr() As Variant 'DS
Public DM_arr() As Variant 'DM
'��-UREGC
Public PIDA_arr() As Variant 'PIDA
Public MAN_arr() As Variant 'MAN
Public SWITCH_arr() As Variant 'SWITCH
Public ORSEL_arr() As Variant 'ORSEL
Public MULDIV_arr() As Variant 'MULDIV
Public SUMMER_CTRL_arr() As Variant 'SUMMER_CTRL
Public MOT2_arr() As Variant 'MOT2
Public VAL2_arr() As Variant 'VAL2
'��-UREGPV
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


'��ȡM6��̬���ݿ��ֶν��������������
Sub D1_M6DataBaseRead()
Dim xc, xr As Integer '�������к���
Dim i, j As Integer 'ѭ������

 '******************************************************��Ϣ��
Application.StatusBar = "ϵͳ���ڶ�ȡM6��׼���ݿ⣬���Ժ�..."

'01-----ʵ�����ֵ�
Set AI = CreateObject("Scripting.Dictionary") 'AI�ֵ�
Set RTD = CreateObject("Scripting.Dictionary") 'RTD�ֵ�
Set TC = CreateObject("Scripting.Dictionary") 'TC�ֵ�
Set AO = CreateObject("Scripting.Dictionary") 'AO�ֵ�
Set DI = CreateObject("Scripting.Dictionary") 'DI�ֵ�
Set DOV = CreateObject("Scripting.Dictionary") 'DO�ֵ�
Set REAL = CreateObject("Scripting.Dictionary") 'REAL�ֵ�
Set AM = CreateObject("Scripting.Dictionary") 'AM�ֵ�
Set DS = CreateObject("Scripting.Dictionary") 'DS�ֵ�
Set DM = CreateObject("Scripting.Dictionary") 'DM�ֵ�

Set PIDA = CreateObject("Scripting.Dictionary") 'PIDA�ֵ�
Set MAN = CreateObject("Scripting.Dictionary") 'MAN�ֵ�
Set SWITCH = CreateObject("Scripting.Dictionary") 'SWITCH�ֵ�
Set ORSEL = CreateObject("Scripting.Dictionary") 'ORSEL�ֵ�
Set MULDIV = CreateObject("Scripting.Dictionary") 'MULDIV�ֵ�
Set SUMMER_CTRL = CreateObject("Scripting.Dictionary") 'SUMMER_CTRL�ֵ�
Set MOT2 = CreateObject("Scripting.Dictionary") 'MOT2�ֵ�
Set VAL2 = CreateObject("Scripting.Dictionary") 'VAL2�ֵ�

Set CALCULTR = CreateObject("Scripting.Dictionary") 'CALCULTR�ֵ�
Set FLOWCOMP = CreateObject("Scripting.Dictionary") 'FLOWCOMP�ֵ�
Set GENLIN = CreateObject("Scripting.Dictionary") 'GENLIN�ֵ�
Set ONEFOLD = CreateObject("Scripting.Dictionary") 'ONEFOLD�ֵ�
Set HILOAVG = CreateObject("Scripting.Dictionary") 'HILOAVG�ֵ�
Set MIDOF3 = CreateObject("Scripting.Dictionary") 'MIDOF3�ֵ�
Set TOTALIZR = CreateObject("Scripting.Dictionary") 'TOTALIZR�ֵ�
Set VDTLDLAG = CreateObject("Scripting.Dictionary") 'VDTLDLAG�ֵ�
Set FLOWSUM = CreateObject("Scripting.Dictionary") 'FLOWSUM�ֵ�
Set SUMMER = CreateObject("Scripting.Dictionary") 'SUMMER�ֵ�

Set HTIMER = CreateObject("Scripting.Dictionary") 'HTIMER�ֵ�

'02-----�򿪶�ȡԴ�ļ�����ͨ�ð���̬���ݿ�
If FileExists(PATH & "\Դ�ļ�\ͨ�ð���̬���ݿ�.xlsx") Then '�жϹ������Ƿ��������������ж��Ƿ����򿪾͹ر�
   If WorkbookOpen("ͨ�ð���̬���ݿ�.xlsx") Then
      Workbooks("ͨ�ð���̬���ݿ�.xlsx").Save
      Workbooks("ͨ�ð���̬���ݿ�.xlsx").Close
   End If
   
   Else
    MsgBox "��ȷ��" & PATH & "\Դ�ļ�\ͨ�ð���̬���ݿ�.xlsx" & "�Ƿ���ڣ�"
    Exit Sub
End If
'��
Workbooks.Open (PATH & "\Դ�ļ�\ͨ�ð���̬���ݿ�.xlsx")
'03-----��ȡ�ֶν�����������
With Workbooks("ͨ�ð���̬���ݿ�.xlsx")
    '03-101-----AI
    .Sheets("AI").Select
    With .Sheets("AI")
         xc = .UsedRange.Columns.Count
         xr = 3000 '��ʱ�̶�Ϊ2
         'AI����
         AI_arr = Sheets("AI").Range(Cells(1, 1), Cells(xr, xc)).Value
         'AI�ֶ��ֵ�
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
         xr = 3000 '��ʱ�̶�Ϊ2
         'RTD����
         RTD_arr = Sheets("RTD").Range(Cells(1, 1), Cells(xr, xc)).Value
         'RTD�ֶ��ֵ�
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
         xr = 3000 '��ʱ�̶�Ϊ2
         'TC����
         TC_arr = Sheets("TC").Range(Cells(1, 1), Cells(xr, xc)).Value
         'RTD�ֶ��ֵ�
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
         xr = 3000 '��ʱ�̶�Ϊ2
         'AO����
         AO_arr = Sheets("AO").Range(Cells(1, 1), Cells(xr, xc)).Value
         'AO�ֶ��ֵ�
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
         xr = 3000 '��ʱ�̶�Ϊ2
         'DI����
         DI_arr = Sheets("DI").Range(Cells(1, 1), Cells(xr, xc)).Value
         'AI�ֶ��ֵ�
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
         xr = 3000 '��ʱ�̶�Ϊ2
         'DOV����
         DOV_arr = Sheets("DOV").Range(Cells(1, 1), Cells(xr, xc)).Value
         'DO�ֶ��ֵ�
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
         xr = 30000 '��ʱ�̶�Ϊ2
         'REAL����
         REAL_arr = Sheets("AS").Range(Cells(1, 1), Cells(xr, xc)).Value
         'REAL�ֶ��ֵ�
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
         xr = 3000 '��ʱ�̶�Ϊ2
         'AM����
         AM_arr = Sheets("AM").Range(Cells(1, 1), Cells(xr, xc)).Value
         'AM�ֶ��ֵ�
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
         xr = 3000 '��ʱ�̶�Ϊ2
         'DM����
         DM_arr = Sheets("DM").Range(Cells(1, 1), Cells(xr, xc)).Value
         'AM�ֶ��ֵ�
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
         xr = 30000 '��ʱ�̶�Ϊ2
         'DS����
         DS_arr = Sheets("DS").Range(Cells(1, 1), Cells(xr, xc)).Value
         'AM�ֶ��ֵ�
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
         xr = 3000 '��ʱ�̶�Ϊ2
         'PIDA����
         PIDA_arr = Sheets("PIDA").Range(Cells(1, 1), Cells(xr, xc)).Value
         'PIDA�ֶ��ֵ�
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
         xr = 3000 '��ʱ�̶�Ϊ2
         'MAN����
         MAN_arr = Sheets("MAN").Range(Cells(1, 1), Cells(xr, xc)).Value
         'MAN�ֶ��ֵ�
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
         xr = 3000 '��ʱ�̶�Ϊ2
         'SWITCH����
         SWITCH_arr = Sheets("SWITCH").Range(Cells(1, 1), Cells(xr, xc)).Value
         'SWITCH�ֶ��ֵ�
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
         xr = 3000 '��ʱ�̶�Ϊ2
         'ORSEL����
         ORSEL_arr = Sheets("ORSEL").Range(Cells(1, 1), Cells(xr, xc)).Value
         'ORSEL�ֶ��ֵ�
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
         xr = 3000 '��ʱ�̶�Ϊ2
         'MULDIV����
         MULDIV_arr = Sheets("MULDIV").Range(Cells(1, 1), Cells(xr, xc)).Value
         'MULDIV�ֶ��ֵ�
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
         xr = 3000 '��ʱ�̶�Ϊ2
         'SUMMER����
         SUMMER_arr = Sheets("SUMMER").Range(Cells(1, 1), Cells(xr, xc)).Value
         'SUMMER�ֶ��ֵ�
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
         xr = 3000 '��ʱ�̶�Ϊ2
         'MOT2����
         MOT2_arr = Sheets("MOT2").Range(Cells(1, 1), Cells(xr, xc)).Value
         'MOT2�ֶ��ֵ�
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
         xr = 3000 '��ʱ�̶�Ϊ2
         'VAL2����
         VAL2_arr = Sheets("VAL2").Range(Cells(1, 1), Cells(xr, xc)).Value
         'VAL2�ֶ��ֵ�
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
         xr = 3000 '��ʱ�̶�Ϊ2
         'FLOWCOMP����
         FLOWCOMP_arr = Sheets("FLOWCOMP").Range(Cells(1, 1), Cells(xr, xc)).Value
         'FLOWCOMP�ֶ��ֵ�
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
'         xr = 3000 '��ʱ�̶�Ϊ2
'         'GENLIN����
'         GENLIN_arr = Sheets("GENLIN").Range(Cells(1, 1), Cells(xr, xc)).Value
'         'GENLIN�ֶ��ֵ�
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
         xr = 3000 '��ʱ�̶�Ϊ2
         'ONEFOLD����
         ONEFOLD_arr = Sheets("ONEFOLD").Range(Cells(1, 1), Cells(xr, xc)).Value
         'ONEFOLD�ֶ��ֵ�
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
         xr = 3000 '��ʱ�̶�Ϊ2
         'HILOAVG����
         HILOAVG_arr = Sheets("HILOAVG").Range(Cells(1, 1), Cells(xr, xc)).Value
         'HILOAVG�ֶ��ֵ�
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
         xr = 3000 '��ʱ�̶�Ϊ2
         'MIDOF3����
         MIDOF3_arr = Sheets("MIDOF3").Range(Cells(1, 1), Cells(xr, xc)).Value
         'MIDOF3�ֶ��ֵ�
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
'         xr = 3000 '��ʱ�̶�Ϊ2
'         'TOTALIZR����
'         TOTALIZR_arr = Sheets("TOTALIZR").Range(Cells(1, 1), Cells(xr, xc)).Value
'         'TOTALIZR�ֶ��ֵ�
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
         xr = 3000 '��ʱ�̶�Ϊ2
         'VDTLDLAG����
         VDTLDLAG_arr = Sheets("VDTLDLAG").Range(Cells(1, 1), Cells(xr, xc)).Value
         'VDTLDLAG�ֶ��ֵ�
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
         xr = 3000 '��ʱ�̶�Ϊ2
         'FLOWSUM����
         FLOWSUM_arr = Sheets("FLOWSUM").Range(Cells(1, 1), Cells(xr, xc)).Value
         'FLOWSUM�ֶ��ֵ�
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
         xr = 3000 '��ʱ�̶�Ϊ2
         'SUMMER_CTRL����
         SUMMER_CTRL_arr = Sheets("SUMMER_CTRL").Range(Cells(1, 1), Cells(xr, xc)).Value
         'FLOWSUM�ֶ��ֵ�
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
         xr = 3000 '��ʱ�̶�Ϊ2
         'TIMER����
         HTIMER_arr = Sheets("TIMER").Range(Cells(1, 1), Cells(xr, xc)).Value
         'FLOWSUM�ֶ��ֵ�
         With HTIMER
             For i = 1 To xc
                .Add HTIMER_arr(1, i), i
             Next
         End With
    End With
    
End With
'03-----�ر�
Workbooks("ͨ�ð���̬���ݿ�.xlsx").Close


End Sub

