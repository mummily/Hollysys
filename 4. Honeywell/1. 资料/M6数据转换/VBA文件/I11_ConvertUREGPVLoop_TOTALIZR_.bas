Attribute VB_Name = "I11_ConvertUREGPVLoop_TOTALIZR_"
'ver20190930_by cjt

'转化TOTALIZR
Sub I11_ConvertUREGPVLoop_TOTALIZR()

'局部变量
'*****************************************************
'通用
Dim i As Integer '循环变量
Dim Element_NO As Long      '元件号号
Dim Element_X As Long       '元件X坐标
Dim Element_Y As Long       '元件Y坐标
Dim Element_ID As Long      '元件id号变量
Dim Sort_ID As Long         'Sid数据流存贮号

'pid用
Dim Blok_ID As Long            '块id号变量
Dim IN_ID As Long              'INid号变量
Dim RS_ID As Long              'RSid号变量
Dim OUT_ID As Long             'OUTid号变量
Dim FULLIND_ID As Long         'FULLINDid号变量
Dim OR_ID As Long              'ORid号变量

Dim Blok_Tag As String   '块位号
Dim IN_Tag As String     'IN位号
Dim RS_Tag As String     'RS位号
Dim OUT_Tag As String     'OUT位号
Dim FULLIND_Tag As String 'FULLIND位号
Dim OR_Tag As String      'OR位号

'*****************************************************


'01---------通用赋值
'初始值
Element_ID = 1         'id号
Sort_ID = 0            'Sid数据流存贮号变量
'块坐标
Element_X = 34         '方案页第一个块X坐标
Element_Y = 15         '方案页第一个块Y坐标

'02---------各种元件id号
'pid用
'获取ID\ID自加
Blok_ID = Element_ID         '块id号
IN_ID = Element_ID + 1       'INid号
RS_ID = Element_ID + 2       'RSid号
FULLIND_ID = Element_ID + 3  'FULLINDid号
OUT_ID = Element_ID + 4      'OUTid号
OR_ID = Element_ID + 5       'ORid号

'03---------位号tag获取
'块位号赋值
OUT_Tag = UREGPV_arr(UREGPV_i, UREGPV("NAME"))
Blok_Tag = OUT_Tag & "_SUM"
FULLIND_Tag = Blok_Tag & ".FULLIND"
RS_Tag = OUT_Tag & "_RS"
'变量赋值：先转换再赋值
HNPN_TI = UREGPV_arr(UREGPV_i, UREGPV("PISRC(1)")) '待转换变量
Call F2_ConvertPN_TI(HNPN_TI) '转换
IN_Tag = M6PN_TI '赋值




'04---------写xml
'写块XML:'位号,ID,坐标X,坐标Y,数据流,块名
Call BOX_XML(Blok_Tag, Blok_ID, Element_X, Element_Y, Sort_ID, "FLOWSUM")
'-块输入引脚:写块输入引脚XML: 块引脚项名,块引脚连接的位号,块引脚连接的位号ID,是否显示引脚
Call BoxIn_XML("IN", IN_Tag, IN_ID, "true")
Call BoxIn_XML("RST", RS_Tag, OR_ID, "true")
'-块输出引脚:写块输出引脚XML: 块引脚项名,是否显示引脚
Call BoxOut_XML("OUT", "true")
'--块结束
POU.WriteLine "</element>"

'04-02--输入元件:写输入元件XML: 位号,ID号,坐标X,坐标Y
Call Input_XML(IN_Tag, IN_ID, Element_X - 2, Element_Y + 1)

'04-03--输出元件:写输出元件XML:'位号,ID,坐标X,坐标Y,数据流,连接的块ID,连接的块输出引脚序号
Call Output_XML(OUT_Tag & ".AI", OUT_ID, Element_X + 9, Element_Y + 1, Sort_ID + 1, Blok_ID, 0)

'04-04--块开始
'写块XML:'块类型,块类ID,块类坐标X,块类坐标Y,块类数据流,EN连接的元件id,输入1连接的元件id,输入2连接的元件id,是否显示EN
Call BOX2_XML("OR", OR_ID, Element_X - 6, Element_Y + 3, Sort_ID + 2, -1, RS_ID, FULLIND_ID, False)

'04-05--输入元件:写输入元件XML: 位号,ID号,坐标X,坐标Y
Call Input_XML(RS_Tag, RS_ID, Element_X - 7, Element_Y + 4)
Call Input_XML(FULLIND_Tag, FULLIND_ID, Element_X - 7, Element_Y + 5)


End Sub


