import 'dart:convert';

import 'package:events/globals.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ModalBottomSheet extends StatefulWidget {
  @override
  _ModalBottomSheetState createState() => _ModalBottomSheetState();
}



var _dayEvent = new NewEvent(null, null, null, null);

class _ModalBottomSheetState extends State<ModalBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  TimeOfDay _timeOfDay = TimeOfDay.now();

  int maxLength = 0;
  int maxLines = 0;

  @override
  void initState() {
    eTitleController = TextEditingController();
    eDescrptionController = TextEditingController();
    // saveEvent();
    super.initState();
  }

  @override
  void dispose() {
    eTitleController.dispose();
    eDescrptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidate: true,
      key: _formKey,
      child: Container(
        margin: EdgeInsets.only(
          left: 10,
          right: 10,
          top: 10,
        ),
        height: MediaQuery.of(context).viewInsets.bottom + 350.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 4,
              width: 25,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),

            TitleWidget(),

            //Start/End for the events
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
                      Text(
                        "Start",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
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
                                              colorScheme: ColorScheme.dark(
                                                primary: Theme.of(context)
                                                    .primaryColorDark,
                                                onPrimary: Theme.of(context)
                                                    .focusColor,
                                                surface: Theme.of(context)
                                                    .backgroundColor,
                                                onSurface: Theme.of(context)
                                                    .focusColor,
                                              ),
                                              dialogBackgroundColor:
                                                  Color(0xFF262E3E))
                                          : ThemeData.light().copyWith(
                                              colorScheme: ColorScheme.light(
                                                primary: Theme.of(context)
                                                    .primaryColorLight,
                                                onPrimary: Theme.of(context)
                                                    .focusColor,
                                                surface: Theme.of(context)
                                                    .backgroundColor,
                                                onSurface: Theme.of(context)
                                                    .focusColor,
                                              ),
                                              dialogBackgroundColor:
                                                  Color(0xFF262E3E)),
                                      child: child);
                                },
                              ).then((value) {
                                setState(() {
                                  if (value != null) {
                                    startDate = value;
                                    endDate = value;
                                  }
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
                                  setState(() {
                                    startDate = DateTime(
                                        startDate.year,
                                        startDate.month,
                                        startDate.day,
                                        value.hour,
                                        value.minute);
                                  });
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
                      Text("End", style: Theme
                          .of(context)
                          .textTheme
                          .subtitle1),
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
                                builder: (context, child) {
                                  return Theme(
                                      data: menuGradient
                                          ? ThemeData.dark().copyWith(
                                          colorScheme: ColorScheme.dark(
                                            primary: Color(0xFF1C4572),
                                            onPrimary: Theme
                                                .of(context)
                                                .focusColor,
                                            surface: Theme
                                                .of(context)
                                                .primaryColor,
                                            onSurface: Theme
                                                .of(context)
                                                .focusColor,
                                          ),
                                          dialogBackgroundColor:
                                          Color(0xFF262E3E))
                                          : ThemeData.light().copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: Theme
                                                .of(context)
                                                .primaryColorLight,
                                            onPrimary: Theme
                                                .of(context)
                                                .focusColor,
                                            surface: Theme
                                                .of(context)
                                                .backgroundColor,
                                            onSurface: Theme
                                                .of(context)
                                                .focusColor,
                                          ),
                                          dialogBackgroundColor:
                                          Color(0xFF262E3E)),
                                      child: child);
                                },
                              ).then((value) {
                                setState(() {
                                  if (value != null) {
                                    endDate = value;
                                    if (startDate
                                        .difference(endDate)
                                        .inDays >
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
                                  ? DateFormat("EEE., MMM d, yyyy")
                                  .format(
                                currentDate.add(
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
                                }
                              });
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

            DescriptionWidget(),
            ButtonBar(
              buttonPadding: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              alignment: MainAxisAlignment.spaceEvenly,
              buttonTextTheme: ButtonTextTheme.primary,
              buttonHeight: 20,
              mainAxisSize: MainAxisSize.max,
              layoutBehavior: ButtonBarLayoutBehavior.constrained,
              children: <Widget>[
                FlatButton(
                  color: Theme
                      .of(context)
                      .primaryColorLight,
                  child: Center(
                      child: Text("Save",
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline6)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () {
//                   TODO _formKey.currentState.validate/save
                    if (endDate.isAfter(startDate) &&
                        eTitleController.text.isNotEmpty) {
                      saveEvent();
                      Navigator.pop(context);
                      setState(() {
                        scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            content: Text('Event Added'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      });
                    } else if (eTitleController.text.isEmpty) {
                      Navigator.pop(context);
                      scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text('Event not added. Title Required'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    } else {
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
                  color: Theme
                      .of(context)
                      .primaryColorLight,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Center(
                      child: Text(
                        "Cancel",
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline6,
                      )),
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

//Title Widget
class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 15, right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme
            .of(context)
            .primaryColorDark,
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
        autofocus: autofocus,
        keyboardType: TextInputType.multiline,
        minLines: 1,
        maxLines: 3,
        enableSuggestions: true,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          hintText: "Title",
          contentPadding: EdgeInsets.symmetric(horizontal: 8),
          focusColor: Colors.pink,
          alignLabelWithHint: true,
          border: InputBorder.none,
        ),
        cursorColor: Colors.pinkAccent,
        style: Theme
            .of(context)
            .textTheme
            .headline5,
      ),
    );
  }
}

//Description widget
class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 4, bottom: 4, left: 15, right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme
            .of(context)
            .primaryColorDark,
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
        autovalidate: true,
        autocorrect: true,
        autofocus: false,
        keyboardAppearance: Brightness.dark,
        keyboardType: TextInputType.multiline,
        minLines: 2,
        maxLines: 4,
        textCapitalization: TextCapitalization.sentences,
        controller: eDescrptionController,
        cursorColor: Colors.pinkAccent,
        enableSuggestions: true,
        decoration: InputDecoration(
          hintText: "Description",
          border: InputBorder.none,
          contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          alignLabelWithHint: true,
        ),
        style: Theme
            .of(context)
            .textTheme
            .headline6,
      ),
    );
  }
}

void saveEvent() {
  _dayEvent.title = eTitleController.text;
  _dayEvent.startDate = startDate.toString();
  _dayEvent.endDate = endDate.toString();

  if (eDescrptionController.text.isNotEmpty) {
    _dayEvent.description = eDescrptionController.text;
  } else {
    _dayEvent.description = "";
  }

  //TODO write a recursive method that will allow us to create events for a range of dates
  if (dayEvents[
  DateTime(startDate.year, startDate.month, startDate.day, 0, 0)] !=
      null) {
    dayEvents[DateTime(startDate.year, startDate.month, startDate.day, 0, 0)]
        .add(_dayEvent.toJson());
    calendarController.visibleEvents;
    // print("More than one event exists for this day");
  } else {
    dayEvents[DateTime(startDate.year, startDate.month, startDate.day, 0, 0)] =
    [_dayEvent.toJson()];
    // print("An event has been added");
  }

  eventPrefs.setString("events", json.encode(encodeMap(dayEvents)));

  eTitleController.clear();
  eDescrptionController.clear();
}

// getStartTime(var a) {
//   NewEvent user = NewEvent.fromJson(a);
//   var startTime = DateFormat.jm().format(DateTime.parse(user.startDate));
//   return startTime;
// }
