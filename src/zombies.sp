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

#include "include/param_test_stocks.inc"
#include "include/zm/inc/struct/extension.inc"
#include "include/zm/inc/zm_const.inc"
#include "include/zm/inc/zm_stocks.inc"

public Plugin pluginInfo = {
  name = ZM_NAME,
  author = "Tirant",
  description = "General Lightweight Zombie Mod API",
  version = ZM_VERSION_STRING,
  url = "http://www.sourcemod.net/"
};

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
}

public void OnPluginEnd() {
  delete g_aExts;
}

public int Native_RegisterExtension(Handle plugin, numParams) {
  ValidateParamsEqual(0, numParams);
  if (g_aExts == null) {
    g_aExts = CreateArray(.startsize=16);
  } else {
    int id = g_aExts.FindValue(plugin);
    if (id != -1) {
      ZM_Extension ext = ZM_Extension:(id+1);
      return any:ext;
    }
  }

  ZM_Extension ext = ZM_Extension:(g_aExts.Push(plugin)+1);
  return any:ext;
}

public int Native_GetExtensions(Handle plugin, numParams) {
  ValidateParamsEqual(0, numParams);
  if (g_aExts == null) {
    // TODO: Return reference to immutable empty ArrayList
    return CreateArray();
  }

  return view_as<int>(g_aExts.Clone());
}

public int Native_GetNumExtensions(Handle plugin, numParams) {
  ValidateParamsEqual(0, numParams);
  if (g_aExts == null) {
    return 0;
  }

  return g_aExts.Length;
}

public int Native_IsValidExtension(Handle plugin, numParams) {
  ValidateParamsEqual(1, numParams);
  if (g_aExts == null) {
    return false;
  }

  int ext = GetNativeCell(1);
  return 1 <= ext && ext <= g_aExts.Length;
}