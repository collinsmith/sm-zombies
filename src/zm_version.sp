#include "include/zm/compiler_settings.inc"

#include <sourcemod>

#include "include/zombies.inc"

static ZM_Extension g_thisExtension = null;

public void ZM_OnZombiesInit() {
  g_thisExtension = ZM_RegisterExtension();

  ZM_GetLogger().Log(Severity_Debug, "Registering console cmd \"zm.version\"");
  RegConsoleCmd("zm.version", Command_PrintVersion,
    "Prints version info about Zombies plugin.");
}

public Action Command_PrintVersion(int client, int args) {
  char buildId[32];
  ZM_GetBuildId(buildId, sizeof buildId - 1);
  ReplyToCommand(client, buildId);
  return Plugin_Handled;
}