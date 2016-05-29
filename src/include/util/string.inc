#if defined _util_string_included
    #endinput
#endif
#define _util_string_included

#if defined TESTSUITE
  #include "../include/util/math.inc"
#else
  #include "include/util/math.inc"
#endif

/*******************************************************************************
 * STOCKS
 ******************************************************************************/

stock Array_IntsToString(char[] dst, int dstLen,
                         const int[] ints, int sizeofInts,
                         const char[] prefix = "[",
                         const char[] infix = ",",
                         const char[] postfix = "]") {
    new tempLen = strcopy(dst, dstLen, prefix);
    for (new i = 0; i < sizeofInts && tempLen < dstLen; i++) {
        if (i > 0) {
            tempLen += strcopy(dst[tempLen], dstLen - tempLen, infix);
        }

        tempLen += IntToString(ints[i], dst[tempLen], dstLen - tempLen);
    }

    tempLen += strcopy(dst[tempLen], dstLen - tempLen, postfix);
    tempLen = Math_Min(dstLen - 1, tempLen);
    dst[tempLen] = EOS;
    return tempLen;
}

stock Array_FloatsToString(char[] dst, int dstLen,
                           const float[] floats, int sizeofFloats,
                           const char[] prefix = "[",
                           const char[] infix = ",",
                           const char[] postfix = "]") {
    new tempLen = strcopy(dst, dstLen, prefix);
    for (new i = 0; i < sizeofFloats && tempLen < dstLen; i++) {
        if (i > 0) {
            tempLen += strcopy(dst[tempLen], dstLen - tempLen, infix);
        }

        tempLen += FloatToString(floats[i], dst[tempLen], dstLen - tempLen);
    }

    tempLen += strcopy(dst[tempLen], dstLen - tempLen, postfix);
    tempLen = Math_Min(dstLen - 1, tempLen);
    dst[tempLen] = EOS;
    return tempLen;
}

stock String_StringJoin(char[] dst, int dstLen,
                        const char[][] strings, int sizeofStrings,
                        const char[] prefix = "[",
                        const char[] infix = ",",
                        const char[] postfix = "]") {
    new tempLen = strcopy(dst, dstLen, prefix);
    for (new i = 0; i < sizeofStrings && tempLen < dstLen; i++) {
        if (i > 0) {
            tempLen += strcopy(dst[tempLen], dstLen - tempLen, infix);
        }

        tempLen += strcopy(dst[tempLen], dstLen - tempLen, strings[i]);
    }

    tempLen += strcopy(dst[tempLen], dstLen - tempLen, postfix);
    tempLen = Math_Min(dstLen - 1, tempLen);
    dst[tempLen] = EOS;
    return tempLen;
}