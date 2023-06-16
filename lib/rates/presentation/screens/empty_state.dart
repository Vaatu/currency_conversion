import 'package:currency_conversion/core/resources/assets_manager.dart';
import 'package:currency_conversion/core/resources/color_manager.dart';
import 'package:currency_conversion/core/resources/strings_manager.dart';
import 'package:currency_conversion/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(ImageAssets.emptyState),
        SizedBox(height: 20.h,),
        Text(AppStrings.empty,style: getBoldStyle(color: ColorManager.grey1),),
        SizedBox(height: 5.h,),
        Text(AppStrings.emptyDesc,style: getBoldStyle(color: ColorManager.lightGrey),),
      ],
    );
  }
}
