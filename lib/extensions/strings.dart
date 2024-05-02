extension CamelCaseStringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return substring(0, 1).toUpperCase() + substring(1);
  }

  String replaceDigitsWithWords(String input) {
    // Define a map to store digit-word pairs
    Map<String, String> digitWords = {
      '0': 'zero',
      '1': 'one',
      '2': 'two',
      '3': 'three',
      '4': 'four',
      '5': 'five',
      '6': 'six',
      '7': 'seven',
      '8': 'eight',
      '9': 'nine'
    };

    // Replace each digit with its word equivalent
    String result = input.replaceAllMapped(RegExp(r'\d'), (match) {
      return digitWords[match.group(0)]!;
    });

    return result;
  }

  String toCamelCase() {
    // Replace dashes, dots, and numbers with words
    String cleanedString = replaceAllMapped(RegExp(r'[-.0-9]'), (match) {
      return replaceDigitsWithWords(match.group(0)!);
    });

    // Check if any replacements were made
    if (cleanedString != this) {
      // If replacements were made, return the cleaned string
      return cleanedString;
    }

    // Split the cleaned string by space or underscore
    List<String> parts = cleanedString.split(RegExp(r'[_\s]'));

    // Convert the first character of each part to uppercase
    List<String> capitalizedParts = parts.map((part) {
      if (part.isNotEmpty) {
        return part.substring(0, 1).toUpperCase() + part.substring(1);
      } else {
        return '';
      }
    }).toList();

    // Combine the capitalized parts
    String camelCaseString = capitalizedParts.join('');

    // Ensure the first character is lowercase, except for digits
    if (RegExp(r'^[A-Za-z]').hasMatch(this)) {
      camelCaseString =
          camelCaseString[0].toLowerCase() + camelCaseString.substring(1);
    }

    return camelCaseString;
  }
}
