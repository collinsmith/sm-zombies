#include "include/zm/compiler_settings.inc"

#include <sourcemod>

#include "include/zombies.inc"

public void ZM_OnZombiesInit() {
  RegConsoleCmd("zm.version", Command_PrintVersion, "Prints version info about this plugin.");
}

public Action Command_PrintVersion(int client, int args) {
  char buildId[32];
  ZM_GetBuildId(buildId, sizeof buildId - 1);
  ReplyToCommand(client, buildId);
  return Plugin_Handled;
}