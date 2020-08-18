//import 'dart:html';

import 'package:events/globals.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EventCards extends StatefulWidget {
  EventCards(this.title, this.startDate, this.endDate, this.description);

  final String title;

  final String startDate;

  final String endDate;

  final String description;

  @override
  _EventCardsState createState() => _EventCardsState();
}

class _EventCardsState extends State<EventCards> {
  @override
  Widget build(BuildContext context) {
    print(startDate);
    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            widget.startDate,
            style:
                Theme.of(context).textTheme.headline2.copyWith(fontSize: 14.0),
          ),
          Container(
            height: 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
            child: VerticalDivider(
              width: 6,
              color: Theme.of(context).accentColor,
              thickness: 4,
            ),
          ),
          Text(
            widget.endDate,
            style:
                Theme.of(context).textTheme.headline2.copyWith(fontSize: 14.0),
          ),
        ],
      ),
      title: AnimatedDefaultTextStyle(
        duration: duration,
        style: calendarController.calendarFormat == CalendarFormat.twoWeeks
            ? Theme.of(context)
                .textTheme
                .headline4
                .copyWith(fontSize: 20.0 - selectedDayEvents.length)
            : Theme.of(context).textTheme.headline4,
        curve: Curves.ease,
        child: Text(
          widget.title,
        ),
        overflow: TextOverflow.fade,
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
    );
  }
}
