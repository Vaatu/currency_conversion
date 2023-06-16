import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


Future<DateTime?> showPlatformDatePicker(BuildContext context) async {
  DateTime now = DateTime.now();
  DateTime today = DateTime(now.year, now.month, now.day);
  DateTime? selectedDate;

  if (Platform.isIOS) {
    await showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
              height: MediaQuery.of(context).size.height * .3,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(26))),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .29,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: selectedDate ?? today,
                      maximumDate: today,
                      maximumYear: today.year,
                      onDateTimeChanged: ((value) => selectedDate = value),
                    ),
                  )
                ],
              ),
            ));
  } else {
    selectedDate = await pickDateTime(context);
  }
  return selectedDate;
}

Future pickDateTime(BuildContext context) async {
  final date = await pickDate(context);
  if (date == null) return;

  return DateTime(
    date.year,
    date.month,
    date.day,
  );
}

Future<DateTime?>? pickDate(BuildContext context) async {
  final initialDate = DateTime.now();
  DateTime? selectedDate;

  final newDate = await showDatePicker(
    context: context,
    initialDate: selectedDate ?? initialDate,
    lastDate: DateTime.now(),
    firstDate: DateTime(DateTime.now().year - 5),
  );

  if (newDate == null) return null;

  return newDate;
}
