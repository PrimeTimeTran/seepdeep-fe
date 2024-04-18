import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logger/logger.dart';

class Glob {
  static Logger logger = Logger(printer: PrettyPrinter());
  static Logger loggerNoStack = Logger(printer: PrettyPrinter(methodCount: 0));

  static loadingDone() => EasyLoading.dismiss();

  static loadingStart([title = 'Processing...']) {
    EasyLoading.show(status: title);
    Future.delayed(const Duration(seconds: 3), () {
      EasyLoading.dismiss();
    });
  }

  static logE(msg) => logger.e('Error: ', error: msg);
  static logI(msg) => logger.i(msg);
}
