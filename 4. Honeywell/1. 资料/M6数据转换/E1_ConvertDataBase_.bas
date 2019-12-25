Attribute VB_Name = "E1_ConvertDataBase_"
'ver20190814_by cjt
'转换HN数据库到M6数据库

Sub E1_ConvertDataBase()
Dim i, j, k, l, m, N As Integer 'HN数据库循环变量
Dim ii, jj, kk, ll, mm, nn As Integer 'M6数据库循环变量
Dim i1, i2, i3, i4, i5, i6 As Integer 'M6数据库循环变量
Dim J1, j2, j3, j4, j5, j6 As Integer 'M6数据库循环变量
Dim AI_cn As Integer 'M6数据库AI通道计数
Dim AO_cn As Integer 'M6数据库AO通道计数
Dim cn As Integer '通道计数
Dim DN As Integer '设备号计数
Dim cn_arr(10 To 30) As Integer  '通道计数
Dim cnIsRD_arr(10 To 30) As String  '通道冗余属性
Dim dn_arr(10 To 30) As Integer '设备号计数
Dim dn_js(10 To 30) As Boolean '设备号计数

Dim SN_i As Integer '站号
Dim AO_i, AI_i, DO_i, DI_i As Integer '物理点表

Dim ThisChalRD As Variant
Dim NextChalRD As Variant
Dim LastChalRD As Variant

Dim ThisDN As Variant
Dim NextDN As Variant
Dim LastDN As Variant
'0---------------------------------------------------------------初始化设备号通道号
For i = 10 To 30
    dn_arr(i) = 10
    cn_arr(i) = 1
Next

'1---------------------------------------------------------------按站循环
AO_i = 3 'M6第三行开始
AI_i = 3 'M6第三行开始
DO_i = 3 'M6第三行开始
DI_i = 3 'M6第三行开始
For SN_i = 10 To 15
        '初始设备号
        DN = 9
'1)-----------------------------------------------------------------转换AO--------------------------------------------------------------------------------------------
        For i = 2 To UBound(UAO_arr, 1)
                
                '站号相同
                If SN(UAO_arr(i, UAO("NODENUM"))) = SN_i Then
                        
                        '---------------------------------------------------------------------
                        '读取冗余信息
                        ThisChalRD = RD(UAO_arr(i, UAO("NODENUM")), UAO_arr(i, UAO("MODNUM")))
                        '读取设备地址信息
                        ThisDN = UAO_arr(i, UAO("MODNUM"))
                        '---------------------------------------------------------------------
                        
                        '---------------------------------------------------------------------
                        '控制设备号增加
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
                        
                        
                        AO_arr(AO_i, AO("PN")) = UAO_arr(i, UAO("NAME")) '点名
                        AO_arr(AO_i, AO("DS")) = UAO_arr(i, UAO("PTDESC")) '点描述
                        AO_arr(AO_i, AO("MD")) = "0" '下限
                        AO_arr(AO_i, AO("MU")) = "100" '上限
                        AO_arr(AO_i, AO("UT")) = "%" '量纲
                        AO_arr(AO_i, AO("SN")) = SN_i  '站号
                        AO_arr(AO_i, AO("MT")) = "K-AO01" '模块类型
                        If UAO_arr(i, UAO("SLOTNUM")) = 9 Then
                           DN = DN + 2
                        End If
                        AO_arr(AO_i, AO("DN")) = DN '设备号
                        If UAO_arr(i, UAO("SLOTNUM")) <= 8 Then
                        AO_arr(AO_i, AO("CN")) = UAO_arr(i, UAO("SLOTNUM")) '通道号
                        Else
                        AO_arr(AO_i, AO("CN")) = UAO_arr(i, UAO("SLOTNUM")) - 8 '通道号
                        End If
                        
                        If UAO_arr(i, UAO("OPTDIR")) = "REVERSE" Then '正反作用
                           AO_arr(AO_i, AO("REVOPT")) = "1"
                        Else
                           AO_arr(AO_i, AO("REVOPT")) = "0"
                        End If
                        
                        '---------------------------------------------------------------------
                        '记录冗余信息
                        LastChalRD = ThisChalRD
                        '记录设备地址信息
                        LastDN = ThisDN
                        '---------------------------------------------------------------------
                        
                        AO_arr(AO_i, AO("RD")) = ThisChalRD '是否冗余
                        
                        'M6数据库
                        AO_i = AO_i + 1 '行计数
                End If
                        
                        
         Next i
         
