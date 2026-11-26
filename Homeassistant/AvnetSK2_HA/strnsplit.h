/// @brief Split a string into segments based on a delimiter.
/// @param pStr The input string to be splitted. The delimiter character will be replaced with null terminators, so the input string will be modified.
/// @param chDelimiter The character to use as a delimiter.
/// @param ppStrArray A pointer to an array of segment pointers.
/// @param nMaxSplits The maximum number of splits to perform (the size of the result array).
/// @return The number of segments created, or -1 on error.

int strnsplit(char *pStr, char chDelimiter, char **ppStrArray, size_t nMaxSplits);
