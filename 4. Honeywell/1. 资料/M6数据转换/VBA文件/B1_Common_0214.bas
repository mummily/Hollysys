Attribute VB_Name = "B1_Common_0214"
'ver20190814_by cjt

'���򹫹����������ش����жϺ͹�����Ϣȡֵ��֤��������˳��ִ��
Sub B1_Common()
Dim folder_arr(1 To 10) As String '�ļ���������
Dim socf_arr(1 To 10) As String 'Դ�ļ������ļ�����

 '******************************************************��Ϣ��
Application.StatusBar = "ϵͳ���ڽ��г�ʼ�������Ժ�..."


    '000-----�ֲ�������ֵ
    Rev = V1 '�汾
    folder_arr(1) = "Դ�ļ�"
    folder_arr(2) = "�����ļ�"
    folder_arr(3) = "��ת�Q�ļ�"
    
    socf_arr(1) = "��������̬���ݿ�"
    socf_arr(2) = "ͨ�ð���̬���ݿ�"

    
    '00-----ȫ�ֱ�����ֵ
    this_sht_name = ThisWorkbook.NAME '������������
    PATH = ThisWorkbook.PATH 'ʱ��
    ftime = Replace(Replace(Replace(VBA.Now, "/", "_"), " ", "_"), ":", "_") 'ʱ��
    
    
    '01-----�������������������
    
    '01-01-----------�ж�main�������Ƿ����
    wb_name = this_sht_name '����������
    sht_name = "main" '����������
    If Not SheetExists(wb_name, sht_name) Then
      MsgBox "��ȷ��" & wb_name & "��" & sht_name & "�������Ƿ���ڣ�"
      Exit Sub
    End If
    
    '01-02-----------�жϼ���������ļ����Ƿ�������Զ�����
    For i = 1 To 10
      If Len(folder_arr(i)) > 0 Then
        If Not filefolderExists(PATH & "\" & folder_arr(i) & "\") Then
        MkDir PATH & "\" & folder_arr(i) & "\"
        End If
      End If
    Next
    
     '01-03-----------�ж�Դ�ļ�����Դ�ļ��Ƿ����
    For i = 1 To 10
      If Len(socf_arr(i)) > 0 Then
        If Not FileExists(PATH & "\Դ�ļ�\" & socf_arr(i) & ".xlsx") Then
        MsgBox "��ȷ��" & PATH & "\Դ�ļ�\" & socf_arr(i) & ".xlsx" & "�Ƿ���ڣ�"
        Exit Sub
        End If
      End If
    Next
    

    '01-04-----------�ж�main�д�ת�Q�ļ�Դ�ļ����ǲ�������
    With Workbooks(this_sht_name).Worksheets("main")
         If Len(.Cells(2, 3)) <= 0 Then
            MsgBox "��ȷ��" & wb_name & "��" & sht_name & "������ ��Ԫ��C2��ת�Q�ļ��� �Ƿ���ڣ�"
            Exit Sub
         End If
         soc_sht_name = .Cells(2, 3) '��ת�Q�ļ�Դ�ļ�����������
    End With
    
    '01-05-----------�жϴ�ת�Q�ļ����´�ת���ļ��Ƿ����
    If Not FileExists(PATH & "\��ת�Q�ļ�\" & soc_sht_name & ".xls") Then
        MsgBox "��ȷ��" & PATH & "\��ת�Q�ļ�\" & soc_sht_name & ".xls" & "�Ƿ���ڣ�"
        Exit Sub
    End If
     
    '01-06-----------��ȡ�������ͺ�
    With Workbooks(this_sht_name).Worksheets("main")
         If .Cells(3, 5) = "K-CU03" Then
            controllerModel = .Cells(3, 5) '�������ͺ�
         Else
            controllerModel = "K-CU01/K-CU11" '�������ͺ�
         End If
         
    End With
     
     
End Sub

