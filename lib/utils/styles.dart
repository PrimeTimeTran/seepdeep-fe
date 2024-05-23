// ignore_for_file: unrelated_type_equality_checks

import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  foregroundColor: Colors.black87,
  minimumSize: const Size(88, 36),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  minimumSize: const Size(88, 36),
  foregroundColor: Colors.black87,
  backgroundColor: Colors.grey[300],
  padding: const EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);

class Style {
  static final Style _instance = Style._privateConstructor();
  static get darkTheme => _instance._darkTheme;
  static Style get instance => _instance;
  static get lightTheme => _instance._lightTheme;
  late ThemeData _lightTheme;
  late ThemeData _darkTheme;

  Style._privateConstructor();

  void initialize(BuildContext context) {
    final heading = TextStyle(
      color: themeColor(context, 'primary'),
      fontFamily: GoogleFonts.leagueSpartan().fontFamily,
      fontWeight: FontWeight.bold,
    );
    final withColor = TextStyle(
      color: themeColor(
        context,
        'secondary',
      ),
    );
    _lightTheme = ThemeData(
      fontFamily: GoogleFonts.libreBaskerville().fontFamily,
      iconTheme: const IconThemeData(color: Colors.grey),
      brightness: Brightness.light,
      textTheme: TextTheme(
        displayLarge: heading,
        displayMedium: heading,
        displaySmall: heading,
        headlineLarge:
            heading.copyWith(color: themeColor(context, 'secondary')),
        headlineMedium:
            heading.copyWith(color: themeColor(context, 'secondary')),
        headlineSmall:
            heading.copyWith(color: themeColor(context, 'secondary')),
        titleLarge: withColor,
        titleMedium: withColor,
        titleSmall: withColor,
        labelLarge: withColor,
        labelMedium: withColor,
        labelSmall: withColor,
        bodyLarge: withColor,
        bodyMedium: withColor,
        bodySmall: withColor,
      ),
    );
    _darkTheme = ThemeData(
      fontFamily: GoogleFonts.libreBaskerville().fontFamily,
      iconTheme: const IconThemeData(color: Colors.grey),
      brightness: Brightness.dark,
      textTheme: TextTheme(
        displayLarge: heading,
        displayMedium: heading,
        displaySmall: heading,
        headlineLarge: heading.copyWith(color: Colors.white),
        headlineMedium: heading.copyWith(color: Colors.white),
        headlineSmall: heading.copyWith(color: Colors.white),
        titleLarge: withColor.copyWith(color: Colors.white),
        titleMedium: withColor.copyWith(color: Colors.white),
        titleSmall: withColor.copyWith(color: Colors.white),
        labelLarge: withColor.copyWith(color: Colors.white),
        labelMedium: withColor.copyWith(color: Colors.white),
        labelSmall: withColor.copyWith(color: Colors.white),
        bodyLarge: withColor.copyWith(color: Colors.white),
        bodyMedium: withColor.copyWith(color: Colors.white),
        bodySmall: withColor.copyWith(color: Colors.white),
      ),
    );
  }

  static Brightness currentTheme(BuildContext context) {
    return Theme.of(context).brightness;
  }

  static of(context, value) {
    switch (value) {
      case 'displayL':
        return Theme.of(context).textTheme.displayLarge;
      case 'displayM':
        return Theme.of(context).textTheme.displayMedium;
      case 'displayS':
        return Theme.of(context).textTheme.displaySmall;
      case 'headlineL':
        return Theme.of(context).textTheme.headlineLarge;
      case 'headlineM':
        return Theme.of(context).textTheme.headlineMedium;
      case 'headlineS':
        return Theme.of(context).textTheme.headlineSmall;
      case 'titleL':
        return Theme.of(context).textTheme.titleLarge;
      case 'titleM':
        return Theme.of(context).textTheme.titleMedium;
      case 'titleS':
        return Theme.of(context).textTheme.titleSmall;
      case 'labelL':
        return Theme.of(context).textTheme.labelLarge;
      case 'labelM':
        return Theme.of(context).textTheme.labelMedium;
      case 'labelS':
        return Theme.of(context).textTheme.labelSmall;
      case 'bodyL':
        return Theme.of(context).textTheme.bodyLarge;
      case 'bodyM':
        return Theme.of(context).textTheme.bodyMedium;
      case 'bodyS':
        return Theme.of(context).textTheme.bodySmall;
      case 'displayLUnderline':
        return Theme.of(context)
            .textTheme
            .displayLarge
            ?.copyWith(decoration: TextDecoration.underline);
      case 'titleGrey':
        return Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.grey,
            );
      default:
        throw Exception('Style does not exist');
    }
  }
}
