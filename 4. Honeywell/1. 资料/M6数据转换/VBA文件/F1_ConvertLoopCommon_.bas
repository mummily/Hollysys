Attribute VB_Name = "F1_ConvertLoopCommon_"

'ver20190821_by cjt

'���ƻ�·ת�����ð�վ�����ļ��в���վɵ�xml

Sub F1_ConvertLoopCommon()

Dim str As String, myfile As String '�ļ��б���

'01-----��վ����POU�����ļ��в����ָ��Ŀ¼��XML�ļ�
'�ж�Դ�ļ�����Դ�ļ��Ƿ����
For i = 0 To SN.Count - 1
    If Not filefolderExists(PATH & "\�����ļ�\" & SN.Items()(i) & "\") Then
       MkDir PATH & "\�����ļ�\" & SN.Items()(i) & "\"
    End If
    '���ָ��Ŀ¼��XML�ļ�
    myfile = PATH & "\�����ļ�\" & SN.Items()(i) & "\" '��ǰ�ļ�����·��
    str = Dir(myfile & "*.XM*", vbReadOnly) 'ͨ���*.*��ʾ�����ļ��������ɾ��excel�ļ�����*.xl*
    While str <> ""  '�ж��ļ����Ƿ����
       Kill myfile & "\" & str '������ڣ������ɾ��
       str = Dir
    Wend
    
Next

End Sub









