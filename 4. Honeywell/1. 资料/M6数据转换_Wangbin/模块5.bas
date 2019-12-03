Attribute VB_Name = "模块5"
'-----------------------------------------------------------------------------------------------------------
'Purpose: ULOGIC BOX数据结构
'History: 9-24-2019
'-----------------------------------------------------------------------------------------------------------
Type T_HN_BOX
    ElementID As Integer
    ElementLevel As Integer
    ElementATType As String
    ElementSortID As Integer
    Element_X As Integer
    Element_Y As Integer
    
    ElementID_DT As Integer 'DLYTIME的元素ID
    ElementID_R1 As Integer 'R1如果是NN，对应的元素ID
    ElementID_R2 As Integer 'R2如果是NN，对应的元素ID
    
    LBINDEX As String
    LOGALGID As String
    S1 As String
    S2 As String
    S3 As String
    S4 As String
    S1REV As String
    S2REV As String
    S3REV As String
    S4REV As String
    DL As String
    DB As String
    R1 As String
    R2 As String
    DLYTIME As String
End Type

'-----------------------------------------------------------------------------------------------------------
'Purpose: ULOGIC INPUT数据结构
'History: 9-24-2019
'-----------------------------------------------------------------------------------------------------------
Type T_HN_INPUT
    ElementID As Integer
    ElementLevel As Integer
    Element_X As Integer
    Element_Y As Integer
    
    LISRC As String
End Type

'-----------------------------------------------------------------------------------------------------------
'Purpose: ULOGIC NN变量数据结构
'History: 9-24-2019
'-----------------------------------------------------------------------------------------------------------
Type T_HN_NN
    ElementID As Integer
    
    NN As String
End Type

'-----------------------------------------------------------------------------------------------------------
'Purpose: ULOGIC OUTPUT数据结构
'History: 9-24-2019
'-----------------------------------------------------------------------------------------------------------
Type T_HN_OUTPUT
    ElementID As Integer
    ElementSortID As Integer
    ElementInputID As Integer
    Element_X As Integer
    Element_Y As Integer
    
    LOSRC As String
    LODSTN As String
    LOENBL As String
End Type

'-----------------------------------------------------------------------------------------------------------
'Purpose: ULOGIC EXCEL信息数据结构
'History: 9-24-2019
'-----------------------------------------------------------------------------------------------------------
Type T_EXCELINFO
    NAME As String      '方案页名称
    PTDESC As String    '方案页描述
    PATH As String      '方案页XML路径
    
    HN_NN(1 To 8) As T_HN_NN            'NN变量信息
    HN_INPUT(1 To 12) As T_HN_INPUT     'INPUT信息
    HN_OUTPUT(1 To 12) As T_HN_OUTPUT   'OUTPUT信息
    HN_BOX(1 To 24) As T_HN_BOX         'BOX信息
End Type
