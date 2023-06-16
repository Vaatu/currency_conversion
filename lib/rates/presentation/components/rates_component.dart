import 'package:currency_conversion/core/utils/enums.dart';
import 'package:currency_conversion/rates/presentation/components/currency_rate_tile.dart';
import 'package:currency_conversion/rates/presentation/controller/rates_bloc.dart';
import 'package:currency_conversion/rates/presentation/controller/rates_state.dart';
import 'package:currency_conversion/rates/presentation/screens/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RatesComponent extends StatelessWidget {
  const RatesComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RatesBloc, RatesState>(builder: (context, state) {
      switch (state.requestState) {
        case RequestState.empty:
          return const EmptyState();
        case RequestState.loaded:
          return ListView.builder(
              itemCount: state.rates!.rates.length,
              itemBuilder: (context, index) => state.rates!.rates.entries.elementAt(index).value.entries.isEmpty
                  ? Container()
                  : CurrencyRateTile(
                      baseCurrency: state.baseCurrency,
                      symbol: state.toCurrency,
                      date: state.rates!.rates.keys.elementAt(index),
                      rate: state.rates!.rates.entries.elementAt(index).value.entries.first.value,
                    ));
        case RequestState.error:
          return const EmptyState();
        case RequestState.loading:
          return const Center(child:  CircularProgressIndicator());

      }
    });
  }
}
