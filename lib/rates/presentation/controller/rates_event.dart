import 'package:currency_conversion/rates/presentation/controller/rates_state.dart';

abstract class RatesEvent {
  const RatesEvent();
}

class EmptyState extends RatesState {}

class GetDailyHistoricalRatesEvent extends RatesEvent {
  final String startDate;
  final String endDate;

  GetDailyHistoricalRatesEvent(this.startDate, this.endDate);
}

class PaginateDailyHistoricalRatesEvent extends RatesEvent {}

class GetSupportedSymbolsEvent extends RatesEvent {}

class SelectStartDateEvent extends RatesEvent {
  final String startDate;

  SelectStartDateEvent(this.startDate);
}

class SelectEndDateEvent extends RatesEvent {
  final String endDate;

  SelectEndDateEvent(this.endDate);
}

class SelectBaseCurrencyEvent extends RatesEvent {
  final String from;

  SelectBaseCurrencyEvent(this.from);
}

class SelectToCurrencyEvent extends RatesEvent {
  final String to;

  SelectToCurrencyEvent(this.to);
}

class SwitchCurrencyEvent extends RatesEvent {}
