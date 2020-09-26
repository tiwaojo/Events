import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:events/globals.dart';
import 'package:flutter/gestures.dart';
import 'package:intl/intl.dart';

import 'custom_widgets.dart';

class MyBody extends StatefulWidget {
  @override
  _MyBodyState createState() => _MyBodyState();
}

class _MyBodyState extends State<MyBody> with TickerProviderStateMixin {
  @override
  void initState() {
    selected = false;
    initPrefs();
    opacityController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();
    rotateController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500))
      ..forward();
    rotateAnimation = Tween(begin: 0.5, end: 1.0).animate(CurvedAnimation(
        parent: rotateController,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut));
    bodyController = AnimationController(
        vsync: this,
        duration: duration,
        animationBehavior: AnimationBehavior.normal)
      ..forward();
    scaleController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    scaleAnimation = Tween<double>(begin: 1, end: 0.65).animate(
        CurvedAnimation(parent: scaleController, curve: Curves.easeInOut));
    calendarController = CalendarController();
    orderedSelectedDay();
    super.initState();
  }

  @override
  void dispose() {
    calendarController.dispose();
    opacityController.dispose();
    rotateController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  initPrefs() async {
    eventPrefs = await SharedPreferences.getInstance();
    setState(() {
      dayEvents = Map<DateTime, List<dynamic>>.from(
          decodeMap(json.decode(eventPrefs.getString("events") ?? "{}")));
    });
  }

  @override
  Widget build(BuildContext context) {
    AnimatedSwitcher eventDisplaySwitcher = AnimatedSwitcher(
        duration: duration,
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        child: selectedDayEvents.isEmpty
            ? DisplayNoEventsWidget()
            : displayRangedEvents(context));
    tableCalendar = TableCalendar(
      rowHeight: 40,
      calendarController: calendarController,
      initialCalendarFormat: CalendarFormat.month,
      events: dayEvents,
      availableGestures: AvailableGestures.horizontalSwipe,
      availableCalendarFormats: {CalendarFormat.month: 'Month'},
      formatAnimation: FormatAnimation.slide,
      initialSelectedDay: currentDate,
      headerVisible: false,
      onHeaderTapped: (focusedDay) {

      },
      calendarStyle: CalendarStyle(
        weekdayStyle: Theme
            .of(context)
            .textTheme
            .subtitle2
            .copyWith(color: Theme
            .of(context)
            .accentColor),
        weekendStyle: Theme
            .of(context)
            .textTheme
            .subtitle2,
        highlightSelected: true,
        canEventMarkersOverflow: true,
        markersPositionBottom: 1,
        renderDaysOfWeek: true,
        markersAlignment: Alignment.bottomCenter,
        markersColor: Colors.blue,
        markersMaxAmount: 1,
        markersPositionLeft: 18,
        outsideDaysVisible: false,
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
          dowTextBuilder: (date, locale) {
            return DateFormat.E(locale).format(date)[0];
          },
          weekdayStyle: Theme
              .of(context)
              .textTheme
              .subtitle1
              .copyWith(
              color: Color(0xFFD89BAA).withOpacity(0.8), fontSize: 14),
          weekendStyle: Theme
              .of(context)
              .textTheme
              .subtitle1
              .copyWith(color: Theme
              .of(context)
              .focusColor
              .withOpacity(0.7), fontSize: 14)
      ),
      onDaySelected: (day, events) {
        selectedDayEvents = events;
        setState(() {
          //order the list of events on selectedDay
          orderedSelectedDay();
        });
      },
      builders: CalendarBuilders(
        todayDayBuilder: (context, date, events) {
          return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme
                  .of(context)
                  .backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Theme
                      .of(context)
                      .backgroundColor,
                  blurRadius: 10.0,
                  spreadRadius: 5.0,
                  offset: Offset(
                    0,
                    0,
                  ),
                ),
              ],
            ),
            child: Text(
              date.day.toString(),
              softWrap: true,
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyText1,
            ),
          );
        },
        selectedDayBuilder: (context, date, events) {
          return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff182231),
            ),
            child: Text(
              date.day.toString(),
              textScaleFactor: 1.5,
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyText2,
              overflow: TextOverflow.fade,
            ),
          );
        },
      ),
    );
    return
      Container(
        height: MediaQuery
            .of(context)
            .size
            .height -
            (MediaQuery
                .of(context)
                .size
                .height * 0.13125),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black,
              Theme
                  .of(context)
                  .primaryColor,
            ],
            begin: FractionalOffset.bottomCenter,
            end: FractionalOffset.topCenter,
            stops: <double>[
              selected ? 0.22 : 0.4,
              0.9,
            ],
          ),
          backgroundBlendMode: BlendMode.srcATop,
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            eventDisplaySwitcher,
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RotationTransition(
                  turns: rotateAnimation,
                  alignment: Alignment.center,
                  child: Bounce(
                    child: Center(child: moreEventsList(context)),
                    infinite: true,
                    duration: const Duration(seconds: 1),
                    delay: const Duration(seconds: 1),
                    animate: true,
                    from: 10,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Column(
                    children: [
                      GestureDetector(
                        onLongPress: () {
                          setState(() {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              initialDatePickerMode: DatePickerMode.year,
                              firstDate: DateTime.now().add(
                                  Duration(days: -365)),
                              lastDate: DateTime.now().add(
                                  Duration(days: 365 * 10)),
                              currentDate: calendarController.focusedDay,
                            )
                              ..then((value) {
                                setState(() {
                                  if (value != null) {
                                    calendarController.setSelectedDay(value);
                                    currentDate = value;
                                  }
                                });
                              }
                              );
                          });
                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.symmetric(horizontal: 10,),
                          child: Text(DateFormat.y()
                              .format(currentDate)
                              .toString(),
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline6
                                .copyWith(fontWeight: FontWeight.w300),),
                        ),
                      ),
                      GestureDetector(
                        onLongPress: () {
                          setState(() {
                            calendarController.setFocusedDay(DateTime.now());
                            currentDate = DateTime.now();
                          });
                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.symmetric(
                              horizontal: 25, vertical: 5),
                          child: Text(DateFormat.MMMM()
                              .format(currentDate)
                              .toString(),
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline4
                                .copyWith(fontWeight: FontWeight.w800),),
                        ),
                      ),
                      GestureDetector(
                          behavior: HitTestBehavior.deferToChild,
                          dragStartBehavior: DragStartBehavior.down,
                          onVerticalDragUpdate: (details) {
                            setState(() {
                              selected = !selected;
                              selected
                                  ? rotateController.reverse()
                                  : rotateController.forward();

                              selected
                                  ? calendarController.setCalendarFormat(
                                  CalendarFormat.week)
                                  : calendarController.setCalendarFormat(
                                  CalendarFormat.month);
                            });
                          },
                          child: tableCalendar),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        // ),
      );
  }

  Widget displayRangedEvents(context) {
    //sets the num of events and height the list of event will occupy before passing the values
    int _numEvents;
    double _eventListHeight = 0.3;

    if (selected == true) {
      _numEvents = selectedDayEvents.length;
      _eventListHeight = 0.55;
    }
    if (selected == false) {
      _numEvents = selectedDayEvents.length <= 3 ? selectedDayEvents.length : 3;
      _eventListHeight = 0.3;
    }

    return DisplayEventsWidget(
      numEvents: _numEvents, eventListHeight: _eventListHeight,);
  }

  Widget moreEventsList(context) {
    return IconButton(
      alignment: Alignment.centerLeft,
      icon: Icon(
        Icons.expand_more,
        size: 45,
        color: Theme
            .of(context)
            .focusColor
            .withOpacity(0.5),
      ),
      onPressed: () {
        setState(() {
          selected = !selected;
          selected ? rotateController.reverse() : rotateController.forward();

          selected
              ? calendarController.setCalendarFormat(CalendarFormat.week)
              : calendarController.setCalendarFormat(CalendarFormat.month);
        });
      },
    );
  }
}


