import 'package:flutter/material.dart';

class DatePicker {
  DatePicker._();

  static final DatePicker instance = DatePicker._();

  Future<DateTime?> selectDate(
    BuildContext context, {
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(1830),
      lastDate: lastDate ?? DateTime.now(),
    );
    return picked;
  }

  Future<TimeOfDay?> selectTime(
    BuildContext context, {
    DateTime? initialDate,
  }) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialDate != null
          ? TimeOfDay(
              hour: initialDate.hour,
              minute: initialDate.minute,
            )
          : TimeOfDay(
              hour: DateTime.now().hour,
              minute: DateTime.now().minute,
            ),
    );
    return picked;
  }
}
