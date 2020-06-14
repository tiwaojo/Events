import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//import 'package:syncfusion_flutter_calendar/calendar.dart';
//import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
bool test = false;

Widget viewDayEvents(context) {
  return Column(
    children: <Widget>[
      SizedBox(
        height: 200,
      ),
      SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 200,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(75.0),
              topRight: Radius.circular(
                75.0,
              ),
            ),
            color: Colors.blue,
            boxShadow: [
              BoxShadow(
                color: Colors.red.withOpacity(0.5),
                blurRadius: 10.0,
                spreadRadius: 1.0,
                offset: Offset(
                  0,
                  0,
                ),
              ),
            ],
          ),
          child: Text("View Days Events"),
//            SwitchListTile(onChanged: (bool value) {
//              test = !test;
//              test = value;
//              print(test);
//            }, value: !test,
//
//            ),
//            Hero(
//              tag: "currentMonth",
//              child: Material(
//                child: GestureDetector(
//                  onTap: () => Navigator.pop(context),
//
//                ),
//              ),
//            ),

//            child: SfCalendar(
//              view: CalendarView.month,backgroundColor: Colors.green,
//                monthViewSettings: MonthViewSettings(showAgenda: true)
//            ),

//child: SizedBox(),
        ),
      ),
    ],
  );
}
