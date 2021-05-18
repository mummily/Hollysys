
/*
ST���Դ���

����:
  CADD

����ֵ����:
  INT

�������:
  INT a
  INT b
�����������:
  INT c

ȫ�ֱ���:
  INT CADD_COUNT;

����:

CADD_COUNT := CADD_COUNT + 1;
c := a + b;
CADD := c;

*/

// ���ɴ���
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

// ���ô���
TypeCADD t;
t.a = GLOBAL_A_ADDR;
t.b = GLOBAL_B_ADDR;
t.c = GLOBAL_C_ADDR;
t.CAD_COUNT = CADD_COUNT_ADDR;
CADD(&t);