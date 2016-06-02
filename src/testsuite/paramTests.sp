#pragma newdecls required
#define TESTSUITE

#include <sourcemod>
#include <testing>

#include "../include/util/params.inc"

public Plugin myinfo = {
  name = "paramValidationTests",
  author = "Tirant",
  description = "Tests for include/util/param_testing.inc",
  version = "0.0.1",
  url = "http://www.sourcemod.net/"
};

public void OnPluginStart() {
  RegServerCmd("tests", Command_TestAll);
  RegServerCmd("tests.util", Command_TestAll);
  RegServerCmd("tests.util.param_testing", Command_TestAll);
  RegServerCmd("tests.util.param_testing.Params_Equal",
      Command_Test_Equal);
  RegServerCmd("tests.util.param_testing.Params_LessThan",
      Command_Test_LessThan);
  RegServerCmd("tests.util.param_testing.Params_LessEqual",
      Command_Test_LessEqual);
  RegServerCmd("tests.util.param_testing.Params_GreaterThan",
      Command_Test_GreaterThan);
  RegServerCmd("tests.util.param_testing.Params_GreaterEqual",
      Command_Test_GreaterEqual);
}

void SetTestingContext() {
  char filename[32];
  GetPluginFilename(null, filename, sizeof filename - 1);
  SetTestContext(filename);
}

public Action Command_TestAll(int args) {
  Command_Test_Equal(0);
  Command_Test_LessThan(0);
  Command_Test_LessEqual(0);
  Command_Test_GreaterThan(0);
  Command_Test_GreaterEqual(0);
}

public Action Command_Test_Equal(int args) {
  SetTestingContext();
  AssertTrue("Testing if Params_Equal(0, 0)", Params_Equal(0, 0));
  AssertTrue("Testing if Params_Equal(1, 1)", Params_Equal(1, 1));
  AssertFalse("Testing if Params_Equal(0, 1)", Params_Equal(0, 1));
  AssertFalse("Testing if Params_Equal(1, 0)", Params_Equal(1, 0));
}

public Action Command_Test_LessThan(int args) {
  SetTestingContext();
  AssertTrue("Testing if Params_LessThan(1, 0)", Params_LessThan(1, 0));
  AssertTrue("Testing if Params_LessThan(2, 1)", Params_LessThan(2, 1));
  AssertTrue("Testing if Params_LessThan(2, 0)", Params_LessThan(2, 0));
  AssertFalse("Testing if Params_LessThan(0, 0)", Params_LessThan(0, 0));
  AssertFalse("Testing if Params_LessThan(1, 1)", Params_LessThan(1, 1));
  AssertFalse("Testing if Params_LessThan(1, 2)", Params_LessThan(1, 2));
}

public Action Command_Test_LessEqual(int args) {
  SetTestingContext();
  AssertTrue("Testing if Params_LessEqual(1, 0)", Params_LessEqual(1, 0));
  AssertTrue("Testing if Params_LessEqual(2, 1)", Params_LessEqual(2, 1));
  AssertTrue("Testing if Params_LessEqual(2, 0)", Params_LessEqual(2, 0));
  AssertTrue("Testing if Params_LessEqual(0, 0)", Params_LessEqual(0, 0));
  AssertTrue("Testing if Params_LessEqual(1, 1)", Params_LessEqual(1, 1));
  AssertFalse("Testing if Params_LessEqual(1, 2)", Params_LessEqual(1, 2));
}

public Action Command_Test_GreaterThan(int args) {
  SetTestingContext();
  AssertTrue("Testing if Params_GreaterThan(0, 1)", Params_GreaterThan(0, 1));
  AssertTrue("Testing if Params_GreaterThan(1, 2)", Params_GreaterThan(1, 2));
  AssertTrue("Testing if Params_GreaterThan(0, 2)", Params_GreaterThan(0, 2));
  AssertFalse("Testing if Params_GreaterThan(0, 0)", Params_GreaterThan(0, 0));
  AssertFalse("Testing if Params_GreaterThan(1, 1)", Params_GreaterThan(1, 1));
  AssertFalse("Testing if Params_GreaterThan(2, 1)", Params_GreaterThan(2, 1));
}

public Action Command_Test_GreaterEqual(int args) {
  SetTestingContext();
  AssertTrue("Testing if Params_GreaterEqual(0, 1)", Params_GreaterEqual(0, 1));
  AssertTrue("Testing if Params_GreaterEqual(1, 2)", Params_GreaterEqual(1, 2));
  AssertTrue("Testing if Params_GreaterEqual(0, 2)", Params_GreaterEqual(0, 2));
  AssertTrue("Testing if Params_GreaterEqual(0, 0)", Params_GreaterEqual(0, 0));
  AssertTrue("Testing if Params_GreaterEqual(1, 1)", Params_GreaterEqual(1, 1));
  AssertFalse("Testing if Params_GreaterEqual(2, 1)",Params_GreaterEqual(2, 1));
}