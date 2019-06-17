class Tools {
  
  /// Returns the input with the first letter capitalized.
  static String capitalizeFirst(String input) {
    return input.replaceFirst(input[0], input[0].toUpperCase());
  }
}