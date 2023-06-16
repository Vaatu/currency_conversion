import 'dart:async';
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
    on<SelectFromDateEvent>(_selectFromDate);
    on<SelectToDateEvent>(_selectToDate);
    on<SelectBaseCurrencyEvent>(_selectBaseCurrency);
    on<SelectToCurrencyEvent>(_selectToCurrency);
  }

  FutureOr<void> _getSupportedSymbols(event, emit) async {
    final response = await getSupportedSymbols();
    emit(state.copyWith(symbols: response, baseCurrency: "USD", toCurrency: "EGP", requestState: RequestState.empty));
  }

  FutureOr<void> _getDailyHistoricalRates(GetDailyHistoricalRatesEvent event, Emitter<RatesState> emit) async {
    DateTime startDate = DateTime.parse(state.startDate);
    DateTime endDate = DateTime.parse(state.endDate);
    if (startDate.isAfter(endDate)) {
      emit(state.copyWith(requestState: RequestState.error));
    } else {
      emit(state.copyWith(requestState: RequestState.loading));
      final response = await getDailyHistoricalRatesUseCase(
          GetDailyHistoricalRatesInput(state.startDate, state.endDate, state.baseCurrency, state.toCurrency));
      emit(state.copyWith(rates: response, requestState: RequestState.loaded));
    }
  }

  FutureOr<void> _selectFromDate(SelectFromDateEvent event, Emitter<RatesState> emit) {
    String formattedDate = DateFormat("yyyy-MM-dd").format(DateTime.parse(event.from));

    emit(state.copyWith(startDate: formattedDate, requestState: RequestState.empty));
  }

  FutureOr<void> _selectToDate(SelectToDateEvent event, Emitter<RatesState> emit) {
    String formattedDate = DateFormat("yyyy-MM-dd").format(DateTime.parse(event.to));
    emit(state.copyWith(endDate: formattedDate, requestState: RequestState.empty));
  }

  FutureOr<void> _selectBaseCurrency(SelectBaseCurrencyEvent event, Emitter<RatesState> emit) {
    emit(state.copyWith(baseCurrency: event.from, requestState: RequestState.empty));
  }

  FutureOr<void> _selectToCurrency(SelectToCurrencyEvent event, Emitter<RatesState> emit) {
    emit(state.copyWith(baseCurrency: event.to, requestState: RequestState.empty));
  }
}
