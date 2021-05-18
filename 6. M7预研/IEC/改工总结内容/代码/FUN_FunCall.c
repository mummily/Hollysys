
/*
ST语言代码

名称:
  CADD

返回值类型:
  INT

输入变量:
  INT a
  INT b
输入输出变量:
  INT c

全局变量:
  INT CADD_COUNT;

代码:

CADD_COUNT := CADD_COUNT + 1;
c := a + b;
CADD := c;

*/

// 生成代码
typedef struct {
  int16_t* a;
  int16_t* b;
  int16_t* c;
  int16_t* CADD_COUNT;
}TypeCADD;

int16_t CADD(TypeCADD* ptr) {
    *(ptr->CADD_COUNT) = *(ptr->CADD_COUNT) + 1;
    *(ptr->c) = *(ptr->a) + *(ptr->b);
    return ptr->c;
}

// 调用代码
TypeCADD t;
t.a = GLOBAL_A_ADDR;
t.b = GLOBAL_B_ADDR;
t.c = GLOBAL_C_ADDR;
t.CAD_COUNT = CADD_COUNT_ADDR;
CADD(&t);