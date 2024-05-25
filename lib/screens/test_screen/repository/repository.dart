import 'data_provider.dart';
import 'get_it.dart';

class Repository {
  final DataProvider dataProvider;
  final AppProvider appProvider;

  Repository(this.appProvider) : dataProvider = getIt<DataProvider>();

  Future<List> getAllDataThatMeetsRequirements() async {
    final List dataSetA = await dataProvider.readData();
    final List dataSetB = await appProvider.readData();

    final List filteredData = _filterData(dataSetA, dataSetB);
    return filteredData;
  }

  isAuthenticated() => appProvider.isAuthenticated;

  signIn() {
    appProvider.signIn();
  }

  signOut() {
    appProvider.signOut();
  }

  // Note: All this work for something important here...
  _filterData(a, b) {}
}
