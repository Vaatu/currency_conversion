import 'package:currency_conversion/rates/domain/entity/symbols.dart';

class CurrencySymbolModel extends Symbol {
  CurrencySymbolModel({required super.description, required super.code});

  factory CurrencySymbolModel.fromJson(Map<String, dynamic> json) => CurrencySymbolModel(
        description: json["description"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "code": code,
      };
}