'2)-----------------------------------------------------------------转换AI--------------------------------------------------------------------------------------------

        For i = 2 To UBound(UAI_arr, 1)
                        
             '站号相同
            If SN(UAI_arr(i, UAI("NODENUM"))) = SN_i Then
                        
                            
                    '---------------------------------------------------------------------
                    '读取冗余信息
                    ThisChalRD = RD(UAI_arr(i, UAI("NODENUM")), UAI_arr(i, UAI("MODNUM")))
                    '读取设备地址信息
                    ThisDN = UAI_arr(i, UAI("MODNUM"))
                    '---------------------------------------------------------------------
                    
                    '---------------------------------------------------------------------
                    '控制设备号增加
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
                    AI_arr(AI_i, AI("PN")) = UAI_arr(i, UAI("NAME")) '点名
                    AI_arr(AI_i, AI("DS")) = UAI_arr(i, UAI("PTDESC")) '点描述
                    AI_arr(AI_i, AI("MD")) = UAI_arr(i, UAI("PVEULO")) '下限
                    AI_arr(AI_i, AI("MU")) = UAI_arr(i, UAI("PVEUHI")) '上限
                    AI_arr(AI_i, AI("UT")) = UAI_arr(i, UAI("EUDESC")) '量纲
                    AI_arr(AI_i, AI("OF")) = DelDit(UAI_arr(i, UAI("PVFORMAT"))) '小数位数
                    AI_arr(AI_i, AI("SN")) = SN(UAI_arr(i, UAI("NODENUM"))) '站号
                    AI_arr(AI_i, AI("MT")) = "K-AIH03" '模块类型
                    AI_arr(AI_i, AI("DN")) = DN
                    AI_arr(AI_i, AI("CN")) = UAI_arr(i, UAI("SLOTNUM")) ' '通道号
                    AI_arr(AI_i, AI("SIGTYPE")) = "S4_20mA" '信号类型
            
                    If VBA.IsNumeric(UAI_arr(i, UAI("PVHITP"))) Then
                       AI_arr(AI_i, AI("AH")) = UAI_arr(i, UAI("PVHITP")) '高报幅值PVHITP对应AH
                       If AI_arr(AI_i, AI("AH")) >= AI_arr(AI_i, AI("MU")) Then
                          AI_arr(AI_i, AI("AH")) = AI_arr(AI_i, AI("MU")) * 0.9
                       End If
                    Else
                       AI_arr(AI_i, AI("AH")) = 0
                    End If
            
                    AI_arr(AI_i, AI("H1")) = AlMLVl(UAI_arr(i, UAI("PVHIPR"))) '高报优先级PVHIPR对应H1
            
                    If VBA.IsNumeric(UAI_arr(i, UAI("PVLOTP"))) Then
                       AI_arr(AI_i, AI("AL")) = UAI_arr(i, UAI("PVLOTP")) '低报幅值PVLOTP对应AL
                      If AI_arr(AI_i, AI("AL")) <= AI_arr(AI_i, AI("MD")) Then
                          AI_arr(AI_i, AI("AL")) = AI_arr(AI_i, AI("MD")) + (AI_arr(AI_i, AI("MU")) - AI_arr(AI_i, AI("MD"))) * 0.2
                       End If
                    Else
                       AI_arr(AI_i, AI("AL")) = 0
                    End If
            
                    AI_arr(AI_i, AI("L1")) = AlMLVl(UAI_arr(i, UAI("PVLOPR"))) '低报优先级PVLOPR对应L1
            
                    If VBA.IsNumeric(UAI_arr(i, UAI("PVHHTP"))) Then
                    
                       AI_arr(AI_i, AI("HH")) = UAI_arr(i, UAI("PVHHTP")) '高高报幅值PVHHTP对应HH
                       If AI_arr(AI_i, AI("HH")) >= AI_arr(AI_i, AI("MU")) Then
                          AI_arr(AI_i, AI("HH")) = AI_arr(AI_i, AI("MU")) * 0.95
                       End If
                    Else
                        AI_arr(AI_i, AI("HH")) = 0
                    End If
            
                    AI_arr(AI_i, AI("H2")) = AlMLVl(UAI_arr(i, UAI("PVHHPR"))) '高高报优先级PVHHPR对应H2
            
                    If VBA.IsNumeric(UAI_arr(i, UAI("PVLLTP"))) Then
                       AI_arr(AI_i, AI("LL")) = UAI_arr(i, UAI("PVLLTP")) '低低报幅值PVLLTP对应LL
                       If AI_arr(AI_i, AI("LL")) <= AI_arr(AI_i, AI("MD")) Then
                          AI_arr(AI_i, AI("LL")) = AI_arr(AI_i, AI("MD")) + (AI_arr(AI_i, AI("MU")) - AI_arr(AI_i, AI("MD"))) * 0.1
                       End If
                    Else
                       AI_arr(AI_i, AI("LL")) = 0
                    End If
            
                    AI_arr(AI_i, AI("L2")) = AlMLVl(UAI_arr(i, UAI("PVLLPR"))) '低低报优先级PVLLPR对应L2
            
                    AI_arr(AI_i, AI("SQRTOPT")) = SQRTOPT(UAI_arr(i, UAI("PVCHAR"))) '输入开方特性PVCHAR=SQRROOT对应SQRTOPT
            
                    AI_arr(AI_i, AI("ALMDB")) = ALMDB(UAI_arr(i, UAI("PVALDB")), UAI_arr(i, UAI("PVALDBEU")), UAI_arr(i, UAI("PVEUHI")), UAI_arr(i, UAI("PVEULO"))) '报警死区PVALDB对应ALMDB。当PVALDB=EU时，报警死区为工程量值PVALDBEU，需要根据量程转换为百分比（M6参数为量程百分比）。当PVALDB=Half为0.5%，PVALDB=one为1%…………PVALDB=five为5%
            
                    
                    AI_arr(AI_i, AI("RD")) = ThisChalRD '是否冗余根据站号设备号查询
    
                    '变更非法报警值
                     If Val(AI_arr(AI_i, AI("HH"))) > 0 Then
                        If Val(AI_arr(AI_i, AI("AH"))) >= Val(AI_arr(AI_i, AI("HH"))) Then
                           AI_arr(AI_i, AI("HH")) = Val(AI_arr(AI_i, AI("AH"))) * 1.1
                        End If
                     End If
    
                    '---------------------------------------------------------------------
                    '记录冗余信息
                    LastChalRD = ThisChalRD
                    '记录设备地址信息
                    LastDN = ThisDN
                    '---------------------------------------------------------------------
                    
                    'M6数据库
                    AI_i = AI_i + 1 '行计数
                    
           End If

       Next i
       
