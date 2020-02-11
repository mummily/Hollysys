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
    
    ElementID_S1 As Integer 'S1如果是FL1 Or FL2，对应的元素ID
    ElementID_S2 As Integer 'S2如果是FL1 Or FL2，对应的元素ID
    ElementID_S3 As Integer 'S3如果是FL1 Or FL2，对应的元素ID
    ElementID_S4 As Integer 'S4如果是FL1 Or FL2，对应的元素ID
    
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
'Purpose: ULOGIC E数据结构，对应M6 Move数据结构
'History: 9-24-2019
'-----------------------------------------------------------------------------------------------------------
Type T_HN_E
    ElementID As Integer
    ElementSortID As Integer
    Element_X As Integer
    Element_Y As Integer
    
    ElementInputID As Integer 'BOX、Input的元素ID
    ElementID_NF As Integer 'NN、FL的元素ID
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
    
    ElementID_Ref As Integer ' Input是个组合，这里记录实际指出的ID值
    
    LISRC As String ' 从Excel中读取的输入数据，可修改适配为M6风格
    LISRC_BAK As String ' 从Excel中读取的输入数据，始终不修改
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
    
    HN_NN(1 To 8) As String             'NN变量信息
    HN_INPUT(1 To 12) As T_HN_INPUT     'INPUT信息
    HN_OUTPUT(1 To 12) As T_HN_OUTPUT   'OUTPUT信息
    HN_BOX(1 To 24) As T_HN_BOX         'BOX信息
    HN_E(1 To 12) As T_HN_E             'E信息
End Type

'-----------------------------------------------------------------------------------------------------------
'Purpose: ULOGIC EXCEL信息数据结构
'History: 9-24-2019
'-----------------------------------------------------------------------------------------------------------
Type T_HN_VAR
    TT As String ' 类型
    PN As String ' 点号
    SN As String ' 站号
End Type

'-----------------------------------------------------------------------------------------------------------
'Purpose: 变量数目
'History: 12-24-2019
'-----------------------------------------------------------------------------------------------------------
Type T_VARINFO
    HN_VAR(1 To 1000) As T_HN_VAR    'TON、TOF、TP变量
    VarNum As Integer 'TON、TOF、TP变量数目
End Type

'-----------------------------------------------------------------------------------------------------------
'Purpose: 模块地址
'History: 12-25-2019
'-----------------------------------------------------------------------------------------------------------
Type T_HN_DN
    NODENUM As String 'HN站号
    index As Integer '索引 1~40
    NAME As String  'POU名称
    DN   As Integer '模块地址
End Type
