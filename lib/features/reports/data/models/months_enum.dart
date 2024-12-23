enum Month {
  January('January'),
  February('February'),
  March('March'),
  April('April'),
  May('May'),
  June('June'),
  July('July'),
  August('August'),
  September('September'),
  October('October'),
  November('November'),
  December('December');

  final String value;

  const Month(this.value);

  static List<String> get allValues {
    return Month.values.map<String>((Month element) {
      return element.value;
    }).toList();
  }
}
