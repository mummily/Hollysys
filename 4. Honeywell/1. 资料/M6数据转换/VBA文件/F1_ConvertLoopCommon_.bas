Attribute VB_Name = "F1_ConvertLoopCommon_"

'ver20190821_by cjt

'控制回路转化公用按站建立文件夹并清空旧的xml

Sub F1_ConvertLoopCommon()

Dim str As String, myfile As String '文件夹变量

'01-----按站建立POU方案文件夹并清空指定目录的XML文件
'判断源文件夹下源文件是否存在
For i = 0 To SN.Count - 1
    If Not filefolderExists(PATH & "\工程文件\" & SN.Items()(i) & "\") Then
       MkDir PATH & "\工程文件\" & SN.Items()(i) & "\"
    End If
    '清空指定目录的XML文件
    myfile = PATH & "\工程文件\" & SN.Items()(i) & "\" '当前文件所在路径
    str = Dir(myfile & "*.XM*", vbReadOnly) '通配符*.*表示任意文件，如果想删除excel文件，用*.xl*
    While str <> ""  '判断文件名是否存在
       Kill myfile & "\" & str '如果存在，则进行删除
       str = Dir
    Wend
    
Next

End Sub









