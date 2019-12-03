Attribute VB_Name = "ģ��5"
'-----------------------------------------------------------------------------------------------------------
'Purpose: ULOGIC BOX���ݽṹ
'History: 9-24-2019
'-----------------------------------------------------------------------------------------------------------
Type T_HN_BOX
    ElementID As Integer
    ElementLevel As Integer
    ElementATType As String
    ElementSortID As Integer
    Element_X As Integer
    Element_Y As Integer
    
    ElementID_DT As Integer 'DLYTIME��Ԫ��ID
    ElementID_R1 As Integer 'R1�����NN����Ӧ��Ԫ��ID
    ElementID_R2 As Integer 'R2�����NN����Ӧ��Ԫ��ID
    
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
'Purpose: ULOGIC INPUT���ݽṹ
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
'Purpose: ULOGIC NN�������ݽṹ
'History: 9-24-2019
'-----------------------------------------------------------------------------------------------------------
Type T_HN_NN
    ElementID As Integer
    
    NN As String
End Type

'-----------------------------------------------------------------------------------------------------------
'Purpose: ULOGIC OUTPUT���ݽṹ
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
'Purpose: ULOGIC EXCEL��Ϣ���ݽṹ
'History: 9-24-2019
'-----------------------------------------------------------------------------------------------------------
Type T_EXCELINFO
    NAME As String      '����ҳ����
    PTDESC As String    '����ҳ����
    PATH As String      '����ҳXML·��
    
    HN_NN(1 To 8) As T_HN_NN            'NN������Ϣ
    HN_INPUT(1 To 12) As T_HN_INPUT     'INPUT��Ϣ
    HN_OUTPUT(1 To 12) As T_HN_OUTPUT   'OUTPUT��Ϣ
    HN_BOX(1 To 24) As T_HN_BOX         'BOX��Ϣ
End Type
