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

class GetSupportedSymbolsEvent extends RatesEvent {}

class SelectFromDateEvent extends RatesEvent {
  final String from;

  SelectFromDateEvent(this.from);
}

class SelectToDateEvent extends RatesEvent {
  final String to;

  SelectToDateEvent(this.to);
}

class SelectBaseCurrencyEvent extends RatesEvent {
  final String from;

  SelectBaseCurrencyEvent(this.from);
}

class SelectToCurrencyEvent extends RatesEvent {
  final String to;

  SelectToCurrencyEvent(this.to);
}





