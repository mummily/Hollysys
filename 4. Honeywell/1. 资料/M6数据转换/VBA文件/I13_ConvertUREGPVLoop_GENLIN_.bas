Attribute VB_Name = "I13_ConvertUREGPVLoop_GENLIN_"
'ver20190930_by cjt

'转化GENLIN
Sub I13_ConvertUREGPVLoop_GENLIN()

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
Dim OUT_ID As Long             'OUTid号变量

Dim Blok_Tag As String   '块位号
Dim IN_Tag As String     'IN位号
Dim OUT_Tag As String     'OUT位号

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
OUT_ID = Element_ID + 2      'OUTid号

'03---------位号tag获取
'块位号赋值
OUT_Tag = UREGPV_arr(UREGPV_i, UREGPV("NAME"))
Blok_Tag = OUT_Tag & "_FOLD"

'变量赋值：先转换再赋值
HNPN_TI = UREGPV_arr(UREGPV_i, UREGPV("PISRC(1)")) '待转换变量
Call F2_ConvertPN_TI(HNPN_TI) '转换
IN_Tag = M6PN_TI '赋值


'04---------写xml
'写块XML:'位号,ID,坐标X,坐标Y,数据流,块名
Call BOX_XML(Blok_Tag, Blok_ID, Element_X, Element_Y, Sort_ID, "ONEFOLD")
'-块输入引脚:写块输入引脚XML: 块引脚项名,块引脚连接的位号,块引脚连接的位号ID,是否显示引脚
Call BoxIn_XML("IN", IN_Tag, IN_ID, "true")
'-块输出引脚:写块输出引脚XML: 块引脚项名,是否显示引脚
Call BoxOut_XML("OUT", "true")
'--块结束
POU.WriteLine "</element>"

'04-02--输入元件:写输入元件XML: 位号,ID号,坐标X,坐标Y
Call Input_XML(IN_Tag, IN_ID, Element_X - 2, Element_Y + 1)

'04-03--输出元件:写输出元件XML:'位号,ID,坐标X,坐标Y,数据流,连接的块ID,连接的块输出引脚序号
Call Output_XML(OUT_Tag & ".AI", OUT_ID, Element_X + 9, Element_Y + 1, Sort_ID + 1, Blok_ID, 0)

'04-04--写参数X,Y
Dim jj2 As Integer
Dim varX As String
Dim varY As String

'初始参数
Element_ID = 10
Sort_ID = 2
Element_X = 20
Element_Y = 20

For jj2 = 0 To 12
     If Len(UREGPV_arr(UREGPV_i, UREGPV("IN" & jj2))) > 0 Then
         varX = UREGPV_arr(UREGPV_i, UREGPV("IN" & jj2))
         varY = UREGPV_arr(UREGPV_i, UREGPV("OUT" & jj2))
        'X点
         Element_Y = Element_Y + 1
         Element_ID = Element_ID + 1
         Call Input_XML(varX, Element_ID, Element_X, Element_Y)
         Element_ID = Element_ID + 1
         Sort_ID = Sort_ID + 1
         Call Output_XML(Blok_Tag & ".XARR[" & jj2 + 1 & "]", Element_ID, Element_X + 1, Element_Y, Sort_ID, Element_ID - 1, 0)

        'Y点
         Element_ID = Element_ID + 1
         Call Input_XML(varY, Element_ID, Element_X + 20, Element_Y)
         Element_ID = Element_ID + 1
         Sort_ID = Sort_ID + 1
         Call Output_XML(Blok_Tag & ".YARR[" & jj2 + 1 & "]", Element_ID, Element_X + 1 + 20, Element_Y, Sort_ID, Element_ID - 1, 0)
         
     End If
Next


End Sub



