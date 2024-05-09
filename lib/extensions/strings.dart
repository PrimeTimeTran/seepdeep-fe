extension CamelCaseStringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return substring(0, 1).toUpperCase() + substring(1);
  }

  String replaceDigitsWithWords(String input) {
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
    String result = input.replaceAllMapped(RegExp(r'\d'), (match) {
      return digitWords[match.group(0)]!;
    });

    return result;
  }

  String toCamelCase() {
    String cleanedString = replaceAllMapped(RegExp(r'[-.0-9]'), (match) {
      return replaceDigitsWithWords(match.group(0)!);
    });
    if (cleanedString != this) {
      return cleanedString;
    }
    List<String> parts = cleanedString.split(RegExp(r'[_\s]'));
    List<String> capitalizedParts = parts.map((part) {
      if (part.isNotEmpty) {
        return part.substring(0, 1).toUpperCase() + part.substring(1);
      } else {
        return '';
      }
    }).toList();
    String camelCaseString = capitalizedParts.join('');
    if (RegExp(r'^[A-Za-z]').hasMatch(this)) {
      camelCaseString =
          camelCaseString[0].toLowerCase() + camelCaseString.substring(1);
    }

    return camelCaseString;
  }
}
