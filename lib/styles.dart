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
  static get bodyL => _instance._bodyLarge;
  static get bodyM => _instance._bodyMedium;
  static get bodyS => _instance._bodySmall;
  static get darkTheme => _instance._darkTheme;
  static get displayL => _instance._displayLarge;
  static get displayM => _instance._displayMedium;
  static get displayS => _instance._displaySmall;
  static get headingColor => _instance._headingColor;
  static get headlineL => _instance._headlineLarge;
  static get headlineM => _instance._headlineMedium;
  static get headlineS => _instance._headlineSmall;
  static Style get instance => _instance;
  static get labelL => _instance._labelLarge;
  static get labelM => _instance._labelMedium;
  static get labelS => _instance._labelSmall;
  static get lightTheme => _instance._lightTheme;
  static get textColor => _instance._textColor;
  static get titleL => _instance._titleLarge;
  static get titleM => _instance._titleMedium;
  static get titleS => _instance._titleSmall;
  late BuildContext _context;
  late Color _textColor;
  late Color _headingColor;
  late ThemeData _lightTheme;
  late ThemeData _darkTheme;
  late TextStyle _displaySmall;
  late TextStyle _displayMedium;
  late TextStyle _displayLarge;
  late TextStyle _headlineSmall;
  late TextStyle _headlineMedium;
  late TextStyle _headlineLarge;
  late TextStyle _titleSmall;
  late TextStyle _titleMedium;
  late TextStyle _titleLarge;
  late TextStyle _labelSmall;
  late TextStyle _labelMedium;
  late TextStyle _labelLarge;
  late TextStyle _bodySmall;
  late TextStyle _bodyMedium;
  late TextStyle _bodyLarge;
  Style._privateConstructor();
  // Info: How we can define styles in one place and reuse them elsewhere more easily.
  // See ./lib/navigation/root.dart

  void initialize(BuildContext context) {
    _context = context;
    // _displaySmall = Theme.of(context).textTheme.displaySmall!;
    _displaySmall = GoogleFonts.pacifico();
    _displayMedium = Theme.of(context).textTheme.displayMedium!;
    // _displayLarge = Theme.of(context).textTheme.displayLarge!;
    _displayLarge = const TextStyle(
      fontSize: 72,
      fontWeight: FontWeight.bold,
    );
    _headlineSmall = Theme.of(context).textTheme.headlineSmall!;
    _headlineMedium = Theme.of(context).textTheme.headlineMedium!;
    _headlineLarge = Theme.of(context).textTheme.headlineLarge!;
    _titleSmall = Theme.of(context).textTheme.titleSmall!;
    _titleMedium = Theme.of(context).textTheme.titleMedium!;
    _titleLarge = Theme.of(context).textTheme.titleLarge!.copyWith(
        fontSize: 30, color: Colors.blue, fontWeight: FontWeight.bold);

    _labelSmall = Theme.of(context).textTheme.labelSmall!;
    _labelMedium = Theme.of(context).textTheme.labelMedium!;
    _labelLarge = Theme.of(context).textTheme.labelLarge!;
    _bodySmall = Theme.of(context).textTheme.bodySmall!;
    // _bodyMedium = Theme.of(context).textTheme.bodyMedium!;
    _bodyMedium = GoogleFonts.merriweather();
    _bodyLarge = Theme.of(context).textTheme.bodyLarge!;

    final Brightness brightness = Theme.of(_context).brightness;
    _textColor = brightness == Brightness.light ? Colors.black : Colors.grey;
    _headingColor =
        brightness == Brightness.light ? Colors.blue : Colors.lightBlue;

    _lightTheme = ThemeData(
      brightness: Brightness.light,
    );
    _darkTheme = ThemeData(
      brightness: Brightness.dark,
    );
  }

  void updateBrightness(Brightness brightness) {
    _textColor = brightness == Brightness.light ? Colors.black : Colors.grey;
    _headingColor =
        brightness == Brightness.light ? Colors.blue : Colors.lightBlue;
  }

  static Brightness currentTheme(BuildContext context) {
    return Theme.of(context).brightness;
  }
}
