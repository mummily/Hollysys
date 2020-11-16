#ifndef  __LKX_TEST_H_ 

#define __LKX_TEST_H_ 

#include <stdint.h> 
#include <stdbool.h> 

#define hol_g_p_lkx_test_a  ((int8_t*)0x1123456)
#define hol_g_p_lkx_test_x3 ((uint16_t*)0x1123456)
#define hol_g_p_lkx_test_n1 ((bool*)0x1123456)
#define hol_g_p_lkx_test_i  ((int16_t*)0x1123456)
#define hol_g_p_lkx_test_b  ((uint16_t*)0x1123456)
#define hol_g_p_lkx_test_sum    ((unsigned char*)0x1123456)

void  lkx_test();

#endif //__LKX_TEST_H_ 