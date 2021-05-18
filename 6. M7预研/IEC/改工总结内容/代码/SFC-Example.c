
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

// 下面为全局变量

// PRG POU变量
bool __AT__SFC_PRG = false;

// 当前时间
int __AT___TIME = 0;

// 步
Step INITSTEP;
Step STEP2;

// 转换
bool Trans1 = false;
bool Trans2 = false;
bool __AT__TEST_SFC = false;

// Step2定义的一个动作，动作名称为AAA
ActionControl __AT____AT__TEST_SFC_ACTIONCONTROL_AAA;

void main() {
    // 2 生成该POU的代码

    // 2.1 初始化内部状态
    if (!__AT__SFC_PRG) {
        __AT__SFC_PRG = true;        
        INITSTEP._X = true;
    }

    // 2.2 调用RTSTime
    __AT___TIME = RTSTIME();

    // 2.3 SFC POU执行逻辑

    // 2.3.1 出口动作调用
    if (INITSTEP.X && !INITSTEP._X) {
        // 
    }

    if (STEP2.X && !STEP2._X) {
        // 若步的目前状态是TRUE，下一步状态是FALSE
    }

    //2.3.2 入口动作调用
    if (!INITSTEP.X && STEP2._X) {
        // 
    }

    if (!STEP2.X && STEP2._X) {
        // 若步的目前状态是FALSE，下一步状态是TRUE
    }


    // 2.3.3 步状态赋值
    INITSTEP.X = INITSTEP._X;
    STEP2.X = STEP2._X;

    // 2.3.4 步持续时间
    if (INITSTEP.X) {
        INITSTEP.T = __AT___TIME - INITSTEP._T;
    }

    if (STEP2.X) {
        STEP2.T = __AT___TIME - STEP2._T;
    }

    //
    // 2.3.5 步动作的调用
    //
    if (INITSTEP.X) {
        // 执行步动作
    }

    if (STEP2.X) {
        // 执行步动作
    }

    //
    // 2.3.6 动作控制块调用以及动作的执行
    //       动作限定符定义的动作的执行

    SFC_ACTION_CONTROL_BLOCK();

    if (__AT____AT__TEST_SFC_ACTIONCONTROL_AAA.Q) {
        TEST_SFC_AAA();
    }


    //
    // 2.3.7 动作转换C代码
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