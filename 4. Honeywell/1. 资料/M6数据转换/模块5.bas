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
    
    ElementID_S1 As Integer 'S1�����FL1 Or FL2����Ӧ��Ԫ��ID
    ElementID_S2 As Integer 'S2�����FL1 Or FL2����Ӧ��Ԫ��ID
    ElementID_S3 As Integer 'S3�����FL1 Or FL2����Ӧ��Ԫ��ID
    ElementID_S4 As Integer 'S4�����FL1 Or FL2����Ӧ��Ԫ��ID
    
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
'Purpose: ULOGIC E���ݽṹ����ӦM6 Move���ݽṹ
'History: 9-24-2019
'-----------------------------------------------------------------------------------------------------------
Type T_HN_E
    ElementID As Integer
    ElementSortID As Integer
    Element_X As Integer
    Element_Y As Integer
    
    ElementInputID As Integer 'BOX��Input��Ԫ��ID
    ElementID_NF As Integer 'NN��FL��Ԫ��ID
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
    
    ElementID_Ref As Integer ' Input�Ǹ���ϣ������¼ʵ��ָ����IDֵ
    
    LISRC As String ' ��Excel�ж�ȡ���������ݣ����޸�����ΪM6���
    LISRC_BAK As String ' ��Excel�ж�ȡ���������ݣ�ʼ�ղ��޸�
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
    
    HN_NN(1 To 8) As String             'NN������Ϣ
    HN_INPUT(1 To 12) As T_HN_INPUT     'INPUT��Ϣ
    HN_OUTPUT(1 To 12) As T_HN_OUTPUT   'OUTPUT��Ϣ
    HN_BOX(1 To 24) As T_HN_BOX         'BOX��Ϣ
    HN_E(1 To 12) As T_HN_E             'E��Ϣ
End Type

'-----------------------------------------------------------------------------------------------------------
'Purpose: ULOGIC EXCEL��Ϣ���ݽṹ
'History: 9-24-2019
'-----------------------------------------------------------------------------------------------------------
Type T_HN_VAR
    TT As String ' ����
    PN As String ' ���
    SN As String ' վ��
End Type

'-----------------------------------------------------------------------------------------------------------
'Purpose: ������Ŀ
'History: 12-24-2019
'-----------------------------------------------------------------------------------------------------------
Type T_VARINFO
    HN_VAR(1 To 1000) As T_HN_VAR    'TON��TOF��TP����
    VarNum As Integer 'TON��TOF��TP������Ŀ
End Type

'-----------------------------------------------------------------------------------------------------------
'Purpose: ģ���ַ
'History: 12-25-2019
'-----------------------------------------------------------------------------------------------------------
Type T_HN_DN
    NODENUM As String 'HNվ��
    index As Integer '���� 1~40
    NAME As String  'POU����
    DN   As Integer 'ģ���ַ
End Type
