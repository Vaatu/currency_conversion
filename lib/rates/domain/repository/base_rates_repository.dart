import 'package:currency_conversion/rates/domain/entity/symbols.dart';
import 'package:currency_conversion/rates/domain/entity/currency_rates.dart';
import 'package:currency_conversion/rates/domain/entity/get_daily_historical_rates_input.dart';

abstract class BaseRatesRepository{
  Future<CurrencyRates> getDailyHistoricalRates(GetDailyHistoricalRatesInput input);
  Future<Map<String, Symbol>> getSupportedSymbols();

}