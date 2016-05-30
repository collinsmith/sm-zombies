#if defined _zm_version_included
    #endinput
#endif
#define _zm_version_included

/**
 * Defines the version of Zombies
 */
#define ZM_VERSION 1.0.0

/**
 * String representation of the version of Zombies. This should match the value
 * of the definition.
 */
stock const char ZM_VERSION_STRING[] = "1.0.0";

stock int ZM_GetBuildId(char[] dst, int len) {
#if defined ZM_DEBUG_MODE
  return FormatEx(dst, len, "%s [%s] [DEBUG]", ZM_VERSION_STRING, __DATE__);
#else
  return FormatEx(dst, len, "%s [%s]", ZM_VERSION_STRING, __DATE__);
#endif
}