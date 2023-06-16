import 'package:currency_conversion/core/resources/strings_manager.dart';
import 'package:currency_conversion/core/utils/enums.dart';
import 'package:currency_conversion/rates/domain/entity/currency_rates.dart';
import 'package:currency_conversion/rates/domain/entity/symbols.dart';

class RatesState {
  final Map<String, Symbol> symbols;
  final CurrencyRates? rates;
  final String startDate;
  final String endDate;
  final String baseCurrency;
  final String toCurrency;
  final RequestState requestState;

  RatesState(
      {this.symbols = const {},
      this.rates,
      this.startDate = AppStrings.startDate,
      this.endDate = AppStrings.endDate,
      this.baseCurrency = "",
      this.toCurrency = "",
      this.requestState = RequestState.loading});

  RatesState copyWith({
    Map<String, Symbol>? symbols,
    CurrencyRates? rates,
    String? startDate,
    String? endDate,
    String? baseCurrency,
    String? toCurrency,
    RequestState? requestState,
  }) {
    return RatesState(
        symbols: symbols ?? this.symbols,
        rates: rates ?? this.rates,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        baseCurrency: baseCurrency ?? this.baseCurrency,
        toCurrency: toCurrency ?? this.toCurrency,
        requestState: requestState ?? this.requestState);
  }
}
