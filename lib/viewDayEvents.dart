import 'dart:convert';

import 'package:events/custom_widgets.dart';
import 'package:events/globals.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

//import 'package:syncfusion_flutter_calendar/calendar.dart';
//import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ViewDayEvents extends StatefulWidget {
  @override
  _ViewDayEventsState createState() => _ViewDayEventsState();
}

class _ViewDayEventsState extends State<ViewDayEvents> {
  @override
  Widget build(BuildContext context) {
    var count = 0;
//    int numDayEvents = 3;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: <Widget>[
          Appbar(),
          ...selectedDayEvents
              .getRange(0,
                  selectedDayEvents.length >= 3 ? 3 : selectedDayEvents.length)
              .map(
            (event) {
              NewEvent user = json.decode(event);

              return Hero(
                tag: user.title + "$count++",
                child: Card(
                  elevation: 5,
                  shadowColor: Colors.black,
                  color: Theme.of(context).primaryColor,
                  child: ListTile(
                    title: Text(
                      user.title,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    trailing: IconButton(
                      icon: Icon(MdiIcons.delete),
                      color: Colors.pinkAccent,
                      onPressed: () {
                        setState(() {
                          dayEvents.remove(0);
                          selectedDayEvents.removeLast();
                          print(selectedDayEvents);
                          print(dayEvents);
                        });
                      },
                    ),
                  ),
                ),
              );
            },
          ),
//          AnimatedList(
//              initialItemCount: selectedDayEvents.length,
////              key: eventListKey,
//              primary: true,
//              shrinkWrap: true,
//              physics: BouncingScrollPhysics(),
//              itemBuilder: (context, index, animation) {
//                NewEvent user = NewEvent.fromJson(
//                    (selectedDayEvents[index]) as Map<String, dynamic>);
//                return FadeIn(
//                  animate: true,
////                delay: Duration(milliseconds: 1500),
//                  duration: Duration(seconds: 2),
//                  child: Card(
//                    elevation: 5,
//                    shadowColor: Colors.black,
//                    color: Theme.of(context).primaryColor,
//                    child: ListTile(
//                      title: Text(
//                        user.title,
//                        style: Theme.of(context).textTheme.headline2,
//                      ),
//                      trailing: IconButton(
//                        icon: Icon(MdiIcons.delete),
//                        color: Colors.pinkAccent,
//                        onPressed: () {
//                          setState(() {
//                            dayEvents.remove(0);
//                            selectedDayEvents.removeLast();
//                            print(selectedDayEvents);
//                            print(dayEvents);
//                          });
//                        },
//                      ),
//                    ),
//                  ),
//                );
//              }),
        ],
      ),
    );
  }
}
