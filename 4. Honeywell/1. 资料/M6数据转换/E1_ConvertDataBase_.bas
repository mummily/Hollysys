Attribute VB_Name = "E1_ConvertDataBase_"
'ver20190814_by cjt
'ת��HN���ݿ⵽M6���ݿ�

Sub E1_ConvertDataBase()
Dim i, j, k, l, m, N As Integer 'HN���ݿ�ѭ������
Dim ii, jj, kk, ll, mm, nn As Integer 'M6���ݿ�ѭ������
Dim i1, i2, i3, i4, i5, i6 As Integer 'M6���ݿ�ѭ������
Dim J1, j2, j3, j4, j5, j6 As Integer 'M6���ݿ�ѭ������
Dim AI_cn As Integer 'M6���ݿ�AIͨ������
Dim AO_cn As Integer 'M6���ݿ�AOͨ������
Dim cn As Integer 'ͨ������
Dim DN As Integer '�豸�ż���
Dim cn_arr(10 To 30) As Integer  'ͨ������
Dim cnIsRD_arr(10 To 30) As String  'ͨ����������
Dim dn_arr(10 To 30) As Integer '�豸�ż���
Dim dn_js(10 To 30) As Boolean '�豸�ż���

Dim SN_i As Integer 'վ��
Dim AO_i, AI_i, DO_i, DI_i As Integer '������

Dim ThisChalRD As Variant
Dim NextChalRD As Variant
Dim LastChalRD As Variant

Dim ThisDN As Variant
Dim NextDN As Variant
Dim LastDN As Variant
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
        '��ʼ�豸��
        DN = 9
'1)-----------------------------------------------------------------ת��AO--------------------------------------------------------------------------------------------
        For i = 2 To UBound(UAO_arr, 1)
                
                'վ����ͬ
                If SN(UAO_arr(i, UAO("NODENUM"))) = SN_i Then
                        
                        '---------------------------------------------------------------------
                        '��ȡ������Ϣ
                        ThisChalRD = RD(UAO_arr(i, UAO("NODENUM")), UAO_arr(i, UAO("MODNUM")))
                        '��ȡ�豸��ַ��Ϣ
                        ThisDN = UAO_arr(i, UAO("MODNUM"))
                        '---------------------------------------------------------------------
                        
                        '---------------------------------------------------------------------
                        '�����豸������
                        If ThisDN <> LastDN Then
                           If LastChalRD = "1" And DN <> 9 Then
                              DN = DN + 2
                           Else
                              DN = DN + 1
                           End If
                           
                           If ThisChalRD = "1" And DN Mod 2 <> 0 Then
                               DN = DN + 1
                           End If
                        End If
                        
    
                        '---------------------------------------------------------------------
                        
                        
                        AO_arr(AO_i, AO("PN")) = UAO_arr(i, UAO("NAME")) '����
                        AO_arr(AO_i, AO("DS")) = UAO_arr(i, UAO("PTDESC")) '������
                        AO_arr(AO_i, AO("MD")) = "0" '����
                        AO_arr(AO_i, AO("MU")) = "100" '����
                        AO_arr(AO_i, AO("UT")) = "%" '����
                        AO_arr(AO_i, AO("SN")) = SN_i  'վ��
                        AO_arr(AO_i, AO("MT")) = "K-AO01" 'ģ������
                        If UAO_arr(i, UAO("SLOTNUM")) = 9 Then
                           DN = DN + 2
                        End If
                        AO_arr(AO_i, AO("DN")) = DN '�豸��
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
                        '��¼�豸��ַ��Ϣ
                        LastDN = ThisDN
                        '---------------------------------------------------------------------
                        
                        AO_arr(AO_i, AO("RD")) = ThisChalRD '�Ƿ�����
                        
                        'M6���ݿ�
                        AO_i = AO_i + 1 '�м���
                End If
                        
                        
         Next i
         