'3)-----------------------------------------------------------------转换DI--------------------------------------------------------------------------------------------
       
        For i = 2 To UBound(UDI_arr, 1)
        
             '站号相同
            If SN(UDI_arr(i, UDI("NODENUM"))) = SN_i Then
            
                    '---------------------------------------------------------------------
                    '读取冗余信息
                    ThisChalRD = RD(UDI_arr(i, UDI("NODENUM")), UDI_arr(i, UDI("MODNUM")))
                    '读取设备地址信息
                    ThisDN = UDI_arr(i, UDI("MODNUM"))
                    '---------------------------------------------------------------------
                    
                    '---------------------------------------------------------------------
                    '控制设备号增加
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
                    DI_arr(DI_i, DI("PN")) = UDI_arr(i, UDI("NAME")) '点名
                    DI_arr(DI_i, DI("DS")) = UDI_arr(i, UDI("PTDESC")) '点描述
                    DI_arr(DI_i, DI("SN")) = SN(UDI_arr(i, UDI("NODENUM"))) '站号
                    DI_arr(DI_i, DI("MT")) = "K-DI03" '模块类型
                    DI_arr(DI_i, DI("DN")) = DN '设备号
                    DI_arr(DI_i, DI("CN")) = UDI_arr(i, UDI("SLOTNUM")) '通道号
            
                    If UDI_arr(i, UDI("INPTDIR")) = "REVERSE" Then '输入反向
                       DI_arr(DI_i, DI("REVOPT")) = "1"
                    Else
                       DI_arr(DI_i, DI("REVOPT")) = "0"
                    End If
            
                    DI_arr(DI_i, DI("DAMOPT")) = DAMOPT(UDI_arr(i, UDI("ALMOPT")), UDI_arr(i, UDI("PVNORMAL"))) '报警属性
            
                    DI_arr(DI_i, DI("DAMLV")) = DAMLV(UDI_arr(i, UDI("OFFNRMPR"))) '报警优先级OFFNRMPR对应DAMLV
            
                   
                    DI_arr(DI_i, DI("RD")) = ThisChalRD '是否冗余根据站号设备号查询
                    
                     '---------------------------------------------------------------------
                    '记录冗余信息
                    LastChalRD = ThisChalRD
                    '记录设备地址信息
                    LastDN = ThisDN
                    '---------------------------------------------------------------------
                    
                    'M6数据库
                    DI_i = DI_i + 1 '行计数
            
            End If
            
        Next i
       
       
