Attribute VB_Name = "C1_HNDataBaseRead_"
'ver20190814_by cjt
'HN���ݿ��ֶ��ֵ�
'�����
Public UAI As Object 'AI\RTD\TC
Public UAO As Object 'AO
Public UDI As Object 'DI
Public UDO As Object 'DO
'�ڲ���
Public UFLG As Object '�ڲ���������
Public UPM As Object '�ڲ���������
Public UNUM As Object '�ڲ�ģ������
'�߼�����
Public UDC As Object '��������߼���
Public ULOGIC As Object '�߼���
Public ULOGIC1 As Object '�߼���ϵ
Public ULOGIC2 As Object '�߼���ϵ
'���ģ�������ƻ�·
Public UREGC As Object 'Regulatory Control Point��ص㺬PID��
Public UREGC1 As Object 'Regulatory Control Point��ص㺬PID��
Public UREGC1Name As Object 'Regulatory Control Point��ص㺬PID��

Public UREGCPIDType As Object 'Regulatory Control Point��ص㺬PID�����ֵ�
Public UREGCPIDAux As Object 'Regulatory Control Point��ص㺬����PID���ڵ���
'ģ��������UREGPV
Public UREGPV As Object 'ģ������
'��ʱ��
Public UTIM As Object '��ʱ��

'HN���ݿ�����
Public UAI_arr() As Variant 'AI
Public UAO_arr() As Variant 'AO
Public UDI_arr() As Variant 'DI
Public UDO_arr() As Variant 'DO
'�ڲ���
Public UFLG_arr() As Variant '�ڲ���������
Public UPM_arr() As Variant '�ڲ���������
Public UNUM_arr() As Variant '�ڲ�ģ������
'�߼�����
Public UDC_arr() As Variant '��������߼���
Public ULOGIC_arr() As Variant '�߼���
Public ULOGIC1_arr() As Variant '�߼���ϵ
Public ULOGIC2_arr() As Variant '�߼���ϵ
'���ģ�������ƻ�·
Public UREGC_arr() As Variant 'Regulatory Control Point��ص㺬PID��
Public UREGC1_arr() As Variant 'Regulatory Control Point��ص㺬PID��
'ģ��������UREGPV
Public UREGPV_arr() As Variant 'ģ������
'��ʱ��
Public UTIM_arr() As Variant '��ʱ��

'ģ���������
Public UPMCONFIG As Object 'UPMCONFIG�ֶ�
Public UPMCONFIG1 As Object 'UPMCONFIG1�ֶ�

Public UPMCONFIGSN As Object 'UPMCONFIGվ��
Public UPMCONFIG1SN As Object 'UPMCONFIG1վ��

Public UPMCONFIG_arr() As Variant 'UPMCONFIG
Public UPMCONFIG1_arr() As Variant 'UPMCONFIG1

'��ȡHN��̬���ݿ��ֶν��������������
Sub C1_HNDataBaseRead()
Dim xc, xr As Integer '�������к���
Dim i, j As Integer 'ѭ������
Dim shh As New HND���� '�����������ʵ��
 '******************************************************��Ϣ��
Application.StatusBar = "ϵͳ���ڶ�ȡHN���ݿ⣬���Ժ�..."

