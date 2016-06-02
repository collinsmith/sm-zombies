#pragma newdecls required
#define TESTSUITE

#include <sourcemod>
#include <testing>

#include "../include/util/strings.inc"

public Plugin myinfo = {
  name = "stringTests",
  author = "Tirant",
  description = "Tests for include/util/string.inc",
  version = "0.0.1",
  url = "http://www.sourcemod.net/"
};

public void OnPluginStart() {
  RegServerCmd("tests", Command_TestAll);
  RegServerCmd("tests.util", Command_TestAll);
  RegServerCmd("tests.util.string", Command_TestAll);
  RegServerCmd("tests.util.string.Strings_IntsToString",
      Command_Test_IntsToString);
  RegServerCmd("tests.util.string.Strings_FloatsToString",
      Command_Test_FloatsToString);
  RegServerCmd("tests.util.string.Strings_StringJoin",
      Command_Test_StringJoin);
}

void SetTestingContext() {
  char filename[32];
  GetPluginFilename(null, filename, sizeof filename - 1);
  SetTestContext(filename);
}

public Action Command_TestAll(int args) {
  Command_Test_IntsToString(0);
  Command_Test_FloatsToString(0);
  Command_Test_StringJoin(0);
}

public Action Command_Test_IntsToString(int args) {
  SetTestingContext();

  char tmp[128];
  int ints1[] = { 2 };
  Strings_IntsToString(tmp, sizeof tmp, ints1, sizeof ints1);
  AssertTrue(tmp, StrEqual(tmp, "[2]"));

  int ints2[] = { 2, 3 };
  Strings_IntsToString(tmp, sizeof tmp, ints2, sizeof ints2);
  AssertTrue(tmp, StrEqual(tmp, "[2,3]"));

  int ints3[] = { 2, 3, 5, 7, 11 };
  Strings_IntsToString(tmp, sizeof tmp, ints3, sizeof ints3);
  AssertTrue(tmp, StrEqual(tmp, "[2,3,5,7,11]"));
}

public Action Command_Test_FloatsToString(int args) {
  SetTestingContext();

  char tmp[128];
  float floats1[] = { 2.0 };
  Strings_FloatsToString(tmp, sizeof tmp, floats1, sizeof floats1);
  AssertTrue(tmp, StrEqual(tmp, "[2.000000]"));

  float floats2[] = { 2.0, 3.0 };
  Strings_FloatsToString(tmp, sizeof tmp, floats2, sizeof floats2);
  AssertTrue(tmp, StrEqual(tmp, "[2.000000,3.000000]"));

  float floats3[] = { 2.0, 3.0, 5.0, 7.0, 11.0 };
  Strings_FloatsToString(tmp, sizeof tmp, floats3, sizeof floats3);
  AssertTrue(tmp,
      StrEqual(tmp, "[2.000000,3.000000,5.000000,7.000000,11.000000]"));
}

public Action Command_Test_StringJoin(int args) {
  SetTestingContext();

  char tmp[128];
  char strings1[][] = { "apple" };
  Strings_StringJoin(tmp, sizeof tmp, strings1, sizeof strings1);
  AssertTrue(tmp, StrEqual(tmp, "[apple]"));

  char strings2[][] = { "pepperoni", "pizza" };
  Strings_StringJoin(tmp, sizeof tmp, strings2, sizeof strings2);
  AssertTrue(tmp, StrEqual(tmp, "[pepperoni,pizza]"));

  char strings3[][] = { "this", "is", "a", "test" };
  Strings_StringJoin(tmp, sizeof tmp, strings3, sizeof strings3);
  AssertTrue(tmp, StrEqual(tmp, "[this,is,a,test]"));

  char strings4[][] = { "models", "player", "gign", "gign.mdl" };
  Strings_StringJoin(tmp, sizeof tmp, strings4, sizeof strings4,
      NULL_STRING, "/", NULL_STRING);
  AssertTrue(tmp, StrEqual(tmp, "models/player/gign/gign.mdl"));
}