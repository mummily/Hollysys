Attribute VB_Name = "E1_ConvertDataBase_0226"
'ver20200226_by cjt
'ת��HN���ݿ⵽M6���ݿ�

Dim AIArr(1 To 844) As T_HN_DN
Dim AOArr(1 To 184) As T_HN_DN
Dim DIArr(1 To 1213) As T_HN_DN
Dim DOArr(1 To 511) As T_HN_DN

'-----------------------------------------------------------------------------------------------------------
'Purpose: ת����̬���ݿ� - cjt
'History: 12-26-2019
'-----------------------------------------------------------------------------------------------------------
Sub E1_ConvertDataBase()
    Dim i, j, k, l, M, N As Integer 'HN���ݿ�ѭ������
    Dim ii, jj, kk, ll, mm, nn As Integer 'M6���ݿ�ѭ������
    Dim i1, i2, i3, i4, i5, i6 As Integer 'M6���ݿ�ѭ������
    Dim J1, j2, j3, j4, j5, j6 As Integer 'M6���ݿ�ѭ������
    Dim AI_cn As Integer 'M6���ݿ�AIͨ������
    Dim AO_cn As Integer 'M6���ݿ�AOͨ������
    Dim cn As Integer 'ͨ������
    Dim cn_arr(10 To 30) As Integer  'ͨ������
    Dim cnIsRD_arr(10 To 30) As String  'ͨ����������
    Dim dn_arr(10 To 30) As Integer '�豸�ż���
    Dim dn_js(10 To 30) As Boolean '�豸�ż���
    
    Dim SN_i As Integer 'վ��
    Dim AO_i, AI_i, DO_i, DI_i As Integer '������
    
    Dim ThisChalRD As Variant
    Dim NextChalRD As Variant
    Dim LastChalRD As Variant
    Dim PVALGID As String 'UREGPV����
    
    Dim ConvDic As Object '�ַ�ת���ֵ�
    
    '00-----��ʼ������
    Set ConvDic = CreateObject("Scripting.Dictionary") 'ʵ�����ַ�ת���ֵ�
    '0---------------------------------------------------------------��ʼ���豸��ͨ����
    For i = 10 To 30
        dn_arr(i) = 10
        cn_arr(i) = 1
    Next
    
    '1---------------------------------------------------------------��վѭ��
    AO_i = 3 'M6�����п�ʼ
    AI_i = 3 'M6�����п�ʼ
    DO_i = 3 'M6�����п�ʼ
    DI_i = 3 'M6�����п�ʼ
    
    For SN_i = 10 To 15
    
        '1)-----------------------------------------------------------------ת��AO--------------------------------------------------------------------------------------------
        For i = 2 To UBound(UAO_arr, 1)
    
            'վ����ͬ
            If SN(UAO_arr(i, UAO("NODENUM"))) = SN_i Then
                '��ȡ������Ϣ
                ThisChalRD = RD(UAO_arr(i, UAO("NODENUM")), UAO_arr(i, UAO("MODNUM")))
                
                AO_arr(AO_i, AO("PN")) = UAO_arr(i, UAO("NAME")) '����
                AO_arr(AO_i, AO("DS")) = UAO_arr(i, UAO("PTDESC")) '������
                AO_arr(AO_i, AO("MD")) = "0" '����
                AO_arr(AO_i, AO("MU")) = "100" '����
                AO_arr(AO_i, AO("UT")) = "%" '����
                AO_arr(AO_i, AO("SN")) = SN_i  'վ��
                AO_arr(AO_i, AO("MT")) = "K-AO01" 'ģ������
    
                If UAO_arr(i, UAO("SLOTNUM")) <= 8 Then
                    AO_arr(AO_i, AO("CN")) = UAO_arr(i, UAO("SLOTNUM")) 'ͨ����
                Else
                    AO_arr(AO_i, AO("CN")) = UAO_arr(i, UAO("SLOTNUM")) - 8 'ͨ����
                End If
    
                If UAO_arr(i, UAO("OPTDIR")) = "REVERSE" Then '��������
                    AO_arr(AO_i, AO("REVOPT")) = "1"
                Else
                    AO_arr(AO_i, AO("REVOPT")) = "0"
                End If
    
                '---------------------------------------------------------------------
                '��¼������Ϣ
                LastChalRD = ThisChalRD
                '---------------------------------------------------------------------
                AO_arr(AO_i, AO("RD")) = ThisChalRD '�Ƿ�����
                
                
                If controllerModel = "K-CU03" Then
                   AO_arr(AO_i, AO("IO_LPS")) = "2" '��·��
                End If
                
                'M6���ݿ�
                AO_i = AO_i + 1 '�м���
            End If
    
        Next i
    
        '2)-----------------------------------------------------------------ת��AI--------------------------------------------------------------------------------------------
        For i = 2 To UBound(UAI_arr, 1)
                            
            'վ����ͬ
            If SN(UAI_arr(i, UAI("NODENUM"))) = SN_i Then
                '��ȡ������Ϣ
                ThisChalRD = RD(UAI_arr(i, UAI("NODENUM")), UAI_arr(i, UAI("MODNUM")))
                
                AI_arr(AI_i, AI("PN")) = UAI_arr(i, UAI("NAME")) '����
                AI_arr(AI_i, AI("DS")) = UAI_arr(i, UAI("PTDESC")) '������
                AI_arr(AI_i, AI("MD")) = UAI_arr(i, UAI("PVEULO")) '����
                AI_arr(AI_i, AI("MU")) = UAI_arr(i, UAI("PVEUHI")) '����
                AI_arr(AI_i, AI("UT")) = UAI_arr(i, UAI("EUDESC")) '����
                AI_arr(AI_i, AI("OF")) = DelDit(UAI_arr(i, UAI("PVFORMAT"))) 'С��λ��
                AI_arr(AI_i, AI("SN")) = SN(UAI_arr(i, UAI("NODENUM"))) 'վ��
                AI_arr(AI_i, AI("MT")) = "K-AIH03" 'ģ������
                AI_arr(AI_i, AI("CN")) = UAI_arr(i, UAI("SLOTNUM")) ' 'ͨ����
                AI_arr(AI_i, AI("SIGTYPE")) = "S4_20mA" '�ź�����
    
                If VBA.IsNumeric(UAI_arr(i, UAI("PVHITP"))) Then
                    AI_arr(AI_i, AI("AH")) = UAI_arr(i, UAI("PVHITP")) '�߱���ֵPVHITP��ӦAH
                    
                    If AI_arr(AI_i, AI("AH")) >= AI_arr(AI_i, AI("MU")) Then
                        AI_arr(AI_i, AI("AH")) = AI_arr(AI_i, AI("MU")) * 0.9
                    End If
                Else
                    AI_arr(AI_i, AI("AH")) = 0
                End If
    
                AI_arr(AI_i, AI("H1")) = AlMLVl(UAI_arr(i, UAI("PVHIPR"))) '�߱����ȼ�PVHIPR��ӦH1
    
                If VBA.IsNumeric(UAI_arr(i, UAI("PVLOTP"))) Then
                    AI_arr(AI_i, AI("AL")) = UAI_arr(i, UAI("PVLOTP")) '�ͱ���ֵPVLOTP��ӦAL
                    
                    If AI_arr(AI_i, AI("AL")) <= AI_arr(AI_i, AI("MD")) Then
                        AI_arr(AI_i, AI("AL")) = AI_arr(AI_i, AI("MD")) + (AI_arr(AI_i, AI("MU")) - AI_arr(AI_i, AI("MD"))) * 0.2
                    End If
                Else
                    AI_arr(AI_i, AI("AL")) = 0
                End If
    
                AI_arr(AI_i, AI("L1")) = AlMLVl(UAI_arr(i, UAI("PVLOPR"))) '�ͱ����ȼ�PVLOPR��ӦL1
    
                If VBA.IsNumeric(UAI_arr(i, UAI("PVHHTP"))) Then
                    AI_arr(AI_i, AI("HH")) = UAI_arr(i, UAI("PVHHTP")) '�߸߱���ֵPVHHTP��ӦHH
                    
                    If AI_arr(AI_i, AI("HH")) >= AI_arr(AI_i, AI("MU")) Then
                        AI_arr(AI_i, AI("HH")) = AI_arr(AI_i, AI("MU")) * 0.95
                    End If
                Else
                    AI_arr(AI_i, AI("HH")) = 0
                End If
    
                AI_arr(AI_i, AI("H2")) = AlMLVl(UAI_arr(i, UAI("PVHHPR"))) '�߸߱����ȼ�PVHHPR��ӦH2
    
                If VBA.IsNumeric(UAI_arr(i, UAI("PVLLTP"))) Then
                    AI_arr(AI_i, AI("LL")) = UAI_arr(i, UAI("PVLLTP")) '�͵ͱ���ֵPVLLTP��ӦLL
                    
                    If AI_arr(AI_i, AI("LL")) <= AI_arr(AI_i, AI("MD")) Then
                        AI_arr(AI_i, AI("LL")) = AI_arr(AI_i, AI("MD")) + (AI_arr(AI_i, AI("MU")) - AI_arr(AI_i, AI("MD"))) * 0.1
                    End If
                Else
                    AI_arr(AI_i, AI("LL")) = 0
                End If
    
                AI_arr(AI_i, AI("L2")) = AlMLVl(UAI_arr(i, UAI("PVLLPR"))) '�͵ͱ����ȼ�PVLLPR��ӦL2
                AI_arr(AI_i, AI("SQRTOPT")) = SQRTOPT(UAI_arr(i, UAI("PVCHAR"))) '���뿪������PVCHAR=SQRROOT��ӦSQRTOPT
                AI_arr(AI_i, AI("ALMDB")) = ALMDB(UAI_arr(i, UAI("PVALDB")), UAI_arr(i, UAI("PVALDBEU")), UAI_arr(i, UAI("PVEUHI")), UAI_arr(i, UAI("PVEULO"))) '��������PVALDB��ӦALMDB����PVALDB=EUʱ����������Ϊ������ֵPVALDBEU����Ҫ��������ת��Ϊ�ٷֱȣ�M6����Ϊ���̰ٷֱȣ�����PVALDB=HalfΪ0.5%��PVALDB=oneΪ1%��������PVALDB=fiveΪ5%
                AI_arr(AI_i, AI("RD")) = ThisChalRD '�Ƿ��������վ���豸�Ų�ѯ
        
                '����Ƿ�����ֵ
                If Val(AI_arr(AI_i, AI("HH"))) > 0 Then
                    If Val(AI_arr(AI_i, AI("AH"))) >= Val(AI_arr(AI_i, AI("HH"))) Then
                        AI_arr(AI_i, AI("HH")) = Val(AI_arr(AI_i, AI("AH"))) * 1.1
                    End If
                End If
        
                If controllerModel = "K-CU03" Then
                   AI_arr(AI_i, AI("IO_LPS")) = "2" '��·��
                End If
                

                If UAI_arr(i, UAI("INPTDIR")) = "REVERSE" Then
                AI_arr(AI_i, AI("REVOPT")) = "1" '������
                Else
                AI_arr(AI_i, AI("REVOPT")) = "0" '������
                End If
        
        
                '---------------------------------------------------------------------
                '��¼������Ϣ
                LastChalRD = ThisChalRD
                '---------------------------------------------------------------------
                'M6���ݿ�
                AI_i = AI_i + 1 '�м���
            End If
    
        Next i
    
        '3)-----------------------------------------------------------------ת��DI--------------------------------------------------------------------------------------------
    
        For i = 2 To UBound(UDI_arr, 1)
    
            'վ����ͬ
            If SN(UDI_arr(i, UDI("NODENUM"))) = SN_i Then
    
                '---------------------------------------------------------------------
                '��ȡ������Ϣ
                ThisChalRD = RD(UDI_arr(i, UDI("NODENUM")), UDI_arr(i, UDI("MODNUM")))
                '---------------------------------------------------------------------
                DI_arr(DI_i, DI("PN")) = UDI_arr(i, UDI("NAME")) '����
                DI_arr(DI_i, DI("DS")) = UDI_arr(i, UDI("PTDESC")) '������
                DI_arr(DI_i, DI("SN")) = SN(UDI_arr(i, UDI("NODENUM"))) 'վ��
                DI_arr(DI_i, DI("MT")) = "K-DI03" 'ģ������
                DI_arr(DI_i, DI("CN")) = UDI_arr(i, UDI("SLOTNUM")) 'ͨ����
    
                If UDI_arr(i, UDI("INPTDIR")) = "REVERSE" Then '���뷴��
                    DI_arr(DI_i, DI("REVOPT")) = "1"
                Else
                    DI_arr(DI_i, DI("REVOPT")) = "0"
                End If
    
                DI_arr(DI_i, DI("DAMOPT")) = DAMOPT(UDI_arr(i, UDI("ALMOPT")), UDI_arr(i, UDI("PVNORMAL"))) '��������
                DI_arr(DI_i, DI("DAMLV")) = DAMLV(UDI_arr(i, UDI("OFFNRMPR"))) '�������ȼ�OFFNRMPR��ӦDAMLV
                DI_arr(DI_i, DI("RD")) = ThisChalRD '�Ƿ��������վ���豸�Ų�ѯ
    
    
                If controllerModel = "K-CU03" Then
                   DI_arr(DI_i, DI("IO_LPS")) = "2" '��·��
                End If
    
                DI_arr(DI_i, DI("E1")) = UDI_arr(i, UDI("STATETXT(1)")) '��1����
                DI_arr(DI_i, DI("E0")) = UDI_arr(i, UDI("STATETXT(0)")) '��0����
                '---------------------------------------------------------------------
                '��¼������Ϣ
                LastChalRD = ThisChalRD
                '---------------------------------------------------------------------
                        
                'M6���ݿ�
                DI_i = DI_i + 1 '�м���
            End If
    
        Next i
    
        '4)-----------------------------------------------------------------ת��DO--------------------------------------------------------------------------------------------
        For i = 2 To UBound(UDO_arr, 1)
    
            'վ����ͬ
            If SN(UDO_arr(i, UDO("NODENUM"))) = SN_i Then
            
                '��ȡ������Ϣ
                ThisChalRD = RD(UDO_arr(i, UDO("NODENUM")), UDO_arr(i, UDO("MODNUM")))
            
                DOV_arr(DO_i, DOV("PN")) = UDO_arr(i, UDO("NAME")) '����
                DOV_arr(DO_i, DOV("DS")) = UDO_arr(i, UDO("PTDESC")) '������
                DOV_arr(DO_i, DOV("SN")) = SN(UDO_arr(i, UDO("NODENUM"))) 'վ��
                DOV_arr(DO_i, DOV("MT")) = "K-DO01" 'ģ������
    
                If UDO_arr(i, UDO("SLOTNUM")) <= 16 Then
                    DOV_arr(DO_i, DOV("CN")) = UDO_arr(i, UDO("SLOTNUM")) 'ͨ����
                Else
                    DOV_arr(DO_i, DOV("CN")) = UDO_arr(i, UDO("SLOTNUM")) - 16 'ͨ����
                End If
                       
                DOV_arr(DO_i, DOV("RD")) = ThisChalRD '�Ƿ��������վ���豸�Ų�ѯ
                
                If controllerModel = "K-CU03" Then
                   DOV_arr(DO_i, DOV("IO_LPS")) = "2" '��·��
                End If
                
                
                '��¼������Ϣ
                LastChalRD = ThisChalRD
                
                'M6���ݿ�
                DO_i = DO_i + 1 '�м���
            End If
        Next
    
    Next SN_i
    
    'ģ���ַ��ֵ
    Call InitDN
    
    '����DNֵ
    Call SetDN
    
    '1-05--------------------ת��REAL
    ii = 3 '�����п�ʼ
    'UNUMת��ΪREAL
    For i = 2 To UBound(UNUM_arr, 1)
        REAL_arr(ii, REAL("PN")) = UNUM_arr(i, UNUM("NAME")) '����
        REAL_arr(ii, REAL("DS")) = UNUM_arr(i, UNUM("PTDESC")) '������
        REAL_arr(ii, REAL("DT")) = "REAL" '��������
        REAL_arr(ii, REAL("AV")) = UNUM_arr(i, UNUM("PV")) '��ǰֵ
        REAL_arr(ii, REAL("MD")) = UNUM_arr(i, UNUM("PV")) * 0.1 '����
        If UNUM_arr(i, UNUM("PV")) = 0 Then
        REAL_arr(ii, REAL("MU")) = 100 '����
        Else
        REAL_arr(ii, REAL("MU")) = UNUM_arr(i, UNUM("PV")) * 10 '����
        End If
        REAL_arr(ii, REAL("UT")) = UNUM_arr(i, UNUM("EUDESC")) '����
        REAL_arr(ii, REAL("OF")) = DelDit(UNUM_arr(i, UNUM("PVFORMAT"))) 'С��λ��
        REAL_arr(ii, REAL("SN")) = SN(UNUM_arr(i, UNUM("NODENUM")))  'վ��
        ii = ii + 1 '�м���
    Next
    
