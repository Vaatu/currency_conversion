import 'package:currency_conversion/rates/data/datasource/remote_datasource.dart';
import 'package:currency_conversion/rates/domain/entity/currency_rates.dart';
import 'package:currency_conversion/rates/domain/entity/get_daily_historical_rates_input.dart';
import 'package:currency_conversion/rates/domain/repository/base_rates_repository.dart';
import 'package:currency_conversion/rates/domain/entity/symbols.dart';

class RatesRepositoryImpl implements BaseRatesRepository {
  final BaseRemoteDatasource _baseRemoteDatasource;

  RatesRepositoryImpl(this._baseRemoteDatasource);

  @override
  Future<CurrencyRates> getDailyHistoricalRates(GetDailyHistoricalRatesInput input) async {
    return await _baseRemoteDatasource.getDailyHistoricalRates(input);
  }

  @override
  Future<Map<String, Symbol>> getSupportedSymbols() async {
    return await _baseRemoteDatasource.getSupportedSymbols();
  }
}
