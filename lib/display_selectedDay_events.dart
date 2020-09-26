import 'package:animate_do/animate_do.dart';
import 'package:events/custom_widgets.dart';
import 'package:events/globals.dart';
import 'package:flutter/gestures.dart';
import 'package:intl/intl.dart';

class DisplayEventsWidget extends StatelessWidget {
  const DisplayEventsWidget({Key key, this.numEvents, this.eventListHeight})
      : super(key: key);
  final int numEvents;
  final double eventListHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * eventListHeight,
      //: MediaQuery.of(context).size.height * 0.3,
      child: ListView.builder(
        itemExtent: 70.0,
        itemCount: numEvents,
        //auto keep alive is false to prevent children from keeping their state
        addAutomaticKeepAlives: false,
        padding: EdgeInsets.all(5),
        dragStartBehavior: DragStartBehavior.start,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        cacheExtent: 3,
        controller: listScrollController,
        physics: BouncingScrollPhysics(),
        itemBuilder: (
          context,
          index,
        ) {
          NewEvent event = NewEvent.fromJson(selectedDayEvents[index]);
          var date1 = DateFormat.jm().format(DateTime.parse(event.startDate));
          var date2 = DateFormat.jm().format(DateTime.parse(event.endDate));
          return DayEventWidgets(event: event, date1: date1, date2: date2);
        },
      ),
    );
  }
}

class DayEventWidgets extends StatelessWidget {
  const DayEventWidgets({
    Key key,
    @required this.event,
    @required this.date1,
    @required this.date2,
  }) : super(key: key);

  final NewEvent event;
  final String date1;
  final String date2;

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      animate: true,
      duration: Duration(milliseconds: 200),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        alignment: Alignment.center,
        decoration: isEventNow(event.startDate, event.endDate)
            ? BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                border:
                    Border.all(width: 2, color: Theme.of(context).accentColor),
              )
            : null,
        child: EventCards(
          title: event.title,
          startDate: event.startDate,
          endDate: event.endDate,
          startTime: date1,
          endTime: date2,
          description: event.description,
        ),
      ),
    );
  }
}