'    'UREGPVת��ΪREAL
'    For i = 2 To UBound(UREGPV_arr, 1)
'        PVALGID = UREGPV_arr(i, UREGPV("PVALGID"))
'        If PVALGID <> "CALCULTR" Then
'            REAL_arr(ii, REAL("PN")) = UREGPV_arr(i, UREGPV("NAME")) '����
'            REAL_arr(ii, REAL("DS")) = UREGPV_arr(i, UREGPV("PTDESC")) '������
'            REAL_arr(ii, REAL("DT")) = "REAL" '��������
'            REAL_arr(ii, REAL("MD")) = UREGPV_arr(i, UREGPV("PVEULO")) '����
'            REAL_arr(ii, REAL("MU")) = UREGPV_arr(i, UREGPV("PVEUHI")) '����
'            REAL_arr(ii, REAL("UT")) = UREGPV_arr(i, UREGPV("EUDESC")) '����
'            REAL_arr(ii, REAL("OF")) = DelDit(UREGPV_arr(i, UREGPV("PVFORMAT"))) 'С��λ��
'            REAL_arr(ii, REAL("SN")) = SN(UREGPV_arr(i, UREGPV("NODENUM")))  'վ��
'            ii = ii + 1 '�м���
'        End If
'    Next
    
    'ULOGIC����NNתΪת��ΪREAL��ÿ����������NN1~NN8
    Dim NNstr As String 'NN�ַ���
    For i = 2 To UBound(ULOGIC_arr, 1)
    
        '----��ȡNN��ʼֵ
        '��ʼ��
        NNstr = ""
        '�ۼ�1~8
        For jj = 1 To 8
        
            If Len(ULOGIC_arr(i, ULOGIC("NN(00" & jj & ")"))) Then
               NNstr = NNstr & "NN(00" & jj & ")=" & ULOGIC_arr(i, ULOGIC("NN(00" & jj & ")"))
            End If
   
        Next
        'ȥ�������ַ�
        NNstr = Replace(NNstr, " ", "")
        NNstr = Replace(NNstr, "(00", "")
        NNstr = Replace(NNstr, ")", "")
        NNarr = Split(NNstr, "NN", 8)
        'ת��
        For jj = 1 To 8
            REAL_arr(ii, REAL("PN")) = ULOGIC_arr(i, ULOGIC("NAME")) & "_NN" & jj '����
            REAL_arr(ii, REAL("DS")) = ULOGIC_arr(i, ULOGIC("PTDESC")) & "��ֵ�Ĵ���" & jj '������
            REAL_arr(ii, REAL("DT")) = "REAL" '��������
            REAL_arr(ii, REAL("MD")) = "0" '����
            REAL_arr(ii, REAL("MU")) = "1000" '����
            REAL_arr(ii, REAL("UT")) = "" '����
            REAL_arr(ii, REAL("OF")) = "%-8.2f" 'С��λ��
            REAL_arr(ii, REAL("SN")) = SN(ULOGIC_arr(i, ULOGIC("NODENUM")))  'վ��
            If jj <= UBound(NNarr) Then
            REAL_arr(ii, REAL("AV")) = Replace(NNarr(jj), jj & "=", "") '��������
            End If
            ii = ii + 1 '�м���
        Next
        
    Next
    
    '1-06--------------------ת��AM
    ii = 3 '�����п�ʼ
    For i = 2 To UBound(UREGPV_arr, 1)
           
                AM_arr(ii, AM("PN")) = UREGPV_arr(i, UREGPV("NAME")) '����
                AM_arr(ii, AM("DS")) = UREGPV_arr(i, UREGPV("PTDESC")) '������
                AM_arr(ii, AM("MD")) = UREGPV_arr(i, UREGPV("PVEULO")) '����
                AM_arr(ii, AM("MU")) = UREGPV_arr(i, UREGPV("PVEUHI")) '����
                
