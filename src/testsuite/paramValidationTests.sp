#define TESTSUITE

#include <sourcemod>
#include <testing>

#include "../include/util/param_testing.inc"

public Plugin pluginInfo = {
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
  RegServerCmd("tests.util.param_testing.ParamsEqual",
      Command_Test_ParamsEqual);
  RegServerCmd("tests.util.param_testing.ParamsLessThan",
      Command_Test_ParamsLessThan);
  RegServerCmd("tests.util.param_testing.ParamsLessEqual",
      Command_Test_ParamsLessEqual);
  RegServerCmd("tests.util.param_testing.ParamsGreaterThan",
      Command_Test_ParamsGreaterThan);
  RegServerCmd("tests.util.param_testing.ParamsGreaterEqual",
      Command_Test_ParamsGreaterEqual);
}

void SetTestingContext() {
  char filename[32];
  GetPluginFilename(null, filename, sizeof filename - 1);
  SetTestContext(filename);
}

public Action Command_TestAll(int args) {
  Command_Test_ParamsEqual(0);
  Command_Test_ParamsLessThan(0);
  Command_Test_ParamsLessEqual(0);
  Command_Test_ParamsGreaterThan(0);
  Command_Test_ParamsGreaterEqual(0);
}

public Action Command_Test_ParamsEqual(int args) {
  SetTestingContext();
  AssertTrue("Testing if ParamsEqual(0, 0)", ParamsEqual(0, 0));
  AssertTrue("Testing if ParamsEqual(1, 1)", ParamsEqual(1, 1));
  AssertFalse("Testing if ParamsEqual(0, 1)", ParamsEqual(0, 1));
  AssertFalse("Testing if ParamsEqual(1, 0)", ParamsEqual(1, 0));
}

public Action Command_Test_ParamsLessThan(int args) {
  SetTestingContext();
  AssertTrue("Testing if ParamsLessThan(1, 0)", ParamsLessThan(1, 0));
  AssertTrue("Testing if ParamsLessThan(2, 1)", ParamsLessThan(2, 1));
  AssertTrue("Testing if ParamsLessThan(2, 0)", ParamsLessThan(2, 0));
  AssertFalse("Testing if ParamsLessThan(0, 0)", ParamsLessThan(0, 0));
  AssertFalse("Testing if ParamsLessThan(1, 1)", ParamsLessThan(1, 1));
  AssertFalse("Testing if ParamsLessThan(1, 2)", ParamsLessThan(1, 2));
}

public Action Command_Test_ParamsLessEqual(int args) {
  SetTestingContext();
  AssertTrue("Testing if ParamsLessEqual(1, 0)", ParamsLessEqual(1, 0));
  AssertTrue("Testing if ParamsLessEqual(2, 1)", ParamsLessEqual(2, 1));
  AssertTrue("Testing if ParamsLessEqual(2, 0)", ParamsLessEqual(2, 0));
  AssertTrue("Testing if ParamsLessEqual(0, 0)", ParamsLessEqual(0, 0));
  AssertTrue("Testing if ParamsLessEqual(1, 1)", ParamsLessEqual(1, 1));
  AssertFalse("Testing if ParamsLessEqual(1, 2)", ParamsLessEqual(1, 2));
}

public Action Command_Test_ParamsGreaterThan(int args) {
  SetTestingContext();
  AssertTrue("Testing if ParamsGreaterThan(0, 1)", ParamsGreaterThan(0, 1));
  AssertTrue("Testing if ParamsGreaterThan(1, 2)", ParamsGreaterThan(1, 2));
  AssertTrue("Testing if ParamsGreaterThan(0, 2)", ParamsGreaterThan(0, 2));
  AssertFalse("Testing if ParamsGreaterThan(0, 0)", ParamsGreaterThan(0, 0));
  AssertFalse("Testing if ParamsGreaterThan(1, 1)", ParamsGreaterThan(1, 1));
  AssertFalse("Testing if ParamsGreaterThan(2, 1)", ParamsGreaterThan(2, 1));
}

public Action Command_Test_ParamsGreaterEqual(int args) {
  SetTestingContext();
  AssertTrue("Testing if ParamsGreaterEqual(0, 1)", ParamsGreaterEqual(0, 1));
  AssertTrue("Testing if ParamsGreaterEqual(1, 2)", ParamsGreaterEqual(1, 2));
  AssertTrue("Testing if ParamsGreaterEqual(0, 2)", ParamsGreaterEqual(0, 2));
  AssertTrue("Testing if ParamsGreaterEqual(0, 0)", ParamsGreaterEqual(0, 0));
  AssertTrue("Testing if ParamsGreaterEqual(1, 1)", ParamsGreaterEqual(1, 1));
  AssertFalse("Testing if ParamsGreaterEqual(2, 1)", ParamsGreaterEqual(2, 1));
}