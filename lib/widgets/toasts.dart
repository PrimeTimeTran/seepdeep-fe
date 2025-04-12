import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:motion_toast/motion_toast.dart';

class Toaster {
  BuildContext context;
  late FToast fToast;
  Toaster(this.context) {
    fToast = FToast();
    fToast.init(context);
  }

  void displayCustomMotionToast([msg]) {
    fToast.showToast(
      toastDuration: const Duration(seconds: 10),
      gravity: ToastGravity.TOP_RIGHT,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.greenAccent,
        ),
        child: Column(
          children: [
            const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check),
                SizedBox(
                  width: 12.0,
                ),
                Text("This is a Custom Toast"),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.check),
                const SizedBox(
                  width: 12.0,
                ),
                Text(msg ?? ''),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void displayDeleteMotionToast() {
    MotionToast.delete(
      title: const Text(
        'Deleted',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: const Text('The item is deleted'),
      animationType: AnimationType.slideInFromBottom,
      position: MotionToastPosition.top,
    ).show(context);
  }

  static void simpleToast(msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM_RIGHT,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
