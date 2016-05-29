#if defined _util_param_testing_included
    #endinput
#endif
#define _util_param_testing_included

#include <functions>

#if defined TESTSUITE
  #include "../include/util/math.inc"
  #include "../include/util/string.inc"
#else
  #include "include/util/math.inc"
  #include "include/util/string.inc"
#endif

/*******************************************************************************
 * STOCKS
 ******************************************************************************/

stock bool ParamsEqual(int expected, int actual) {
  return expected == actual;
}

stock bool ParamsLessThan(int expected, int actual) {
  return actual < expected;
}

stock bool ParamsLessEqual(int expected, int actual) {
  return actual <= expected;
}

stock bool ParamsGreaterThan(int expected, int actual) {
  return expected < actual;
}

stock bool ParamsGreaterEqual(int expected, int actual) {
  return expected <= actual;
}

stock ValidateParamsEqual(int expected, int actual) {
  if (!ParamsEqual(expected, actual)) {
    ThrowNativeError(SP_ERROR_NATIVE,
        "Invalid number of params: Expected %d, actual %d",
        expected, actual);
  }
}

stock ValidateParamsLessThan(int expected, int actual) {
  if (!ParamsLessThan(expected, actual)) {
    ThrowNativeError(SP_ERROR_NATIVE,
        "Invalid number of params: Expected less than %d, actual %d",
        expected, actual);
  }
}

stock ValidateParamsLessEqual(int expected, int actual) {
  if (!ParamsLessEqual(expected, actual)) {
    ThrowNativeError(SP_ERROR_NATIVE,
        "Invalid number of params: Expected less than or equal to %d, \
         actual %d",
        expected, actual);
  }
}

stock ValidateParamsGreaterThan(int expected, int actual) {
  if (!ParamsGreaterThan(expected, actual)) {
    ThrowNativeError(SP_ERROR_NATIVE,
        "Invalid number of params: Expected greater than %d, actual %d",
        expected, actual);
  }
}

stock ValidateParamsGreaterEqual(int expected, int actual) {
  if (!ParamsGreaterEqual(expected, actual)) {
    ThrowNativeError(SP_ERROR_NATIVE,
        "Invalid number of params: Expected greater than or equal to %d, \
         actual %d",
        expected, actual);
  }
}

stock ValidateParamsOneOf(int[] set, int sizeofSet, int actual) {
  int id = Array_FindValue(set, sizeof set, actual);
  if (id == -1) {
    char tmp[64];
    Array_IntsToString(tmp, sizeof tmp, set, sizeofSet);
    ThrowNativeError(SP_ERROR_NATIVE,
        "Invalid number of params: Expected one of %s, actual %d",
        tmp, actual);
  }
}

stock ValidateTrue(bool condition, const char[] message) {
  if (!condition) {
    ThrowNativeError(SP_ERROR_NATIVE, message);
  }
}

stock ValidateFalse(bool condition, const char[] message) {
  if (condition) {
    ThrowNativeError(SP_ERROR_NATIVE, message);
  }
}