'                AM_arr(ii, AM("MD")) = UREGPV_arr(i, UREGPV("PVEXEULO")) '����
'                AM_arr(ii, AM("MU")) = UREGPV_arr(i, UREGPV("PVEXEUHI")) '����
                
                AM_arr(ii, AM("UT")) = UREGPV_arr(i, UREGPV("EUDESC")) '����
                AM_arr(ii, AM("SN")) = SN(UREGPV_arr(i, UREGPV("NODENUM")))  'վ��
        
                ii = ii + 1 '�м���
            
    Next
    
    
    '1-07--------------------ת��UREGC PID ,MAN,�Զ����
    i1 = 3 '�����п�ʼ
    i2 = 3 '�����п�ʼ
    i3 = 3 '�����п�ʼ
    i4 = 3 '�����п�ʼ
    i5 = 3 '�����п�ʼ
    i6 = 3 '�����п�ʼ
    i7 = 3 '�����п�ʼ
    i8 = 3 '�����п�ʼ
    For i = 2 To UBound(UREGC_arr, 1)
    
        If UREGC_arr(i, UREGC("CTLALGID")) Like "PID" Or UREGC_arr(i, UREGC("CTLALGID")) Like "PIDFF" Then
      
            PIDA_arr(i1, PIDA("PN")) = UREGC_arr(i, UREGC("NAME")) '����
            PIDA_arr(i1, PIDA("DS")) = UREGC_arr(i, UREGC("PTDESC")) '������
            PIDA_arr(i1, PIDA("PVL")) = UREGC_arr(i, UREGC("PVEULO")) '����
            PIDA_arr(i1, PIDA("PVU")) = UREGC_arr(i, UREGC("PVEUHI")) '����
            PIDA_arr(i1, PIDA("PVUT")) = UREGC_arr(i, UREGC("EUDESC")) '����
            PIDA_arr(i1, PIDA("SN")) = SN(UREGC_arr(i, UREGC("NODENUM")))  'վ��
            If UREGC_arr(i, UREGC("CTLACTN")) = "REVERSE" Then '���÷�ʽ
            PIDA_arr(i1, PIDA("ACTOPT")) = 1
            Else
            PIDA_arr(i1, PIDA("ACTOPT")) = 0
            End If
            PIDA_arr(i1, PIDA("KP")) = UREGC_arr(i, UREGC("K")) * 100 '����
            PIDA_arr(i1, PIDA("TI")) = UREGC_arr(i, UREGC("T1"))  '����
            PIDA_arr(i1, PIDA("KD")) = 1  '΢������
            PIDA_arr(i1, PIDA("TD")) = UREGC_arr(i, UREGC("T2"))  '΢��
            i1 = i1 + 1 '�м���
        End If
      
        If UREGC_arr(i, UREGC("CTLALGID")) Like "AUTOMAN" Then
      
            MAN_arr(i2, MAN("PN")) = UREGC_arr(i, UREGC("NAME")) '����
            MAN_arr(i2, MAN("DS")) = UREGC_arr(i, UREGC("PTDESC")) '������
            MAN_arr(i2, MAN("ENGL")) = UREGC_arr(i, UREGC("PVEULO")) '����
            MAN_arr(i2, MAN("ENGU")) = UREGC_arr(i, UREGC("PVEUHI")) '����
            MAN_arr(i2, MAN("UT")) = UREGC_arr(i, UREGC("EUDESC")) '����
            MAN_arr(i2, MAN("SN")) = SN(UREGC_arr(i, UREGC("NODENUM")))  'վ��
    
            i2 = i2 + 1 '�м���
        End If
      
        If UREGC_arr(i, UREGC("CTLALGID")) Like "SWITCH" Then
      
            SWITCH_arr(i3, SWITCH("PN")) = UREGC_arr(i, UREGC("NAME")) '����
            SWITCH_arr(i3, SWITCH("DS")) = UREGC_arr(i, UREGC("PTDESC")) '������
            SWITCH_arr(i3, SWITCH("SN")) = SN(UREGC_arr(i, UREGC("NODENUM")))  'վ��
            
            SWITCH_arr(i3, SWITCH("CVEUHI")) = UREGC_arr(i, UREGC("OPHILM"))  '�������
            SWITCH_arr(i3, SWITCH("CVEULO")) = UREGC_arr(i, UREGC("OPLOLM")) '�������
            SWITCH_arr(i3, SWITCH("XEUHI")) = UREGC_arr(i, UREGC("XEUHI"))  '�������
            SWITCH_arr(i3, SWITCH("XEULO")) = UREGC_arr(i, UREGC("XEULO"))  '�������
            
            If UREGC_arr(i, UREGC("CTLEQN")) = "EQA" Then
               SWITCH_arr(i3, SWITCH("PVEQN")) = "0"  'ģʽѡ��0-EQA,1-EQB
            End If
            
            If UREGC_arr(i, UREGC("CTLEQN")) = "EQB" Then
               SWITCH_arr(i3, SWITCH("PVEQN")) = "1"  'ģʽѡ��0-EQA,1-EQB
            End If
            
            i3 = i3 + 1 '�м���
            
        End If
      
        If UREGC_arr(i, UREGC("CTLALGID")) Like "ORSEL" Then
      
            ORSEL_arr(i4, ORSEL("PN")) = UREGC_arr(i, UREGC("NAME")) '����
            ORSEL_arr(i4, ORSEL("DS")) = UREGC_arr(i, UREGC("PTDESC")) '������
            ORSEL_arr(i4, ORSEL("SN")) = SN(UREGC_arr(i, UREGC("NODENUM")))  'վ��
            
        '    OROPT:BOOL:=FALSE;(*����ѡ�0-δ��ѡ�����벻���ٱ�ѡֵ 1-δ��ѡ��������ٱ�ѡֵ*)
        '    CTLEQN:BOOL:=FALSE;(*ģʽѡ��0-��ѡ 1-��ѡ*)===
        '    BYPASS:BOOL:=FALSE;(*������·�Ƿ�ʹ��:ON������·���룻OFF��������·����*)
        '    BYPASS1:BOOL:=FALSE;(*����1��·����*)
        '    BYPASS2:BOOL:=FALSE;(*����2��·����*)
        '    BYPASS3:BOOL:=FALSE;(*����3��·����*)
        '    BYPASS4:BOOL:=FALSE;(*����4��·����*)
        '    OROFFSET:BOOL:=FALSE;(*����ƫ�Ʋ���:����δ��ѡ��ֵ�ĸ���ֵ*)
        '    XEULO:REAL:=0;(*������������*)===
        '    XEUHI:REAL:=100;(*������������*)===
        '    CVEULO:REAL:=0;(*�����������*)==
        '    CVEUHI:REAL:=100;(*�����������*)==

        '    M:BYTE:=2;(*�������*)
            ConvDic.RemoveAll: ConvDic.Add "OFF", "0": ConvDic.Add "ON", "1" '����ѡ�0-δ��ѡ�����벻���ٱ�ѡֵ 1-δ��ѡ��������ٱ�ѡֵ
            ORSEL_arr(i4, ORSEL("OROPT")) = ConvDic(UREGC_arr(i, UREGC("OROPT")))
            ConvDic.RemoveAll: ConvDic.Add "EQA", "0": ConvDic.Add "EQB", "1" 'ģʽѡ��0-��ѡ 1-��ѡ
            ORSEL_arr(i4, ORSEL("CTLEQN")) = ConvDic(UREGC_arr(i, UREGC("CTLEQN")))
            
            
            ORSEL_arr(i4, ORSEL("OROFFSET")) = UREGC_arr(i, UREGC("OROFFSET"))  '����ƫ�Ʋ���:����δ��ѡ��ֵ�ĸ���ֵ
            ORSEL_arr(i4, ORSEL("CVEUHI")) = UREGC_arr(i, UREGC("OPHILM"))  '�������
            ORSEL_arr(i4, ORSEL("CVEULO")) = UREGC_arr(i, UREGC("OPLOLM")) '�������
            ORSEL_arr(i4, ORSEL("XEUHI")) = UREGC_arr(i, UREGC("XEUHI"))  '�������
            ORSEL_arr(i4, ORSEL("XEULO")) = UREGC_arr(i, UREGC("XEULO"))  '�������
            ORSEL_arr(i4, ORSEL("M")) = UREGC_arr(i, UREGC("M"))  '�������
            

            i4 = i4 + 1 '�м���
        End If
      
        If UREGC_arr(i, UREGC("CTLALGID")) Like "MULDIV" Then
      
            MULDIV_arr(i5, MULDIV("PN")) = UREGC_arr(i, UREGC("NAME")) '����
            MULDIV_arr(i5, MULDIV("DS")) = UREGC_arr(i, UREGC("PTDESC")) '������
            MULDIV_arr(i5, MULDIV("SN")) = SN(UREGC_arr(i, UREGC("NODENUM")))  'վ��
            
            MULDIV_arr(i5, MULDIV("CVEUHI")) = UREGC_arr(i, UREGC("OPHILM"))  '�������
            MULDIV_arr(i5, MULDIV("CVEULO")) = UREGC_arr(i, UREGC("OPLOLM")) '�������
            MULDIV_arr(i5, MULDIV("XEUHI")) = UREGC_arr(i, UREGC("XEUHI"))  '�������
            MULDIV_arr(i5, MULDIV("XEULO")) = UREGC_arr(i, UREGC("XEULO"))  '�������
            
            MULDIV_arr(i5, MULDIV("K")) = UREGC_arr(i, UREGC("K"))   '��������
            MULDIV_arr(i5, MULDIV("K1")) = UREGC_arr(i, UREGC("K1"))  '����1��������
            MULDIV_arr(i5, MULDIV("K2")) = UREGC_arr(i, UREGC("K2"))  '����2��������
            MULDIV_arr(i5, MULDIV("K3")) = UREGC_arr(i, UREGC("K3"))  '����3��������
            MULDIV_arr(i5, MULDIV("B")) = UREGC_arr(i, UREGC("B"))   'ƫ��
            MULDIV_arr(i5, MULDIV("B1")) = UREGC_arr(i, UREGC("B1")) '����1ƫ��
            MULDIV_arr(i5, MULDIV("B2")) = UREGC_arr(i, UREGC("B2")) '����2ƫ��
            MULDIV_arr(i5, MULDIV("B3")) = UREGC_arr(i, UREGC("B3")) '����3ƫ��
            MULDIV_arr(i5, MULDIV("PVEQN")) = CTLEQN(UREGC_arr(i, UREGC("CTLEQN"))) 'ģʽѡ��0-A,1-B,2-C,3-D,4-E
            
            i5 = i5 + 1 '�м���
            
        End If
      
        If UREGC_arr(i, UREGC("CTLALGID")) Like "SUMMER" Then
      
            SUMMER_CTRL_arr(i6, SUMMER_CTRL("PN")) = UREGC_arr(i, UREGC("NAME")) '����
            SUMMER_CTRL_arr(i6, SUMMER_CTRL("DS")) = UREGC_arr(i, UREGC("PTDESC")) '������
            SUMMER_CTRL_arr(i6, SUMMER_CTRL("SN")) = SN(UREGC_arr(i, UREGC("NODENUM")))  'վ��
            
            SUMMER_CTRL_arr(i6, SUMMER_CTRL("CVEUHI")) = UREGC_arr(i, UREGC("OPHILM"))  '�������
            SUMMER_CTRL_arr(i6, SUMMER_CTRL("CVEULO")) = UREGC_arr(i, UREGC("OPLOLM")) '�������
            SUMMER_CTRL_arr(i6, SUMMER_CTRL("XEUHI")) = UREGC_arr(i, UREGC("XEUHI"))  '�������
            SUMMER_CTRL_arr(i6, SUMMER_CTRL("XEULO")) = UREGC_arr(i, UREGC("XEULO"))  '�������
            
            SUMMER_CTRL_arr(i6, SUMMER_CTRL("K")) = UREGC_arr(i, UREGC("K"))  '��������
            SUMMER_CTRL_arr(i6, SUMMER_CTRL("K1")) = UREGC_arr(i, UREGC("K1"))  '����1��������
            SUMMER_CTRL_arr(i6, SUMMER_CTRL("K2")) = UREGC_arr(i, UREGC("K2"))  '����2��������
            SUMMER_CTRL_arr(i6, SUMMER_CTRL("K3")) = UREGC_arr(i, UREGC("K3"))  '����3��������
            SUMMER_CTRL_arr(i6, SUMMER_CTRL("K4")) = UREGC_arr(i, UREGC("K4"))  '����4��������
            SUMMER_CTRL_arr(i6, SUMMER_CTRL("B")) = UREGC_arr(i, UREGC("B"))   'ƫ��
            
            i6 = i6 + 1 '�м���
            
        End If
      
    Next
    
    '1-08--------------------ת��UREGPV �Զ����
    J1 = 3 '�����п�ʼ
    j2 = 3 '�����п�ʼ
    j3 = 3 '�����п�ʼ
    j4 = 3 '�����п�ʼ
    j5 = 3 '�����п�ʼ
    j6 = 3 '�����п�ʼ
    j7 = 3 '�����п�ʼ
    j8 = 3 '�����п�ʼ
    For i = 2 To UBound(UREGPV_arr, 1)
    
        If UREGPV_arr(i, UREGPV("PVALGID")) = "FLOWCOMP" Then
        
            FLOWCOMP_arr(J1, FLOWCOMP("PN")) = UREGPV_arr(i, UREGPV("NAME")) & "_OMP" '����
            FLOWCOMP_arr(J1, FLOWCOMP("DS")) = UREGPV_arr(i, UREGPV("PTDESC"))  '������
            FLOWCOMP_arr(J1, FLOWCOMP("UT")) = UREGPV_arr(i, UREGPV("EUDESC"))  '����
            FLOWCOMP_arr(J1, FLOWCOMP("SN")) = SN(UREGPV_arr(i, UREGPV("NODENUM")))   'վ��

            FLOWCOMP_arr(J1, FLOWCOMP("RG")) = UREGPV_arr(i, UREGPV("RG"))  '��ƵĲο�����/������
            FLOWCOMP_arr(J1, FLOWCOMP("RP")) = UREGPV_arr(i, UREGPV("RP"))  '���ѹ������ѹ��
            FLOWCOMP_arr(J1, FLOWCOMP("RT")) = UREGPV_arr(i, UREGPV("RT"))  '����¶ȣ������¶ȣ�
            FLOWCOMP_arr(J1, FLOWCOMP("P0")) = UREGPV_arr(i, UREGPV("P0"))  'ѹ�����ο�,��P�ĵ�λһ�½��е���
            FLOWCOMP_arr(J1, FLOWCOMP("T0")) = UREGPV_arr(i, UREGPV("T0"))  '�����¶�ת������
            FLOWCOMP_arr(J1, FLOWCOMP("RX")) = UREGPV_arr(i, UREGPV("RX"))  '�ο�����ѹ��ϵ��
            FLOWCOMP_arr(J1, FLOWCOMP("C")) = UREGPV_arr(i, UREGPV("C"))    '�̶�����
            FLOWCOMP_arr(J1, FLOWCOMP("C1")) = UREGPV_arr(i, UREGPV("C1"))  'У������1
            FLOWCOMP_arr(J1, FLOWCOMP("C2")) = UREGPV_arr(i, UREGPV("C2"))  'У������2
            
            
            ConvDic.RemoveAll: ConvDic.Add "EQA", "0": ConvDic.Add "EQB", "1" '������ʽѡ��0-4
                               ConvDic.Add "EQC", "2": ConvDic.Add "EQD", "3": ConvDic.Add "EQE", "4"
            FLOWCOMP_arr(J1, FLOWCOMP("PVEQN")) = ConvDic(UREGPV_arr(i, UREGPV("PVEQN")))
            
            ConvDic.RemoveAll: ConvDic.Add "SQRROOT", "1": ConvDic.Add "LINEAR", "0" 'FALSE-Linear���� TRUE-Sqrroot����
            FLOWCOMP_arr(J1, FLOWCOMP("PVCHAR")) = ConvDic(UREGPV_arr(i, UREGPV("PVCHAR")))
            
            FLOWCOMP_arr(J1, FLOWCOMP("COMPLOLM")) = UREGPV_arr(i, UREGPV("COMPLOLM"))  '���������
            FLOWCOMP_arr(J1, FLOWCOMP("COMPHILM")) = UREGPV_arr(i, UREGPV("COMPHILM"))  '���������
            
            J1 = J1 + 1 '�м���
        End If
    
        If UREGPV_arr(i, UREGPV("PVALGID")) = "GENLIN" Then
            ONEFOLD_arr(j2, ONEFOLD("PN")) = UREGPV_arr(i, UREGPV("NAME")) & "_FOLD" '����
            ONEFOLD_arr(j2, ONEFOLD("DS")) = UREGPV_arr(i, UREGPV("PTDESC"))  '������
            ONEFOLD_arr(j2, ONEFOLD("SN")) = SN(UREGPV_arr(i, UREGPV("NODENUM")))   'վ��
            
            Dim jj2 As Integer
            PNTNUM = 0
            For jj2 = 0 To 12
                 If Len(UREGPV_arr(i, UREGPV("IN" & jj2))) > 0 Then
                    PNTNUM = PNTNUM + 1
                 End If
            Next
            ONEFOLD_arr(j2, ONEFOLD("PNTNUM")) = PNTNUM   '����
            j2 = j2 + 1 '�м���
        End If
    
        If UREGPV_arr(i, UREGPV("PVALGID")) = "HILOAVG" Then
            HILOAVG_arr(j3, HILOAVG("PN")) = UREGPV_arr(i, UREGPV("NAME")) & "_AVG"  '����
            HILOAVG_arr(j3, HILOAVG("DS")) = UREGPV_arr(i, UREGPV("PTDESC"))  '������
            HILOAVG_arr(j3, HILOAVG("UT")) = UREGPV_arr(i, UREGPV("EUDESC"))  '����
            HILOAVG_arr(j3, HILOAVG("SN")) = SN(UREGPV_arr(i, UREGPV("NODENUM")))   'վ��
            
            HILOAVG_arr(j3, HILOAVG("PVEUHI")) = UREGPV_arr(i, UREGPV("PVEUHI"))  '��������
            HILOAVG_arr(j3, HILOAVG("PVEULO")) = UREGPV_arr(i, UREGPV("PVEULO"))  '��������
            HILOAVG_arr(j3, HILOAVG("PVEXEUHI")) = UREGPV_arr(i, UREGPV("PVEXEUHI"))  '��������
            HILOAVG_arr(j3, HILOAVG("PVEXEULO")) = UREGPV_arr(i, UREGPV("PVEXEULO"))  '��������
            
            HILOAVG_arr(j3, HILOAVG("NMIN")) = UREGPV_arr(i, UREGPV("NMIN"))  '״̬�ò�����С����
            
            ConvDic.RemoveAll: ConvDic.Add "ON", "1": ConvDic.Add "OFF", "0" '�Ƿ�����ǿ��
            HILOAVG_arr(j3, HILOAVG("FRCPERM")) = ConvDic(UREGPV_arr(i, UREGPV("FRCPERM")))
            
            ConvDic.RemoveAll: ConvDic.Add "EQA", "0": ConvDic.Add "EQB", "1": ConvDic.Add "EQC", "2" 'ģʽѡ��0-��ѡ1-��ѡ2-ȡƽ��
            HILOAVG_arr(j3, HILOAVG("PVEQN")) = ConvDic(UREGPV_arr(i, UREGPV("PVEQN")))
            
            ConvDic.RemoveAll: ConvDic.Add "SELECTP1", "1": ConvDic.Add "SELECTP2", "2": ConvDic.Add "SELECTP3", "3" 'ǿ��ѡ����1-6
                               ConvDic.Add "SELECTP4", "4": ConvDic.Add "SELECTP5", "5": ConvDic.Add "SELECTP6", "6"
            HILOAVG_arr(j3, HILOAVG("FSELIN")) = ConvDic(UREGPV_arr(i, UREGPV("FSELIN")))
            
            j3 = j3 + 1 '�м���
        End If
    
        If UREGPV_arr(i, UREGPV("PVALGID")) = "MIDOF3" Then
            MIDOF3_arr(j4, MIDOF3("PN")) = UREGPV_arr(i, UREGPV("NAME")) & "_OF3" '����
            MIDOF3_arr(j4, MIDOF3("DS")) = UREGPV_arr(i, UREGPV("PTDESC"))  '������
            MIDOF3_arr(j4, MIDOF3("UT")) = UREGPV_arr(i, UREGPV("EUDESC"))  '����
            MIDOF3_arr(j4, MIDOF3("SN")) = SN(UREGPV_arr(i, UREGPV("NODENUM")))   'վ��
            
            'STGN:BYTE:=0;(*״̬�ò�����ǰ����*)
            'PVEQN:BYTE:=0;(*ģʽѡ��0-��ѡ1-��ѡ2-ȡƽ��*)

            ConvDic.RemoveAll: ConvDic.Add "EQA", "0": ConvDic.Add "EQB", "1": ConvDic.Add "EQC", "2" 'ģʽѡ��0-��ѡ1-��ѡ2-ȡƽ��
            MIDOF3_arr(j4, MIDOF3("PVEQN")) = ConvDic(UREGPV_arr(i, UREGPV("PVEQN")))
            
            j4 = j4 + 1 '�м���
        End If
    
