class Utils {
  static String trimString(String strToTrim, [int trimLimit = 40]) {
    if (strToTrim.length < 40)
      return strToTrim;
    else
      return '${strToTrim.substring(0, trimLimit)}...';
  }
}
