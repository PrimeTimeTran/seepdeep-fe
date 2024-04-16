import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

Future<void> dialogBuilder(BuildContext context, title, body) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(
          body,
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

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

enum GiffyType {
  image,
  rive,
  lottie;

  Widget when({
    required Widget Function() image,
    required Widget Function() rive,
    required Widget Function() lottie,
  }) {
    switch (this) {
      case GiffyType.image:
        return image();
      case GiffyType.rive:
        return rive();
      case GiffyType.lottie:
        return lottie();
    }
  }
}

class Modal extends StatefulWidget {
  final GiffyType type;

  const Modal({
    super.key,
    required this.type,
  });

  @override
  State<Modal> createState() => _ModalState();
}

class _ModalState extends State<Modal> {
  late var image = GiffyModel.image(context);
  late var rive = GiffyModel.rive(context);
  late var lottie = GiffyModel.lottie(context);
  late var useMaterial3 = Theme.of(context).useMaterial3;
  @override
  Widget build(BuildContext context) {
    useMaterial3 = Theme.of(context).useMaterial3;
    image = GiffyModel.image(context);
    rive = GiffyModel.rive(context);
    lottie = GiffyModel.lottie(context);

    return const SizedBox(height: 36);
  }

  Widget buildBottomSheet() {
    return widget.type.when(
      image: () {
        return GiffyBottomSheet.image(
          image.giffy as Image,
          title: image.title,
          content: image.content,
          actions: image.actions,
        );
      },
      rive: () {
        return GiffyBottomSheet.rive(
          rive.giffy as RiveAnimation,
          giffyBuilder: (context, rive) {
            return ClipRRect(
              borderRadius: useMaterial3
                  ? const BorderRadius.all(Radius.circular(16))
                  : const BorderRadius.all(Radius.circular(4)),
              child: SizedBox(height: 200, child: rive),
            );
          },
          title: rive.title,
          content: rive.content,
          actions: rive.actions,
        );
      },
      lottie: () {
        return GiffyBottomSheet.lottie(
          lottie.giffy as LottieBuilder,
          title: lottie.title,
          content: lottie.content,
          actions: lottie.actions,
        );
      },
    );
  }

  Widget buildDialog() {
    return widget.type.when(
      image: () {
        return GiffyDialog.image(
          image.giffy as Image,
          title: image.title,
          content: image.content,
          actions: image.actions,
        );
      },
      rive: () {
        return GiffyDialog.rive(
          rive.giffy as RiveAnimation,
          giffyBuilder: (context, rive) {
            return ClipRRect(
              borderRadius: useMaterial3
                  ? const BorderRadius.all(Radius.circular(16))
                  : const BorderRadius.all(Radius.circular(4)),
              child: SizedBox(height: 200, child: rive),
            );
          },
          title: rive.title,
          content: rive.content,
          actions: rive.actions,
        );
      },
      lottie: () {
        return GiffyDialog.lottie(
          lottie.giffy as LottieBuilder,
          title: lottie.title,
          content: lottie.content,
          actions: lottie.actions,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!kDebugMode) {
        onLoad();
      }
    });
  }

  onLoad() {
    showDialog(
      context: context,
      builder: (_) {
        return buildDialog();
      },
    );
  }
}