'        If UREGPV_arr(i, UREGPV("PVALGID")) = "TOTALIZR" Then
'            TOTALIZR_arr(j5, TOTALIZR("PN")) = UREGPV_arr(i, UREGPV("NAME"))  '����
'            TOTALIZR_arr(j5, TOTALIZR("DS")) = UREGPV_arr(i, UREGPV("PTDESC"))  '������
'            TOTALIZR_arr(j5, TOTALIZR("UT")) = UREGPV_arr(i, UREGPV("EUDESC"))  '����
'            TOTALIZR_arr(j5, TOTALIZR("SN")) = SN(UREGPV_arr(i, UREGPV("NODENUM")))   'վ��
'            j5 = j5 + 1 '�м���
'        End If
    
        If UREGPV_arr(i, UREGPV("PVALGID")) = "TOTALIZR" Then
            FLOWSUM_arr(j5, FLOWSUM("PN")) = UREGPV_arr(i, UREGPV("NAME")) & "_SUM" '����
            FLOWSUM_arr(j5, FLOWSUM("DS")) = UREGPV_arr(i, UREGPV("PTDESC"))  '������
            FLOWSUM_arr(j5, FLOWSUM("PVUT")) = UREGPV_arr(i, UREGPV("EUDESC"))  '����
            FLOWSUM_arr(j5, FLOWSUM("SN")) = SN(UREGPV_arr(i, UREGPV("NODENUM")))   'վ��
            j5 = j5 + 1 '�м���
        End If
    
    
        If UREGPV_arr(i, UREGPV("PVALGID")) = "VDTLDLAG" Then
            VDTLDLAG_arr(j6, VDTLDLAG("PN")) = UREGPV_arr(i, UREGPV("NAME")) & "_LAG" '����
            VDTLDLAG_arr(j6, VDTLDLAG("DS")) = UREGPV_arr(i, UREGPV("PTDESC"))  '������
            VDTLDLAG_arr(j6, VDTLDLAG("UT")) = UREGPV_arr(i, UREGPV("EUDESC"))  '����
            VDTLDLAG_arr(j6, VDTLDLAG("SN")) = SN(UREGPV_arr(i, UREGPV("NODENUM")))   'վ��
            
            'C:REAL:=1;(*�̶�����*)
            'D:REAL:=0;(*ƫ��*)
            'TS:REAL:=0;(*����ʱ��,�����ɨ������,S*)
            'DP1:REAL:=0;(*P1��ʱTD���ֵ*)
            'NRATE:WORD:=0;(*���ݱ���λ����*)
            'NLOC:WORD:=0;(*���ݱ�ʹ�������С*)
            'INC:WORD:=0;(*����ļ�����*)
            'ARRIN:ARRAY[1..30] OF REAL;(*���30����ʷ����*)
            'FIRSTFLAG:BOOL:=TRUE;(*��һ�����б��*)
            'I:BYTE:=0;(*ѭ������*)
            VDTLDLAG_arr(j6, VDTLDLAG("C")) = UREGPV_arr(i, UREGPV("C"))  '�̶�����
            VDTLDLAG_arr(j6, VDTLDLAG("D")) = UREGPV_arr(i, UREGPV("D"))  'ƫ��
            
            
            j6 = j6 + 1 '�м���
        End If
        
        If UREGPV_arr(i, UREGPV("PVALGID")) = "SUMMER" Then
            SUMMER_arr(j7, SUMMER("PN")) = UREGPV_arr(i, UREGPV("NAME")) & "_SUM" '����
            SUMMER_arr(j7, SUMMER("DS")) = UREGPV_arr(i, UREGPV("PTDESC"))  '������
            SUMMER_arr(j7, SUMMER("UT")) = UREGPV_arr(i, UREGPV("EUDESC"))  '����
            SUMMER_arr(j7, SUMMER("SN")) = SN(UREGPV_arr(i, UREGPV("NODENUM")))   'վ��
            
            'C:REAL:=1;(*��������*)
            'C1:REAL:=1;(*����1��������*)
            'C2:REAL:=1;(*����2��������*)
            'C3:REAL:=1;(*����3��������*)
            'C4:REAL:=1;(*����4��������*)
            'C5:REAL:=1;(*����5��������*)
            'C6:REAL:=1;(*����6��������*)
            'D:REAL:=0;(*ƫ��*)
            'PVEQN:BOOL:=FALSE;(*ģʽѡ��0-A,1-B*)
             SUMMER_arr(j7, SUMMER("C")) = UREGPV_arr(i, UREGPV("C"))   '��������
             SUMMER_arr(j7, SUMMER("C1")) = UREGPV_arr(i, UREGPV("C1")) '����1��������
             SUMMER_arr(j7, SUMMER("C2")) = UREGPV_arr(i, UREGPV("C2")) '����2��������
             SUMMER_arr(j7, SUMMER("C3")) = UREGPV_arr(i, UREGPV("C3")) '����3��������
             SUMMER_arr(j7, SUMMER("C4")) = UREGPV_arr(i, UREGPV("C4")) '����4��������
             SUMMER_arr(j7, SUMMER("C5")) = UREGPV_arr(i, UREGPV("C5")) '����5��������
             SUMMER_arr(j7, SUMMER("C6")) = UREGPV_arr(i, UREGPV("C6")) '����6��������
             SUMMER_arr(j7, SUMMER("D")) = UREGPV_arr(i, UREGPV("D"))   'ƫ��
             ConvDic.RemoveAll: ConvDic.Add "EQA", "0": ConvDic.Add "EQB", "1" 'ģʽѡ��0-A,1-B
             SUMMER_arr(j7, SUMMER("PVEQN")) = ConvDic(UREGPV_arr(i, UREGPV("PVEQN")))
             
            j7 = j7 + 1 '�м���
        End If
        
    Next
    '1-09--------------------ת��DM
    ii = 3 '�����п�ʼ
    'UREGPVת��ΪDM
    'UREGPV�����ۼ�ת��λ��ť
    For i = 2 To UBound(UREGPV_arr, 1)
        If UREGPV_arr(i, UREGPV("PVALGID")) = "FLOWCOMP" Then
            DM_arr(ii, DM("PN")) = UREGPV_arr(i, UREGPV("NAME")) & "_RS" '����
            DM_arr(ii, DM("DS")) = UREGPV_arr(i, UREGPV("PTDESC")) '������
            DM_arr(ii, DM("SN")) = SN(UREGPV_arr(i, UREGPV("NODENUM")))  'վ��
            ii = ii + 1 '�м���
        End If
    Next

    'UFLGת��ΪDM
    For i = 2 To UBound(UFLG_arr, 1)
  
            DM_arr(ii, DM("PN")) = UFLG_arr(i, UFLG("NAME")) '����
            DM_arr(ii, DM("DS")) = UFLG_arr(i, UFLG("PTDESC")) '������
            DM_arr(ii, DM("SN")) = SN(UFLG_arr(i, UFLG("NODENUM")))  'վ��
            DM_arr(ii, DM("E0")) = UFLG_arr(i, UFLG("STATETXT(0)")) '��0˵��
            DM_arr(ii, DM("E1")) = UFLG_arr(i, UFLG("STATETXT(1)")) '��0˵��
            DM_arr(ii, DM("DAMLV")) = DAMLV(UFLG_arr(i, UFLG("OFFNRMPR"))) '�������ȼ�OFFNRMPR��ӦDAMLV
            ii = ii + 1 '�м���

    Next
    
    
    '1-10--------------------ת��BOOL DS
    ii = 3 '�����п�ʼ
    'ULOGIC����FLתΪת��ΪBOOL��ÿ����������FL1~FL12
    For i = 2 To UBound(ULOGIC_arr, 1)
        For jj = 1 To 12
            DS_arr(ii, DS("PN")) = ULOGIC_arr(i, ULOGIC("NAME")) & "_FL" & jj '����
            DS_arr(ii, DS("DS")) = ULOGIC_arr(i, ULOGIC("PTDESC")) & "��־�Ĵ���" & jj '������
            DS_arr(ii, DS("SN")) = SN(ULOGIC_arr(i, ULOGIC("NODENUM")))  'վ��
            ii = ii + 1 '�м���
        Next
    Next
     'UREGPV����TOTALIZRתΪת��ΪBOOL
    For i = 2 To UBound(UREGPV_arr, 1)
        If UREGPV_arr(i, UREGPV("PVALGID")) = "TOTALIZR" Then
            DS_arr(ii, DS("PN")) = UREGPV_arr(i, UREGPV("NAME")) & "_RS" '����
            DS_arr(ii, DS("DS")) = UREGPV_arr(i, UREGPV("PTDESC")) '������
            DS_arr(ii, DS("SN")) = SN(UREGPV_arr(i, UREGPV("NODENUM")))  'վ��
            ii = ii + 1 '�м���
        End If
    Next
     
    '1-11-----ת��VAL2��MOT2
    ii = 3 '�����п�ʼ
    jj = 3 '�����п�ʼ
    'UDCת��ΪVAL2��MOT2
    For i = 2 To UBound(UDC_arr, 1)
        If UDC_arr(i, UDC("M6BlockType")) = "VAL2" Then
            VAL2_arr(ii, VAL2("PN")) = UDC_arr(i, UDC("NAME"))  '����
            VAL2_arr(ii, VAL2("DS")) = UDC_arr(i, UDC("PTDESC")) '������
            VAL2_arr(ii, VAL2("SN")) = SN(UDC_arr(i, UDC("NODENUM")))  'վ��
            VAL2_arr(ii, VAL2("ONDESC")) = UDC_arr(i, UDC("STATETXT(1)"))  '��/������
            VAL2_arr(ii, VAL2("OFDESC")) = UDC_arr(i, UDC("STATETXT(0)"))  '��/ͣ����
            ii = ii + 1 '�м���
        End If
        
        If UDC_arr(i, UDC("M6BlockType")) = "MOT2" Then
            MOT2_arr(jj, MOT2("PN")) = UDC_arr(i, UDC("NAME"))  '����
            MOT2_arr(jj, MOT2("DS")) = UDC_arr(i, UDC("PTDESC")) '������
            MOT2_arr(jj, MOT2("SN")) = SN(UDC_arr(i, UDC("NODENUM")))  'վ��
            MOT2_arr(jj, MOT2("ONDESC")) = UDC_arr(i, UDC("STATETXT(1)"))  '��/������
            MOT2_arr(jj, MOT2("OFDESC")) = UDC_arr(i, UDC("STATETXT(0)"))  '��/ͣ����
            jj = jj + 1 '�м���
        End If
    Next
    
     '1-12-----ת��UTIM
    ii = 3 '�����п�ʼ
    For i = 2 To UBound(UTIM_arr, 1)

            HTIMER_arr(ii, HTIMER("PN")) = UTIM_arr(i, UTIM("NAME"))  '����
            HTIMER_arr(ii, HTIMER("DS")) = UTIM_arr(i, UTIM("PTDESC")) '������
            HTIMER_arr(ii, HTIMER("SN")) = SN(UTIM_arr(i, UTIM("NODENUM")))  'վ��
            HTIMER_arr(ii, HTIMER("UT")) = UTIM_arr(i, UTIM("EUDESC")) '��λ
 
            'TIMEBASE:BOOL:=FALSE;(*SPʱ�����٣�0-�� 1-����*)
            'SP:WORD:=0;(*�趨ʱ��*)
            'RTSTIME01:RTSTIME;
            'STARTTIME:DWORD:=0;
            'RTSTIME02:RTSTIME;
            'CURTIME:DWORD:=0;
            'PRECOMM:BYTE:=0;
            'TEMSP:WORD:=0;(*�趨ʱ��*)
            'SPC:DWORD:=0;
            'SFLAG:BOOL:=FALSE;
            'TFLAG:WORD:=0;
            'TS:REAL:=0;(*�ɼ����� MS*)
            
            ConvDic.RemoveAll: ConvDic.Add "SECONDS", "0": ConvDic.Add "MINUTES", "1" 'SPʱ�����٣�0-�� 1-����
            HTIMER_arr(ii, HTIMER("TIMEBASE")) = ConvDic(UTIM_arr(i, UTIM("TIMEBASE")))
            
            HTIMER_arr(ii, HTIMER("SP")) = UTIM_arr(i, UTIM("SP")) 'SPʱ�����٣�0-�� 1-����
            
            
 
            ii = ii + 1 '�м���

    Next
    
    '2---------------------------------------------------------------����д����ǰ������
    
    '2-01------ɾ���ɱ����±�-AI
    Application.DisplayAlerts = False '�ر�ɾ����������ʾ��
    For Each sht In Workbooks(wb_name).Worksheets
        If sht.NAME = "AI" Then
            sht.Delete
        End If
    Next
    
    Sheets.Add After:=ActiveSheet
    ActiveSheet.NAME = "AI"
    Sheets("AI").Select
    
    With Sheets("AI")
        .Cells(1, 1).Resize(UBound(AI_arr(), 1), UBound(AI_arr(), 2)) = AI_arr
    End With
    '2-02------ɾ���ɱ����±�-AO
    Application.DisplayAlerts = False '�ر�ɾ����������ʾ��
    For Each sht In Workbooks(wb_name).Worksheets
        If sht.NAME = "AO" Then
            sht.Delete
        End If
    Next
    
    Sheets.Add After:=ActiveSheet
    ActiveSheet.NAME = "AO"
    Sheets("AO").Select
    
    With Sheets("AO")
        .Cells(1, 1).Resize(UBound(AO_arr(), 1), UBound(AO_arr(), 2)) = AO_arr
    End With
        
    '2-03------ɾ���ɱ����±�-DI
    Application.DisplayAlerts = False '�ر�ɾ����������ʾ��
    For Each sht In Workbooks(wb_name).Worksheets
        If sht.NAME = "DI" Then
            sht.Delete
        End If
    Next
    
    Sheets.Add After:=ActiveSheet
    ActiveSheet.NAME = "DI"
    Sheets("DI").Select
    
    With Sheets("DI")
        .Cells(1, 1).Resize(UBound(DI_arr(), 1), UBound(DI_arr(), 2)) = DI_arr
    End With
    
    '2-04------ɾ���ɱ����±�-DO
    Application.DisplayAlerts = False '�ر�ɾ����������ʾ��
    For Each sht In Workbooks(wb_name).Worksheets
        If sht.NAME = "DOV" Then
            sht.Delete
        End If
    Next
    
    Sheets.Add After:=ActiveSheet
    ActiveSheet.NAME = "DOV"
    Sheets("DOV").Select
    
    With Sheets("DOV")
        .Cells(1, 1).Resize(UBound(DOV_arr(), 1), UBound(DOV_arr(), 2)) = DOV_arr
    End With
    
    '2-05------ɾ���ɱ����±�-AS
    Application.DisplayAlerts = False '�ر�ɾ����������ʾ��
    For Each sht In Workbooks(wb_name).Worksheets
        If sht.NAME = "AS" Then
            sht.Delete
        End If
    Next
    
    Sheets.Add After:=ActiveSheet
    ActiveSheet.NAME = "AS"
    Sheets("AS").Select
    
    With Sheets("AS")
        .Cells(1, 1).Resize(UBound(REAL_arr(), 1), UBound(REAL_arr(), 2)) = REAL_arr
    End With
    
    '2-06------ɾ���ɱ����±�-AM
    Application.DisplayAlerts = False '�ر�ɾ����������ʾ��
    For Each sht In Workbooks(wb_name).Worksheets
        If sht.NAME = "AM" Then
            sht.Delete
        End If
    Next
    
    Sheets.Add After:=ActiveSheet
    ActiveSheet.NAME = "AM"
    Sheets("AM").Select
    
    With Sheets("AM")
        .Cells(1, 1).Resize(UBound(AM_arr(), 1), UBound(AM_arr(), 2)) = AM_arr
    End With
        
    '2-07------ɾ���ɱ����±�-PID
    Application.DisplayAlerts = False '�ر�ɾ����������ʾ��
    For Each sht In Workbooks(wb_name).Worksheets
        If sht.NAME = "PIDA" Then
            sht.Delete
        End If
    Next
    
    Sheets.Add After:=ActiveSheet
    ActiveSheet.NAME = "PIDA"
    Sheets("PIDA").Select
    
    With Sheets("PIDA")
        .Cells(1, 1).Resize(UBound(PIDA_arr(), 1), UBound(PIDA_arr(), 2)) = PIDA_arr
    End With
        
    '2-08------ɾ���ɱ����±�-MOT2
    Application.DisplayAlerts = False '�ر�ɾ����������ʾ��
    For Each sht In Workbooks(wb_name).Worksheets
        If sht.NAME = "MOT2" Then
            sht.Delete
        End If
    Next
    
    Sheets.Add After:=ActiveSheet
    ActiveSheet.NAME = "MOT2"
    Sheets("MOT2").Select
    
    With Sheets("MOT2")
        .Cells(1, 1).Resize(UBound(MOT2_arr(), 1), UBound(MOT2_arr(), 2)) = MOT2_arr
    End With
        
        '2-09------ɾ���ɱ����±�-VAL2
    Application.DisplayAlerts = False '�ر�ɾ����������ʾ��
    For Each sht In Workbooks(wb_name).Worksheets
        If sht.NAME = "VAL2" Then
            sht.Delete
        End If
    Next
    
    Sheets.Add After:=ActiveSheet
    ActiveSheet.NAME = "VAL2"
    Sheets("VAL2").Select
    
    With Sheets("VAL2")
        .Cells(1, 1).Resize(UBound(VAL2_arr(), 1), UBound(VAL2_arr(), 2)) = VAL2_arr
    End With
        
        
    '2-10------ɾ���ɱ����±�-MAN
    Application.DisplayAlerts = False '�ر�ɾ����������ʾ��
    For Each sht In Workbooks(wb_name).Worksheets
        If sht.NAME = "MAN" Then
            sht.Delete
        End If
    Next
    
    Sheets.Add After:=ActiveSheet
    ActiveSheet.NAME = "MAN"
    Sheets("MAN").Select
    
    With Sheets("MAN")
        .Cells(1, 1).Resize(UBound(MAN_arr(), 1), UBound(MAN_arr(), 2)) = MAN_arr
    End With
    
    '2-11------ɾ���ɱ����±�-SWITCH
    Application.DisplayAlerts = False '�ر�ɾ����������ʾ��
    For Each sht In Workbooks(wb_name).Worksheets
        If sht.NAME = "SWITCH" Then
            sht.Delete
        End If
    Next
    
    Sheets.Add After:=ActiveSheet
    ActiveSheet.NAME = "SWITCH"
    Sheets("SWITCH").Select
    
    With Sheets("SWITCH")
        .Cells(1, 1).Resize(UBound(SWITCH_arr(), 1), UBound(SWITCH_arr(), 2)) = SWITCH_arr
    End With
    
    '2-12------ɾ���ɱ����±�-ORSEL
    Application.DisplayAlerts = False '�ر�ɾ����������ʾ��
    For Each sht In Workbooks(wb_name).Worksheets
        If sht.NAME = "ORSEL" Then
            sht.Delete
        End If
    Next
    
    Sheets.Add After:=ActiveSheet
    ActiveSheet.NAME = "ORSEL"
    Sheets("ORSEL").Select
    
    With Sheets("ORSEL")
        .Cells(1, 1).Resize(UBound(ORSEL_arr(), 1), UBound(ORSEL_arr(), 2)) = ORSEL_arr
    End With
        
    '2-13------ɾ���ɱ����±�-MULDIV
    Application.DisplayAlerts = False '�ر�ɾ����������ʾ��
    For Each sht In Workbooks(wb_name).Worksheets
        If sht.NAME = "MULDIV" Then
            sht.Delete
        End If
    Next
    
    Sheets.Add After:=ActiveSheet
    ActiveSheet.NAME = "MULDIV"
    Sheets("MULDIV").Select
    
    With Sheets("MULDIV")
        .Cells(1, 1).Resize(UBound(MULDIV_arr(), 1), UBound(MULDIV_arr(), 2)) = MULDIV_arr
    End With
        
    '2-14------ɾ���ɱ����±�-SUMMER
    Application.DisplayAlerts = False '�ر�ɾ����������ʾ��
    For Each sht In Workbooks(wb_name).Worksheets
        If sht.NAME = "SUMMER" Then
            sht.Delete
        End If
    Next
    
    Sheets.Add After:=ActiveSheet
    ActiveSheet.NAME = "SUMMER"
    Sheets("SUMMER").Select
    
    With Sheets("SUMMER")
        .Cells(1, 1).Resize(UBound(SUMMER_arr(), 1), UBound(SUMMER_arr(), 2)) = SUMMER_arr
    End With
    
        '2-15------ɾ���ɱ����±�-FLOWCOMP
        Application.DisplayAlerts = False '�ر�ɾ����������ʾ��
        For Each sht In Workbooks(wb_name).Worksheets
           If sht.NAME = "FLOWCOMP" Then
               sht.Delete
           End If
        Next
        Sheets.Add After:=ActiveSheet
        ActiveSheet.NAME = "FLOWCOMP"
    
        Sheets("FLOWCOMP").Select
        With Sheets("FLOWCOMP")
            .Cells(1, 1).Resize(UBound(FLOWCOMP_arr(), 1), UBound(FLOWCOMP_arr(), 2)) = FLOWCOMP_arr
        End With
    