'3)-----------------------------------------------------------------转换DO--------------------------------------------------------------------------------------------
        For i = 2 To UBound(UDO_arr, 1)
        
             '站号相同
            If SN(UDO_arr(i, UDO("NODENUM"))) = SN_i Then
            
                    '---------------------------------------------------------------------
                    '读取冗余信息
                    ThisChalRD = RD(UDO_arr(i, UDO("NODENUM")), UDO_arr(i, UDO("MODNUM")))
                    '读取设备地址信息
                    ThisDN = UDO_arr(i, UDO("MODNUM"))
                    '---------------------------------------------------------------------
                    
                    '---------------------------------------------------------------------
                    '控制设备号增加
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
        
                    DOV_arr(DO_i, DOV("PN")) = UDO_arr(i, UDO("NAME")) '点名
                    DOV_arr(DO_i, DOV("DS")) = UDO_arr(i, UDO("PTDESC")) '点描述
                    DOV_arr(DO_i, DOV("SN")) = SN(UDO_arr(i, UDO("NODENUM"))) '站号
                    DOV_arr(DO_i, DOV("MT")) = "K-DO01" '模块类型
                    If UDO_arr(i, UDO("SLOTNUM")) = 17 Then
                       DN = DN + 2
                    End If
                    DOV_arr(DO_i, DOV("DN")) = DN '设备号
                    If UDO_arr(i, UDO("SLOTNUM")) <= 16 Then
                    DOV_arr(DO_i, DOV("CN")) = UDO_arr(i, UDO("SLOTNUM")) '通道号
                    Else
                    DOV_arr(DO_i, DOV("CN")) = UDO_arr(i, UDO("SLOTNUM")) - 16 '通道号
                    End If
                   
                    DOV_arr(DO_i, DOV("RD")) = ThisChalRD '是否冗余根据站号设备号查询
                    
                     '---------------------------------------------------------------------
                    '记录冗余信息
                    LastChalRD = ThisChalRD
                    '记录设备地址信息
                    LastDN = ThisDN
                    '---------------------------------------------------------------------
                    
                    'M6数据库
                    DO_i = DO_i + 1 '行计数
                    
            End If
        
        Next
'

Next SN_i



'1-05--------------------转换REAL
ii = 3 '第三行开始
'UNUM转化为REAL
For i = 2 To UBound(UNUM_arr, 1)

        REAL_arr(ii, REAL("PN")) = UNUM_arr(i, UNUM("NAME")) '点名
        REAL_arr(ii, REAL("DS")) = UNUM_arr(i, UNUM("PTDESC")) '点描述
        REAL_arr(ii, REAL("DT")) = "REAL" '数据类型
        REAL_arr(ii, REAL("AV")) = UNUM_arr(i, UNUM("PV")) '当前值
        REAL_arr(ii, REAL("MD")) = UNUM_arr(i, UNUM("PV")) * 0.1 '下限
        If UNUM_arr(i, UNUM("PV")) = 0 Then
        REAL_arr(ii, REAL("MU")) = 100 '上限
        Else
        REAL_arr(ii, REAL("MU")) = UNUM_arr(i, UNUM("PV")) * 10 '上限
        End If
        REAL_arr(ii, REAL("UT")) = UNUM_arr(i, UNUM("EUDESC")) '量纲
        REAL_arr(ii, REAL("OF")) = DelDit(UNUM_arr(i, UNUM("PVFORMAT"))) '小数位数
        REAL_arr(ii, REAL("SN")) = SN(UNUM_arr(i, UNUM("NODENUM")))  '站号
        ii = ii + 1 '行计数
Next
'UREGPV转化为REAL
For i = 2 To UBound(UREGPV_arr, 1)
        REAL_arr(ii, REAL("PN")) = UREGPV_arr(i, UREGPV("NAME")) '点名
        REAL_arr(ii, REAL("DS")) = UREGPV_arr(i, UREGPV("PTDESC")) '点描述
        REAL_arr(ii, REAL("DT")) = "REAL" '数据类型
        REAL_arr(ii, REAL("MD")) = UREGPV_arr(i, UREGPV("PVEULO")) '下限
        REAL_arr(ii, REAL("MU")) = UREGPV_arr(i, UREGPV("PVEUHI")) '上限
        REAL_arr(ii, REAL("UT")) = UREGPV_arr(i, UREGPV("EUDESC")) '量纲
        REAL_arr(ii, REAL("OF")) = DelDit(UREGPV_arr(i, UREGPV("PVFORMAT"))) '小数位数
        REAL_arr(ii, REAL("SN")) = SN(UREGPV_arr(i, UREGPV("NODENUM")))  '站号
        ii = ii + 1 '行计数
Next

