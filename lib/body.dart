import 'dart:convert';
import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:events/globals.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'custom_widgets.dart';

class MyBody extends StatefulWidget {
  @override
  _MyBodyState createState() => _MyBodyState();
}

class _MyBodyState extends State<MyBody> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    initPrefs();
    opacityController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();
    slideAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();
    slideAnimation =
        Tween<Offset>(begin: Offset(0.0, 0.7), end: Offset(0.0, 0.0))
            .animate(slideAnimationController);
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
    calendarController = CalendarController();
//orderedSelectedDay();
//    mainAnimation=Tween(begin: 0.0,end: 16.0).animate(CurvedAnimation(parent: mainController, curve: Curves.linearToEaseOut))..addStatusListener((AnimationStatus status) {
//      if(status==AnimationStatus.completed){mainController.reverse();}
//    });
//    animation = Tween(begin: 0, end: 300).animate(controller)
//      ..addListener(() {
//        setState(() {});
//      })
//      ..addStatusListener((status) {
//        if (status == AnimationStatus.completed) {
//          controller.reverse();
//        } else if (status == AnimationStatus.dismissed) {
//          controller.forward();
//        }
//      });
//    animation = Tween(begin: 0, end: 1.0).animate(CurvedAnimation(parent: controller, curve: Interval(0.0, 0.5)));

//  animationController1.reverse();
  }

  @override
  void dispose() {
    super.dispose();
    calendarController.dispose();
    slideAnimationController.dispose();
    opacityController.dispose();
    rotateController.dispose();
    bodyController.dispose();
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
            ? displayEvents(context)
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
      headerVisible: true,
      onHeaderTapped: (focusedDay) {
        setState(() {
          calendarController.setFocusedDay(currentDate);
        });
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
        contentPadding: EdgeInsets.only(left: 30, right: 30, bottom: 5),
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonShowsNext: true,
        formatButtonVisible: false,
        titleTextStyle: Theme
            .of(context)
            .textTheme
            .headline4,

      ),
      daysOfWeekStyle: DaysOfWeekStyle(
          dowTextBuilder: (date, locale) {
            return DateFormat.E(locale).format(date)[0];
          },
          weekdayStyle: Theme
              .of(context)
              .textTheme
              .subtitle1
              .copyWith(color: Color(0xFFD89BAA), fontSize: 14),
          weekendStyle: Theme
              .of(context)
              .textTheme
              .subtitle1
              .copyWith(color: Theme
              .of(context)
              .primaryColorDark, fontSize: 14)
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
      AnimatedBuilder(
        animation: rotateAnimation,
        builder: (context, child) {
          return child;
        },
        child:
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
                      duration: Duration(seconds: 1),
                      delay: Duration(seconds: 1),
                      animate: true,
                      from: 10,
                    ),
                  ),
                  GestureDetector(
                      onVerticalDragStart: (details) {
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
                      dragStartBehavior: DragStartBehavior.start,
                      child:
                      tableCalendar
                  ),
                ],
              ),
            ],
          ),
        ),
      );
  }


  Widget displayEvents(context) {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.only(top: 40),
      child:
      // Image.asset("images/No Events Placeholder.png",),
      Text(
        "No Events",
        textAlign: TextAlign.center,
        style: Theme
            .of(context)
            .textTheme
            .headline2
            .copyWith(color: Color(0XFFC8C8C8).withOpacity(0.5),
        ),
      ),
    );
  }

  Widget displayRangedEvents(context) {
    int numDayEvents = selected ? selectedDayEvents.length : 3;
    return Container(
      height: selected
          ? MediaQuery
          .of(context)
          .size
          .height * 0.6
          : MediaQuery
          .of(context)
          .size
          .height * 0.3,
      child: ListView(
        physics: BouncingScrollPhysics(),
        dragStartBehavior: DragStartBehavior.start,
        primary: true,
        padding: EdgeInsets.zero,
        children: <Widget>[
          ...selectedDayEvents
              .getRange(
              0,
              selectedDayEvents.length >= numDayEvents
                  ? numDayEvents
                  : selectedDayEvents.length)
              .map(
                (_dayEvent) {
              NewEvent event = NewEvent.fromJson(_dayEvent);
              var date1 =
              DateFormat.jm().format(DateTime.parse(event.startDate));
              var date2 = DateFormat.jm().format(DateTime.parse(event.endDate));
              return FadeIn(
                animate: true,
                duration: Duration(milliseconds: 1000),
                child: Container(
                  decoration: isEventNow(event.startDate, event.endDate)
                      ? BoxDecoration(
                    color: Theme
                        .of(context)
                        .primaryColor,
                    borderRadius:
                    BorderRadius.all(Radius.circular(8),),
                    border: Border.all(width: 2, color: Theme
                        .of(context)
                        .accentColor),)
                      : null,
                  child: EventCards(
                    title: event.title,
                    startDate: event.startDate,
                    endDate: event.endDate,
                    startTime: date1,
                    endTime: date2,
                    description: event.description,
                  ),),
              );
            },
          ).toList(),
        ],
      ),
    );
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


