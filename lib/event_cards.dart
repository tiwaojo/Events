import 'package:events/globals.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EventCards extends StatelessWidget {
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
  Widget build(BuildContext context) {
    bool _isEventNow = isEventNow(startDate, endDate);
    return ListTile(
      visualDensity: VisualDensity.comfortable,
      leading: Column(
        children: [
          Text(
            startTime,
            style: _isEventNow
                ? Theme.of(context).textTheme.caption.copyWith(fontSize: 16.0)
                : Theme.of(context).textTheme.caption.copyWith(fontSize: 14.0),
          ),
          Container(
            alignment: Alignment.center,
            height: _isEventNow ? 14 : 16,
            width: 2.5,
            padding: EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).focusColor.withOpacity(0.2),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
          Text(endTime,
              style: _isEventNow
                  ? Theme.of(context).textTheme.caption.copyWith(fontSize: 16.0)
                  : Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(fontSize: 14.0)),
        ],
      ),
      title: Text(
        title,
        style: selected
            ? Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(fontSize: _isEventNow ? 25 : 15)
            : Theme.of(context).textTheme.subtitle1,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        softWrap: true,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.start,
      ),
      subtitle: Text(
        description,
        style: calendarController.calendarFormat == CalendarFormat.week
            ? Theme.of(context)
                .textTheme
                .subtitle2
                .copyWith(fontSize: _isEventNow ? 25 : 12)
            : Theme.of(context).textTheme.subtitle2,
        overflow: TextOverflow.fade,
      ),
      trailing: IconButton(
        icon: Icon(MdiIcons.delete),
        color: Theme.of(context).accentColor,
        onPressed: () {
          // setState(() {
          scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text('Event Deletion is yet to be implemented'),
              duration: Duration(seconds: 5),
            ),
          );
          // });
        },
      ),
    );
  }
}
