Attribute VB_Name = "E1_ConvertDataBase_0226"
'ver20200226_by cjt
'转换HN数据库到M6数据库

Dim AIArr(1 To 844) As T_HN_DN
Dim AOArr(1 To 184) As T_HN_DN
Dim DIArr(1 To 1213) As T_HN_DN
Dim DOArr(1 To 511) As T_HN_DN

'-----------------------------------------------------------------------------------------------------------
'Purpose: 转换组态数据库 - cjt
'History: 12-26-2019
'-----------------------------------------------------------------------------------------------------------
Sub E1_ConvertDataBase()
    Dim i, j, k, l, M, N As Integer 'HN数据库循环变量
    Dim ii, jj, kk, ll, mm, nn As Integer 'M6数据库循环变量
    Dim i1, i2, i3, i4, i5, i6 As Integer 'M6数据库循环变量
    Dim J1, j2, j3, j4, j5, j6 As Integer 'M6数据库循环变量
    Dim AI_cn As Integer 'M6数据库AI通道计数
    Dim AO_cn As Integer 'M6数据库AO通道计数
    Dim cn As Integer '通道计数
    Dim cn_arr(10 To 30) As Integer  '通道计数
    Dim cnIsRD_arr(10 To 30) As String  '通道冗余属性
    Dim dn_arr(10 To 30) As Integer '设备号计数
    Dim dn_js(10 To 30) As Boolean '设备号计数
    
    Dim SN_i As Integer '站号
    Dim AO_i, AI_i, DO_i, DI_i As Integer '物理点表
    
    Dim ThisChalRD As Variant
    Dim NextChalRD As Variant
    Dim LastChalRD As Variant
    Dim PVALGID As String 'UREGPV类型
    
    Dim ConvDic As Object '字符转换字典
    
    '00-----初始化变量
    Set ConvDic = CreateObject("Scripting.Dictionary") '实例化字符转换字典
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
    
        '1)-----------------------------------------------------------------转换AO--------------------------------------------------------------------------------------------
        For i = 2 To UBound(UAO_arr, 1)
    
            '站号相同
            If SN(UAO_arr(i, UAO("NODENUM"))) = SN_i Then
                '读取冗余信息
                ThisChalRD = RD(UAO_arr(i, UAO("NODENUM")), UAO_arr(i, UAO("MODNUM")))
                
                AO_arr(AO_i, AO("PN")) = UAO_arr(i, UAO("NAME")) '点名
                AO_arr(AO_i, AO("DS")) = UAO_arr(i, UAO("PTDESC")) '点描述
                AO_arr(AO_i, AO("MD")) = "0" '下限
                AO_arr(AO_i, AO("MU")) = "100" '上限
                AO_arr(AO_i, AO("UT")) = "%" '量纲
                AO_arr(AO_i, AO("SN")) = SN_i  '站号
                AO_arr(AO_i, AO("MT")) = "K-AO01" '模块类型
    
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
                '---------------------------------------------------------------------
                AO_arr(AO_i, AO("RD")) = ThisChalRD '是否冗余
                
                
                If controllerModel = "K-CU03" Then
                   AO_arr(AO_i, AO("IO_LPS")) = "2" '链路号
                End If
                
                'M6数据库
                AO_i = AO_i + 1 '行计数
            End If
    
        Next i
    
        '2)-----------------------------------------------------------------转换AI--------------------------------------------------------------------------------------------
        For i = 2 To UBound(UAI_arr, 1)
                            
            '站号相同
            If SN(UAI_arr(i, UAI("NODENUM"))) = SN_i Then
                '读取冗余信息
                ThisChalRD = RD(UAI_arr(i, UAI("NODENUM")), UAI_arr(i, UAI("MODNUM")))
                
                AI_arr(AI_i, AI("PN")) = UAI_arr(i, UAI("NAME")) '点名
                AI_arr(AI_i, AI("DS")) = UAI_arr(i, UAI("PTDESC")) '点描述
                AI_arr(AI_i, AI("MD")) = UAI_arr(i, UAI("PVEULO")) '下限
                AI_arr(AI_i, AI("MU")) = UAI_arr(i, UAI("PVEUHI")) '上限
                AI_arr(AI_i, AI("UT")) = UAI_arr(i, UAI("EUDESC")) '量纲
                AI_arr(AI_i, AI("OF")) = DelDit(UAI_arr(i, UAI("PVFORMAT"))) '小数位数
                AI_arr(AI_i, AI("SN")) = SN(UAI_arr(i, UAI("NODENUM"))) '站号
                AI_arr(AI_i, AI("MT")) = "K-AIH03" '模块类型
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
        
                If controllerModel = "K-CU03" Then
                   AI_arr(AI_i, AI("IO_LPS")) = "2" '链路号
                End If
                

                If UAI_arr(i, UAI("INPTDIR")) = "REVERSE" Then
                AI_arr(AI_i, AI("REVOPT")) = "1" '反量程
                Else
                AI_arr(AI_i, AI("REVOPT")) = "0" '反量程
                End If
        
        
                '---------------------------------------------------------------------
                '记录冗余信息
                LastChalRD = ThisChalRD
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
                '---------------------------------------------------------------------
                DI_arr(DI_i, DI("PN")) = UDI_arr(i, UDI("NAME")) '点名
                DI_arr(DI_i, DI("DS")) = UDI_arr(i, UDI("PTDESC")) '点描述
                DI_arr(DI_i, DI("SN")) = SN(UDI_arr(i, UDI("NODENUM"))) '站号
                DI_arr(DI_i, DI("MT")) = "K-DI03" '模块类型
                DI_arr(DI_i, DI("CN")) = UDI_arr(i, UDI("SLOTNUM")) '通道号
    
                If UDI_arr(i, UDI("INPTDIR")) = "REVERSE" Then '输入反向
                    DI_arr(DI_i, DI("REVOPT")) = "1"
                Else
                    DI_arr(DI_i, DI("REVOPT")) = "0"
                End If
    
                DI_arr(DI_i, DI("DAMOPT")) = DAMOPT(UDI_arr(i, UDI("ALMOPT")), UDI_arr(i, UDI("PVNORMAL"))) '报警属性
                DI_arr(DI_i, DI("DAMLV")) = DAMLV(UDI_arr(i, UDI("OFFNRMPR"))) '报警优先级OFFNRMPR对应DAMLV
                DI_arr(DI_i, DI("RD")) = ThisChalRD '是否冗余根据站号设备号查询
    
    
                If controllerModel = "K-CU03" Then
                   DI_arr(DI_i, DI("IO_LPS")) = "2" '链路号
                End If
    
                DI_arr(DI_i, DI("E1")) = UDI_arr(i, UDI("STATETXT(1)")) '置1描述
                DI_arr(DI_i, DI("E0")) = UDI_arr(i, UDI("STATETXT(0)")) '置0描述
                '---------------------------------------------------------------------
                '记录冗余信息
                LastChalRD = ThisChalRD
                '---------------------------------------------------------------------
                        
                'M6数据库
                DI_i = DI_i + 1 '行计数
            End If
    
        Next i
    
        '4)-----------------------------------------------------------------转换DO--------------------------------------------------------------------------------------------
        For i = 2 To UBound(UDO_arr, 1)
    
            '站号相同
            If SN(UDO_arr(i, UDO("NODENUM"))) = SN_i Then
            
                '读取冗余信息
                ThisChalRD = RD(UDO_arr(i, UDO("NODENUM")), UDO_arr(i, UDO("MODNUM")))
            
                DOV_arr(DO_i, DOV("PN")) = UDO_arr(i, UDO("NAME")) '点名
                DOV_arr(DO_i, DOV("DS")) = UDO_arr(i, UDO("PTDESC")) '点描述
                DOV_arr(DO_i, DOV("SN")) = SN(UDO_arr(i, UDO("NODENUM"))) '站号
                DOV_arr(DO_i, DOV("MT")) = "K-DO01" '模块类型
    
                If UDO_arr(i, UDO("SLOTNUM")) <= 16 Then
                    DOV_arr(DO_i, DOV("CN")) = UDO_arr(i, UDO("SLOTNUM")) '通道号
                Else
                    DOV_arr(DO_i, DOV("CN")) = UDO_arr(i, UDO("SLOTNUM")) - 16 '通道号
                End If
                       
                DOV_arr(DO_i, DOV("RD")) = ThisChalRD '是否冗余根据站号设备号查询
                
                If controllerModel = "K-CU03" Then
                   DOV_arr(DO_i, DOV("IO_LPS")) = "2" '链路号
                End If
                
                
                '记录冗余信息
                LastChalRD = ThisChalRD
                
                'M6数据库
                DO_i = DO_i + 1 '行计数
            End If
        Next
    
    Next SN_i
    
    '模块地址赋值
    Call InitDN
    
    '重设DN值
    Call SetDN
    
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
    
