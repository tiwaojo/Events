library globals;

//export 'src/ScrollingYears.dart';
//export 'src/main.dart';
//export 'package:events/src/viewDayEvents.dart';
//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

export 'package:flutter/material.dart';
export 'package:intl/date_symbol_data_local.dart';
export 'package:provider/provider.dart';
export 'package:shared_preferences/shared_preferences.dart';
export 'package:table_calendar/table_calendar.dart';

final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
Animation<double> animation;
AnimationController animationController1, animationController2;
String currentMonth = DateFormat.MMMM().format(DateTime.now());
//DateTime eventDateTime = DateTime.now().add(Duration(days: 1));//DateTime(2020, 6, 8);
//DateTime targetDateTime = DateTime(2020, 6, 8);
DateTime currentDate = DateTime.now();
DateTime startDate = DateTime.now();
DateTime endDate = DateTime.now().add(Duration(days: 1));

bool modalOpen = false;
bool resized = true;
int switchWidget = 1;
var scale = animationController2;
bool menuGradient = false;

//void showToast(BuildContext context) {
//  final scaffold = Scaffold.of(context);
//  scaffold.showSnackBar(
//    SnackBar(
//      content: Text(
//          'Event not added./n Event can not end before it has started.'),
//      duration: Duration(seconds: 3),
//      action: SnackBarAction(
//          label: "Undo", onPressed: null),
//    ),
//  );
//}

//double infinHeight=double.infinity;
//bool visibility = false;
//double opacity = 0.0;

//String nextMonth = DateFormat.MMMM()
//    .format(DateTime(targetDateTime.year, targetDateTime.month + 1));
//String prevMonth = DateFormat.MMMM()
//    .format(DateTime(targetDateTime.year, targetDateTime.month - 1));

//void _showToast(BuildContext context) {
//    final scaffold = Scaffold.of(context);
//    scaffold.showSnackBar(
//        SnackBar(
//          content: Text(
//              'Event not added./n Event can not end before it has started.'),
//          duration: Duration(seconds: 3),
//          action: SnackBarAction(
//              label: "Undo", onPressed: null),
//        ),
//    );
//}

CalendarController calendarController;
Map<DateTime, List<dynamic>> dayEvents;
TextEditingController eTitleController;
TextEditingController eDescrptionController;
//a list of the dayEvents
List<dynamic> selectedDayEvents;
//List<NewEvent> someEventList;
SharedPreferences eventPrefs;

Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
  Map<String, dynamic> newMap = {};
  map.forEach((key, value) {
    newMap[key.toString()] = map[key];
//    newMap[value.toString()] = map[value];
  });
  return newMap;
}

Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
  Map<DateTime, dynamic> newMap = {};
  map.forEach((key, value) {
    newMap[DateTime.parse(key)] = map[key];
  });
  return newMap;
}

class NewEvent {
  String title;
  String startDate = DateTime.now().toString();
  String endDate = DateTime.now().add(Duration(days: 1)).toString();
  String description;

  //if using {this.description} instead of [this.description], to assign a value use paramName:Value (e.g. var customer = Customer("bezkoder", location: "US", age: 26);
  NewEvent([this.title, this.startDate, this.endDate, this.description]);

  Map<String, dynamic> toJson() => {
//   Map startDate = this.startDate != null ? this.startDate.toJson() : null;

//    return {
        "title": title,
        "startDate": startDate,
        "endDate": endDate,
        "description": description,
//    };
      };

//  Map fromJson(Map<String, dynamic> json)=>{
//title = json['title'],
//        startDate = json['startDate'],
//        endDate = json['endDate'],
//        description = json['description'];
//  }
  factory NewEvent.fromJson(json) {
    return NewEvent(
        json['title'], json['startDate'], json['endDate'], json['description']);
  }
//  NewEvent.withoutDescription(this.title,this.startDate,this.endDate){
//    this.startDate = currentDate;
//    this.endDate = currentDate.add(Duration(days: 1));
}
