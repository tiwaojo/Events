library tasks.globals;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

Animation<double> animation;
AnimationController animationController1, animationController2;
String currentMonth = DateFormat.MMMM().format(DateTime.now());
DateTime targetDateTime = DateTime(2020, 6, 8);
DateTime currentDate = DateTime(2020, 6, 7);
DateTime selectedDate = DateTime.now();

bool modalOpen = false;
bool resized = true;
//double infinHeight=double.infinity;
//bool visibility = false;
//double opacity = 0.0;
int switchWidget = 1;
var scale = animationController2;
bool menuGradient = false;

String nextMonth = DateFormat.MMMM()
    .format(DateTime(targetDateTime.year, targetDateTime.month + 1));
String prevMonth = DateFormat.MMMM()
    .format(DateTime(targetDateTime.year, targetDateTime.month - 1));
var alignment = Alignment.center;

CalendarController calendarController;
Map<DateTime, List<dynamic>> dayEvents;
TextEditingController eventTitleController;
//a list of the dayEvents
List<dynamic> selectedEvents;
SharedPreferences eventPrefs;

Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
  Map<String, dynamic> newMap = {};
  map.forEach((key, value) {
    newMap[key.toString()] = map[key];
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
