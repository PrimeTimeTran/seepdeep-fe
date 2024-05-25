import 'package:app/screens/test_screen/repository/app_bloc.dart';
import 'package:get_it/get_it.dart';

import 'data_provider.dart';
import 'repository.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  final appBloc = AppBloc();
  getIt.registerSingleton<AppBloc>(appBloc);
  getIt.registerSingleton<DataProvider>(DataProvider());
  getIt.registerSingleton<AppProvider>(AppProvider(appBloc));
  getIt.registerSingleton<Repository>(Repository(getIt<AppProvider>()));
}
