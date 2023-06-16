import 'package:currency_conversion/core/error/exceptions.dart';
import 'package:currency_conversion/core/utils/constants.dart';
import 'package:currency_conversion/rates/data/model/currency_rates_model.dart';
import 'package:currency_conversion/rates/data/model/symbol_model.dart';
import 'package:currency_conversion/rates/domain/entity/get_daily_historical_rates_input.dart';
import 'package:dio/dio.dart';

abstract class BaseRemoteDatasource {
  Future<CurrencyRatesModel> getDailyHistoricalRates(GetDailyHistoricalRatesInput input);

  Future<Map<String, CurrencySymbolModel>> getSupportedSymbols();
}

class RemoteDataSourceImpl implements BaseRemoteDatasource {
  @override
  Future<CurrencyRatesModel> getDailyHistoricalRates(GetDailyHistoricalRatesInput input) async {
    try {
      final response = await Dio().get(
          "${AppConstants.baseUrl}timeseries?start_date=${input.startDate}&end_date=${input.endDate}&base=${input.baseCurrency}&symbols=${input.symbol}");
      return CurrencyRatesModel.fromJson(response.data);
    } catch (e) {
      throw ServerException("$e");
    }
  }

  @override
  Future<Map<String, CurrencySymbolModel>> getSupportedSymbols() async {
    try {
      final response = await Dio().get("${AppConstants.baseUrl}/symbols");
      return Map.from(response.data["symbols"]!)
          .map((k, v) => MapEntry<String, CurrencySymbolModel>(k, CurrencySymbolModel.fromJson(v)));
    } catch (e) {
      print(e);
      throw ServerException("$e");
    }
  }
}
