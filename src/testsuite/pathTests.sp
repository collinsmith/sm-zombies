#pragma newdecls required
#define TESTSUITE

#include <sourcemod>
#include <testing>

#include "../include/util/paths.inc"

public Plugin pluginInfo = {
  name = "pathTests",
  author = "csmith",
  description = "Tests for include/util/paths.inc",
  version = "0.0.1",
  url = "http://www.sourcemod.net/"
};

public void OnPluginStart() {
  RegServerCmd("tests", Command_TestAll);
  RegServerCmd("tests.util", Command_TestAll);
  RegServerCmd("tests.util.paths", Command_TestAll);
  RegServerCmd("tests.util.paths.Paths_FixPath",
      Command_Test_FixPath);
}

void SetTestingContext() {
  char filename[32];
  GetPluginFilename(null, filename, sizeof filename - 1);
  SetTestContext(filename);
}

public Action Command_TestAll(int args) {
  Command_Test_FixPath(0);
}

public Action Command_Test_FixPath(int args) {
  SetTestingContext();
  
  char path1[] = "this/is/a/test";
  Test_FixPath(path1, sizeof path1, "this/is/a/test");
  char path2[] = "this\\is/a/test";
  Test_FixPath(path2, sizeof path2, "this/is/a/test");
  char path3[] = "this\\is\\a/test";
  Test_FixPath(path3, sizeof path3, "this/is/a/test");
  char path4[] = "this\\is\\a\\test";
  Test_FixPath(path4, sizeof path4, "this/is/a/test");
  char path5[] = "this/is/a\\test";
  Test_FixPath(path5, sizeof path5, "this/is/a/test");
  char path6[] = "this/is\\a\\test";
  Test_FixPath(path6, sizeof path6, "this/is/a/test");
}

void Test_FixPath(char[] path, int len, const char[] solution) {
  char text[64];
  FormatEx(text, sizeof text - 1, "Fixed path matches %s", solution);

  Paths_FixPath(path, len);
  AssertTrue(text, StrEqual(path, solution));
}