'    'UREGPV转化为REAL
'    For i = 2 To UBound(UREGPV_arr, 1)
'        PVALGID = UREGPV_arr(i, UREGPV("PVALGID"))
'        If PVALGID <> "CALCULTR" Then
'            REAL_arr(ii, REAL("PN")) = UREGPV_arr(i, UREGPV("NAME")) '点名
'            REAL_arr(ii, REAL("DS")) = UREGPV_arr(i, UREGPV("PTDESC")) '点描述
'            REAL_arr(ii, REAL("DT")) = "REAL" '数据类型
'            REAL_arr(ii, REAL("MD")) = UREGPV_arr(i, UREGPV("PVEULO")) '下限
'            REAL_arr(ii, REAL("MU")) = UREGPV_arr(i, UREGPV("PVEUHI")) '上限
'            REAL_arr(ii, REAL("UT")) = UREGPV_arr(i, UREGPV("EUDESC")) '量纲
'            REAL_arr(ii, REAL("OF")) = DelDit(UREGPV_arr(i, UREGPV("PVFORMAT"))) '小数位数
'            REAL_arr(ii, REAL("SN")) = SN(UREGPV_arr(i, UREGPV("NODENUM")))  '站号
'            ii = ii + 1 '行计数
'        End If
'    Next
    
    'ULOGIC变量NN转为转化为REAL，每个变量增加NN1~NN8
    Dim NNstr As String 'NN字符串
    For i = 2 To UBound(ULOGIC_arr, 1)
    
        '----提取NN初始值
        '初始化
        NNstr = ""
        '累计1~8
        For jj = 1 To 8
        
            If Len(ULOGIC_arr(i, ULOGIC("NN(00" & jj & ")"))) Then
               NNstr = NNstr & "NN(00" & jj & ")=" & ULOGIC_arr(i, ULOGIC("NN(00" & jj & ")"))
            End If
   
        Next
        '去无意义字符
        NNstr = Replace(NNstr, " ", "")
        NNstr = Replace(NNstr, "(00", "")
        NNstr = Replace(NNstr, ")", "")
        NNarr = Split(NNstr, "NN", 8)
        '转化
        For jj = 1 To 8
            REAL_arr(ii, REAL("PN")) = ULOGIC_arr(i, ULOGIC("NAME")) & "_NN" & jj '点名
            REAL_arr(ii, REAL("DS")) = ULOGIC_arr(i, ULOGIC("PTDESC")) & "数值寄存器" & jj '点描述
            REAL_arr(ii, REAL("DT")) = "REAL" '数据类型
            REAL_arr(ii, REAL("MD")) = "0" '下限
            REAL_arr(ii, REAL("MU")) = "1000" '上限
            REAL_arr(ii, REAL("UT")) = "" '量纲
            REAL_arr(ii, REAL("OF")) = "%-8.2f" '小数位数
            REAL_arr(ii, REAL("SN")) = SN(ULOGIC_arr(i, ULOGIC("NODENUM")))  '站号
            If jj <= UBound(NNarr) Then
            REAL_arr(ii, REAL("AV")) = Replace(NNarr(jj), jj & "=", "") '数据类型
            End If
            ii = ii + 1 '行计数
        Next
        
    Next
    
    '1-06--------------------转换AM
    ii = 3 '第三行开始
    For i = 2 To UBound(UREGPV_arr, 1)
           
                AM_arr(ii, AM("PN")) = UREGPV_arr(i, UREGPV("NAME")) '点名
                AM_arr(ii, AM("DS")) = UREGPV_arr(i, UREGPV("PTDESC")) '点描述
                AM_arr(ii, AM("MD")) = UREGPV_arr(i, UREGPV("PVEULO")) '下限
                AM_arr(ii, AM("MU")) = UREGPV_arr(i, UREGPV("PVEUHI")) '上限
                
