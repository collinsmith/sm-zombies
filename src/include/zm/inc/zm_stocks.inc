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

/*******************************************************************************
 * STOCKS
 ******************************************************************************/

stock int ZM_GetLogsDir(char[] dst, int len) {
  return BuildPath(Path_SM, dst, len, "logs/%s", ZM_LOGS_DIR);
}