//import 'dart:html';

import 'package:events/globals.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EventCards extends StatefulWidget {
  const EventCards(
      {Key key, this.title, this.startDate, this.endDate, this.description})
      : super(key: key);
  final String title, startDate, endDate, description;

  @override
  _EventCardsState createState() => _EventCardsState();
}

class _EventCardsState extends State<EventCards> with TickerProviderStateMixin {
  @override
//  void initState() {
//    super.initState();
//    eListController=AnimationController(
//        //upperBound: 25,lowerBound: 10,
//        vsync: this, duration: const Duration(milliseconds: 500))
//      ..forward()..addStatusListener((AnimationStatus status) { if(status==AnimationStatus.completed){
//        eListController.reverse();
//      }});
//    eListAnimation= Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: eListController, curve: Curves.easeInOut));
//  }
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
            style: selected
                ? Theme
                .of(context)
                .textTheme
                .headline2
                .copyWith(fontSize: 14.0)
                : Theme
                .of(context)
                .textTheme
                .headline2
                .copyWith(fontSize: 14.0),
          ),
          Container(
//              duration: duration,
//              curve: Curves.easeInOut,
            height: selected ? 6 : 10,
            decoration: BoxDecoration(
//              borderRadius: BorderRadius.circular(60),
              borderRadius: BorderRadius.all(Radius.circular(20)),
//              shape: BoxShape.circle,
            ),
            child: VerticalDivider(
//              width: selected?6:10,
              color: Theme
                  .of(context)
                  .accentColor,
              thickness: 2.5,
            ),
          ),
          Text(
            widget.endDate,
            style:
            Theme
                .of(context)
                .textTheme
                .headline2
                .copyWith(fontSize: 14.0),
          ),
        ],
      ),
      title: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: calendarController.calendarFormat == CalendarFormat.week
                ? Theme
                .of(context)
                .textTheme
                .headline4
                .copyWith(fontSize: 25.0)
                : Theme
                .of(context)
                .textTheme
                .headline4,
            overflow: TextOverflow.fade,
            textAlign: TextAlign.start,
          ),
          Text(
            widget.description, //==null?"":widget.description,
            style: calendarController.calendarFormat == CalendarFormat.week
                ? Theme
                .of(context)
                .textTheme
                .headline3
                .copyWith(fontSize: 14.0)
                : Theme
                .of(context)
                .textTheme
                .headline3, overflow: TextOverflow.fade,),
        ],
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