'                AM_arr(ii, AM("MD")) = UREGPV_arr(i, UREGPV("PVEXEULO")) '下限
'                AM_arr(ii, AM("MU")) = UREGPV_arr(i, UREGPV("PVEXEUHI")) '上限
                
                AM_arr(ii, AM("UT")) = UREGPV_arr(i, UREGPV("EUDESC")) '量纲
                AM_arr(ii, AM("SN")) = SN(UREGPV_arr(i, UREGPV("NODENUM")))  '站号
        
                ii = ii + 1 '行计数
            
    Next
    
    
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
            
            SWITCH_arr(i3, SWITCH("CVEUHI")) = UREGC_arr(i, UREGC("OPHILM"))  '输出高限
            SWITCH_arr(i3, SWITCH("CVEULO")) = UREGC_arr(i, UREGC("OPLOLM")) '输出低限
            SWITCH_arr(i3, SWITCH("XEUHI")) = UREGC_arr(i, UREGC("XEUHI"))  '输入高限
            SWITCH_arr(i3, SWITCH("XEULO")) = UREGC_arr(i, UREGC("XEULO"))  '输入低限
            
            If UREGC_arr(i, UREGC("CTLEQN")) = "EQA" Then
               SWITCH_arr(i3, SWITCH("PVEQN")) = "0"  '模式选择0-EQA,1-EQB
            End If
            
            If UREGC_arr(i, UREGC("CTLEQN")) = "EQB" Then
               SWITCH_arr(i3, SWITCH("PVEQN")) = "1"  '模式选择0-EQA,1-EQB
            End If
            
            i3 = i3 + 1 '行计数
            
        End If
      
        If UREGC_arr(i, UREGC("CTLALGID")) Like "ORSEL" Then
      
            ORSEL_arr(i4, ORSEL("PN")) = UREGC_arr(i, UREGC("NAME")) '点名
            ORSEL_arr(i4, ORSEL("DS")) = UREGC_arr(i, UREGC("PTDESC")) '点描述
            ORSEL_arr(i4, ORSEL("SN")) = SN(UREGC_arr(i, UREGC("NODENUM")))  '站号
            
        '    OROPT:BOOL:=FALSE;(*超驰选项：0-未被选中输入不跟踪被选值 1-未被选中输入跟踪被选值*)
        '    CTLEQN:BOOL:=FALSE;(*模式选择：0-高选 1-低选*)===
        '    BYPASS:BOOL:=FALSE;(*输入旁路是否使能:ON允许旁路输入；OFF不允许旁路输入*)
        '    BYPASS1:BOOL:=FALSE;(*输入1旁路开关*)
        '    BYPASS2:BOOL:=FALSE;(*输入2旁路开关*)
        '    BYPASS3:BOOL:=FALSE;(*输入3旁路开关*)
        '    BYPASS4:BOOL:=FALSE;(*输入4旁路开关*)
        '    OROFFSET:BOOL:=FALSE;(*超驰偏移参数:控制未被选中值的跟踪值*)
        '    XEULO:REAL:=0;(*输入量程下限*)===
        '    XEUHI:REAL:=100;(*输入量程上限*)===
        '    CVEULO:REAL:=0;(*输出量程下限*)==
        '    CVEUHI:REAL:=100;(*输出量程上限*)==

        '    M:BYTE:=2;(*输入个数*)
            ConvDic.RemoveAll: ConvDic.Add "OFF", "0": ConvDic.Add "ON", "1" '超驰选项：0-未被选中输入不跟踪被选值 1-未被选中输入跟踪被选值
            ORSEL_arr(i4, ORSEL("OROPT")) = ConvDic(UREGC_arr(i, UREGC("OROPT")))
            ConvDic.RemoveAll: ConvDic.Add "EQA", "0": ConvDic.Add "EQB", "1" '模式选择：0-高选 1-低选
            ORSEL_arr(i4, ORSEL("CTLEQN")) = ConvDic(UREGC_arr(i, UREGC("CTLEQN")))
            
            
            ORSEL_arr(i4, ORSEL("OROFFSET")) = UREGC_arr(i, UREGC("OROFFSET"))  '超驰偏移参数:控制未被选中值的跟踪值
            ORSEL_arr(i4, ORSEL("CVEUHI")) = UREGC_arr(i, UREGC("OPHILM"))  '输出高限
            ORSEL_arr(i4, ORSEL("CVEULO")) = UREGC_arr(i, UREGC("OPLOLM")) '输出低限
            ORSEL_arr(i4, ORSEL("XEUHI")) = UREGC_arr(i, UREGC("XEUHI"))  '输入高限
            ORSEL_arr(i4, ORSEL("XEULO")) = UREGC_arr(i, UREGC("XEULO"))  '输入低限
            ORSEL_arr(i4, ORSEL("M")) = UREGC_arr(i, UREGC("M"))  '输入个数
            

            i4 = i4 + 1 '行计数
        End If
      
        If UREGC_arr(i, UREGC("CTLALGID")) Like "MULDIV" Then
      
            MULDIV_arr(i5, MULDIV("PN")) = UREGC_arr(i, UREGC("NAME")) '点名
            MULDIV_arr(i5, MULDIV("DS")) = UREGC_arr(i, UREGC("PTDESC")) '点描述
            MULDIV_arr(i5, MULDIV("SN")) = SN(UREGC_arr(i, UREGC("NODENUM")))  '站号
            
            MULDIV_arr(i5, MULDIV("CVEUHI")) = UREGC_arr(i, UREGC("OPHILM"))  '输出高限
            MULDIV_arr(i5, MULDIV("CVEULO")) = UREGC_arr(i, UREGC("OPLOLM")) '输出低限
            MULDIV_arr(i5, MULDIV("XEUHI")) = UREGC_arr(i, UREGC("XEUHI"))  '输入高限
            MULDIV_arr(i5, MULDIV("XEULO")) = UREGC_arr(i, UREGC("XEULO"))  '输入低限
            
            MULDIV_arr(i5, MULDIV("K")) = UREGC_arr(i, UREGC("K"))   '比例因子
            MULDIV_arr(i5, MULDIV("K1")) = UREGC_arr(i, UREGC("K1"))  '输入1比例因子
            MULDIV_arr(i5, MULDIV("K2")) = UREGC_arr(i, UREGC("K2"))  '输入2比例因子
            MULDIV_arr(i5, MULDIV("K3")) = UREGC_arr(i, UREGC("K3"))  '输入3比例因子
            MULDIV_arr(i5, MULDIV("B")) = UREGC_arr(i, UREGC("B"))   '偏置
            MULDIV_arr(i5, MULDIV("B1")) = UREGC_arr(i, UREGC("B1")) '输入1偏置
            MULDIV_arr(i5, MULDIV("B2")) = UREGC_arr(i, UREGC("B2")) '输入2偏置
            MULDIV_arr(i5, MULDIV("B3")) = UREGC_arr(i, UREGC("B3")) '输入3偏置
            MULDIV_arr(i5, MULDIV("PVEQN")) = CTLEQN(UREGC_arr(i, UREGC("CTLEQN"))) '模式选择0-A,1-B,2-C,3-D,4-E
            
            i5 = i5 + 1 '行计数
            
        End If
      
        If UREGC_arr(i, UREGC("CTLALGID")) Like "SUMMER" Then
      
            SUMMER_CTRL_arr(i6, SUMMER_CTRL("PN")) = UREGC_arr(i, UREGC("NAME")) '点名
            SUMMER_CTRL_arr(i6, SUMMER_CTRL("DS")) = UREGC_arr(i, UREGC("PTDESC")) '点描述
            SUMMER_CTRL_arr(i6, SUMMER_CTRL("SN")) = SN(UREGC_arr(i, UREGC("NODENUM")))  '站号
            
            SUMMER_CTRL_arr(i6, SUMMER_CTRL("CVEUHI")) = UREGC_arr(i, UREGC("OPHILM"))  '输出高限
            SUMMER_CTRL_arr(i6, SUMMER_CTRL("CVEULO")) = UREGC_arr(i, UREGC("OPLOLM")) '输出低限
            SUMMER_CTRL_arr(i6, SUMMER_CTRL("XEUHI")) = UREGC_arr(i, UREGC("XEUHI"))  '输入高限
            SUMMER_CTRL_arr(i6, SUMMER_CTRL("XEULO")) = UREGC_arr(i, UREGC("XEULO"))  '输入低限
            
            SUMMER_CTRL_arr(i6, SUMMER_CTRL("K")) = UREGC_arr(i, UREGC("K"))  '比例因子
            SUMMER_CTRL_arr(i6, SUMMER_CTRL("K1")) = UREGC_arr(i, UREGC("K1"))  '输入1比例因子
            SUMMER_CTRL_arr(i6, SUMMER_CTRL("K2")) = UREGC_arr(i, UREGC("K2"))  '输入2比例因子
            SUMMER_CTRL_arr(i6, SUMMER_CTRL("K3")) = UREGC_arr(i, UREGC("K3"))  '输入3比例因子
            SUMMER_CTRL_arr(i6, SUMMER_CTRL("K4")) = UREGC_arr(i, UREGC("K4"))  '输入4比例因子
            SUMMER_CTRL_arr(i6, SUMMER_CTRL("B")) = UREGC_arr(i, UREGC("B"))   '偏置
            
            i6 = i6 + 1 '行计数
            
        End If
      
    Next
    
    '1-08--------------------转换UREGPV 自定义块
    J1 = 3 '第三行开始
    j2 = 3 '第三行开始
    j3 = 3 '第三行开始
    j4 = 3 '第三行开始
    j5 = 3 '第三行开始
    j6 = 3 '第三行开始
    j7 = 3 '第三行开始
    j8 = 3 '第三行开始
    For i = 2 To UBound(UREGPV_arr, 1)
    
        If UREGPV_arr(i, UREGPV("PVALGID")) = "FLOWCOMP" Then
        
            FLOWCOMP_arr(J1, FLOWCOMP("PN")) = UREGPV_arr(i, UREGPV("NAME")) & "_OMP" '点名
            FLOWCOMP_arr(J1, FLOWCOMP("DS")) = UREGPV_arr(i, UREGPV("PTDESC"))  '点描述
            FLOWCOMP_arr(J1, FLOWCOMP("UT")) = UREGPV_arr(i, UREGPV("EUDESC"))  '量纲
            FLOWCOMP_arr(J1, FLOWCOMP("SN")) = SN(UREGPV_arr(i, UREGPV("NODENUM")))   '站号

            FLOWCOMP_arr(J1, FLOWCOMP("RG")) = UREGPV_arr(i, UREGPV("RG"))  '设计的参考比重/分子量
            FLOWCOMP_arr(J1, FLOWCOMP("RP")) = UREGPV_arr(i, UREGPV("RP"))  '设计压力（绝压）
            FLOWCOMP_arr(J1, FLOWCOMP("RT")) = UREGPV_arr(i, UREGPV("RT"))  '设计温度（绝对温度）
            FLOWCOMP_arr(J1, FLOWCOMP("P0")) = UREGPV_arr(i, UREGPV("P0"))  '压力零点参考,与P的单位一致进行调整
            FLOWCOMP_arr(J1, FLOWCOMP("T0")) = UREGPV_arr(i, UREGPV("T0"))  '绝对温度转换因数
            FLOWCOMP_arr(J1, FLOWCOMP("RX")) = UREGPV_arr(i, UREGPV("RX"))  '参考蒸汽压缩系数
            FLOWCOMP_arr(J1, FLOWCOMP("C")) = UREGPV_arr(i, UREGPV("C"))    '刻度因子
            FLOWCOMP_arr(J1, FLOWCOMP("C1")) = UREGPV_arr(i, UREGPV("C1"))  '校正常量1
            FLOWCOMP_arr(J1, FLOWCOMP("C2")) = UREGPV_arr(i, UREGPV("C2"))  '校正常量2
            
            
            ConvDic.RemoveAll: ConvDic.Add "EQA", "0": ConvDic.Add "EQB", "1" '补偿公式选择0-4
                               ConvDic.Add "EQC", "2": ConvDic.Add "EQD", "3": ConvDic.Add "EQE", "4"
            FLOWCOMP_arr(J1, FLOWCOMP("PVEQN")) = ConvDic(UREGPV_arr(i, UREGPV("PVEQN")))
            
            ConvDic.RemoveAll: ConvDic.Add "SQRROOT", "1": ConvDic.Add "LINEAR", "0" 'FALSE-Linear线性 TRUE-Sqrroot开方
            FLOWCOMP_arr(J1, FLOWCOMP("PVCHAR")) = ConvDic(UREGPV_arr(i, UREGPV("PVCHAR")))
            
            FLOWCOMP_arr(J1, FLOWCOMP("COMPLOLM")) = UREGPV_arr(i, UREGPV("COMPLOLM"))  '补偿项低限
            FLOWCOMP_arr(J1, FLOWCOMP("COMPHILM")) = UREGPV_arr(i, UREGPV("COMPHILM"))  '补偿项高限
            
            J1 = J1 + 1 '行计数
        End If
    
        If UREGPV_arr(i, UREGPV("PVALGID")) = "GENLIN" Then
            ONEFOLD_arr(j2, ONEFOLD("PN")) = UREGPV_arr(i, UREGPV("NAME")) & "_FOLD" '点名
            ONEFOLD_arr(j2, ONEFOLD("DS")) = UREGPV_arr(i, UREGPV("PTDESC"))  '点描述
            ONEFOLD_arr(j2, ONEFOLD("SN")) = SN(UREGPV_arr(i, UREGPV("NODENUM")))   '站号
            
            Dim jj2 As Integer
            PNTNUM = 0
            For jj2 = 0 To 12
                 If Len(UREGPV_arr(i, UREGPV("IN" & jj2))) > 0 Then
                    PNTNUM = PNTNUM + 1
                 End If
            Next
            ONEFOLD_arr(j2, ONEFOLD("PNTNUM")) = PNTNUM   '点数
            j2 = j2 + 1 '行计数
        End If
    
        If UREGPV_arr(i, UREGPV("PVALGID")) = "HILOAVG" Then
            HILOAVG_arr(j3, HILOAVG("PN")) = UREGPV_arr(i, UREGPV("NAME")) & "_AVG"  '点名
            HILOAVG_arr(j3, HILOAVG("DS")) = UREGPV_arr(i, UREGPV("PTDESC"))  '点描述
            HILOAVG_arr(j3, HILOAVG("UT")) = UREGPV_arr(i, UREGPV("EUDESC"))  '量纲
            HILOAVG_arr(j3, HILOAVG("SN")) = SN(UREGPV_arr(i, UREGPV("NODENUM")))   '站号
            
            HILOAVG_arr(j3, HILOAVG("PVEUHI")) = UREGPV_arr(i, UREGPV("PVEUHI"))  '量程上限
            HILOAVG_arr(j3, HILOAVG("PVEULO")) = UREGPV_arr(i, UREGPV("PVEULO"))  '量程下限
            HILOAVG_arr(j3, HILOAVG("PVEXEUHI")) = UREGPV_arr(i, UREGPV("PVEXEUHI"))  '输入上限
            HILOAVG_arr(j3, HILOAVG("PVEXEULO")) = UREGPV_arr(i, UREGPV("PVEXEULO"))  '输入下限
            
            HILOAVG_arr(j3, HILOAVG("NMIN")) = UREGPV_arr(i, UREGPV("NMIN"))  '状态好参数最小个数
            
            ConvDic.RemoveAll: ConvDic.Add "ON", "1": ConvDic.Add "OFF", "0" '是否允许强制
            HILOAVG_arr(j3, HILOAVG("FRCPERM")) = ConvDic(UREGPV_arr(i, UREGPV("FRCPERM")))
            
            ConvDic.RemoveAll: ConvDic.Add "EQA", "0": ConvDic.Add "EQB", "1": ConvDic.Add "EQC", "2" '模式选择0-高选1-低选2-取平均
            HILOAVG_arr(j3, HILOAVG("PVEQN")) = ConvDic(UREGPV_arr(i, UREGPV("PVEQN")))
            
            ConvDic.RemoveAll: ConvDic.Add "SELECTP1", "1": ConvDic.Add "SELECTP2", "2": ConvDic.Add "SELECTP3", "3" '强制选择项1-6
                               ConvDic.Add "SELECTP4", "4": ConvDic.Add "SELECTP5", "5": ConvDic.Add "SELECTP6", "6"
            HILOAVG_arr(j3, HILOAVG("FSELIN")) = ConvDic(UREGPV_arr(i, UREGPV("FSELIN")))
            
            j3 = j3 + 1 '行计数
        End If
    
        If UREGPV_arr(i, UREGPV("PVALGID")) = "MIDOF3" Then
            MIDOF3_arr(j4, MIDOF3("PN")) = UREGPV_arr(i, UREGPV("NAME")) & "_OF3" '点名
            MIDOF3_arr(j4, MIDOF3("DS")) = UREGPV_arr(i, UREGPV("PTDESC"))  '点描述
            MIDOF3_arr(j4, MIDOF3("UT")) = UREGPV_arr(i, UREGPV("EUDESC"))  '量纲
            MIDOF3_arr(j4, MIDOF3("SN")) = SN(UREGPV_arr(i, UREGPV("NODENUM")))   '站号
            
            'STGN:BYTE:=0;(*状态好参数当前个数*)
            'PVEQN:BYTE:=0;(*模式选择0-高选1-低选2-取平均*)

            ConvDic.RemoveAll: ConvDic.Add "EQA", "0": ConvDic.Add "EQB", "1": ConvDic.Add "EQC", "2" '模式选择0-高选1-低选2-取平均
            MIDOF3_arr(j4, MIDOF3("PVEQN")) = ConvDic(UREGPV_arr(i, UREGPV("PVEQN")))
            
            j4 = j4 + 1 '行计数
        End If
    
