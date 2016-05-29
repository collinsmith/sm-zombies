#if defined _zombies_included
    #endinput
#endif
#define _zombies_included

#if defined TESTSUITE
  #include "../include/zm/inc/struct/extension.inc"
  #include "../include/zm/inc/zm_const.inc"
  #include "../include/zm/inc/zm_stocks.inc"
#else
  #include "include/zm/inc/struct/extension.inc"
  #include "include/zm/inc/zm_const.inc"
  #include "include/zm/inc/zm_stocks.inc"
#endif

/*******************************************************************************
 * FORWARDS
 ******************************************************************************/

//...

/*******************************************************************************
 * NATIVES
 ******************************************************************************/

/**
 * Registers the calling plugin as an extension of Zombies, and thus, a user of
 * its API. While it is not a requirement for a plugin to register itself with
 * Zombies, it is considered good bookkeeping in order to keep track of the
 * Zombies extensions.
 * 
 * @return Extension Handle identifying the registered Plugin
 */
native ZM_Extension ZM_RegisterExtension();

/**
 * Retrives a Handle to an ArrayList containing a copy to each Plugin handle
 * that has registered itself with Zombies.
 * 
 * @return ArrayList Handle containing a copy of the list of registered
 *         extensions
 */
native ArrayList ZM_GetExtensions();

/**
 * Retrieves the number of extensions that have been registered with Zombies.
 * 
 * @return Number of registered extensions
 */
native int ZM_GetNumExtensions();

/**
 * Checks whether or not the specified value is a valid Extension handle and
 * may be casted as such.
 * 
 * @param i Value to check
 * 
 * @return {@code true} if the specified value is considered a valid Extension
 *         Handle, otherwise {@code false}
 */
native bool ZM_IsValidExtension(any:i);