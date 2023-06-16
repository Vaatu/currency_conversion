import 'package:currency_conversion/core/resources/color_manager.dart';
import 'package:currency_conversion/core/resources/styles_manager.dart';
import 'package:currency_conversion/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectDateField extends StatelessWidget {
  const SelectDateField({Key? key, this.onPressed, required this.text}) : super(key: key);
  final VoidCallback? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(16.r), color: ColorManager.white.withOpacity(0.1)),
        width: 160.w,
        height: 52.w,
        padding: const EdgeInsets.symmetric(vertical: AppMargin.m17, horizontal: AppMargin.m15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: getSemiBoldStyle(color: ColorManager.darkWhite)),
            const Icon(
              Icons.date_range,
              color: ColorManager.darkWhite,
            )
          ],
        ),
      ),
    );
  }
}
