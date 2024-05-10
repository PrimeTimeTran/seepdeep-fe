// ignore_for_file: must_be_immutable
import 'package:app/all.dart' as prefix;
import 'package:app/all.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  String title;
  bool? outlined = false;
  bool? textButton = false;
  bool? elevatedButton = false;
  void Function()? onPress;

  Button({
    super.key,
    required this.onPress,
    required this.title,
    this.outlined,
    this.textButton,
    this.elevatedButton,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle outlineButtonStyle = OutlinedButton.styleFrom(
      textStyle: const TextStyle(color: Colors.blue),
      foregroundColor: Colors.black87,
      minimumSize: const Size(88, 36),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
    ).copyWith(
      side: MaterialStateProperty.resolveWith<BorderSide?>(
        (Set<MaterialState> states) {
          final pressed = states.contains(MaterialState.pressed);
          return pressed
              ? BorderSide(
                  color: Theme.of(context).colorScheme.primary, width: 1)
              : null;
        },
      ),
    );

    if (outlined == true) {
      return OutlinedButtonTheme(
        data: OutlinedButtonThemeData(style: outlineButtonStyle),
        child: OutlinedButton(
          style: outlineButtonStyle,
          onPressed: onPress,
          child: AppText(
            text: title,
          ),
        ),
      );
    }
    if (textButton == true) {
      return TextButtonTheme(
        data: TextButtonThemeData(
          style: prefix.flatButtonStyle.copyWith(
              foregroundColor: MaterialStatePropertyAll(Colors.lightBlue[700])),
        ),
        child: TextButton(
          onPressed: onPress,
          child: AppText(
            text: title,
          ),
        ),
      );
    }
    if (elevatedButton == true) {
      return ElevatedButtonTheme(
        data: ElevatedButtonThemeData(style: prefix.raisedButtonStyle),
        child: ElevatedButton(onPressed: onPress, child: Text(title)),
      );
    }
    return Container();
  }
}
