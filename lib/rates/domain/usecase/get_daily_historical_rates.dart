import 'package:currency_conversion/rates/domain/entity/currency_rates.dart';
import 'package:currency_conversion/rates/domain/entity/get_daily_historical_rates_input.dart';
import 'package:currency_conversion/rates/domain/repository/base_rates_repository.dart';

class GetDailyHistoricalRatesUseCase {
  final BaseRatesRepository _baseRatesRepository;

  GetDailyHistoricalRatesUseCase(this._baseRatesRepository);

  Future<CurrencyRates> call(GetDailyHistoricalRatesInput input) async {
    return await _baseRatesRepository.getDailyHistoricalRates(input);
  }
}
