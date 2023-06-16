import 'package:currency_conversion/rates/domain/entity/currency_rates.dart';

class CurrencyRatesModel extends CurrencyRates {
  CurrencyRatesModel(super.base, super.startDate, super.endDate, super.rates);

  factory CurrencyRatesModel.fromJson(Map<String, dynamic> json) => CurrencyRatesModel(
        json["base"],
        DateTime.parse(json["start_date"]),
        DateTime.parse(json["end_date"]),
        Map.from(json["rates"]!).map((k, v) => MapEntry<String, Map<String, double>>(
            k, Map.from(v).map((k, v) => MapEntry<String, double>(k, v?.toDouble())))),
      );

  Map<String, dynamic> toJson() => {
        "base": base,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "rates": Map.from(rates)
            .map((k, v) => MapEntry<String, dynamic>(k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
      };
}
