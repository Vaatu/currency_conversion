class CurrencyRates {
  String base;
  DateTime startDate;
  DateTime endDate;
  Map<String, Map<String, double>> rates;

  CurrencyRates(this.base, this.startDate, this.endDate, this.rates);
}
