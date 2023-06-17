class CurrencyRates {
  String base;
  DateTime startDate;
  DateTime endDate;
  Map<String, Map<String, double>> rates;

  CurrencyRates copyWith({
    String? base,
    DateTime? startDate,
    DateTime? endDate,
    Map<String, Map<String, double>>? rates,
  }) {
    return CurrencyRates(
      base = base ?? this.base,
      startDate = startDate ?? this.startDate,
      endDate = endDate ?? this.endDate,
      rates = rates ?? this.rates);
  }

  CurrencyRates(this.base, this.startDate, this.endDate, this.rates);
}
