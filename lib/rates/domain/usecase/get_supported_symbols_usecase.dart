import 'package:currency_conversion/rates/domain/repository/base_rates_repository.dart';
import 'package:currency_conversion/rates/domain/entity/symbols.dart';

class GetSupportedSymbolsUseCase {
  final BaseRatesRepository _baseRatesRepository;

  GetSupportedSymbolsUseCase(this._baseRatesRepository);

  Future<Map<String, Symbol>> call() async {
    return await _baseRatesRepository.getSupportedSymbols();
  }
}
