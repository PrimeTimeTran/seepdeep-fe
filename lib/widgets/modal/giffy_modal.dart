import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

class GiffyModel {
  final Widget giffy;
  final Widget title;
  final Widget content;
  final List<Widget> actions;

  const GiffyModel({
    required this.giffy,
    required this.title,
    required this.content,
    required this.actions,
  });

  factory GiffyModel.image(BuildContext context) {
    return GiffyModel(
      giffy: Image.network(
        "https://raw.githubusercontent.com/Shashank02051997/FancyGifDialog-Android/master/GIF's/gif14.gif",
        height: 200,
        fit: BoxFit.cover,
      ),
      title: const Text(
        'Computer Science ToolKit',
        textAlign: TextAlign.center,
      ),
      content: const Text(
        'Were the best online platform for leveling up your CS skills. Data Structures, Sorting Algorithms, Databases & more, you can find it here.',
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, 'Close'),
          child: const Text('Close'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    );
  }

  factory GiffyModel.lottie(BuildContext context) {
    return GiffyModel(
      giffy: Lottie.network(
        'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json',
        fit: BoxFit.contain,
        height: 200,
      ),
      title: const Text(
        'Lottie Animation',
        textAlign: TextAlign.center,
      ),
      content: const Text(
        'This is a lottie animation dialog box. This library helps you easily create fancy giffy dialog.',
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, 'CANCEL'),
          child: const Text('CANCEL'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    );
  }

  factory GiffyModel.rive(BuildContext context) {
    return GiffyModel(
      giffy: const RiveAnimation.network(
        'https://cdn.rive.app/animations/vehicles.riv',
        fit: BoxFit.cover,
        placeHolder: Center(child: CircularProgressIndicator()),
      ),
      title: const Text(
        'Rive Animation',
        textAlign: TextAlign.center,
      ),
      content: const Text(
        'This is a rive animation dialog box. This library helps you easily create fancy giffy dialog.',
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, 'CANCEL'),
          child: const Text('CANCEL'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
