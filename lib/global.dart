import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logger/logger.dart';

class Glob {
  static Logger logger = Logger(
    printer: PrettyPrinter(
      colors: true,
      methodCount: 10,
      lineLength: 120,
      printTime: false,
      printEmojis: true,
      errorMethodCount: 10,
    ),
  );
  static Logger loggerNoStack = Logger(printer: PrettyPrinter(methodCount: 0));

  static loadDone() => EasyLoading.dismiss();

  static loadStart([title = 'Processing...']) {
    EasyLoading.show(status: title);
    Future.delayed(const Duration(seconds: 3), () {
      EasyLoading.dismiss();
    });
  }

  static logE(msg) => logger.e('❌', error: msg);
  static logI(msg) => logger.i(msg);

  // Works
  // Glob.logI(data['data'][0]);
  // Don't work
  // Glob.logIObj(res[0].toString());
  // Glob.logIObj(res[0].toJson());
  // Glob.logIObj(res[0].toJson().toString());
  // Glob.logIObj(json.decode(res[0].toJson().toString()));
  // Glob.logIObj(json.encode(res[0].toJson().toString()).toString());
  // Glob.logIObj(jsonEncode(res[0]));
  // print(jsonEncode(res[0]));
  static logIObj(msg) => loggerNoStack.t(jsonDecode(msg));
}