'2)-----------------------------------------------------------------ת��AI--------------------------------------------------------------------------------------------

        For i = 2 To UBound(UAI_arr, 1)
                        
             'վ����ͬ
            If SN(UAI_arr(i, UAI("NODENUM"))) = SN_i Then
                        
                            
                    '---------------------------------------------------------------------
                    '��ȡ������Ϣ
                    ThisChalRD = RD(UAI_arr(i, UAI("NODENUM")), UAI_arr(i, UAI("MODNUM")))
                    '��ȡ�豸��ַ��Ϣ
                    ThisDN = UAI_arr(i, UAI("MODNUM"))
                    '---------------------------------------------------------------------
                    
                    '---------------------------------------------------------------------
                    '�����豸������
                    If ThisDN <> LastDN Then
                       If LastChalRD = "1" Then
                          DN = DN + 2
                       Else
                          DN = DN + 1
                       End If
                       
                       If ThisChalRD = "1" And DN Mod 2 <> 0 Then
                           DN = DN + 1
                       End If
                    End If
    
                    '---------------------------------------------------------------------
                    AI_arr(AI_i, AI("PN")) = UAI_arr(i, UAI("NAME")) '����
                    AI_arr(AI_i, AI("DS")) = UAI_arr(i, UAI("PTDESC")) '������
                    AI_arr(AI_i, AI("MD")) = UAI_arr(i, UAI("PVEULO")) '����
                    AI_arr(AI_i, AI("MU")) = UAI_arr(i, UAI("PVEUHI")) '����
                    AI_arr(AI_i, AI("UT")) = UAI_arr(i, UAI("EUDESC")) '����
                    AI_arr(AI_i, AI("OF")) = DelDit(UAI_arr(i, UAI("PVFORMAT"))) 'С��λ��
                    AI_arr(AI_i, AI("SN")) = SN(UAI_arr(i, UAI("NODENUM"))) 'վ��
                    AI_arr(AI_i, AI("MT")) = "K-AIH03" 'ģ������
                    AI_arr(AI_i, AI("DN")) = DN
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
    
                    '---------------------------------------------------------------------
                    '��¼������Ϣ
                    LastChalRD = ThisChalRD
                    '��¼�豸��ַ��Ϣ
                    LastDN = ThisDN
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
                    '��ȡ�豸��ַ��Ϣ
                    ThisDN = UDI_arr(i, UDI("MODNUM"))
                    '---------------------------------------------------------------------
                    
                    '---------------------------------------------------------------------
                    '�����豸������
                    If ThisDN <> LastDN Then
                       If LastChalRD = "1" Then
                          DN = DN + 2
                       Else
                          DN = DN + 1
                       End If
                       
                       If ThisChalRD = "1" And DN Mod 2 <> 0 Then
                           DN = DN + 1
                       End If
                    End If
    
                    '---------------------------------------------------------------------
                    DI_arr(DI_i, DI("PN")) = UDI_arr(i, UDI("NAME")) '����
                    DI_arr(DI_i, DI("DS")) = UDI_arr(i, UDI("PTDESC")) '������
                    DI_arr(DI_i, DI("SN")) = SN(UDI_arr(i, UDI("NODENUM"))) 'վ��
                    DI_arr(DI_i, DI("MT")) = "K-DI03" 'ģ������
                    DI_arr(DI_i, DI("DN")) = DN '�豸��
                    DI_arr(DI_i, DI("CN")) = UDI_arr(i, UDI("SLOTNUM")) 'ͨ����
            
                    If UDI_arr(i, UDI("INPTDIR")) = "REVERSE" Then '���뷴��
                       DI_arr(DI_i, DI("REVOPT")) = "1"
                    Else
                       DI_arr(DI_i, DI("REVOPT")) = "0"
                    End If
            
                    DI_arr(DI_i, DI("DAMOPT")) = DAMOPT(UDI_arr(i, UDI("ALMOPT")), UDI_arr(i, UDI("PVNORMAL"))) '��������
            
                    DI_arr(DI_i, DI("DAMLV")) = DAMLV(UDI_arr(i, UDI("OFFNRMPR"))) '�������ȼ�OFFNRMPR��ӦDAMLV
            
                   
                    DI_arr(DI_i, DI("RD")) = ThisChalRD '�Ƿ��������վ���豸�Ų�ѯ
                    
                     '---------------------------------------------------------------------
                    '��¼������Ϣ
                    LastChalRD = ThisChalRD
                    '��¼�豸��ַ��Ϣ
                    LastDN = ThisDN
                    '---------------------------------------------------------------------
                    
                    'M6���ݿ�
                    DI_i = DI_i + 1 '�м���
            
            End If
            
        Next i
       
       