'        If UREGPV_arr(i, UREGPV("PVALGID")) = "TOTALIZR" Then
'            TOTALIZR_arr(j5, TOTALIZR("PN")) = UREGPV_arr(i, UREGPV("NAME"))  '点名
'            TOTALIZR_arr(j5, TOTALIZR("DS")) = UREGPV_arr(i, UREGPV("PTDESC"))  '点描述
'            TOTALIZR_arr(j5, TOTALIZR("UT")) = UREGPV_arr(i, UREGPV("EUDESC"))  '量纲
'            TOTALIZR_arr(j5, TOTALIZR("SN")) = SN(UREGPV_arr(i, UREGPV("NODENUM")))   '站号
'            j5 = j5 + 1 '行计数
'        End If
    
        If UREGPV_arr(i, UREGPV("PVALGID")) = "TOTALIZR" Then
            FLOWSUM_arr(j5, FLOWSUM("PN")) = UREGPV_arr(i, UREGPV("NAME")) & "_SUM" '点名
            FLOWSUM_arr(j5, FLOWSUM("DS")) = UREGPV_arr(i, UREGPV("PTDESC"))  '点描述
            FLOWSUM_arr(j5, FLOWSUM("PVUT")) = UREGPV_arr(i, UREGPV("EUDESC"))  '量纲
            FLOWSUM_arr(j5, FLOWSUM("SN")) = SN(UREGPV_arr(i, UREGPV("NODENUM")))   '站号
            j5 = j5 + 1 '行计数
        End If
    
    
        If UREGPV_arr(i, UREGPV("PVALGID")) = "VDTLDLAG" Then
            VDTLDLAG_arr(j6, VDTLDLAG("PN")) = UREGPV_arr(i, UREGPV("NAME")) & "_LAG" '点名
            VDTLDLAG_arr(j6, VDTLDLAG("DS")) = UREGPV_arr(i, UREGPV("PTDESC"))  '点描述
            VDTLDLAG_arr(j6, VDTLDLAG("UT")) = UREGPV_arr(i, UREGPV("EUDESC"))  '量纲
            VDTLDLAG_arr(j6, VDTLDLAG("SN")) = SN(UREGPV_arr(i, UREGPV("NODENUM")))   '站号
            
            'C:REAL:=1;(*刻度因子*)
            'D:REAL:=0;(*偏置*)
            'TS:REAL:=0;(*采样时间,程序的扫描周期,S*)
            'DP1:REAL:=0;(*P1延时TD后的值*)
            'NRATE:WORD:=0;(*数据表移位因子*)
            'NLOC:WORD:=0;(*数据表使用区域大小*)
            'INC:WORD:=0;(*间隔的计数器*)
            'ARRIN:ARRAY[1..30] OF REAL;(*最多30个历史数据*)
            'FIRSTFLAG:BOOL:=TRUE;(*第一次运行标记*)
            'I:BYTE:=0;(*循环参数*)
            VDTLDLAG_arr(j6, VDTLDLAG("C")) = UREGPV_arr(i, UREGPV("C"))  '刻度因子
            VDTLDLAG_arr(j6, VDTLDLAG("D")) = UREGPV_arr(i, UREGPV("D"))  '偏置
            
            
            j6 = j6 + 1 '行计数
        End If
        
        If UREGPV_arr(i, UREGPV("PVALGID")) = "SUMMER" Then
            SUMMER_arr(j7, SUMMER("PN")) = UREGPV_arr(i, UREGPV("NAME")) & "_SUM" '点名
            SUMMER_arr(j7, SUMMER("DS")) = UREGPV_arr(i, UREGPV("PTDESC"))  '点描述
            SUMMER_arr(j7, SUMMER("UT")) = UREGPV_arr(i, UREGPV("EUDESC"))  '量纲
            SUMMER_arr(j7, SUMMER("SN")) = SN(UREGPV_arr(i, UREGPV("NODENUM")))   '站号
            
            'C:REAL:=1;(*比例因子*)
            'C1:REAL:=1;(*输入1比例因子*)
            'C2:REAL:=1;(*输入2比例因子*)
            'C3:REAL:=1;(*输入3比例因子*)
            'C4:REAL:=1;(*输入4比例因子*)
            'C5:REAL:=1;(*输入5比例因子*)
            'C6:REAL:=1;(*输入6比例因子*)
            'D:REAL:=0;(*偏置*)
            'PVEQN:BOOL:=FALSE;(*模式选择0-A,1-B*)
             SUMMER_arr(j7, SUMMER("C")) = UREGPV_arr(i, UREGPV("C"))   '比例因子
             SUMMER_arr(j7, SUMMER("C1")) = UREGPV_arr(i, UREGPV("C1")) '输入1比例因子
             SUMMER_arr(j7, SUMMER("C2")) = UREGPV_arr(i, UREGPV("C2")) '输入2比例因子
             SUMMER_arr(j7, SUMMER("C3")) = UREGPV_arr(i, UREGPV("C3")) '输入3比例因子
             SUMMER_arr(j7, SUMMER("C4")) = UREGPV_arr(i, UREGPV("C4")) '输入4比例因子
             SUMMER_arr(j7, SUMMER("C5")) = UREGPV_arr(i, UREGPV("C5")) '输入5比例因子
             SUMMER_arr(j7, SUMMER("C6")) = UREGPV_arr(i, UREGPV("C6")) '输入6比例因子
             SUMMER_arr(j7, SUMMER("D")) = UREGPV_arr(i, UREGPV("D"))   '偏置
             ConvDic.RemoveAll: ConvDic.Add "EQA", "0": ConvDic.Add "EQB", "1" '模式选择0-A,1-B
             SUMMER_arr(j7, SUMMER("PVEQN")) = ConvDic(UREGPV_arr(i, UREGPV("PVEQN")))
             
            j7 = j7 + 1 '行计数
        End If
        
    Next
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

    'UFLG转化为DM
    For i = 2 To UBound(UFLG_arr, 1)
  
            DM_arr(ii, DM("PN")) = UFLG_arr(i, UFLG("NAME")) '点名
            DM_arr(ii, DM("DS")) = UFLG_arr(i, UFLG("PTDESC")) '点描述
            DM_arr(ii, DM("SN")) = SN(UFLG_arr(i, UFLG("NODENUM")))  '站号
            DM_arr(ii, DM("E0")) = UFLG_arr(i, UFLG("STATETXT(0)")) '置0说明
            DM_arr(ii, DM("E1")) = UFLG_arr(i, UFLG("STATETXT(1)")) '置0说明
            DM_arr(ii, DM("DAMLV")) = DAMLV(UFLG_arr(i, UFLG("OFFNRMPR"))) '报警优先级OFFNRMPR对应DAMLV
            ii = ii + 1 '行计数

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
     'UREGPV变量TOTALIZR转为转化为BOOL
    For i = 2 To UBound(UREGPV_arr, 1)
        If UREGPV_arr(i, UREGPV("PVALGID")) = "TOTALIZR" Then
            DS_arr(ii, DS("PN")) = UREGPV_arr(i, UREGPV("NAME")) & "_RS" '点名
            DS_arr(ii, DS("DS")) = UREGPV_arr(i, UREGPV("PTDESC")) '点描述
            DS_arr(ii, DS("SN")) = SN(UREGPV_arr(i, UREGPV("NODENUM")))  '站号
            ii = ii + 1 '行计数
        End If
    Next
     
    '1-11-----转换VAL2和MOT2
    ii = 3 '第三行开始
    jj = 3 '第三行开始
    'UDC转化为VAL2和MOT2
    For i = 2 To UBound(UDC_arr, 1)
        If UDC_arr(i, UDC("M6BlockType")) = "VAL2" Then
            VAL2_arr(ii, VAL2("PN")) = UDC_arr(i, UDC("NAME"))  '点名
            VAL2_arr(ii, VAL2("DS")) = UDC_arr(i, UDC("PTDESC")) '点描述
            VAL2_arr(ii, VAL2("SN")) = SN(UDC_arr(i, UDC("NODENUM")))  '站号
            VAL2_arr(ii, VAL2("ONDESC")) = UDC_arr(i, UDC("STATETXT(1)"))  '开/启描述
            VAL2_arr(ii, VAL2("OFDESC")) = UDC_arr(i, UDC("STATETXT(0)"))  '关/停描述
            ii = ii + 1 '行计数
        End If
        
        If UDC_arr(i, UDC("M6BlockType")) = "MOT2" Then
            MOT2_arr(jj, MOT2("PN")) = UDC_arr(i, UDC("NAME"))  '点名
            MOT2_arr(jj, MOT2("DS")) = UDC_arr(i, UDC("PTDESC")) '点描述
            MOT2_arr(jj, MOT2("SN")) = SN(UDC_arr(i, UDC("NODENUM")))  '站号
            MOT2_arr(jj, MOT2("ONDESC")) = UDC_arr(i, UDC("STATETXT(1)"))  '开/启描述
            MOT2_arr(jj, MOT2("OFDESC")) = UDC_arr(i, UDC("STATETXT(0)"))  '关/停描述
            jj = jj + 1 '行计数
        End If
    Next
    
     '1-12-----转换UTIM
    ii = 3 '第三行开始
    For i = 2 To UBound(UTIM_arr, 1)

            HTIMER_arr(ii, HTIMER("PN")) = UTIM_arr(i, UTIM("NAME"))  '点名
            HTIMER_arr(ii, HTIMER("DS")) = UTIM_arr(i, UTIM("PTDESC")) '点描述
            HTIMER_arr(ii, HTIMER("SN")) = SN(UTIM_arr(i, UTIM("NODENUM")))  '站号
            HTIMER_arr(ii, HTIMER("UT")) = UTIM_arr(i, UTIM("EUDESC")) '单位
 
            'TIMEBASE:BOOL:=FALSE;(*SP时间量纲：0-秒 1-分钟*)
            'SP:WORD:=0;(*设定时间*)
            'RTSTIME01:RTSTIME;
            'STARTTIME:DWORD:=0;
            'RTSTIME02:RTSTIME;
            'CURTIME:DWORD:=0;
            'PRECOMM:BYTE:=0;
            'TEMSP:WORD:=0;(*设定时间*)
            'SPC:DWORD:=0;
            'SFLAG:BOOL:=FALSE;
            'TFLAG:WORD:=0;
            'TS:REAL:=0;(*采集周期 MS*)
            
            ConvDic.RemoveAll: ConvDic.Add "SECONDS", "0": ConvDic.Add "MINUTES", "1" 'SP时间量纲：0-秒 1-分钟
            HTIMER_arr(ii, HTIMER("TIMEBASE")) = ConvDic(UTIM_arr(i, UTIM("TIMEBASE")))
            
            HTIMER_arr(ii, HTIMER("SP")) = UTIM_arr(i, UTIM("SP")) 'SP时间量纲：0-秒 1-分钟
            
            
 
            ii = ii + 1 '行计数

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
    
        '2-15------删除旧表建立新表-FLOWCOMP
        Application.DisplayAlerts = False '关闭删除工作表提示框
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
    
