/**
 *  Zombies
 *
 *  File: zombiereloaded.sp
 *  Type: Core
 *
 *  Copyright (C) 2016 Collin Smith 
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "include/zm/compiler_settings.inc"

#include <sourcemod>

#include "include/logger.inc"

#include "include/util/params.inc"
#include "include/util/paths.inc"
#include "include/zm/inc/struct/extension.inc"
#include "include/zm/inc/zm_const.inc"
#include "include/zm/inc/zm_stocks.inc"
#include "include/zm/inc/zm_version.inc"

public Plugin pluginInfo = {
  name = ZM_NAME,
  author = "Tirant",
  description = "General Lightweight Zombie Mod API",
  version = ZM_VERSION_STRING,
  url = "http://www.sourcemod.net/"
};

static Logger g_Logger = null;
static ArrayList g_aExts = null;

public APLRes AskPluginLoad2(Handle h, bool isLate, char[] err, int errLen) {
  CreateNatives();
  return APLRes_Success;
}

void CreateNatives() {
  CreateNative("ZM_RegisterExtension", Native_RegisterExtension);
  CreateNative("ZM_GetExtensions", Native_GetExtensions);
  CreateNative("ZM_GetNumExtensions", Native_GetNumExtensions);
  CreateNative("ZM_IsValidExtension", Native_IsValidExtension);
}

public void OnPluginStart() {
  char buildId[32];
  ZM_GetBuildId(buildId, sizeof buildId - 1);

  g_Logger = new Logger();
#if defined ZM_DEBUG_MODE
  g_Logger.SetVerbosity(Severity_None);
#endif

  char pathFormat[PLATFORM_MAX_PATH];
  strcopy(pathFormat, sizeof pathFormat - 1, ZM_LOGS_DIR);
  g_Logger.SetPathFormat(pathFormat);
  g_Logger.SetMessageFormat("[%5v] [%t] %p - %s");

  g_Logger.Log(Severity_Info, "Launching %s v%s", ZM_MOD_NAME, buildId);
}

public void OnPluginEnd() {
  delete g_aExts;
}

public int Native_RegisterExtension(Handle plugin, int numParams) {
  Params_ValidateEqual(0, numParams);
  if (g_aExts == null) {
    g_aExts = CreateArray(.startsize=16);
  } else {
    int id = g_aExts.FindValue(plugin);
    if (id != -1) {
      ZM_Extension ext = view_as<ZM_Extension>(id+1);
      return view_as<int>(ext);
    }
  }

  ZM_Extension ext = view_as<ZM_Extension>(g_aExts.Push(plugin)+1);
  return view_as<int>(ext);
}

public int Native_GetExtensions(Handle plugin, int numParams) {
  Params_ValidateEqual(0, numParams);
  if (g_aExts == null) {
    // TODO: Return reference to immutable empty ArrayList
    return view_as<int>(CreateArray());
  }

  return view_as<int>(g_aExts.Clone());
}

public int Native_GetNumExtensions(Handle plugin, int numParams) {
  Params_ValidateEqual(0, numParams);
  if (g_aExts == null) {
    return 0;
  }

  return g_aExts.Length;
}

public int Native_IsValidExtension(Handle plugin, int numParams) {
  Params_ValidateEqual(1, numParams);
  if (g_aExts == null) {
    return false;
  }

  int ext = GetNativeCell(1);
  return 1 <= ext && ext <= g_aExts.Length;
}