'01-----ʵ�����ֵ�
'�����
Set UAI = CreateObject("Scripting.Dictionary") 'UAI�ֵ�
Set UAO = CreateObject("Scripting.Dictionary") 'UAO�ֵ�
Set UDI = CreateObject("Scripting.Dictionary") 'UDI�ֵ�
Set UDO = CreateObject("Scripting.Dictionary") 'UDO�ֵ�
'�ڲ���
Set UFLG = CreateObject("Scripting.Dictionary") '�ڲ����������ֵ�
Set UPM = CreateObject("Scripting.Dictionary") '�ڲ����������ֵ�
Set UNUM = CreateObject("Scripting.Dictionary") '�ڲ�ģ�������ֵ�
'�߼�����
Set UDC = CreateObject("Scripting.Dictionary") '�߼����ֵ�
Set ULOGIC = CreateObject("Scripting.Dictionary") '�߼����ֵ�
Set ULOGIC1 = CreateObject("Scripting.Dictionary") '�߼���ϵ�ֵ�
Set ULOGIC2 = CreateObject("Scripting.Dictionary") '�߼���ϵ�ֵ�
'���ģ�������ƻ�·
Set UREGC = CreateObject("Scripting.Dictionary")  'Regulatory Control Point��ص㺬PID���ֵ�
Set UREGC1 = CreateObject("Scripting.Dictionary")  'Regulatory Control Point��ص㺬PID���ֵ�
Set UREGC1Name = CreateObject("Scripting.Dictionary")  'Regulatory Control Point��ص㺬PID���ֵ�
Set UREGCPIDType = CreateObject("Scripting.Dictionary") 'Regulatory Control Point��ص㺬PID�������������Ǹ���
Set UREGCPIDAux = CreateObject("Scripting.Dictionary") 'Regulatory Control PointPoint��ص㺬����PID���ڵ���
'ģ��������UREGPV
Set UREGPV = CreateObject("Scripting.Dictionary")  'ģ�������ֵ�
'��ʱ��
Set UTIM = CreateObject("Scripting.Dictionary")  '��ʱ���ֵ�
'ģ���������
Set UPMCONFIG = CreateObject("Scripting.Dictionary") 'UPMCONFIG
Set UPMCONFIG1 = CreateObject("Scripting.Dictionary") 'UPMCONFIG1
Set UPMCONFIGSN = CreateObject("Scripting.Dictionary") 'UPMCONFIG
Set UPMCONFIG1SN = CreateObject("Scripting.Dictionary") 'UPMCONFIG1
'02-----�򿪶�ȡ��ת�Q�ļ�����UCN01all���ݿ�
If FileExists(PATH & "\��ת�Q�ļ�\" & soc_sht_name & ".xls") Then '�жϹ������Ƿ��������������ж��Ƿ����򿪾͹ر�
   If WorkbookOpen(soc_sht_name & ".xls") Then
      Workbooks(soc_sht_name & ".xls").Save
      Workbooks(soc_sht_name & ".xls").Close
   End If
   
   Else
    MsgBox "��ȷ��" & PATH & "\��ת�Q�ļ�\" & soc_sht_name & ".xls" & "�Ƿ���ڣ�"
    Exit Sub
End If
'��
Workbooks.Open (PATH & "\��ת�Q�ļ�\" & soc_sht_name & ".xls")
'03-----��ȡ�ֶν�����������
With Workbooks(soc_sht_name & ".xls")
    '03-01-----UAI
    .Sheets("UAI").Select
    'Set shh.���� = .Sheets("UAI")
    With .Sheets("UAI")
         xc = .UsedRange.Columns.Count
         xr = .UsedRange.Rows.Count
         'UAI����
         UAI_arr = Sheets("UAI").Range(Cells(1, 1), Cells(xr, xc)).Value
         'UAI�ֶ��ֵ�
         With UAI
             For i = 1 To xc
                .Add UAI_arr(1, i), i
             Next
         End With
    End With
    
    '03-02-----UAO
    .Sheets("UAO").Select
    'Set shh.���� = .Sheets("UAO")
    With .Sheets("UAO")
         xc = .UsedRange.Columns.Count
         xr = .UsedRange.Rows.Count
         'UAO����
         UAO_arr = Sheets("UAO").Range(Cells(1, 1), Cells(xr, xc)).Value
         'UAO�ֶ��ֵ�
         With UAO
             For i = 1 To xc
                .Add UAO_arr(1, i), i
             Next
         End With
    End With
    
    '03-02-----UDI
    .Sheets("UDI").Select
    'Set shh.���� = .Sheets("UDI")
    With .Sheets("UDI")
         xc = .UsedRange.Columns.Count
         xr = .UsedRange.Rows.Count
         'UDI����
         UDI_arr = Sheets("UDI").Range(Cells(1, 1), Cells(xr, xc)).Value
         'UDI�ֶ��ֵ�
         With UDI
             For i = 1 To xc
                .Add UDI_arr(1, i), i
             Next
         End With
    End With
    
    
    '03-02-----UDO
    .Sheets("UDO").Select
    'Set shh.���� = .Sheets("UDO")
    With .Sheets("UDO")
         xc = .UsedRange.Columns.Count
         xr = .UsedRange.Rows.Count
         'UDO����
         UDO_arr = Sheets("UDO").Range(Cells(1, 1), Cells(xr, xc)).Value
         'UDO�ֶ��ֵ�
         With UDO
             For i = 1 To xc
                .Add UDO_arr(1, i), i
             Next
         End With
    End With
    
    '03-03-----UREGC
    '-UREGC
    .Sheets("UREGC").Select
    'Set shh.���� = .Sheets("UREGC")
    With .Sheets("UREGC")
         xc = .UsedRange.Columns.Count
         xr = .UsedRange.Rows.Count
         'UREGC����
         UREGC_arr = Sheets("UREGC").Range(Cells(1, 1), Cells(xr, xc)).Value
         'UREGC�ֶ��ֵ�
         With UREGC
             For i = 1 To xc
                .Add UREGC_arr(1, i), i
             Next
         End With
    End With
     '�����е�PIDװ��UREGCPIDType�ֵ���ã��ؼ���ΪPIDλ�ţ���ĿΪUREGC�к�
    For j = 2 To xr
        If UREGC_arr(j, UREGC("CTLALGID")) = "PID" Then
           With UREGCPIDType
                If Not .Exists(UREGC_arr(j, UREGC("NAME"))) Then
                   .Add UREGC_arr(j, UREGC("NAME")), j
                End If
           End With
        End If
    Next
    '��ת�ַ���
    Dim str1 As String
    
     '�Ѹ���PIDװ��UREGCPIDAux�ֵ䣬�ؼ���ΪPIDλ�ţ���ĿΪUREGC�к�
    For j = 2 To xr
        If UREGC_arr(j, UREGC("CTLALGID")) = "PID" Then '����PID
           str1 = UREGC_arr(j, UREGC("CODSTN(1)")) 'PID������ӵı���
           If str1 Like "*.SP*" Then '�ж��ǲ������ӵ�PID��SP,�����PID���ڵ����ֵ�
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
         'UREGC1����
         UREGC1_arr = Sheets("UREGC1").Range(Cells(1, 1), Cells(xr, xc)).Value
         'UREGC1�ֶ��ֵ�
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
    
    '03-04�ڲ�ģ������
    .Sheets("UNUM").Select
    'Set shh.���� = .Sheets("UNUM")
    With .Sheets("UNUM")
         xc = .UsedRange.Columns.Count
         xr = .UsedRange.Rows.Count
         'UNUM����
         UNUM_arr = Sheets("UNUM").Range(Cells(1, 1), Cells(xr, xc)).Value
         'UNUM�ֶ��ֵ�
         With UNUM
             For i = 1 To xc
                .Add UNUM_arr(1, i), i
             Next
         End With
    End With
    
    '03-05ģ��������
    .Sheets("UREGPV").Select
    'Set shh.���� = .Sheets("UREGPV")
    With .Sheets("UREGPV")
         xc = .UsedRange.Columns.Count
         xr = .UsedRange.Rows.Count
         'UREGPV����
         UREGPV_arr = Sheets("UREGPV").Range(Cells(1, 1), Cells(xr, xc)).Value
         'UREGPV�ֶ��ֵ�
         With UREGPV
             For i = 1 To xc
                .Add UREGPV_arr(1, i), i
             Next
         End With
    End With
    
    '03-06UDC
    .Sheets("UDC").Select
    'Set shh.���� = .Sheets("UDC")
    With .Sheets("UDC")
         xc = .UsedRange.Columns.Count
         xr = .UsedRange.Rows.Count
         'UDC����
         UDC_arr = Sheets("UDC").Range(Cells(1, 1), Cells(xr, xc)).Value
         'UDC�ֶ��ֵ�
         With UDC
             For i = 1 To xc
                .Add UDC_arr(1, i), i
             Next
         End With
         
        If Not UDC.Exists("M6BlockType") Then
            .Columns("B:B").Insert Shift:=xlToRight
            .Cells(1, 2) = "M6BlockType"
            MsgBox ("��ת���ļ����� M6BlockType �� ���ݷ���UDC�������ת��")
            '�ض�
            xc = .UsedRange.Columns.Count
            xr = .UsedRange.Rows.Count
            'UDC����
             Erase UDC_arr
             UDC_arr = Sheets("UDC").Range(Cells(1, 1), Cells(xr, xc)).Value
             'UDC�ֶ��ֵ�
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
    'Set shh.���� = .Sheets("UFLG")
    With .Sheets("UFLG")
         xc = .UsedRange.Columns.Count
         xr = .UsedRange.Rows.Count
         'UFLG����
         UFLG_arr = Sheets("UFLG").Range(Cells(1, 1), Cells(xr, xc)).Value
         'UFLG�ֶ��ֵ�
         With UFLG
             For i = 1 To xc
                .Add UFLG_arr(1, i), i
             Next
         End With
    End With
    
    '03-08ULOGIC
    .Sheets("ULOGIC").Select
    'Set shh.���� = .Sheets("ULOGIC")
    With .Sheets("ULOGIC")
         xc = .UsedRange.Columns.Count
         xr = .UsedRange.Rows.Count
         'ULOGIC����
         ULOGIC_arr = Sheets("ULOGIC").Range(Cells(1, 1), Cells(xr, xc)).Value
         'ULOGIC�ֶ��ֵ�
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
         'ULOGIC1����
         ULOGIC1_arr = Sheets("ULOGIC1").Range(Cells(1, 1), Cells(xr, xc)).Value
         'ULOGIC1�ֶ��ֵ�
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
         'ULOGIC2����
         ULOGIC2_arr = Sheets("ULOGIC2").Range(Cells(1, 1), Cells(xr, xc)).Value
         'ULOGIC2�ֶ��ֵ�
         With ULOGIC2
             For i = 1 To xc
                .Add ULOGIC2_arr(1, i), i
             Next
         End With
    End With
    
    '03-09UPM
    .Sheets("UPM").Select
    'Set shh.���� = .Sheets("UPM")
    With .Sheets("UPM")
         xc = .UsedRange.Columns.Count
         xr = .UsedRange.Rows.Count
         'UPM����
         UPM_arr = Sheets("UPM").Range(Cells(1, 1), Cells(xr, xc)).Value
         'UPM�ֶ��ֵ�
         With UPM
             For i = 1 To xc
                .Add UPM_arr(1, i), i
             Next
         End With
    End With
    
    '03-10UTIM
    .Sheets("UTIM").Select
    'Set shh.���� = .Sheets("UTIM")
    With .Sheets("UTIM")
         xc = .UsedRange.Columns.Count
         xr = .UsedRange.Rows.Count
         'UTIM����
        UTIM_arr = Sheets("UTIM").Range(Cells(1, 1), Cells(xr, xc)).Value
         'UTIM�ֶ��ֵ�
         With UTIM
             For i = 1 To xc
                .Add UTIM_arr(1, i), i
             Next
         End With
    End With
    
    '03-11ģ����Ϣ
    .Sheets("UPMCONFIG").Select
    With .Sheets("UPMCONFIG")
         xc = .UsedRange.Columns.Count
         xr = .UsedRange.Rows.Count
         'UTIM����
        UPMCONFIG_arr = Sheets("UPMCONFIG").Range(Cells(1, 1), Cells(xr, xc)).Value
         'UTIM�ֶ��ֵ�
         With UPMCONFIG
             For i = 1 To xc
                .Add UPMCONFIG_arr(1, i), i
             Next
         End With
         
         'վ���ֵ�
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
         'UTIM����
        UPMCONFIG1_arr = Sheets("UPMCONFIG1").Range(Cells(1, 1), Cells(xr, xc)).Value
         'UTIM�ֶ��ֵ�
         With UPMCONFIG1
             For i = 1 To xc
                .Add UPMCONFIG1_arr(1, i), i
             Next
         End With
         
         'վ���ֵ�
         With UPMCONFIG1SN
             For i = 2 To xr
                .Add UPMCONFIG1_arr(i, UPMCONFIG1("NAME")), i
             Next
         End With
         
    End With
    
End With


'03-----�ر�
Workbooks(soc_sht_name & ".xls").Close savechanges:=True


End Sub
