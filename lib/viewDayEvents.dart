import 'package:animate_do/animate_do.dart';
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
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
//              appbar(context),

          Appbar(context),
          ...selectedDayEvents
              .getRange(0,
                  selectedDayEvents.length >= 3 ? 3 : selectedDayEvents.length)
              .map(
            (event) {
              var user = NewEvent.fromJson(event);
              print(user.toJson());
              return Hero(
                tag: user.title,
                child: FadeIn(
                  animate: true,
//                delay: Duration(milliseconds: 1500),
                  duration: Duration(seconds: 2),
                  child: Card(
                    elevation: 5,
                    shadowColor: Colors.black,
                    child: ListTile(
                      title: Text(user.title),
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
                ),
              );
            },
          ),
        ],
      ),
    );
//
  }
}
//Widget viewDayEvents(context) {
//
//      ],
//    ),
//  );
//}
