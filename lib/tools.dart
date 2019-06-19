class Tools {
  /// Returns the input with the first letter capitalized.
  static String capitalizeFirst(String input) {
    return input.replaceFirst(input[0], input[0].toUpperCase());
  }

  /// Returns a string with zeroes added to the left so that the string has a 
  /// width of 3.
  static String displayWithZeroes(int num) => num.toString().padLeft(3, '0');
}
