import 'package:currency_conversion/rates/data/datasource/remote_datasource.dart';
import 'package:currency_conversion/rates/data/repository/rates_repository.dart';
import 'package:currency_conversion/rates/domain/repository/base_rates_repository.dart';
import 'package:currency_conversion/rates/domain/usecase/get_daily_historical_rates.dart';
import 'package:currency_conversion/rates/domain/usecase/get_supported_symbols_usecase.dart';
import 'package:currency_conversion/rates/presentation/controller/rates_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class ServiceLocator {
  void init() {
    // Bloc
    sl.registerFactory(() => RatesBloc(sl(), sl()));

    // Use Cases
    sl.registerLazySingleton(() => GetDailyHistoricalRatesUseCase(sl()));
    sl.registerLazySingleton(() => GetSupportedSymbolsUseCase(sl()));

    // Repository
    sl.registerLazySingleton<BaseRatesRepository>(() => RatesRepositoryImpl(sl()));

    // DataSource
    sl.registerLazySingleton<BaseRemoteDatasource>(() => RemoteDataSourceImpl());
  }
}