'3)-----------------------------------------------------------------ת��DO--------------------------------------------------------------------------------------------
        For i = 2 To UBound(UDO_arr, 1)
        
             'վ����ͬ
            If SN(UDO_arr(i, UDO("NODENUM"))) = SN_i Then
            
                    '---------------------------------------------------------------------
                    '��ȡ������Ϣ
                    ThisChalRD = RD(UDO_arr(i, UDO("NODENUM")), UDO_arr(i, UDO("MODNUM")))
                    '��ȡ�豸��ַ��Ϣ
                    ThisDN = UDO_arr(i, UDO("MODNUM"))
                    '---------------------------------------------------------------------
                    
                    '---------------------------------------------------------------------
                    '�����豸������
                    If ThisDN <> LastDN Then
                       If LastChalRD = "1" Then
                          DN = DN + 2
                       Else
                          DN = DN + 1
                       End If
                       
                       If ThisChalRD = "1" And DN Mod 2 <> 0 Then
                           DN = DN + 1
                       End If
                    End If
    
                    '---------------------------------------------------------------------
        
                    DOV_arr(DO_i, DOV("PN")) = UDO_arr(i, UDO("NAME")) '����
                    DOV_arr(DO_i, DOV("DS")) = UDO_arr(i, UDO("PTDESC")) '������
                    DOV_arr(DO_i, DOV("SN")) = SN(UDO_arr(i, UDO("NODENUM"))) 'վ��
                    DOV_arr(DO_i, DOV("MT")) = "K-DO01" 'ģ������
                    If UDO_arr(i, UDO("SLOTNUM")) = 17 Then
                       DN = DN + 2
                    End If
                    DOV_arr(DO_i, DOV("DN")) = DN '�豸��
                    If UDO_arr(i, UDO("SLOTNUM")) <= 16 Then
                    DOV_arr(DO_i, DOV("CN")) = UDO_arr(i, UDO("SLOTNUM")) 'ͨ����
                    Else
                    DOV_arr(DO_i, DOV("CN")) = UDO_arr(i, UDO("SLOTNUM")) - 16 'ͨ����
                    End If
                   
                    DOV_arr(DO_i, DOV("RD")) = ThisChalRD '�Ƿ��������վ���豸�Ų�ѯ
                    
                     '---------------------------------------------------------------------
                    '��¼������Ϣ
                    LastChalRD = ThisChalRD
                    '��¼�豸��ַ��Ϣ
                    LastDN = ThisDN
                    '---------------------------------------------------------------------
                    
                    'M6���ݿ�
                    DO_i = DO_i + 1 '�м���
                    
            End If
        
        Next
'

Next SN_i



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
'UREGPVת��ΪREAL
For i = 2 To UBound(UREGPV_arr, 1)
        REAL_arr(ii, REAL("PN")) = UREGPV_arr(i, UREGPV("NAME")) '����
        REAL_arr(ii, REAL("DS")) = UREGPV_arr(i, UREGPV("PTDESC")) '������
        REAL_arr(ii, REAL("DT")) = "REAL" '��������
        REAL_arr(ii, REAL("MD")) = UREGPV_arr(i, UREGPV("PVEULO")) '����
        REAL_arr(ii, REAL("MU")) = UREGPV_arr(i, UREGPV("PVEUHI")) '����
        REAL_arr(ii, REAL("UT")) = UREGPV_arr(i, UREGPV("EUDESC")) '����
        REAL_arr(ii, REAL("OF")) = DelDit(UREGPV_arr(i, UREGPV("PVFORMAT"))) 'С��λ��
        REAL_arr(ii, REAL("SN")) = SN(UREGPV_arr(i, UREGPV("NODENUM")))  'վ��
        ii = ii + 1 '�м���
Next

