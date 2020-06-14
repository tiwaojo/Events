import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'globals.dart' as globals;

class ModalBottomSheet extends StatefulWidget {
  @override
  _ModalBottomSheetState createState() => _ModalBottomSheetState();
}

class _ModalBottomSheetState extends State<ModalBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
//      color: Theme.of(context).backgroundColor,
      margin: EdgeInsets.only(left: 10, right: 10, top: 40),
      height: MediaQuery.of(context).viewInsets.bottom + 200.0,
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
              controller: globals.eventTitleController,
              autovalidate: true,
              autocorrect: true,
              autofocus: false,
              decoration: InputDecoration(
                  fillColor: Theme.of(context).backgroundColor,
                  contentPadding: EdgeInsets.only(left: 10),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.pink),
                      borderRadius: BorderRadius.circular(10),
                      gapPadding: 10),
                  alignLabelWithHint: true,
                  hintText: "Title"),

//                      scrollPadding: EdgeInsets.all(10),
              cursorColor: Colors.pinkAccent,
              cursorRadius: Radius.circular(12),
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          TextFormField(
            autovalidate: true,
            autocorrect: true,
            autofocus: false,
//                      scrollPadding: EdgeInsets.all(10),
            cursorColor: Colors.pinkAccent,
            style: Theme.of(context).textTheme.headline1,
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
                  if (globals.eventTitleController.text.isEmpty) return;
                  setState(() {
                    if (globals.dayEvents[
                            globals.calendarController.selectedDay] !=
                        null) {
                      globals.dayEvents[globals.calendarController.selectedDay]
                          .add(globals.eventTitleController.text);
                      globals.calendarController.visibleEvents;
                      print("Event added");
                    } else {
                      globals
                          .dayEvents[globals.calendarController.selectedDay] = [
                        globals.eventTitleController.text
                      ];
                      print("Event not added");
                    }
                    globals.eventPrefs.setString("events",
                        jsonEncode(globals.encodeMap(globals.dayEvents)));
                    globals.eventTitleController.clear();
                    Navigator.pop(context);
                  });
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
    );
  }
}
