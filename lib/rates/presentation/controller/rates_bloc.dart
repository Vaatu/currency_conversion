import 'dart:async';
import 'dart:developer';
import 'package:currency_conversion/core/utils/enums.dart';
import 'package:currency_conversion/rates/domain/entity/get_daily_historical_rates_input.dart';
import 'package:currency_conversion/rates/domain/usecase/get_daily_historical_rates.dart';
import 'package:currency_conversion/rates/domain/usecase/get_supported_symbols_usecase.dart';
import 'package:currency_conversion/rates/presentation/controller/rates_event.dart';
import 'package:currency_conversion/rates/presentation/controller/rates_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class RatesBloc extends Bloc<RatesEvent, RatesState> {
  final GetSupportedSymbolsUseCase getSupportedSymbols;
  final GetDailyHistoricalRatesUseCase getDailyHistoricalRatesUseCase;

  RatesBloc(this.getSupportedSymbols, this.getDailyHistoricalRatesUseCase) : super(RatesState()) {
    on<GetSupportedSymbolsEvent>(_getSupportedSymbols);

    on<GetDailyHistoricalRatesEvent>(_getDailyHistoricalRates);
    on<SelectStartDateEvent>(_selectStartDate);
    on<SelectEndDateEvent>(_selectEndDate);
    on<SelectBaseCurrencyEvent>(_selectBaseCurrency);
    on<SelectToCurrencyEvent>(_selectToCurrency);
    on<SwitchCurrencyEvent>(_switchCurrencyEvent);
  }

  FutureOr<void> _getSupportedSymbols(event, emit) async {
    final response = await getSupportedSymbols();

    emit(state.copyWith(symbols: response, baseCurrency: "USD", toCurrency: "EGP", requestState: RequestState.empty));
  }

  FutureOr<void> _getDailyHistoricalRates(GetDailyHistoricalRatesEvent event, Emitter<RatesState> emit) async {
    DateTime startDate = DateTime.parse(state.startDate);
    DateTime endDate = DateTime.parse(state.endDate);
    final dateFormatter = DateFormat('yyyy-MM-dd');
    if (startDate.isAfter(endDate)) {
      emit(state.copyWith(requestState: RequestState.error));
    } else {
      var currentDate = state.nextStartDate ?? startDate;

      if (currentDate.isBefore(endDate)) {
        final nextDate = currentDate.add(const Duration(days: 1));
        final afterTenDays = currentDate.add(const Duration(days: 10));
        var newNextDate;
        final daysDifference = endDate.difference(nextDate).inDays;

        if (nextDate.isAfter(endDate)) {
          newNextDate = endDate;
        } else {
          newNextDate = afterTenDays;
        }
        final formattedStartDate = dateFormatter.format(currentDate);
        final formattedEndDate = dateFormatter.format(currentDate.add(const Duration(days: 10)));
        if (daysDifference != 0) {
          emit(state.copyWith(requestState: RequestState.loading));
          final response = await getDailyHistoricalRatesUseCase(
              GetDailyHistoricalRatesInput(formattedStartDate, formattedEndDate, state.baseCurrency, state.toCurrency));
          var oldRates = state.rates?.rates;
          if (oldRates != null) {
            oldRates.addEntries(response.rates.map((key, value) => MapEntry(key, value)).entries);
          }
          emit(state.copyWith(
              rates: oldRates != null ? state.rates!.copyWith(rates: oldRates) : response,
              requestState: RequestState.loaded,
              nextStartDate: newNextDate));
        } else {
          var newRates = state.rates?.rates;
          newRates?.clear();
          emit(state.copyWith(rates: state.rates?.copyWith(rates: newRates)));
        }
      }
    }
  }

  FutureOr<void> _selectStartDate(SelectStartDateEvent event, Emitter<RatesState> emit) {
    String formattedDate = DateFormat("yyyy-MM-dd").format(DateTime.parse(event.startDate));
    var rates = state.rates?.rates;
    rates?.clear();

    emit(state.copyWith(
        rates: state.rates?.copyWith(rates: rates),
        startDate: formattedDate,
        requestState: RequestState.empty,
        nextStartDate: DateTime.parse(event.startDate)));
  }

  FutureOr<void> _selectEndDate(SelectEndDateEvent event, Emitter<RatesState> emit) {
    String formattedDate = DateFormat("yyyy-MM-dd").format(DateTime.parse(event.endDate));
    var rates = state.rates?.rates;
    rates?.clear();

    emit(state.copyWith(
        rates: state.rates?.copyWith(rates: rates),
        endDate: formattedDate,
        requestState: RequestState.empty,
        nextStartDate: DateTime.tryParse(state.startDate)));
  }

  FutureOr<void> _selectBaseCurrency(SelectBaseCurrencyEvent event, Emitter<RatesState> emit) {
    var rates = state.rates?.rates;
    rates?.clear();

    emit(state.copyWith(
        rates: state.rates?.copyWith(rates: rates),
        baseCurrency: event.from,
        requestState: RequestState.empty,
        nextStartDate: DateTime.tryParse(state.startDate)));
  }

  FutureOr<void> _selectToCurrency(SelectToCurrencyEvent event, Emitter<RatesState> emit) {
    var rates = state.rates?.rates;
    rates?.clear();

    emit(state.copyWith(
        rates: state.rates?.copyWith(rates: rates),
        baseCurrency: event.to,
        requestState: RequestState.empty,
        nextStartDate: DateTime.tryParse(state.startDate)));
  }

  FutureOr<void> _switchCurrencyEvent(SwitchCurrencyEvent event, Emitter<RatesState> emit) {
    String baseCurrency = state.baseCurrency;
    String toCurrency = state.toCurrency;
    var rates = state.rates?.rates;
    rates?.clear();

    emit(state.copyWith(
        rates: state.rates?.copyWith(rates: rates),
        baseCurrency: toCurrency,
        toCurrency: baseCurrency,
        requestState: RequestState.empty,
        nextStartDate: DateTime.parse(state.startDate)));
  }
}