'        '2-16------删除旧表建立新表-GENLIN
'        Application.DisplayAlerts = False '关闭删除工作表提示框
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
    
        '2-16------删除旧表建立新表-ONEFOLD
        Application.DisplayAlerts = False '关闭删除工作表提示框
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
    
    
        '2-17------删除旧表建立新表-HILOAVG
        Application.DisplayAlerts = False '关闭删除工作表提示框
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
    
        '2-18------删除旧表建立新表-MIDOF3
        Application.DisplayAlerts = False '关闭删除工作表提示框
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
    
'        '2-19------删除旧表建立新表-TOTALIZR
'        Application.DisplayAlerts = False '关闭删除工作表提示框
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
    
        '2-20------删除旧表建立新表-VDTLDLAG
        Application.DisplayAlerts = False '关闭删除工作表提示框
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
    
        '2-20_1------删除旧表建立新表-FLOWSUM
        Application.DisplayAlerts = False '关闭删除工作表提示框
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
        
   '2-23------删除旧表建立新表-SUMMER_CTRL
    Application.DisplayAlerts = False '关闭删除工作表提示框
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
    
   '2-23------删除旧表建立新表-TIMER
    Application.DisplayAlerts = False '关闭删除工作表提示框
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
    
    
    '4---------------------------------------------------------------激活主页
    Workbooks(wb_name).Activate
    Sheets("main").Select

