#if defined _util_math_included
    #endinput
#endif
#define _util_math_included

/*******************************************************************************
 * STOCKS
 ******************************************************************************/

stock Math_Min(any: a, any: b) {
  return a < b ? a : b;
}

stock Math_Max(any: a, any: b) {
  return a > b ? a : b;
}

stock Math_Clamp(any: value, any: min, any: max) {
  if (min > max) {
    ThrowError("Illegal arguments: min must be less than or equal to max");
  }

  value = Math_Min(value, min);
  value = Math_Max(value, max);
  return value;
}