'        '2-16------ɾ���ɱ����±�-GENLIN
'        Application.DisplayAlerts = False '�ر�ɾ����������ʾ��
'        For Each sht In Workbooks(wb_name).Worksheets
'           If sht.NAME = "GENLIN" Then
'               sht.Delete
'           End If
'        Next
'        Sheets.Add After:=ActiveSheet
'        ActiveSheet.NAME = "GENLIN"
'
'        Sheets("GENLIN").Select
'        With Sheets("GENLIN")
'            .Cells(1, 1).Resize(UBound(GENLIN_arr(), 1), UBound(GENLIN_arr(), 2)) = GENLIN_arr
'        End With
    
        '2-16------ɾ���ɱ����±�-ONEFOLD
        Application.DisplayAlerts = False '�ر�ɾ����������ʾ��
        For Each sht In Workbooks(wb_name).Worksheets
           If sht.NAME = "ONEFOLD" Then
               sht.Delete
           End If
        Next
        Sheets.Add After:=ActiveSheet
        ActiveSheet.NAME = "ONEFOLD"

        Sheets("ONEFOLD").Select
        With Sheets("ONEFOLD")
            .Cells(1, 1).Resize(UBound(ONEFOLD_arr(), 1), UBound(ONEFOLD_arr(), 2)) = ONEFOLD_arr
        End With
    
    
        '2-17------ɾ���ɱ����±�-HILOAVG
        Application.DisplayAlerts = False '�ر�ɾ����������ʾ��
        For Each sht In Workbooks(wb_name).Worksheets
           If sht.NAME = "HILOAVG" Then
               sht.Delete
           End If
        Next
        Sheets.Add After:=ActiveSheet
        ActiveSheet.NAME = "HILOAVG"
    
        Sheets("HILOAVG").Select
        With Sheets("HILOAVG")
            .Cells(1, 1).Resize(UBound(HILOAVG_arr(), 1), UBound(HILOAVG_arr(), 2)) = HILOAVG_arr
        End With
    
        '2-18------ɾ���ɱ����±�-MIDOF3
        Application.DisplayAlerts = False '�ر�ɾ����������ʾ��
        For Each sht In Workbooks(wb_name).Worksheets
           If sht.NAME = "MIDOF3" Then
               sht.Delete
           End If
        Next
        Sheets.Add After:=ActiveSheet
        ActiveSheet.NAME = "MIDOF3"
    
        Sheets("MIDOF3").Select
        With Sheets("MIDOF3")
            .Cells(1, 1).Resize(UBound(MIDOF3_arr(), 1), UBound(MIDOF3_arr(), 2)) = MIDOF3_arr
        End With
    