'ULOGIC����NNתΪת��ΪREAL��ÿ����������NN1~NN8
For i = 2 To UBound(ULOGIC_arr, 1)
        For jj = 1 To 8
            
            REAL_arr(ii, REAL("PN")) = ULOGIC_arr(i, ULOGIC("NAME")) & "_NN" & jj '����
            REAL_arr(ii, REAL("DS")) = ULOGIC_arr(i, ULOGIC("PTDESC")) & "��ֵ�Ĵ���" & jj '������
            REAL_arr(ii, REAL("DT")) = "REAL" '��������
            REAL_arr(ii, REAL("MD")) = "0" '����
            REAL_arr(ii, REAL("MU")) = "1000" '����
            REAL_arr(ii, REAL("UT")) = "" '����
            REAL_arr(ii, REAL("OF")) = "%-8.2f" 'С��λ��
            REAL_arr(ii, REAL("SN")) = SN(ULOGIC_arr(i, ULOGIC("NODENUM")))  'վ��
            ii = ii + 1 '�м���
        Next
        
Next
'1-06--------------------ת��AM
'ii = 3 '�����п�ʼ
'For i = 2 To UBound(UREGPV_arr, 1)
'
'        AM_arr(ii, AM("PN")) = UREGPV_arr(i, UREGPV("NAME")) '����
'        AM_arr(ii, AM("DS")) = UREGPV_arr(i, UREGPV("PTDESC")) '������
'        AM_arr(ii, AM("MD")) = UREGPV_arr(i, UREGPV("PVEULO")) '����
'        AM_arr(ii, AM("MU")) = UREGPV_arr(i, UREGPV("PVEUHI")) '����
'        AM_arr(ii, AM("UT")) = UREGPV_arr(i, UREGPV("EUDESC")) '����
'        AM_arr(ii, AM("SN")) = SN(UREGPV_arr(i, UREGPV("NODENUM")))  'վ��
'
'        ii = ii + 1 '�м���
'Next


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

        i3 = i3 + 1 '�м���
  End If
  
  If UREGC_arr(i, UREGC("CTLALGID")) Like "ORSEL" Then
  
        ORSEL_arr(i4, ORSEL("PN")) = UREGC_arr(i, UREGC("NAME")) '����
        ORSEL_arr(i4, ORSEL("DS")) = UREGC_arr(i, UREGC("PTDESC")) '������
        ORSEL_arr(i4, ORSEL("SN")) = SN(UREGC_arr(i, UREGC("NODENUM")))  'վ��

        i4 = i4 + 1 '�м���
  End If
  
  
  If UREGC_arr(i, UREGC("CTLALGID")) Like "MULDIV" Then
  
        MULDIV_arr(i5, MULDIV("PN")) = UREGC_arr(i, UREGC("NAME")) '����
        MULDIV_arr(i5, MULDIV("DS")) = UREGC_arr(i, UREGC("PTDESC")) '������
        MULDIV_arr(i5, MULDIV("SN")) = SN(UREGC_arr(i, UREGC("NODENUM")))  'վ��

        i5 = i5 + 1 '�м���
  End If
  
  If UREGC_arr(i, UREGC("CTLALGID")) Like "SUMMER" Then
  
        SUMMER_arr(i6, SUMMER("PN")) = UREGC_arr(i, UREGC("NAME")) '����
        SUMMER_arr(i6, SUMMER("DS")) = UREGC_arr(i, UREGC("PTDESC")) '������
        SUMMER_arr(i6, SUMMER("SN")) = SN(UREGC_arr(i, UREGC("NODENUM")))  'վ��

        i6 = i6 + 1 '�м���
  End If
  
Next