End Sub

'-----------------------------------------------------------------------------------------------------------
'Purpose: 初始化模块地址值 - wb
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
    Dim NODENUM As String 'HN站号 09 10 13 15
    
    '遍历UPMCONFIG行，共2~5行
    For Row = 2 To 5
        '模块地址从10开始
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
            
            ' 当前是冗余主模块，模块地址必需为偶数
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
                
                '重设DN值
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
                
                '重设DN值
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
                
                '重设DN值
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
                
                '重设DN值
                If IOREDOPT_Value = "REDUN" Then
                    DN = DN + 4
                Else
                    DN = DN + 2
                End If
            Else 'NONE不处理
            End If
        Next 'Column = 1 To 20
        
        'UPMCONFIG1
        For Column = 21 To 40
            IOMTYPE = "IOMTYPE" & "(" & Column & ")"
            IOREDOPT = "IOREDOPT" & "(" & Column & ")"
            IOMTYPE_Value = UPMCONFIG1_arr(Row, UPMCONFIG1(IOMTYPE))
            IOREDOPT_Value = UPMCONFIG1_arr(Row, UPMCONFIG1(IOREDOPT))
            
            ' 当前是冗余主模块，模块地址必需为偶数
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
                
                '重设DN值
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
                
                '重设DN值
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
                
                '重设DN值
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
                
                '重设DN值
                If IOREDOPT_Value = "REDUN" Then
                    DN = DN + 4
                Else
                    DN = DN + 2
                End If
            Else 'NONE不处理
            End If
        Next 'Column = 21 To 40
    Next 'Row = 2 To 5

End Sub

'-----------------------------------------------------------------------------------------------------------
'Purpose: 剪贴板赋值 - wb
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
'Purpose: 设置模块地址值 - wb
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
