enum Month {
  january('January'),
  february('February'),
  march('March'),
  april('April'),
  may('May'),
  june('June'),
  july('July'),
  august('August'),
  september('September'),
  october('October'),
  november('November'),
  december('December');

  final String value;

  const Month(this.value);

  static int getMonthNum(String month) {
    return Month.values.indexWhere((element) => element.value == month);
  }

  static List<String> get allValues {
    return Month.values.map<String>((Month element) {
      return element.value;
    }).toList();
  }
}
