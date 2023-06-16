import 'package:currency_conversion/core/resources/assets_manager.dart';
import 'package:currency_conversion/core/resources/color_manager.dart';
import 'package:currency_conversion/core/resources/strings_manager.dart';
import 'package:currency_conversion/core/resources/styles_manager.dart';
import 'package:currency_conversion/core/resources/values_manager.dart';
import 'package:currency_conversion/core/service/service_locator.dart';
import 'package:currency_conversion/core/helper/date_time_picker.dart';
import 'package:currency_conversion/core/utils/enums.dart';
import 'package:currency_conversion/rates/presentation/components/rates_component.dart';
import 'package:currency_conversion/rates/presentation/components/select_date_field.dart';
import 'package:currency_conversion/rates/presentation/controller/rates_bloc.dart';
import 'package:currency_conversion/rates/presentation/controller/rates_event.dart';
import 'package:currency_conversion/rates/presentation/controller/rates_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RatesScreen extends StatelessWidget {
  const RatesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => sl<RatesBloc>()..add(GetSupportedSymbolsEvent()),
        child: BlocBuilder<RatesBloc, RatesState>(
          builder: (context, state) {
            if (state.requestState == RequestState.error) {
              Fluttertoast.showToast(
                  msg: "End date mustn't be before start date",
                  toastLength: Toast.LENGTH_SHORT,
                  // gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
            return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                  centerTitle: true,
                  title: const Text(AppStrings.ratesScreenTitle),
                  elevation: 0,
                  backgroundColor: Colors.transparent),
              body: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(ImageAssets.bgImage),
                        colorFilter: ColorFilter.matrix(ColorMatrix.darkerImageMatrix))),
                child: SafeArea(
                    bottom: false,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppStrings.selectDateRange,
                                style: getBoldStyle(color: ColorManager.white),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SelectDateField(
                                      text: state.startDate,
                                      onPressed: () async {
                                        var pickedData = await showPlatformDatePicker(context);
                                        if (pickedData != null) {
                                          context.read<RatesBloc>().add(SelectFromDateEvent(pickedData.toString()));
                                        }

                                        //     print(pickedData);
                                      }),
                                  SelectDateField(
                                      text: state.endDate,
                                      onPressed: () async {
                                        var pickedData = await showPlatformDatePicker(context);
                                        if (pickedData != null) {
                                          BlocProvider.of<RatesBloc>(context)
                                              .add(SelectToDateEvent(pickedData.toString()));
                                        }
                                      }),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppStrings.selectCurrencies,
                                style: getBoldStyle(color: ColorManager.white),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 140.w,
                                    height: 52.h,
                                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16.r),
                                        color: ColorManager.white.withOpacity(0.1)),
                                    child: DropdownButton(
                                        value: state.baseCurrency,
                                        style: getBoldStyle(color: ColorManager.darkWhite),
                                        items: state.symbols.keys
                                            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                                            .toList(),
                                        borderRadius: BorderRadius.circular(16.sp),
                                        onChanged: (val) {
                                          context.read<RatesBloc>().add(SelectBaseCurrencyEvent(val!));
                                        },
                                        hint:
                                            Text(AppStrings.from, style: getMediumStyle(color: ColorManager.darkWhite)),
                                        underline: const SizedBox(),
                                        isExpanded: true,
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down_sharp,
                                          color: ColorManager.darkWhite,
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Image.asset(ImageAssets.switchImage),
                                  ),
                                  Container(
                                    width: 140.w,
                                    height: 52.h,
                                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16.r),
                                        color: ColorManager.white.withOpacity(0.1)),
                                    child: DropdownButton(
                                        value: state.toCurrency,
                                        style: getBoldStyle(color: ColorManager.darkWhite),
                                        items: state.symbols.keys
                                            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                                            .toList(),
                                        borderRadius: BorderRadius.circular(16.sp),
                                        onChanged: (val) {
                                          context.read<RatesBloc>().add(SelectToCurrencyEvent(val!));
                                        },
                                        hint: Text(AppStrings.to, style: getMediumStyle(color: ColorManager.darkWhite)),
                                        underline: const SizedBox(),
                                        isExpanded: true,
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down_sharp,
                                          color: ColorManager.darkWhite,
                                        )),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 31.h,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    fixedSize: Size(343.w, 54.h),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                                    elevation: 0,
                                    disabledBackgroundColor: ColorManager.lightGrey,
                                    backgroundColor: ColorManager.green),
                                onPressed: !state.startDate.contains("D") && !state.endDate.contains("D")
                                    ? () {
                                        BlocProvider.of<RatesBloc>(context)
                                            .add(GetDailyHistoricalRatesEvent(state.startDate, state.endDate));
                                      }
                                    : null,
                                child: Text(
                                  AppStrings.exchangeRates,
                                  style: getMediumStyle(color: ColorManager.white, fontSize: 16.sp),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 48.h,
                        ),
                        Expanded(
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.h),
                              decoration: BoxDecoration(
                                  color: ColorManager.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(28.r), topRight: Radius.circular(28.r))),
                              width: double.infinity,
                              child: const RatesComponent()),
                        )
                      ],
                    )),
              ),
            );
          },
        ));
  }
}
