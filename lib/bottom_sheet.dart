import 'dart:convert';

import 'package:events/globals.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ModalBottomSheet extends StatefulWidget {
  @override
  _ModalBottomSheetState createState() => _ModalBottomSheetState();
}

int maxLength = 0;

int maxLines = 0;

var _dayEvent = new NewEvent(null, null, null, null);

class _ModalBottomSheetState extends State<ModalBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  TimeOfDay pickedTime = TimeOfDay.now();

//  Future<TimeOfDay> selectTime(BuildContext context) async {
//    pickedDate = await showTimePicker(
//      context: context,
//      initialTime: _timeOfDay,
//      builder: (BuildContext context, Widget child) {
//        return MediaQuery(
//          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
//
//          child: child,
//        );
//      },
//    );
//    if (pickedDate != null && pickedDate != _timeOfDay) {
//      setState(() {
//        _timeOfDay = pickedDate;
//        print(pickedDate);
//      });
//    }
//  }
  selectTime(BuildContext context, DateTime pickedDate) {
    showTimePicker(
      context: context,
      initialTime: _timeOfDay,
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child,
        );
      },
    ).then((value) {
      if (value != null) {
//                                pickedTime = value;
        setState(() {
          pickedDate = DateTime(pickedDate.year, pickedDate.month,
              pickedDate.day, value.hour, value.minute);
        });
      }
//      print("Picked Date: $pickedDate ");
      return pickedDate;
    });
  }

  @override
  void initState() {
    super.initState();
    eTitleController = TextEditingController();
    eDescrptionController = TextEditingController();
//    initPrefs();
  }


  @override
  void dispose() {
    super.dispose();
    eTitleController.dispose();
    eDescrptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidate: true,
      key: _formKey,
      child: Container(
//      color: Theme.of(context).backgroundColor,
        margin: EdgeInsets.only(
          left: 10,
          right: 10,
          top: 40,
        ),
        height: MediaQuery.of(context).viewInsets.bottom + 350.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
//              shape: BoxShape.circle,
                color: Theme.of(context).backgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.5),
                    blurRadius: 10.0,
                    spreadRadius: 1.0,
                    offset: Offset(
                      0,
                      0,
                    ),
                  ),
                ],
              ),
              child: TextFormField(
                controller: eTitleController,
                autovalidate: true,
                autocorrect: true,
                autofocus: false,
                expands: false,

//                textInputAction: TextInputAction.continueAction,
                maxLines: maxLength < 30 ? 1 : maxLines += 1,
                enableSuggestions: true,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(hintText: "Title"),
//                      scrollPadding: EdgeInsets.all(10),
                cursorColor: Colors.pinkAccent,
                cursorRadius: Radius.circular(12),
                style: Theme
                    .of(context)
                    .textTheme
                    .headline4,
              ),
            ),

            Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.centerRight,
              child: Column(
                children: <Widget>[
                  //START DATE
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Start"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FlatButton.icon(
                            onPressed: () {
                              showDatePicker(
                                context: context,
                                initialDate:
//                                startDate == null ?
                                currentDate,
//                                    : startDate,
                                initialDatePickerMode: DatePickerMode.day,
                                firstDate: DateTime(2018),
                                lastDate: DateTime(currentDate.year + 10),
                                builder: (context, child) {
                                  return Theme(
                                      data: menuGradient
                                          ? ThemeData.dark().copyWith(
                                          primaryColor: Colors.amber,
                                          //OK/Cancel button text color
                                          //Head background
                                          splashColor: Color(0xff182231),
                                          accentColor: const Color(
                                              0xFF4A5BF6) //selection color
                                        //dialogBackgroundColor: Colors.white,//Background color
                                      )
                                          : ThemeData.light().copyWith(
                                        colorScheme: ColorScheme.dark(
                                          primary: Colors.deepPurple,
                                          onPrimary: Colors.white,
                                          surface: Colors.pink,
                                          onSurface: Colors.yellow,
                                        ),
                                        dialogBackgroundColor:
                                        Colors.blue[900],
                                      ),
                                      child: child);
                                },
                              ).then((value) {
                                setState(() {
                                  if (value != null) {
                                    startDate = value;
                                    endDate = value;
//                                        .add(
//                                      Duration(days: 1),
//                                    );
                                  }

//                                startDate.difference(endDate).inDays>=1?startDate.subtract(Duration(days: 1)):endDate=startDate;
                                });
                              });
                            },
                            icon: Icon(Icons.calendar_today),
                            label: Text(
                              startDate == null
                                  ? DateFormat("EEE., MMM d, yyyy")
                                  .format(currentDate)
                                  .toString()
                                  : DateFormat("EEE., MMM d, yyyy")
                                  .format(startDate)
                                  .toString(),
                            ),
                          ),
                          FlatButton.icon(
                            onPressed: () {
                              showTimePicker(
                                context: context,
                                initialTime: _timeOfDay,
                                builder: (BuildContext context, Widget child) {
                                  return MediaQuery(
                                    data: MediaQuery.of(context)
                                        .copyWith(alwaysUse24HourFormat: false),
                                    child: child,
                                  );
                                },
                              ).then((value) {
                                if (value != null) {
//                                pickedTime = value;
                                  setState(() {
                                    startDate = DateTime(
                                        startDate.year,
                                        startDate.month,
                                        startDate.day,
                                        value.hour,
                                        value.minute);
                                  });
//                                  print(startDate);
                                }
                              });
                            },
                            icon: Icon(Icons.access_alarms),
                            label: Text(
                              startDate == currentDate
                                  ? DateFormat("h:mm a")
                                  .format(currentDate)
                                  .toString()
                                  : DateFormat("h:mm a")
                                  .format(startDate)
                                  .toString(),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),

                  //END DATE
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("End"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FlatButton.icon(
                            onPressed: () {
                              showDatePicker(
                                context: context,
                                initialDate:
//                              startDate == null
//                                  ?
                                startDate,
//                                  : startDate.add(Duration(days: 1),
//                                    ),
                                initialDatePickerMode: DatePickerMode.day,
                                firstDate: DateTime(2018),
                                lastDate: DateTime(currentDate.year + 10),
                              ).then((value) {
                                setState(() {
                                  if (value != null) {
                                    endDate = value;
                                    if (startDate
                                        .difference(endDate)
                                        .inDays > 1) {
                                      endDate = startDate.add(
                                        Duration(days: 1),
                                      );
                                    }
                                  }
                                });
                              });
                            },
                            icon: Icon(MdiIcons.calendarPlus),
                            label: Text(
                              endDate == null
                                  ? DateFormat("EEE., MMM d, yyyy")
                                  .format(
                                currentDate
                                    .add(
                                  Duration(days: 1),
                                ),
                              )
                                  .toString()
                                  : DateFormat("EEE., MMM d, yyyy")
                                  .format(endDate)
                                  .toString(),
                            ),
                          ),
                          FlatButton.icon(
                            onPressed: () {
                              showTimePicker(
                                context: context,
                                initialTime: _timeOfDay,
                                builder: (BuildContext context, Widget child) {
                                  return MediaQuery(
                                    data: MediaQuery.of(context)
                                        .copyWith(alwaysUse24HourFormat: false),
                                    child: child,
                                  );
                                },
                              ).then((value) {
                                if (value != null) {
                                  setState(() {
                                    endDate = DateTime(
                                        endDate.year,
                                        endDate.month,
                                        endDate.day,
                                        value.hour,
                                        value.minute);
                                  });
//                                  print(endDate);
                                }
                              });

//                              print(endDate);
                            },
                            icon: Icon(Icons.access_alarms),
                            label: Text(
                              endDate == currentDate.add(Duration(days: 1))
                                  ? DateFormat("h:mm a")
                                  .format(currentDate)
                                  .toString()
                                  : DateFormat("h:mm a")
                                  .format(endDate)
                                  .toString(),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),

            TextFormField(
              autovalidate: true,
              autocorrect: true,
              autofocus: false,
              keyboardAppearance: Brightness.dark,
              textCapitalization: TextCapitalization.sentences,
              controller: eDescrptionController,
              cursorColor: Colors.pinkAccent,
              maxLines: 4,
              enableSuggestions: true,
              maxLength: 250,
              maxLengthEnforced: false,
              decoration: InputDecoration(
                hintText: "Description",
                contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                isDense: true,
                fillColor: Colors.green,
                suffixText: "What",
              ),
              style: Theme
                  .of(context)
                  .textTheme
                  .headline2,
            ),
            ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              buttonHeight: 20,
              mainAxisSize: MainAxisSize.max,
              layoutBehavior: ButtonBarLayoutBehavior.constrained,
              children: <Widget>[
                FlatButton(
                  child: Center(child: Text("Save")),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () async {
//                   TODO _formKey.currentState.validate/save
//                    if (eTitleController.text.isEmpty) return;
                    if (endDate.isAfter(startDate) &&
                        eTitleController.text.isNotEmpty) {
                      saveEvent();
                      Navigator.pop(context);
                      setState(() {
                        scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            content: Text('Event Added'),
                            duration: Duration(seconds: 10),
                          ),
                        );
                      });
                    }
                    else if (eTitleController.text.isEmpty) {
                      Navigator.pop(context);
                      scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text('Event not added. Title Required'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                    else {
                      Navigator.pop(context);
                      scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text('Event not added. Invalid Datetime.'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                  },
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Center(child: Text("Cancel")),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void saveEvent() {
    _dayEvent.title = eTitleController.text;
    _dayEvent.startDate = startDate.toString();
    _dayEvent.endDate = endDate.toString();

    if (eDescrptionController.text.isNotEmpty) {
      _dayEvent.description = eDescrptionController.text;
    }
    else {
      _dayEvent.description = "";
    }
//    if (calendarController.isSelected(startDate)||calendarController.focusedDay==startDate) {
//      setState(() {
//        eventListKey.currentState.insertItem(selectedDayEvents.length );
////
//      });
////
//    }

    //TODO write a recursive method that will reassign [calendarController.selectedDay] to the days within the startDate and the endDate
//                        calendarController.setSelectedDay(DateTime(startDate.year,startDate.month,startDate.day,0,0),animate: false);
    if (dayEvents[DateTime(
        startDate.year, startDate.month, startDate.day, 0, 0)] != null) {
      dayEvents[DateTime(startDate.year, startDate.month, startDate.day, 0, 0)]
          .add(_dayEvent.toJson());
      calendarController.visibleEvents;
//                          selectedDayEvents.forEach((element) {var user = NewEvent.fromJson(element);
//                            print(user.toJson());});
      print("More than one event exists for this day");
    } else {
      //TODO cannot have new event [_dayEvent] be saved to key [startDate]. It will override the previous value

      dayEvents[DateTime(
          startDate.year, startDate.month, startDate.day, 0, 0)] =
      [_dayEvent.toJson()];

      print("An event has been added");
//                          print(dayEvents.values.toList());
//                          print(selectedDayEvents);

    }

    eventPrefs.setString(
        "events", json.encode(encodeMap(dayEvents)));
//                      eventListKey.currentState.insertItem(selectedDayEvents.length+1);

    eTitleController.clear();
    eDescrptionController.clear();
    orderedSelectedDay();
//    if (calendarController.isSelected(startDate)) { selectedDayEvents=dayEvents[calendarController.selectedDay];
//    if(selectedDayEvents.isEmpty){
//      setState(() {
//      selectedDayEvents;print(selectedDayEvents);
//    });
//    }
//    }
//                      _dayEvent = null;

  }


  getStartTime(var a) {
    NewEvent user = NewEvent.fromJson(a);
    var startTime = DateFormat.jm().format(DateTime.parse(user.startDate));
    return startTime;
  }
}


//                  print(dayEvents);
////                  dayEvents=[(dayEvents.keys,dayEvents)];
//                  print(selectedDayEvents);
//                    String tartDate = jsonEncode((_dayEvent));
//                    String tartDate=jsonEncode(encodeMap((dayEvents)));
//                    print(tartDate);
//                    for (var key in dayEvents.keys) {
//                      print(key);
//                    }
//                    print("\n");
//                    for (var value in dayEvents.values) {
//                      print(value);
//                    }
//
//                    dayEvents.forEach((key, value) {
//                      print("key: $key and value: $value");
//                      value.forEach((element) {element=someEventList;print(someEventList);});
//                    });
/*Future.delayed(Duration(seconds;3)).then((value){progressDialog.update/show/hide();});*/

//assert is to tell the program that to make sure the variable has the correct parameters//                              assert(
//                              startDate.hour == pickedDate.hour);
//                              assert(startDate.minute ==
//                                  pickedDate.minute);

//                              DateTime(startDate.hour) =pickedDate.hour;
//                            assert(startDate.hour==pickedDate.hour);
//                            assert(startDate.minute==pickedDate.minute);
//                            assert(DateFormat("H:m").format(startDate)==pickedDate.format(context));
//=pickedDate.hour;
//                              startDate.
//                            showTimePicker(
//                              context: context,
//                              initialTime: TimeOfDay.fromDateTime(
//                                  DateTime.parse(
//                                      startDate.toIso8601String(),
//                                  ),
//                              ),
//                            );
//                          selectTime(context);
//                    if (startDate.difference(endDate).inDays >
//                        1) {
//                      setState(() {
//
//                      });
//                    }
//                              then((value) {
//                                if (value != null) {
//                                  pickedTime = value;
//
//                                  endDate = DateTime(
//                                      endDate.year,
//                                      endDate.month,
//                                      endDate.day,
//                                      pickedTime.hour,
//                                      pickedTime.minute);
//                                }
//                              });
//assert is to tell the program that to make sure the variable has the correct parameters
//                              assert(
//                              startDate.hour == pickedDate.hour);
//                              assert(startDate.minute ==
//                                  pickedDate.minute);

//                            TimeOfDay(hour: pickedDate.hour,minute: pickedDate.minute).toString()+pickedDate.period.toString().substring(10,12),
//                            pickedDate.toString().substring(10, 15) +
//                                pickedDate.period.toString().substring(10, 12),

//  InputDatePickerFormField(firstDate: DateTime(2018), lastDate: DateTime(2021),)

//  onPressed: () {
//                // Validate returns true if the form is valid, or false
//                // otherwise.
//                if (_formKey.currentState.validate()) {
//                  // If the form is valid, display a Snackbar.
//                  Scaffold.of(context)
//                      .showSnackBar(SnackBar(content: Text('Processing Data')));
//                }
//              },
//                            showTimePicker(
//                              builder: (context, child) {
//                                return MediaQuery(
//                                  data: MediaQuery.of(context).copyWith(
//                                    alwaysUse24HourFormat: false,
//                                    physicalDepth: 10,
//                                  ),
//                                  child: child,
//                                );
//                              },
//                              context: context,
//                              initialTime: TimeOfDay.fromDateTime(
//                                DateTime(
//                                  DateTime.now().year,
//                                  DateTime.now().month,
//                                  DateTime.now().day + 1,
//                                  DateTime.now().hour,
//                                  DateTime.now().minute,
//                                ),
//                              ),
//                            );
