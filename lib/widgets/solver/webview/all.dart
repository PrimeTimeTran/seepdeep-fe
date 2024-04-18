// Load platform specific libs
export 'solver_none.dart'
    if (dart.library.io) 'solver_mobile.dart'
    if (dart.library.html) 'solver_web.dart';