'ULOGIC变量NN转为转化为REAL，每个变量增加NN1~NN8
For i = 2 To UBound(ULOGIC_arr, 1)
        For jj = 1 To 8
            
            REAL_arr(ii, REAL("PN")) = ULOGIC_arr(i, ULOGIC("NAME")) & "_NN" & jj '点名
            REAL_arr(ii, REAL("DS")) = ULOGIC_arr(i, ULOGIC("PTDESC")) & "数值寄存器" & jj '点描述
            REAL_arr(ii, REAL("DT")) = "REAL" '数据类型
            REAL_arr(ii, REAL("MD")) = "0" '下限
            REAL_arr(ii, REAL("MU")) = "1000" '上限
            REAL_arr(ii, REAL("UT")) = "" '量纲
            REAL_arr(ii, REAL("OF")) = "%-8.2f" '小数位数
            REAL_arr(ii, REAL("SN")) = SN(ULOGIC_arr(i, ULOGIC("NODENUM")))  '站号
            ii = ii + 1 '行计数
        Next
        
Next
'1-06--------------------转换AM
'ii = 3 '第三行开始
'For i = 2 To UBound(UREGPV_arr, 1)
'
'        AM_arr(ii, AM("PN")) = UREGPV_arr(i, UREGPV("NAME")) '点名
'        AM_arr(ii, AM("DS")) = UREGPV_arr(i, UREGPV("PTDESC")) '点描述
'        AM_arr(ii, AM("MD")) = UREGPV_arr(i, UREGPV("PVEULO")) '下限
'        AM_arr(ii, AM("MU")) = UREGPV_arr(i, UREGPV("PVEUHI")) '上限
'        AM_arr(ii, AM("UT")) = UREGPV_arr(i, UREGPV("EUDESC")) '量纲
'        AM_arr(ii, AM("SN")) = SN(UREGPV_arr(i, UREGPV("NODENUM")))  '站号
'
'        ii = ii + 1 '行计数
'Next


'1-07--------------------转换UREGC PID ,MAN,自定义块
i1 = 3 '第三行开始
i2 = 3 '第三行开始
i3 = 3 '第三行开始
i4 = 3 '第三行开始
i5 = 3 '第三行开始
i6 = 3 '第三行开始
i7 = 3 '第三行开始
i8 = 3 '第三行开始
For i = 2 To UBound(UREGC_arr, 1)

  If UREGC_arr(i, UREGC("CTLALGID")) Like "PID" Or UREGC_arr(i, UREGC("CTLALGID")) Like "PIDFF" Then
  
        PIDA_arr(i1, PIDA("PN")) = UREGC_arr(i, UREGC("NAME")) '点名
        PIDA_arr(i1, PIDA("DS")) = UREGC_arr(i, UREGC("PTDESC")) '点描述
        PIDA_arr(i1, PIDA("PVL")) = UREGC_arr(i, UREGC("PVEULO")) '下限
        PIDA_arr(i1, PIDA("PVU")) = UREGC_arr(i, UREGC("PVEUHI")) '上限
        PIDA_arr(i1, PIDA("PVUT")) = UREGC_arr(i, UREGC("EUDESC")) '量纲
        PIDA_arr(i1, PIDA("SN")) = SN(UREGC_arr(i, UREGC("NODENUM")))  '站号
        If UREGC_arr(i, UREGC("CTLACTN")) = "REVERSE" Then '作用方式
        PIDA_arr(i1, PIDA("ACTOPT")) = 1
        Else
        PIDA_arr(i1, PIDA("ACTOPT")) = 0
        End If
        PIDA_arr(i1, PIDA("KP")) = UREGC_arr(i, UREGC("K")) * 100 '比例
        PIDA_arr(i1, PIDA("TI")) = UREGC_arr(i, UREGC("T1"))  '积分
        PIDA_arr(i1, PIDA("KD")) = 1  '微分增益
        PIDA_arr(i1, PIDA("TD")) = UREGC_arr(i, UREGC("T2"))  '微分
        i1 = i1 + 1 '行计数
  End If
  
  If UREGC_arr(i, UREGC("CTLALGID")) Like "AUTOMAN" Then
  
        MAN_arr(i2, MAN("PN")) = UREGC_arr(i, UREGC("NAME")) '点名
        MAN_arr(i2, MAN("DS")) = UREGC_arr(i, UREGC("PTDESC")) '点描述
        MAN_arr(i2, MAN("ENGL")) = UREGC_arr(i, UREGC("PVEULO")) '下限
        MAN_arr(i2, MAN("ENGU")) = UREGC_arr(i, UREGC("PVEUHI")) '上限
        MAN_arr(i2, MAN("UT")) = UREGC_arr(i, UREGC("EUDESC")) '量纲
        MAN_arr(i2, MAN("SN")) = SN(UREGC_arr(i, UREGC("NODENUM")))  '站号

        i2 = i2 + 1 '行计数
  End If
  
  If UREGC_arr(i, UREGC("CTLALGID")) Like "SWITCH" Then
  
        SWITCH_arr(i3, SWITCH("PN")) = UREGC_arr(i, UREGC("NAME")) '点名
        SWITCH_arr(i3, SWITCH("DS")) = UREGC_arr(i, UREGC("PTDESC")) '点描述
        SWITCH_arr(i3, SWITCH("SN")) = SN(UREGC_arr(i, UREGC("NODENUM")))  '站号

        i3 = i3 + 1 '行计数
  End If
  
  If UREGC_arr(i, UREGC("CTLALGID")) Like "ORSEL" Then
  
        ORSEL_arr(i4, ORSEL("PN")) = UREGC_arr(i, UREGC("NAME")) '点名
        ORSEL_arr(i4, ORSEL("DS")) = UREGC_arr(i, UREGC("PTDESC")) '点描述
        ORSEL_arr(i4, ORSEL("SN")) = SN(UREGC_arr(i, UREGC("NODENUM")))  '站号

        i4 = i4 + 1 '行计数
  End If
  
  
  If UREGC_arr(i, UREGC("CTLALGID")) Like "MULDIV" Then
  
        MULDIV_arr(i5, MULDIV("PN")) = UREGC_arr(i, UREGC("NAME")) '点名
        MULDIV_arr(i5, MULDIV("DS")) = UREGC_arr(i, UREGC("PTDESC")) '点描述
        MULDIV_arr(i5, MULDIV("SN")) = SN(UREGC_arr(i, UREGC("NODENUM")))  '站号

        i5 = i5 + 1 '行计数
  End If
  
  If UREGC_arr(i, UREGC("CTLALGID")) Like "SUMMER" Then
  
        SUMMER_arr(i6, SUMMER("PN")) = UREGC_arr(i, UREGC("NAME")) '点名
        SUMMER_arr(i6, SUMMER("DS")) = UREGC_arr(i, UREGC("PTDESC")) '点描述
        SUMMER_arr(i6, SUMMER("SN")) = SN(UREGC_arr(i, UREGC("NODENUM")))  '站号

        i6 = i6 + 1 '行计数
  End If
  
