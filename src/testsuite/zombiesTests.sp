#pragma newdecls required
#define TESTSUITE

#include <sourcemod>
#include <testing>

#include "../include/zombies.inc"

public Plugin myinfo = {
    name = "zombiesTests",
    author = "Tirant",
    description = "Tests for zombies.sp",
    version = "0.0.1",
    url = "http://www.sourcemod.net/"
};

static Handle thisPlugin = null;

public APLRes AskPluginLoad2(Handle self, bool isLate, char[] err, int errLen) {
  thisPlugin = self;
  return APLRes_Success;
}

public void OnPluginStart() {
  RegServerCmd("tests", Command_TestAll);
  RegServerCmd("tests.zombies", Command_TestAll);
  RegServerCmd("tests.zombies.ZM_RegisterExtension",
      Command_TestRegisterExtension);
  RegServerCmd("tests.zombies.ZM_GetExtensions",
      Command_TestGetExtensions);
}

void SetTestingContext() {
  char filename[32];
  GetPluginFilename(null, filename, sizeof filename - 1);
  SetTestContext(filename);
}

public Action Command_TestAll(int args) {
  Command_TestRegisterExtension(0);
  Command_TestGetExtensions(0);
}

public Action Command_TestRegisterExtension(int args) {
  SetTestingContext();
  ZM_Extension ext = ZM_RegisterExtension();
  AssertTrue("Testing if ZM_RegisterExtension return Handle non-null",
      ext != null);
  AssertTrue(
      "Testing if ZM_RegisterExtension return Handle passes \
       ZM_IsValidExtension(int)",
      ZM_IsValidExtension(ext));
  ZM_Extension ext2 = ZM_RegisterExtension();
  AssertTrue(
      "Testing if ZM_RegisterExtension return Handle matches Handle \
       from duplicate registration",
      ext == ext2);
  AssertTrue("Testing if ZM_GetNumExtensions > 0", ZM_GetNumExtensions() > 0);
}

public Action Command_TestGetExtensions(int args) {
  SetTestingContext();
  ArrayList exts = ZM_GetExtensions();
  ZM_Extension ext = ZM_RegisterExtension();
  int id = exts.FindValue(thisPlugin);
  AssertTrue("Testing if ZM_GetExtensions contains a Handle to this plugin",
      id != -1);
  AssertTrue("Testing if ZM_GetExtensions Handle to this plugin is correct",
      thisPlugin == view_as<Handle>(exts.Get(id)));
  ZM_Extension ext2 = view_as<ZM_Extension>(id+1);
  AssertTrue(
      "Testing if ZM_GetExtensions Handle under this plugin is equal to \
       the registered extension",
      ext == ext2);
}