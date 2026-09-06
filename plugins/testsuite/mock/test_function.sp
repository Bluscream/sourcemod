#pragma semicolon 1
#pragma newdecls required

#include <sourcemod>
#include <testing>


public void OnPluginStart()
{
    Test_GetFunctionByName();
}


void Test_GetFunctionByName()
{
    SetTestContext("Test GetFunctionByName");

    Function func = GetFunctionByName(INVALID_HANDLE, "__Func");
    AssertTrue("Function is valid", func != INVALID_FUNCTION);
    AssertTrue("Function is __Func", func == __Func);

    int result = 0;
    Call_StartFunction(INVALID_HANDLE, func);
    Call_PushCell(1);
    Call_PushCell(2);
    Call_Finish(result);
    AssertEq("Function result", result, 3);
}


public int __Func(int a, int b)
{
    AssertEq("__Func param a", a, 1);
    AssertEq("__Func param b", b, 2);
    return a + b;
}
