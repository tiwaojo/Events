library globals;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

export 'package:flutter/material.dart';
export 'package:intl/date_symbol_data_local.dart';
export 'package:provider/provider.dart';
export 'package:shared_preferences/shared_preferences.dart';
export 'package:table_calendar/table_calendar.dart';

//Key for the scaffold widget object
final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

//Animation controllers and variables
Animation<double> rotateAnimation, scaleAnimation;
Animation<Offset> slideAnimation, offsetAnimation;
Animation<RelativeRect> mainAnimation, posAnimation;
AnimationController opacityController,
    slideAnimationController,
    mainController,
    bodyController,
    scaleController,
    rotateController;

//DateTime and Calendar variables
TableCalendar tableCalendar;
DateTime currentDate = DateTime.now();
DateTime startDate = DateTime.now();
DateTime endDate = DateTime.now().add(Duration(days: 1));

// Constants to maintain states and values across multiple widgets
bool modalOpen = false;
bool resized = true;
bool selected = false;
int switchWidget = 1;
bool menuGradient = false;
double decorGradient = 0.25;
Duration duration = const Duration(seconds: 2);

//Map for all the events
Map<DateTime, List<dynamic>> dayEvents;

// Controllers for the form fields
CalendarController calendarController;
TextEditingController eTitleController;
TextEditingController eDescrptionController;
TextEditingController eSearchController;

//a list of the dayEvents
List<dynamic> selectedDayEvents;
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
  NewEvent(this.title, this.startDate, this.endDate, this.description);

  Map<String, dynamic> toJson() => {

//    return {
        'title': this.title,
        'startDate': this.startDate,
        'endDate': this.endDate,
        'description': this.description,
//    };
      };

//  Map fromJson(Map<String, dynamic> json)=>{
//title = json['title'],
//        startDate = json['startDate'],
//        endDate = json['endDate'],
//        description = json['description'];
//  }

//  NewEvent.fromJson(   dynamic data)
//      : title = data["title"],
//        startDate = data['startDate'],
//        endDate = data['endDate'],
//        description = data['description'];

  factory NewEvent.fromJson(dynamic json) {
    return NewEvent(
        json['title'], json['startDate'], json['endDate'], json['description']);
  }

//  NewEvent.withoutDescription(this.title,this.startDate,this.endDate){
//    this.startDate = currentDate;
//    this.endDate = currentDate.add(Duration(days: 1));
}

void orderedSelectedDay() {
  if (selectedDayEvents.isNotEmpty && selectedDayEvents.length > 1) {
    for (int i = 0; i < selectedDayEvents.length - 1; i++) {
      for (int j = 0; j < selectedDayEvents.length - i - 1; j++) {
        NewEvent user1 = NewEvent.fromJson(selectedDayEvents.elementAt(j));
        NewEvent user2 = NewEvent.fromJson(selectedDayEvents.elementAt(1 + j));
        var time1 = DateTime.parse(user1.startDate);
        var time2 = DateTime.parse(user2.startDate);
        if (time2.isBefore(time1)) {
          //remove and replace the first time with the preceeding one and vice versa
          selectedDayEvents.removeAt(j);
          selectedDayEvents.insert(j, user2.toJson());
          selectedDayEvents.removeAt(1 + j);
          selectedDayEvents.insert(1 + j, user1.toJson());
          print('$time1 > $time2');
        }
      }
    }
  }
}

bool isEventNow(
  String startDate,
  String endDate,
) {
  //method to determine and allow for UI decoration based on if the event/events are already happening
// Future<bool>result= Future.delayed(duration,(){
  if (currentDate.isBefore(DateTime.parse(startDate)) == false &&
      currentDate.isAfter(DateTime.parse(endDate)) == false) {
    //|| currentDate.isAtSameMomentAs(DateTime.parse(startDate))) {
//      print("$currentDate is after $startDate");
    return true;
  } else {
    return false;
  }
}