'1-08--------------------ת��UREGPV �Զ����
'j1 = 3 '�����п�ʼ
'j2 = 3 '�����п�ʼ
'j3 = 3 '�����п�ʼ
'j4 = 3 '�����п�ʼ
'j5 = 3 '�����п�ʼ
'j6 = 3 '�����п�ʼ
'j7 = 3 '�����п�ʼ
'j8 = 3 '�����п�ʼ
'For i = 2 To UBound(UREGPV_arr, 1)
'    If UREGPV_arr(i, UREGPV("PVALGID")) = "FLOWCOMP" Then
'        FLOWCOMP_arr(j1, FLOWCOMP("PN")) = UREGPV_arr(i, UREGPV("NAME"))  '����
'        FLOWCOMP_arr(j1, FLOWCOMP("DS")) = UREGPV_arr(i, UREGPV("PTDESC"))  '������
'        FLOWCOMP_arr(j1, FLOWCOMP("UT")) = UREGPV_arr(i, UREGPV("EUDESC"))  '����
'        FLOWCOMP_arr(j1, FLOWCOMP("SN")) = SN(UREGPV_arr(i, UREGPV("NODENUM")))   'վ��
'        j1 = j1 + 1 '�м���
'    End If
'
'    If UREGPV_arr(i, UREGPV("PVALGID")) = "GENLIN" Then
'        GENLIN_arr(j2, GENLIN("PN")) = UREGPV_arr(i, UREGPV("NAME"))  '����
'        GENLIN_arr(j2, GENLIN("DS")) = UREGPV_arr(i, UREGPV("PTDESC"))  '������
'        GENLIN_arr(j2, GENLIN("UT")) = UREGPV_arr(i, UREGPV("EUDESC"))  '����
'        GENLIN_arr(j2, GENLIN("SN")) = SN(UREGPV_arr(i, UREGPV("NODENUM")))   'վ��
'        j2 = j2 + 1 '�м���
'    End If
'
'    If UREGPV_arr(i, UREGPV("PVALGID")) = "HILOAVG" Then
'        HILOAVG_arr(j3, HILOAVG("PN")) = UREGPV_arr(i, UREGPV("NAME"))  '����
'        HILOAVG_arr(j3, HILOAVG("DS")) = UREGPV_arr(i, UREGPV("PTDESC"))  '������
'        HILOAVG_arr(j3, HILOAVG("UT")) = UREGPV_arr(i, UREGPV("EUDESC"))  '����
'        HILOAVG_arr(j3, HILOAVG("SN")) = SN(UREGPV_arr(i, UREGPV("NODENUM")))   'վ��
'        j3 = j3 + 1 '�м���
'    End If
'
'    If UREGPV_arr(i, UREGPV("PVALGID")) = "MIDOF3" Then
'        MIDOF3_arr(j4, MIDOF3("PN")) = UREGPV_arr(i, UREGPV("NAME"))  '����
'        MIDOF3_arr(j4, MIDOF3("DS")) = UREGPV_arr(i, UREGPV("PTDESC"))  '������
'        MIDOF3_arr(j4, MIDOF3("UT")) = UREGPV_arr(i, UREGPV("EUDESC"))  '����
'        MIDOF3_arr(j4, MIDOF3("SN")) = SN(UREGPV_arr(i, UREGPV("NODENUM")))   'վ��
'        j4 = j4 + 1 '�м���
'    End If
'
'    If UREGPV_arr(i, UREGPV("PVALGID")) = "TOTALIZR" Then
'        TOTALIZR_arr(j5, TOTALIZR("PN")) = UREGPV_arr(i, UREGPV("NAME"))  '����
'        TOTALIZR_arr(j5, TOTALIZR("DS")) = UREGPV_arr(i, UREGPV("PTDESC"))  '������
'        TOTALIZR_arr(j5, TOTALIZR("UT")) = UREGPV_arr(i, UREGPV("EUDESC"))  '����
'        TOTALIZR_arr(j5, TOTALIZR("SN")) = SN(UREGPV_arr(i, UREGPV("NODENUM")))   'վ��
'        j5 = j5 + 1 '�м���
'    End If
'
'    If UREGPV_arr(i, UREGPV("PVALGID")) = "VDTLDLAG" Then
'        VDTLDLAG_arr(j6, VDTLDLAG("PN")) = UREGPV_arr(i, UREGPV("NAME"))  '����
'        VDTLDLAG_arr(j6, VDTLDLAG("DS")) = UREGPV_arr(i, UREGPV("PTDESC"))  '������
'        VDTLDLAG_arr(j6, VDTLDLAG("UT")) = UREGPV_arr(i, UREGPV("EUDESC"))  '����
'        VDTLDLAG_arr(j6, VDTLDLAG("SN")) = SN(UREGPV_arr(i, UREGPV("NODENUM")))   'վ��
'        j6 = j6 + 1 '�м���
'    End If
'
'Next
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
'1-11-----ת��VAL2��MOT2
ii = 3 '�����п�ʼ
jj = 3 '�����п�ʼ
'UDCת��ΪVAL2��MOT2
For i = 2 To UBound(UDC_arr, 1)
    If UDCType(UDC_arr(i, UDC("NAME")), UDC_arr(i, UDC("DISRC(1)")), UDC_arr(i, UDC("DISRC(2)")), UDC_arr(i, UDC("DODSTN(1)")), UDC_arr(i, UDC("DODSTN(2)")), UDC_arr(i, UDC("DODSTN(3)"))) = "VAL2" Then
        VAL2_arr(ii, VAL2("PN")) = UDC_arr(i, UDC("NAME"))  '����
        VAL2_arr(ii, VAL2("DS")) = UDC_arr(i, UDC("PTDESC")) '������
        VAL2_arr(ii, VAL2("SN")) = SN(UDC_arr(i, UDC("NODENUM")))  'վ��
        ii = ii + 1 '�м���
    End If
    
    If UDCType(UDC_arr(i, UDC("NAME")), UDC_arr(i, UDC("DISRC(1)")), UDC_arr(i, UDC("DISRC(2)")), UDC_arr(i, UDC("DODSTN(1)")), UDC_arr(i, UDC("DODSTN(2)")), UDC_arr(i, UDC("DODSTN(3)"))) = "MOT2" Then
        MOT2_arr(jj, VAL2("PN")) = UDC_arr(i, UDC("NAME"))  '����
        MOT2_arr(jj, VAL2("DS")) = UDC_arr(i, UDC("PTDESC")) '������
        MOT2_arr(jj, VAL2("SN")) = SN(UDC_arr(i, UDC("NODENUM")))  'վ��
        jj = jj + 1 '�м���
    End If
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

