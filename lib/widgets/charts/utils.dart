import 'dart:async';
import 'dart:math' as math;

class AppUtils {
  static final AppUtils _singleton = AppUtils._internal();

  factory AppUtils() {
    return _singleton;
  }
  AppUtils._internal();

  double degreeToRadian(double degree) {
    return degree * math.pi / 180;
  }

  double radianToDegree(double radian) {
    return radian * 180 / math.pi;
  }

  Future<bool> tryToLaunchUrl(String url) async {
    final uri = Uri.parse(url);
    // if (await canLaunchUrl(uri)) {
    //   return await launchUrl(uri);
    // }
    return false;
  }
}