Next

'1-08--------------------转换UREGPV 自定义块
'j1 = 3 '第三行开始
'j2 = 3 '第三行开始
'j3 = 3 '第三行开始
'j4 = 3 '第三行开始
'j5 = 3 '第三行开始
'j6 = 3 '第三行开始
'j7 = 3 '第三行开始
'j8 = 3 '第三行开始
'For i = 2 To UBound(UREGPV_arr, 1)
'    If UREGPV_arr(i, UREGPV("PVALGID")) = "FLOWCOMP" Then
'        FLOWCOMP_arr(j1, FLOWCOMP("PN")) = UREGPV_arr(i, UREGPV("NAME"))  '点名
'        FLOWCOMP_arr(j1, FLOWCOMP("DS")) = UREGPV_arr(i, UREGPV("PTDESC"))  '点描述
'        FLOWCOMP_arr(j1, FLOWCOMP("UT")) = UREGPV_arr(i, UREGPV("EUDESC"))  '量纲
'        FLOWCOMP_arr(j1, FLOWCOMP("SN")) = SN(UREGPV_arr(i, UREGPV("NODENUM")))   '站号
'        j1 = j1 + 1 '行计数
'    End If
'
'    If UREGPV_arr(i, UREGPV("PVALGID")) = "GENLIN" Then
'        GENLIN_arr(j2, GENLIN("PN")) = UREGPV_arr(i, UREGPV("NAME"))  '点名
'        GENLIN_arr(j2, GENLIN("DS")) = UREGPV_arr(i, UREGPV("PTDESC"))  '点描述
'        GENLIN_arr(j2, GENLIN("UT")) = UREGPV_arr(i, UREGPV("EUDESC"))  '量纲
'        GENLIN_arr(j2, GENLIN("SN")) = SN(UREGPV_arr(i, UREGPV("NODENUM")))   '站号
'        j2 = j2 + 1 '行计数
'    End If
'
'    If UREGPV_arr(i, UREGPV("PVALGID")) = "HILOAVG" Then
'        HILOAVG_arr(j3, HILOAVG("PN")) = UREGPV_arr(i, UREGPV("NAME"))  '点名
'        HILOAVG_arr(j3, HILOAVG("DS")) = UREGPV_arr(i, UREGPV("PTDESC"))  '点描述
'        HILOAVG_arr(j3, HILOAVG("UT")) = UREGPV_arr(i, UREGPV("EUDESC"))  '量纲
'        HILOAVG_arr(j3, HILOAVG("SN")) = SN(UREGPV_arr(i, UREGPV("NODENUM")))   '站号
'        j3 = j3 + 1 '行计数
'    End If
'
'    If UREGPV_arr(i, UREGPV("PVALGID")) = "MIDOF3" Then
'        MIDOF3_arr(j4, MIDOF3("PN")) = UREGPV_arr(i, UREGPV("NAME"))  '点名
'        MIDOF3_arr(j4, MIDOF3("DS")) = UREGPV_arr(i, UREGPV("PTDESC"))  '点描述
'        MIDOF3_arr(j4, MIDOF3("UT")) = UREGPV_arr(i, UREGPV("EUDESC"))  '量纲
'        MIDOF3_arr(j4, MIDOF3("SN")) = SN(UREGPV_arr(i, UREGPV("NODENUM")))   '站号
'        j4 = j4 + 1 '行计数
'    End If
'
'    If UREGPV_arr(i, UREGPV("PVALGID")) = "TOTALIZR" Then
'        TOTALIZR_arr(j5, TOTALIZR("PN")) = UREGPV_arr(i, UREGPV("NAME"))  '点名
'        TOTALIZR_arr(j5, TOTALIZR("DS")) = UREGPV_arr(i, UREGPV("PTDESC"))  '点描述
'        TOTALIZR_arr(j5, TOTALIZR("UT")) = UREGPV_arr(i, UREGPV("EUDESC"))  '量纲
'        TOTALIZR_arr(j5, TOTALIZR("SN")) = SN(UREGPV_arr(i, UREGPV("NODENUM")))   '站号
'        j5 = j5 + 1 '行计数
'    End If
'
'    If UREGPV_arr(i, UREGPV("PVALGID")) = "VDTLDLAG" Then
'        VDTLDLAG_arr(j6, VDTLDLAG("PN")) = UREGPV_arr(i, UREGPV("NAME"))  '点名
'        VDTLDLAG_arr(j6, VDTLDLAG("DS")) = UREGPV_arr(i, UREGPV("PTDESC"))  '点描述
'        VDTLDLAG_arr(j6, VDTLDLAG("UT")) = UREGPV_arr(i, UREGPV("EUDESC"))  '量纲
'        VDTLDLAG_arr(j6, VDTLDLAG("SN")) = SN(UREGPV_arr(i, UREGPV("NODENUM")))   '站号
'        j6 = j6 + 1 '行计数
'    End If
'
'Next
'1-09--------------------转换DM
ii = 3 '第三行开始
'UREGPV转化为DM
'UREGPV流量累计转复位按钮
For i = 2 To UBound(UREGPV_arr, 1)
    If UREGPV_arr(i, UREGPV("PVALGID")) = "FLOWCOMP" Then
        DM_arr(ii, DM("PN")) = UREGPV_arr(i, UREGPV("NAME")) & "_RS" '点名
        DM_arr(ii, DM("DS")) = UREGPV_arr(i, UREGPV("PTDESC")) '点描述
        DM_arr(ii, DM("SN")) = SN(UREGPV_arr(i, UREGPV("NODENUM")))  '站号
        ii = ii + 1 '行计数
    End If