'    '2-15------ɾ���ɱ����±�-FLOWCOMP
'    Application.DisplayAlerts = False '�ر�ɾ����������ʾ��
'    For Each sht In Workbooks(wb_name).Worksheets
'       If sht.Name = "FLOWCOMP" Then
'           sht.Delete
'       End If
'    Next
'    Sheets.Add After:=ActiveSheet
'    ActiveSheet.Name = "FLOWCOMP"
'
'    Sheets("FLOWCOMP").Select
'    With Sheets("FLOWCOMP")
'        .Cells(1, 1).Resize(UBound(FLOWCOMP_arr(), 1), UBound(FLOWCOMP_arr(), 2)) = FLOWCOMP_arr
'    End With
'
'    '2-16------ɾ���ɱ����±�-GENLIN
'    Application.DisplayAlerts = False '�ر�ɾ����������ʾ��
'    For Each sht In Workbooks(wb_name).Worksheets
'       If sht.Name = "GENLIN" Then
'           sht.Delete
'       End If
'    Next
'    Sheets.Add After:=ActiveSheet
'    ActiveSheet.Name = "GENLIN"
'
'    Sheets("GENLIN").Select
'    With Sheets("GENLIN")
'        .Cells(1, 1).Resize(UBound(GENLIN_arr(), 1), UBound(GENLIN_arr(), 2)) = GENLIN_arr
'    End With
'
'    '2-17------ɾ���ɱ����±�-HILOAVG
'    Application.DisplayAlerts = False '�ر�ɾ����������ʾ��
'    For Each sht In Workbooks(wb_name).Worksheets
'       If sht.Name = "HILOAVG" Then
'           sht.Delete
'       End If
'    Next
'    Sheets.Add After:=ActiveSheet
'    ActiveSheet.Name = "HILOAVG"
'
'    Sheets("HILOAVG").Select
'    With Sheets("HILOAVG")
'        .Cells(1, 1).Resize(UBound(HILOAVG_arr(), 1), UBound(HILOAVG_arr(), 2)) = HILOAVG_arr
'    End With
'
'    '2-18------ɾ���ɱ����±�-MIDOF3
'    Application.DisplayAlerts = False '�ر�ɾ����������ʾ��
'    For Each sht In Workbooks(wb_name).Worksheets
'       If sht.Name = "MIDOF3" Then
'           sht.Delete
'       End If
'    Next
'    Sheets.Add After:=ActiveSheet
'    ActiveSheet.Name = "MIDOF3"
'
'    Sheets("MIDOF3").Select
'    With Sheets("MIDOF3")
'        .Cells(1, 1).Resize(UBound(MIDOF3_arr(), 1), UBound(MIDOF3_arr(), 2)) = MIDOF3_arr
'    End With
'
'    '2-19------ɾ���ɱ����±�-TOTALIZR
'    Application.DisplayAlerts = False '�ر�ɾ����������ʾ��
'    For Each sht In Workbooks(wb_name).Worksheets
'       If sht.Name = "TOTALIZR" Then
'           sht.Delete
'       End If
'    Next
'    Sheets.Add After:=ActiveSheet
'    ActiveSheet.Name = "TOTALIZR"
'
'    Sheets("TOTALIZR").Select
'    With Sheets("TOTALIZR")
'        .Cells(1, 1).Resize(UBound(TOTALIZR_arr(), 1), UBound(TOTALIZR_arr(), 2)) = TOTALIZR_arr
'    End With
'
'    '2-20------ɾ���ɱ����±�-VDTLDLAG
'    Application.DisplayAlerts = False '�ر�ɾ����������ʾ��
'    For Each sht In Workbooks(wb_name).Worksheets
'       If sht.Name = "VDTLDLAG" Then
'           sht.Delete
'       End If
'    Next
'    Sheets.Add After:=ActiveSheet
'    ActiveSheet.Name = "VDTLDLAG"
'
'    Sheets("VDTLDLAG").Select
'    With Sheets("VDTLDLAG")
'        .Cells(1, 1).Resize(UBound(VDTLDLAG_arr(), 1), UBound(VDTLDLAG_arr(), 2)) = VDTLDLAG_arr
'    End With

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

