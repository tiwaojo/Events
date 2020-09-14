import 'package:events/globals.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EventCards extends StatefulWidget {
  const EventCards({
    Key key,
    this.title,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.description,
  }) : super(key: key);
  final String title, startDate, endDate, startTime, endTime, description;

  @override
  _EventCardsState createState() => _EventCardsState();
}

class _EventCardsState extends State<EventCards> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          vertical: 10,
        ),
        visualDensity: VisualDensity.compact,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.startTime,
              style: isEventNow(widget.startDate, widget.endDate)
                  ? Theme.of(context).textTheme.caption.copyWith(fontSize: 16.0)
                  : Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(fontSize: 14.0),
            ),
            Container(
              alignment: Alignment.center,
              // height: selected ? 20 : 16,
              width: 2.5, padding: EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).focusColor.withOpacity(0.2),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
            Text(widget.endTime,
                style: isEventNow(widget.startDate, widget.endDate)
                    ? Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(fontSize: 16.0)
                    : Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(fontSize: 14.0)),
          ],
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.title,
              style: selected
                  ? Theme.of(context).textTheme.subtitle1.copyWith(
                      fontSize: isEventNow(widget.startDate, widget.endDate)
                          ? 25
                          : 15)
                  : Theme.of(context).textTheme.subtitle1,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: true,
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.start,
            ),
          ],
        ),
        subtitle: Text(
          widget.description,
          style: calendarController.calendarFormat == CalendarFormat.week
              ? Theme.of(context).textTheme.subtitle2.copyWith(
                  fontSize:
                      isEventNow(widget.startDate, widget.endDate) ? 25 : 12)
              : Theme.of(context).textTheme.subtitle2,
          overflow: TextOverflow.fade,
        ),
        trailing: IconButton(
          icon: Icon(MdiIcons.delete),
          color: Theme.of(context).accentColor,
          onPressed: () {
            setState(() {
              scaffoldKey.currentState.showSnackBar(
                SnackBar(
                  content: Text('Event Deletion is yet to be implemented'),
                  duration: Duration(seconds: 5),
                ),
              );
            });
          },
        ),
      ),
    );
  }
}
