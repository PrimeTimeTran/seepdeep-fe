currentYear() {
  DateTime now = DateTime.now();
  int currentYear = now.year;
  String yearString = currentYear.toString();
  return yearString;
}

DateTime parseDate(String dateString) {
  List<String> dateParts = dateString.split('/');
  int month = int.parse(dateParts[0]);
  int day = int.parse(dateParts[1]);
  int year = int.parse(dateParts[2]);
  year += (year < 100) ? 2000 : 0;
  return DateTime(year, month, day);
}
