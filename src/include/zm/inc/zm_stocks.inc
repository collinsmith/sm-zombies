#if defined _zm_stocks_included
    #endinput
#endif
#define _zm_stocks_included

#if defined TESTSUITE
  #include "../include/zm/inc/zm_const.inc"
  #include "../include/util/strings.inc"
#else
  #include "include/zm/inc/zm_const.inc"
  #include "include/util/strings.inc"
#endif

#define LOG_EXT ".log"

/*******************************************************************************
 * STOCKS
 ******************************************************************************/

stock int ZM_GetLogsDir(char[] dst, int len) {
  return BuildPath(Path_SM, dst, len, "logs/%s", ZM_LOGS_DIR);
}

stock int ZM_GetLogFile(char[] dst, int len) {
  static char timestamp[32];
  if (Strings_IsEmpty(timestamp)) {
    int time = GetTime();
    FormatTime(timestamp, sizeof timestamp - 1, "%Y%m%d", time);
  }

  int curLen = ZM_GetLogsDir(dst, len);
  dst[curLen++] = '/';
  curLen += strcopy(dst[curLen], len - curLen, timestamp);
  curLen += strcopy(dst[curLen], len - curLen, LOG_EXT);
  return curLen;
}