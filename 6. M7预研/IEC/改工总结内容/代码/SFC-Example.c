
#include <stdbool.h>

int RTSTIME();

typedef struct tagStep {
    bool X;
    int T;
    bool _X;
    int _T;
}Step;

typedef struct tagActionControl {
    bool Q;
}ActionControl;

// ����Ϊȫ�ֱ���

// PRG POU����
bool __AT__SFC_PRG = false;

// ��ǰʱ��
int __AT___TIME = 0;

// ��
Step INITSTEP;
Step STEP2;

// ת��
bool Trans1 = false;
bool Trans2 = false;
bool __AT__TEST_SFC = false;

// Step2�����һ����������������ΪAAA
ActionControl __AT____AT__TEST_SFC_ACTIONCONTROL_AAA;

void main() {
    // 2 ���ɸ�POU�Ĵ���

    // 2.1 ��ʼ���ڲ�״̬
    if (!__AT__SFC_PRG) {
        __AT__SFC_PRG = true;        
        INITSTEP._X = true;
    }

    // 2.2 ����RTSTime
    __AT___TIME = RTSTIME();

    // 2.3 SFC POUִ���߼�

    // 2.3.1 ���ڶ�������
    if (INITSTEP.X && !INITSTEP._X) {
        // 
    }

    if (STEP2.X && !STEP2._X) {
        // ������Ŀǰ״̬��TRUE����һ��״̬��FALSE
    }

    //2.3.2 ��ڶ�������
    if (!INITSTEP.X && STEP2._X) {
        // 
    }

    if (!STEP2.X && STEP2._X) {
        // ������Ŀǰ״̬��FALSE����һ��״̬��TRUE
    }


    // 2.3.3 ��״̬��ֵ
    INITSTEP.X = INITSTEP._X;
    STEP2.X = STEP2._X;

    // 2.3.4 ������ʱ��
    if (INITSTEP.X) {
        INITSTEP.T = __AT___TIME - INITSTEP._T;
    }

    if (STEP2.X) {
        STEP2.T = __AT___TIME - STEP2._T;
    }

    //
    // 2.3.5 �������ĵ���
    //
    if (INITSTEP.X) {
        // ִ�в�����
    }

    if (STEP2.X) {
        // ִ�в�����
    }

    //
    // 2.3.6 �������ƿ�����Լ�������ִ��
    //       �����޶�������Ķ�����ִ��

    SFC_ACTION_CONTROL_BLOCK();

    if (__AT____AT__TEST_SFC_ACTIONCONTROL_AAA.Q) {
        TEST_SFC_AAA();
    }


    //
    // 2.3.7 ����ת��C����
    //
    __AT__TEST_SFC = Trans1;

    if (INITSTEP.X && __AT__TEST_SFC) {
        INITSTEP._X = false;
        INITSTEP.T = 0;
        STEP2._X = true;
        STEP2._T = __AT___TIME;
    }

    __AT__TEST_SFC = Trans2;
    if (STEP2.X && __AT__TEST_SFC) {
        STEP2._X = false;
        STEP2.T = 0;
        INITSTEP._X = true;
        INITSTEP._T =  __AT___TIME;
    }
}