Next
'1-10--------------------转换BOOL DS
ii = 3 '第三行开始
'ULOGIC变量FL转为转化为BOOL，每个变量增加FL1~FL12
For i = 2 To UBound(ULOGIC_arr, 1)
        For jj = 1 To 12
            DS_arr(ii, DS("PN")) = ULOGIC_arr(i, ULOGIC("NAME")) & "_FL" & jj '点名
            DS_arr(ii, DS("DS")) = ULOGIC_arr(i, ULOGIC("PTDESC")) & "标志寄存器" & jj '点描述
            DS_arr(ii, DS("SN")) = SN(ULOGIC_arr(i, ULOGIC("NODENUM")))  '站号
            ii = ii + 1 '行计数
        Next
        
Next
'1-11-----转换VAL2和MOT2
ii = 3 '第三行开始
jj = 3 '第三行开始
'UDC转化为VAL2和MOT2
For i = 2 To UBound(UDC_arr, 1)
    If UDCType(UDC_arr(i, UDC("NAME")), UDC_arr(i, UDC("DISRC(1)")), UDC_arr(i, UDC("DISRC(2)")), UDC_arr(i, UDC("DODSTN(1)")), UDC_arr(i, UDC("DODSTN(2)")), UDC_arr(i, UDC("DODSTN(3)"))) = "VAL2" Then
        VAL2_arr(ii, VAL2("PN")) = UDC_arr(i, UDC("NAME"))  '点名
        VAL2_arr(ii, VAL2("DS")) = UDC_arr(i, UDC("PTDESC")) '点描述
        VAL2_arr(ii, VAL2("SN")) = SN(UDC_arr(i, UDC("NODENUM")))  '站号
        ii = ii + 1 '行计数
    End If
    
    If UDCType(UDC_arr(i, UDC("NAME")), UDC_arr(i, UDC("DISRC(1)")), UDC_arr(i, UDC("DISRC(2)")), UDC_arr(i, UDC("DODSTN(1)")), UDC_arr(i, UDC("DODSTN(2)")), UDC_arr(i, UDC("DODSTN(3)"))) = "MOT2" Then
        MOT2_arr(jj, VAL2("PN")) = UDC_arr(i, UDC("NAME"))  '点名
        MOT2_arr(jj, VAL2("DS")) = UDC_arr(i, UDC("PTDESC")) '点描述
        MOT2_arr(jj, VAL2("SN")) = SN(UDC_arr(i, UDC("NODENUM")))  '站号
        jj = jj + 1 '行计数
    End If