'        '2-19------ɾ���ɱ����±�-TOTALIZR
'        Application.DisplayAlerts = False '�ر�ɾ����������ʾ��
'        For Each sht In Workbooks(wb_name).Worksheets
'           If sht.NAME = "TOTALIZR" Then
'               sht.Delete
'           End If
'        Next
'        Sheets.Add After:=ActiveSheet
'        ActiveSheet.NAME = "TOTALIZR"
'
'        Sheets("TOTALIZR").Select
'        With Sheets("TOTALIZR")
'            .Cells(1, 1).Resize(UBound(TOTALIZR_arr(), 1), UBound(TOTALIZR_arr(), 2)) = TOTALIZR_arr
'        End With
    
        '2-20------ɾ���ɱ����±�-VDTLDLAG
        Application.DisplayAlerts = False '�ر�ɾ����������ʾ��
        For Each sht In Workbooks(wb_name).Worksheets
           If sht.NAME = "VDTLDLAG" Then
               sht.Delete
           End If
        Next
        Sheets.Add After:=ActiveSheet
        ActiveSheet.NAME = "VDTLDLAG"
    
        Sheets("VDTLDLAG").Select
        With Sheets("VDTLDLAG")
            .Cells(1, 1).Resize(UBound(VDTLDLAG_arr(), 1), UBound(VDTLDLAG_arr(), 2)) = VDTLDLAG_arr
        End With
    
        '2-20_1------ɾ���ɱ����±�-FLOWSUM
        Application.DisplayAlerts = False '�ر�ɾ����������ʾ��
        For Each sht In Workbooks(wb_name).Worksheets
           If sht.NAME = "FLOWSUM" Then
               sht.Delete
           End If
        Next
        Sheets.Add After:=ActiveSheet
        ActiveSheet.NAME = "FLOWSUM"
    
        Sheets("FLOWSUM").Select
        With Sheets("FLOWSUM")
            .Cells(1, 1).Resize(UBound(FLOWSUM_arr(), 1), UBound(FLOWSUM_arr(), 2)) = FLOWSUM_arr
        End With
    
    '2-21------ɾ���ɱ����±�-DM
    Application.DisplayAlerts = False '�ر�ɾ����������ʾ��
    For Each sht In Workbooks(wb_name).Worksheets
        If sht.NAME = "DM" Then
            sht.Delete
        End If
    Next
    
    Sheets.Add After:=ActiveSheet
    ActiveSheet.NAME = "DM"
    Sheets("DM").Select
    
    With Sheets("DM")
        .Cells(1, 1).Resize(UBound(DM_arr(), 1), UBound(DM_arr(), 2)) = DM_arr
    End With
        
    '2-22------ɾ���ɱ����±�-DS
    Application.DisplayAlerts = False '�ر�ɾ����������ʾ��
    For Each sht In Workbooks(wb_name).Worksheets
        If sht.NAME = "DS" Then
            sht.Delete
        End If
    Next
    
    Sheets.Add After:=ActiveSheet
    ActiveSheet.NAME = "DS"
    Sheets("DS").Select
    
    With Sheets("DS")
        .Cells(1, 1).Resize(UBound(DS_arr(), 1), UBound(DS_arr(), 2)) = DS_arr
    End With
        
   '2-23------ɾ���ɱ����±�-SUMMER_CTRL
    Application.DisplayAlerts = False '�ر�ɾ����������ʾ��
    For Each sht In Workbooks(wb_name).Worksheets
        If sht.NAME = "SUMMER_CTRL" Then
            sht.Delete
        End If
    Next
    
    Sheets.Add After:=ActiveSheet
    ActiveSheet.NAME = "SUMMER_CTRL"
    Sheets("SUMMER_CTRL").Select
    
    With Sheets("SUMMER_CTRL")
        .Cells(1, 1).Resize(UBound(SUMMER_CTRL_arr(), 1), UBound(SUMMER_CTRL_arr(), 2)) = SUMMER_CTRL_arr
    End With
    
   '2-23------ɾ���ɱ����±�-TIMER
    Application.DisplayAlerts = False '�ر�ɾ����������ʾ��
    For Each sht In Workbooks(wb_name).Worksheets
        If sht.NAME = "TIMER" Then
            sht.Delete
        End If
    Next
    
    Sheets.Add After:=ActiveSheet
    ActiveSheet.NAME = "TIMER"
    Sheets("TIMER").Select
    
    With Sheets("TIMER")
        .Cells(1, 1).Resize(UBound(HTIMER_arr(), 1), UBound(HTIMER_arr(), 2)) = HTIMER_arr
    End With
    
    '3---------------------------------------------------------------��ȡ��ǰĿ¼���ļ�����������
    CC = PATH & "\Դ�ļ�\ͨ�ð���̬���ݿ�.xlsx"                              'ģ���ļ�
    ftime = Replace(Replace(Replace(VBA.Now, "/", "_"), " ", "_"), ":", "_") 'ʱ��
    fname = "ͨ�ð���̬���ݿ�"
    ccb = PATH & "\�����ļ�\" & "ͨ�ð���̬���ݿ�" & ftime & ".xlsx"   '���ļ���ʱ��
    FileCopy CC, ccb
    
    '�����ݿ���д����
    Workbooks.Open (PATH & "\�����ļ�\" & fname & ftime & ".xlsx")
    '��ĿBOM
    project_sjk = fname & ftime & ".xlsx"
    
    Workbooks(project_sjk).Sheets("AI").Cells(1, 1).Resize(UBound(AI_arr(), 1), UBound(AI_arr(), 2)) = AI_arr
    Workbooks(project_sjk).Sheets("AO").Cells(1, 1).Resize(UBound(AO_arr(), 1), UBound(AO_arr(), 2)) = AO_arr
    Workbooks(project_sjk).Sheets("DI").Cells(1, 1).Resize(UBound(DI_arr(), 1), UBound(DI_arr(), 2)) = DI_arr
    Workbooks(project_sjk).Sheets("DOV").Cells(1, 1).Resize(UBound(DOV_arr(), 1), UBound(DOV_arr(), 2)) = DOV_arr
    Workbooks(project_sjk).Sheets("AM").Cells(1, 1).Resize(UBound(AM_arr(), 1), UBound(AM_arr(), 2)) = AM_arr
    Workbooks(project_sjk).Sheets("AS").Cells(1, 1).Resize(UBound(REAL_arr(), 1), UBound(REAL_arr(), 2)) = REAL_arr
    Workbooks(project_sjk).Sheets("PIDA").Cells(1, 1).Resize(UBound(PIDA_arr(), 1), UBound(PIDA_arr(), 2)) = PIDA_arr
    Workbooks(project_sjk).Sheets("VAL2").Cells(1, 1).Resize(UBound(VAL2_arr(), 1), UBound(VAL2_arr(), 2)) = VAL2_arr
    Workbooks(project_sjk).Sheets("MOT2").Cells(1, 1).Resize(UBound(MOT2_arr(), 1), UBound(MOT2_arr(), 2)) = MOT2_arr
    Workbooks(project_sjk).Sheets("MAN").Cells(1, 1).Resize(UBound(MAN_arr(), 1), UBound(MAN_arr(), 2)) = MAN_arr
    Workbooks(project_sjk).Sheets("SWITCH").Cells(1, 1).Resize(UBound(SWITCH_arr(), 1), UBound(SWITCH_arr(), 2)) = SWITCH_arr
    Workbooks(project_sjk).Sheets("ORSEL").Cells(1, 1).Resize(UBound(ORSEL_arr(), 1), UBound(ORSEL_arr(), 2)) = ORSEL_arr
    Workbooks(project_sjk).Sheets("MULDIV").Cells(1, 1).Resize(UBound(MULDIV_arr(), 1), UBound(MULDIV_arr(), 2)) = MULDIV_arr
    Workbooks(project_sjk).Sheets("SUMMER").Cells(1, 1).Resize(UBound(SUMMER_arr(), 1), UBound(SUMMER_arr(), 2)) = SUMMER_arr
    
    Workbooks(project_sjk).Sheets("FLOWCOMP").Cells(1, 1).Resize(UBound(FLOWCOMP_arr(), 1), UBound(FLOWCOMP_arr(), 2)) = FLOWCOMP_arr
'    Workbooks(project_sjk).Sheets("GENLIN").Cells(1, 1).Resize(UBound(GENLIN_arr(), 1), UBound(GENLIN_arr(), 2)) = GENLIN_arr
    Workbooks(project_sjk).Sheets("ONEFOLD").Cells(1, 1).Resize(UBound(ONEFOLD_arr(), 1), UBound(ONEFOLD_arr(), 2)) = ONEFOLD_arr
    Workbooks(project_sjk).Sheets("HILOAVG").Cells(1, 1).Resize(UBound(HILOAVG_arr(), 1), UBound(HILOAVG_arr(), 2)) = HILOAVG_arr
    Workbooks(project_sjk).Sheets("MIDOF3").Cells(1, 1).Resize(UBound(MIDOF3_arr(), 1), UBound(MIDOF3_arr(), 2)) = MIDOF3_arr
'    Workbooks(project_sjk).Sheets("TOTALIZR").Cells(1, 1).Resize(UBound(TOTALIZR_arr(), 1), UBound(TOTALIZR_arr(), 2)) = TOTALIZR_arr
    Workbooks(project_sjk).Sheets("VDTLDLAG").Cells(1, 1).Resize(UBound(VDTLDLAG_arr(), 1), UBound(VDTLDLAG_arr(), 2)) = VDTLDLAG_arr
    Workbooks(project_sjk).Sheets("FLOWSUM").Cells(1, 1).Resize(UBound(FLOWSUM_arr(), 1), UBound(FLOWSUM_arr(), 2)) = FLOWSUM_arr
    Workbooks(project_sjk).Sheets("DM").Cells(1, 1).Resize(UBound(DM_arr(), 1), UBound(DM_arr(), 2)) = DM_arr
    Workbooks(project_sjk).Sheets("DS").Cells(1, 1).Resize(UBound(DS_arr(), 1), UBound(DS_arr(), 2)) = DS_arr
    Workbooks(project_sjk).Sheets("SUMMER_CTRL").Cells(1, 1).Resize(UBound(SUMMER_CTRL_arr(), 1), UBound(SUMMER_CTRL_arr(), 2)) = SUMMER_CTRL_arr
    Workbooks(project_sjk).Sheets("TIMER").Cells(1, 1).Resize(UBound(HTIMER_arr(), 1), UBound(HTIMER_arr(), 2)) = HTIMER_arr
    Workbooks(project_sjk).Save
    Workbooks(project_sjk).Close
    
    
    '4---------------------------------------------------------------������ҳ
    Workbooks(wb_name).Activate
    Sheets("main").Select

End Sub

'-----------------------------------------------------------------------------------------------------------
'Purpose: ��ʼ��ģ���ֵַ - wb
'History: 12-26-2019
'-----------------------------------------------------------------------------------------------------------
Sub InitDN()
    Dim aiIndex As Integer, aoIndex As Integer, diIndex As Integer, doIndex As Integer, DN As Integer
    aiIndex = 1
    aoIndex = 1
    diIndex = 1
    doIndex = 1
    
    Dim IOMTYPE As String, IOMTYPE_Value As String
    Dim IOREDOPT As String, IOREDOPT_Value As String
    Dim NODENUM As String 'HNվ�� 09 10 13 15
    
    '����UPMCONFIG�У���2~5��
    For Row = 2 To 5
        'ģ���ַ��10��ʼ
        DN = 10
        'NODENUM
        NODENUM = UPMCONFIG_arr(Row, UPMCONFIG("NODENUM"))
        If Left(NODENUM, 1) = "0" Then
            NODENUM = Right(NODENUM, Len(NODENUM) - 1)
        End If
        
        'UPMCONFIG
        For Column = 1 To 20
            IOMTYPE = "IOMTYPE" & "(" & Column & ")"
            IOREDOPT = "IOREDOPT" & "(" & Column & ")"
            IOMTYPE_Value = UPMCONFIG_arr(Row, UPMCONFIG(IOMTYPE))
            IOREDOPT_Value = UPMCONFIG_arr(Row, UPMCONFIG(IOREDOPT))
            
            ' ��ǰ��������ģ�飬ģ���ַ����Ϊż��
            If IOREDOPT_Value = "REDUN" And DN Mod 2 = 1 Then
                DN = DN + 1
            End If
            
            If IOMTYPE_Value = "AO_16" Then
                For i = 2 To UBound(UAO_arr, 1)
                    If UAO_arr(i, UAO("NODENUM")) = NODENUM And UAO_arr(i, UAO("MODNUM")) = CStr(Column) Then
                        If UAO_arr(i, UAO("SLOTNUM")) <= 8 Then
                            AOArr(aoIndex).NODENUM = NODENUM
                            AOArr(aoIndex).index = Column
                            AOArr(aoIndex).NAME = UAO_arr(i, UAO("NAME"))
                            AOArr(aoIndex).DN = DN
                            aoIndex = aoIndex + 1
                        Else
                            AOArr(aoIndex).NODENUM = NODENUM
                            AOArr(aoIndex).index = Column
                            AOArr(aoIndex).NAME = UAO_arr(i, UAO("NAME"))
                            If IOREDOPT_Value = "REDUN" Then
                                AOArr(aoIndex).DN = DN + 2
                            Else
                                AOArr(aoIndex).DN = DN + 1
                            End If
                            
                            aoIndex = aoIndex + 1
                        End If
                    End If
                Next
                
                '����DNֵ
                If IOREDOPT_Value = "REDUN" Then
                    DN = DN + 4
                Else
                    DN = DN + 2
                End If
            ElseIf IOMTYPE_Value = "HLAI" Then
                For i = 2 To UBound(UAI_arr, 1)
                    If UAI_arr(i, UAI("NODENUM")) = NODENUM And UAI_arr(i, UAI("MODNUM")) = CStr(Column) Then
                        AIArr(aiIndex).NODENUM = NODENUM
                        AIArr(aiIndex).index = Column
                        AIArr(aiIndex).NAME = UAI_arr(i, UAI("NAME"))
                        AIArr(aiIndex).DN = DN
                        
                        aiIndex = aiIndex + 1
                    End If
                Next
                
                '����DNֵ
                If IOREDOPT_Value = "REDUN" Then
                    DN = DN + 2
                Else
                    DN = DN + 1
                End If
            ElseIf IOMTYPE_Value = "DI" Then
                For i = 2 To UBound(UDI_arr, 1)
                    If UDI_arr(i, UDI("NODENUM")) = NODENUM And UDI_arr(i, UDI("MODNUM")) = CStr(Column) Then
                        DIArr(diIndex).NODENUM = NODENUM
                        DIArr(diIndex).index = Column
                        DIArr(diIndex).NAME = UDI_arr(i, UDI("NAME"))
                        DIArr(diIndex).DN = DN
                        
                        diIndex = diIndex + 1
                    End If
                Next
                
                '����DNֵ
                If IOREDOPT_Value = "REDUN" Then
                    DN = DN + 2
                Else
                    DN = DN + 1
                End If
            ElseIf IOMTYPE_Value = "DO_32" Then
                For i = 2 To UBound(UDO_arr, 1)
                    If UDO_arr(i, UDO("NODENUM")) = NODENUM And UDO_arr(i, UDO("MODNUM")) = CStr(Column) Then
                        If UDO_arr(i, UDO("SLOTNUM")) <= 16 Then
                            DOArr(doIndex).NODENUM = NODENUM
                            DOArr(doIndex).index = Column
                            DOArr(doIndex).NAME = UDO_arr(i, UDO("NAME"))
                            DOArr(doIndex).DN = DN
                            doIndex = doIndex + 1
                        Else
                            DOArr(doIndex).NODENUM = NODENUM
                            DOArr(doIndex).index = Column
                            DOArr(doIndex).NAME = UDO_arr(i, UDO("NAME"))
                            If IOREDOPT_Value = "REDUN" Then
                                DOArr(doIndex).DN = DN + 2
                            Else
                                DOArr(doIndex).DN = DN + 1
                            End If
                            doIndex = doIndex + 1
                        End If
                    End If
                Next 'i
                
                '����DNֵ
                If IOREDOPT_Value = "REDUN" Then
                    DN = DN + 4
                Else
                    DN = DN + 2
                End If
            Else 'NONE������
            End If
        Next 'Column = 1 To 20
        
        'UPMCONFIG1
        For Column = 21 To 40
            IOMTYPE = "IOMTYPE" & "(" & Column & ")"
            IOREDOPT = "IOREDOPT" & "(" & Column & ")"
            IOMTYPE_Value = UPMCONFIG1_arr(Row, UPMCONFIG1(IOMTYPE))
            IOREDOPT_Value = UPMCONFIG1_arr(Row, UPMCONFIG1(IOREDOPT))
            
            ' ��ǰ��������ģ�飬ģ���ַ����Ϊż��
            If IOREDOPT_Value = "REDUN" And DN Mod 2 = 1 Then
                DN = DN + 1
            End If
            
            If IOMTYPE_Value = "AO_16" Then
                For i = 2 To UBound(UAO_arr, 1)
                    If UAO_arr(i, UAO("NODENUM")) = NODENUM And UAO_arr(i, UAO("MODNUM")) = CStr(Column) Then
                        If UAO_arr(i, UAO("SLOTNUM")) <= 8 Then
                            AOArr(aoIndex).NODENUM = NODENUM
                            AOArr(aoIndex).index = Column
                            AOArr(aoIndex).NAME = UAO_arr(i, UAO("NAME"))
                            AOArr(aoIndex).DN = DN
                            aoIndex = aoIndex + 1
                        Else
                            AOArr(aoIndex).NODENUM = NODENUM
                            AOArr(aoIndex).index = Column
                            AOArr(aoIndex).NAME = UAO_arr(i, UAO("NAME"))
                            If IOREDOPT_Value = "REDUN" Then
                                AOArr(aoIndex).DN = DN + 2
                            Else
                                AOArr(aoIndex).DN = DN + 1
                            End If
                            aoIndex = aoIndex + 1
                        End If
                    End If
                Next
                
                '����DNֵ
                If IOREDOPT_Value = "REDUN" Then
                    DN = DN + 4
                Else
                    DN = DN + 2
                End If
            ElseIf IOMTYPE_Value = "HLAI" Then
                For i = 2 To UBound(UAI_arr, 1)
                    If UAI_arr(i, UAI("NODENUM")) = NODENUM And UAI_arr(i, UAI("MODNUM")) = CStr(Column) Then
                        AIArr(aiIndex).NODENUM = NODENUM
                        AIArr(aiIndex).index = Column
                        AIArr(aiIndex).NAME = UAI_arr(i, UAI("NAME"))
                        AIArr(aiIndex).DN = DN

                        aiIndex = aiIndex + 1
                    End If
                Next
                
                '����DNֵ
                If IOREDOPT_Value = "REDUN" Then
                    DN = DN + 2
                Else
                    DN = DN + 1
                End If
            ElseIf IOMTYPE_Value = "DI" Then
                For i = 2 To UBound(UDI_arr, 1)
                    If UDI_arr(i, UDI("NODENUM")) = NODENUM And UDI_arr(i, UDI("MODNUM")) = CStr(Column) Then
                        DIArr(diIndex).NODENUM = NODENUM
                        DIArr(diIndex).index = Column
                        DIArr(diIndex).NAME = UDI_arr(i, UDI("NAME"))
                        DIArr(diIndex).DN = DN

                        diIndex = diIndex + 1
                    End If
                Next
                
                '����DNֵ
                If IOREDOPT_Value = "REDUN" Then
                    DN = DN + 2
                Else
                    DN = DN + 1
                End If
            ElseIf IOMTYPE_Value = "DO_32" Then
                For i = 2 To UBound(UDO_arr, 1)
                    If UDO_arr(i, UDO("NODENUM")) = NODENUM And UDO_arr(i, UDO("MODNUM")) = CStr(Column) Then
                        If UDO_arr(i, UDO("SLOTNUM")) <= 16 Then
                            DOArr(doIndex).NODENUM = NODENUM
                            DOArr(doIndex).index = Column
                            DOArr(doIndex).NAME = UDO_arr(i, UDO("NAME"))
                            DOArr(doIndex).DN = DN
                            
                            doIndex = doIndex + 1
                        Else
                            DOArr(doIndex).NODENUM = NODENUM
                            DOArr(doIndex).index = Column
                            DOArr(doIndex).NAME = UDO_arr(i, UDO("NAME"))
                            If IOREDOPT_Value = "REDUN" Then
                                DOArr(doIndex).DN = DN + 2
                            Else
                                DOArr(doIndex).DN = DN + 1
                            End If
                            
                            doIndex = doIndex + 1
                        End If
                    End If
                Next 'i = 2 To UBound(UDO_arr, 1)
                
                '����DNֵ
                If IOREDOPT_Value = "REDUN" Then
                    DN = DN + 4
                Else
                    DN = DN + 2
                End If
            Else 'NONE������
            End If
        Next 'Column = 21 To 40
    Next 'Row = 2 To 5

End Sub

'-----------------------------------------------------------------------------------------------------------
'Purpose: �����帳ֵ - wb
'History: 12-26-2019
'-----------------------------------------------------------------------------------------------------------
Function setClipBoard(str)
    Set WshShell = CreateObject("WScript.Shell")
    Set oExec = WshShell.Exec("clip")
    Set oIn = oExec.stdIn
    oIn.WriteLine str
    oIn.Close
End Function

'-----------------------------------------------------------------------------------------------------------
'Purpose: ����ģ���ֵַ - wb
'History: 12-26-2019
'-----------------------------------------------------------------------------------------------------------
Sub SetDN()
    For index = 1 To UBound(AI_arr, 1)
        For arrIndex = 1 To UBound(AIArr, 1)
            If AI_arr(index, AI("PN")) <> "" And AI_arr(index, AI("PN")) = AIArr(arrIndex).NAME Then
                AI_arr(index, AI("DN")) = AIArr(arrIndex).DN
            End If
        Next
    Next
    
    For index = 1 To UBound(AO_arr, 1)
        For arrIndex = 1 To UBound(AOArr, 1)
            If AO_arr(index, AO("PN")) <> "" And AO_arr(index, AO("PN")) = AOArr(arrIndex).NAME Then
                AO_arr(index, AO("DN")) = AOArr(arrIndex).DN
            End If
        Next
    Next
    
    For index = 1 To UBound(DI_arr, 1)
        For arrIndex = 1 To UBound(DIArr, 1)
            If DI_arr(index, DI("PN")) <> "" And DI_arr(index, DI("PN")) = DIArr(arrIndex).NAME Then
                DI_arr(index, DI("DN")) = DIArr(arrIndex).DN
            End If
        Next
    Next
    
    For index = 1 To UBound(DOV_arr, 1)
        For arrIndex = 1 To UBound(DOArr, 1)
            If DOV_arr(index, DOV("PN")) <> "" And DOV_arr(index, DOV("PN")) = DOArr(arrIndex).NAME Then
                DOV_arr(index, DOV("DN")) = DOArr(arrIndex).DN
            End If
        Next
    Next
End Sub
