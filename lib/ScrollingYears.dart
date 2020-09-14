import 'package:events/globals.dart';
import 'package:flutter/material.dart';

class Year extends StatefulWidget {
  @override
  _YearState createState() => _YearState();
}

class _YearState extends State<Year> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.height,
      child: Center(
        child: (() {
          showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime.now().add(Duration(days: -365)),
            lastDate: DateTime.now().add(Duration(days: 365)),
          );
        }()),
      ),
    );
  }
}