Next

'2---------------------------------------------------------------数据写到当前工作簿

    '2-01------删除旧表建立新表-AI
    Application.DisplayAlerts = False '关闭删除工作表提示框
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
    '2-02------删除旧表建立新表-AO
    Application.DisplayAlerts = False '关闭删除工作表提示框
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
    
     '2-03------删除旧表建立新表-DI
    Application.DisplayAlerts = False '关闭删除工作表提示框
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
    '2-04------删除旧表建立新表-DO
    Application.DisplayAlerts = False '关闭删除工作表提示框
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
    '2-05------删除旧表建立新表-AS
    Application.DisplayAlerts = False '关闭删除工作表提示框
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
    '2-06------删除旧表建立新表-AM
    Application.DisplayAlerts = False '关闭删除工作表提示框
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
    
    '2-07------删除旧表建立新表-PID
    Application.DisplayAlerts = False '关闭删除工作表提示框
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
    
    '2-08------删除旧表建立新表-MOT2
    Application.DisplayAlerts = False '关闭删除工作表提示框
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
    
     '2-09------删除旧表建立新表-VAL2
    Application.DisplayAlerts = False '关闭删除工作表提示框
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
    
    
    '2-10------删除旧表建立新表-MAN
    Application.DisplayAlerts = False '关闭删除工作表提示框
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

    '2-11------删除旧表建立新表-SWITCH
    Application.DisplayAlerts = False '关闭删除工作表提示框
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

    '2-12------删除旧表建立新表-ORSEL
    Application.DisplayAlerts = False '关闭删除工作表提示框
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
    
    '2-13------删除旧表建立新表-MULDIV
    Application.DisplayAlerts = False '关闭删除工作表提示框
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
    
    '2-14------删除旧表建立新表-SUMMER
    Application.DisplayAlerts = False '关闭删除工作表提示框
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

'    '2-15------删除旧表建立新表-FLOWCOMP
'    Application.DisplayAlerts = False '关闭删除工作表提示框
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
'    '2-16------删除旧表建立新表-GENLIN
'    Application.DisplayAlerts = False '关闭删除工作表提示框
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
'    '2-17------删除旧表建立新表-HILOAVG
'    Application.DisplayAlerts = False '关闭删除工作表提示框
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
'    '2-18------删除旧表建立新表-MIDOF3
'    Application.DisplayAlerts = False '关闭删除工作表提示框
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
'    '2-19------删除旧表建立新表-TOTALIZR
'    Application.DisplayAlerts = False '关闭删除工作表提示框
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
'    '2-20------删除旧表建立新表-VDTLDLAG
'    Application.DisplayAlerts = False '关闭删除工作表提示框
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

     '2-21------删除旧表建立新表-DM
    Application.DisplayAlerts = False '关闭删除工作表提示框
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
    
    '2-22------删除旧表建立新表-DS
    Application.DisplayAlerts = False '关闭删除工作表提示框
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
    
'3---------------------------------------------------------------读取当前目录下文件并建立副本
CC = PATH & "\源文件\通用版组态数据库.xlsx"                              '模板文件
ftime = Replace(Replace(Replace(VBA.Now, "/", "_"), " ", "_"), ":", "_") '时间
fname = "通用版组态数据库"
ccb = PATH & "\工程文件\" & "通用版组态数据库" & ftime & ".xlsx"   '新文件带时间
FileCopy CC, ccb

'打开数据库填写数据
Workbooks.Open (PATH & "\工程文件\" & fname & ftime & ".xlsx")
'项目BOM
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


'4---------------------------------------------------------------激活主页
Workbooks(wb_name).Activate
Sheets("main").Select


End Sub