'Workbooks(project_sjk).Sheets("FLOWCOMP").Cells(1, 1).Resize(UBound(FLOWCOMP_arr(), 1), UBound(FLOWCOMP_arr(), 2)) = FLOWCOMP_arr
'Workbooks(project_sjk).Sheets("GENLIN").Cells(1, 1).Resize(UBound(GENLIN_arr(), 1), UBound(GENLIN_arr(), 2)) = GENLIN_arr
'Workbooks(project_sjk).Sheets("HILOAVG").Cells(1, 1).Resize(UBound(HILOAVG_arr(), 1), UBound(HILOAVG_arr(), 2)) = HILOAVG_arr
'Workbooks(project_sjk).Sheets("MIDOF3").Cells(1, 1).Resize(UBound(MIDOF3_arr(), 1), UBound(MIDOF3_arr(), 2)) = MIDOF3_arr
'Workbooks(project_sjk).Sheets("TOTALIZR").Cells(1, 1).Resize(UBound(TOTALIZR_arr(), 1), UBound(TOTALIZR_arr(), 2)) = TOTALIZR_arr
'Workbooks(project_sjk).Sheets("VDTLDLAG").Cells(1, 1).Resize(UBound(VDTLDLAG_arr(), 1), UBound(VDTLDLAG_arr(), 2)) = VDTLDLAG_arr
Workbooks(project_sjk).Sheets("DM").Cells(1, 1).Resize(UBound(DM_arr(), 1), UBound(DM_arr(), 2)) = DM_arr
Workbooks(project_sjk).Sheets("DS").Cells(1, 1).Resize(UBound(DS_arr(), 1), UBound(DS_arr(), 2)) = DS_arr

Workbooks(project_sjk).Save
Workbooks(project_sjk).Close


'4---------------------------------------------------------------������ҳ
Workbooks(wb_name).Activate
Sheets("main").Select


End Sub
