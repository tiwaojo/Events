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
      print("Picked Date: $pickedDate ");
      return pickedDate;
    });
  }

  //    this._showToast(context);

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidate: true,
      key: _formKey,
      child: Container(
//      color: Theme.of(context).backgroundColor,
        margin: EdgeInsets.only(left: 10, right: 10, top: 40),
        height: MediaQuery.of(context).viewInsets.bottom + 350.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
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
                maxLines: (() {
                  maxLength < 30 ? 1 : maxLines += 1;
//                if(maxLines==4){maxLength=maxLength;}
                }()),
                enableSuggestions: true,
                textCapitalization: TextCapitalization.sentences,

                decoration: InputDecoration(hintText: "Title"),

//                      scrollPadding: EdgeInsets.all(10),
                cursorColor: Colors.pinkAccent,
                cursorRadius: Radius.circular(12),
                style: Theme.of(context).textTheme.headline1,
              ),
            ),

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
//START DATE
            Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.centerRight,
              child: Column(children: <Widget>[
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
                              initialDate: startDate == null
                                  ? DateTime.now()
                                  : startDate,
                              initialDatePickerMode: DatePickerMode.day,
                              firstDate: DateTime(2018),
                              lastDate: DateTime(2021),
                              builder: (context, child) {
                                return Theme(
                                    data:
//                                  menuGradient?Theme.of(context).copyWith(
//                                    primaryColor: Color(0xFF4A5BF6),
//                                  ): Theme.of(context).copyWith(
//                                    primaryColor: Color(0xff182231),
//                                  ),
                                        menuGradient
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
                                  endDate = value.add(
                                    Duration(days: 1),
                                  );
                                }

//                                startDate.difference(endDate).inDays>=1?startDate.subtract(Duration(days: 1)):endDate=startDate;
                              });
                            });
                          },
                          icon: Icon(Icons.calendar_today),
                          label: Text(
                            startDate == null
                                ? DateFormat("MMMM dd, yyyy")
                                    .format(currentDate)
                                    .toString()
                                : DateFormat("MMMM dd, yyyy")
                                    .format(startDate)
                                    .toString(),
                          ),
                        ),
                        FlatButton.icon(
                          onPressed: () {
                            print(startDate);
//setState(() {
//  selectTime(context, startDate);
//});

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
                                print(startDate);
                              }
                            });
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
                          },
                          icon: Icon(Icons.access_alarms),
                          label: Text(
//                            TimeOfDay(hour: pickedDate.hour,minute: pickedDate.minute).toString()+pickedDate.period.toString().substring(10,12),
//                            pickedDate.toString().substring(10, 15) +
//                                pickedDate.period.toString().substring(10, 12),

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
                            print(endDate);
                            showDatePicker(
                              context: context,
                              initialDate:
//                              startDate == null
//                                  ?
                                  endDate,
//                                  : startDate.add(Duration(days: 1),
//                                    ),
                              initialDatePickerMode: DatePickerMode.day,
                              firstDate: DateTime(2018),
                              lastDate: DateTime(2021),
                            ).then((value) {
                              setState(() {
                                if (value != null) {
                                  endDate = value;
                                  if (startDate.difference(endDate).inDays >=
                                      1) {
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
                                ? DateFormat("MMMM dd, yyyy")
                                    .format(
                                      currentDate.add(
                                        Duration(days: 1),
                                      ),
                                    )
                                    .toString()
                                : DateFormat("MMMM dd, yyyy")
                                    .format(endDate)
                                    .toString(),
                          ),
                        ),
                        FlatButton.icon(
                          onPressed: () {
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

                            print(endDate);

//                            setState(() {
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
                                  endDate = DateTime(
                                      endDate.year,
                                      endDate.month,
                                      endDate.day,
                                      value.hour,
                                      value.minute);
                                });
                                print(endDate);
                              }
                            });
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
                            print(endDate);
//                            });
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
              ]),
            ),

            TextFormField(
              autovalidate: true,
              autocorrect: true,
              autofocus: false,
              keyboardAppearance: Brightness.dark,
              textCapitalization: TextCapitalization.sentences,
              controller: eDescrptionController,
//                      scrollPadding: EdgeInsets.all(10),
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
              style: Theme.of(context).textTheme.headline2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  child: Center(child: Text("Save")),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () {
                    if (eTitleController.text.isEmpty) return;
                    setState(() {
                      if (dayEvents[calendarController.selectedDay] != null) {
                        dayEvents[calendarController.selectedDay]
                            .add(eTitleController.text);
                        calendarController.visibleEvents;
                        print("More than one event exists for this day");
                      } else {
                        dayEvents[calendarController.selectedDay] = [
                          eTitleController.text
                        ];
                        print("An event has been added");
//                        Navigator.pop(context);
                      }
                      eventPrefs.setString(
                          "events", jsonEncode(encodeMap(dayEvents)));
                      eTitleController.clear();

                      Navigator.pop(context);
                      scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text(
                              'Event not added. Event can not end before it has started.'),
                          duration: Duration(seconds: 10),
                          action: SnackBarAction(
                            label: "Redo",
                            onPressed: () {
                              ModalBottomSheet();
                            },
                          ),
                        ),
                      );
                    });
//                    if (startDate.difference(endDate).inDays >
//                        1) {
//                      setState(() {
//
//                      });
//                    }
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
}
