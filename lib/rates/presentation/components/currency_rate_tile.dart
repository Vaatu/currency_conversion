import 'package:currency_conversion/core/resources/color_manager.dart';
import 'package:currency_conversion/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CurrencyRateTile extends StatelessWidget {
  final String baseCurrency;
  final String symbol;
  final String date;
  final double rate;

  const CurrencyRateTile(
      {Key? key, required this.date, required this.baseCurrency, required this.symbol, required this.rate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      height: 72.h,
      decoration: BoxDecoration(color: ColorManager.lightGrey2, borderRadius: BorderRadius.all(Radius.circular(16.r))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                date,
                style: getBoldStyle(color: ColorManager.primary),
              ),
              SizedBox(
                height: 4.h,
              ),
              Text(
                "1.00 $baseCurrency",
                style: getLightStyle(color: ColorManager.lightGrey),
              )
            ],
          ),
          Text("$rate $symbol",style: getBoldStyle(color: ColorManager.primary,fontSize: 16.sp),)
        ],
      ),
    );
  }
}
