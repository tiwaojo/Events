import 'package:animate_do/animate_do.dart';
import 'package:events/globals.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

import 'custom_widgets.dart';

class MyBody extends StatefulWidget {
//  MyBody({Key key}):super(key:key);

  @override
  _MyBodyState createState() => _MyBodyState();
//  GlobalKey eventDisplayWidgetKey= new GlobalKey();
}

//CalendarCarousel _calendarCarousel;

//class CurrentEvent {
//  CurrentEvent({this.isExpanded: false, this.header, this.body});
//
//  bool isExpanded;
//  String header;
//  String body;
//}

class _MyBodyState extends State<MyBody> with TickerProviderStateMixin {
//  printEvents() {}

  @override
  void initState() {
    // TODO: implement initState

    animationController1 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    slideAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    slideAnimation =
        Tween<Offset>(begin: Offset(0.0, 0.7), end: Offset(0.0, 0.0))
            .animate(slideAnimationController);
    animation = CurvedAnimation(
        parent: animationController1,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut);
//  posAnimation =CurvedAnimation(parent: animationController2, curve: Curves.easeOut);
//    animation = Tween(begin: 0.0, end: 1.0).animate(animationController1);
    animationController1.forward();
    slideAnimationController.forward();

//  animationController1.reverse();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    slideAnimationController.dispose();
    animationController1.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _color = Colors.black;
//    Widget _myDayEvents = displayEvents(context);
    tableCalendar = TableCalendar(
      calendarController: calendarController,
      initialCalendarFormat: CalendarFormat.month,
      events: dayEvents,
      availableGestures: AvailableGestures.horizontalSwipe,
      availableCalendarFormats: {CalendarFormat.month: 'Month'},
      formatAnimation: FormatAnimation.slide,
      initialSelectedDay: currentDate,
      headerVisible: true,
      calendarStyle: CalendarStyle(
        weekdayStyle: TextStyle(
            fontFamily: "Phenomena", fontSize: 16, color: Colors.pink),
        weekendStyle: TextStyle(
            fontFamily: "Phenomena", fontSize: 16, color: Color(0xFFC8C8C8)),
        highlightSelected: true,
        canEventMarkersOverflow: true,
        markersPositionBottom: 1,
        renderDaysOfWeek: true,
        markersAlignment: Alignment.bottomCenter,
        markersColor: Colors.blue,
        markersMaxAmount: 1,
        markersPositionLeft: 22,
//        contentPadding: EdgeInsets.only(top: 10),
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
//        formatButtonShowsNext: true,
        formatButtonVisible: false,
        titleTextStyle: Theme.of(context).textTheme.headline4,
//            TextStyle(
//                fontFamily: "Phenomena",
//                fontSize: 30,
//                color: Colors.pink),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
          dowTextBuilder: (date, locale) {
            return DateFormat.E(locale).format(date)[0];
          },
          weekdayStyle: TextStyle(
              color: Color(0xFFD89BAA), //D06BA4
              fontFamily: "Phenomena",
              fontSize: 18),
          weekendStyle: TextStyle(
            color: Color.fromRGBO(200, 200, 200, 90),
            fontSize: 18,
            fontFamily: "Phenomena",
          )
//              weekdayStyle:WeekdayFormat.short,
      ),
      onDaySelected: (day, events) {
        setState(() {
          selectedDayEvents = events;
        });
      },
      builders: CalendarBuilders(
        todayDayBuilder: (context, date, events) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
//                    height: 32,
//                    width: 32,
//                        padding: EdgeInsets.all(6),
                margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
//                                borderRadius: BorderRadius.circular(30),
                  shape: BoxShape.circle,
                  color: Theme
                      .of(context)
                      .backgroundColor,
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
                child: Text(
                  date.day.toString(),
                  softWrap: true,
                  style: TextStyle(
                      fontFamily: "Phenomena",
                      fontSize: 18,
                      color: Colors.pink),
                ),
              ),
            ],
          );
        },
        selectedDayBuilder: (context, date, events) {
          return Container(
//            duration: Duration(seconds: 5),
//            curve: Curves.bounceInOut,
            alignment: Alignment.center,
            margin: EdgeInsets.all(12),
            decoration: BoxDecoration(
//                                borderRadius: BorderRadius.circular(30),
              shape: BoxShape.circle,
              color: Color(0xff182231),

              boxShadow: [
                BoxShadow(
                  color: _color,
                  blurRadius: 2.0,
                  spreadRadius: 3.0,
                  offset: Offset(
                    0,
                    3,
                  ),
                ),
              ],
            ),
            child: Text(
              date.day.toString(),
              textScaleFactor: 2,
              style: TextStyle(
                fontFamily: "Phenomena",
              ),
              overflow: TextOverflow.fade,
            ),
          );
        },
      ),
    );

    AnimatedSwitcher eventDisplaySwitcher = AnimatedSwitcher(
        duration: Duration(seconds: 2),
        transitionBuilder: (Widget child, Animation<double> animation) {
          final offsetAnimation =
          Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
              .animate(animation);
          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        layoutBuilder: (currentChild, previousChildren) {
          return currentChild;
        },
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        child: (selectedDayEvents.isEmpty)
            ? displayEvents(context)
            : displayRangedEvents(context));
    return AnimatedContainer(
      duration: Duration(seconds: 2), curve: Curves.easeInOut,
//      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(resized ? 0 : 16),
        gradient: LinearGradient(
          colors: [
            Colors.black,
            Theme
                .of(context)
                .primaryColor,
          ],
          begin: FractionalOffset.bottomCenter,
          end: FractionalOffset.topCenter,
          stops: <double>[selected ? 0.1 : 0.15, 0.9,],
        ),
      ),
      child: Column(
//        shrinkWrap: false,
        mainAxisSize: MainAxisSize.max,
//        verticalDirection: VerticalDirection.down,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Appbar(context),
          ListView(shrinkWrap: true, children: [eventDisplaySwitcher]),
//          SizedBox(
//            height: 20,
//          ),
          AnimatedCrossFade(
//          turns: selected?animation:null,
            firstChild: Bounce(
              child: IconButton(
                alignment: Alignment.center,
                icon: Icon(
                  Icons.expand_more,
                  size: 48,
                  color: Colors.amber,
                ),
                onPressed: () {
                  selected = !selected;

                  setState(() {
//                  animationController2.reverse();
//                  animationController1.reverse();
                    calendarController.setCalendarFormat(CalendarFormat.week);
                  });
                },
              ),
              infinite: true,
              duration: Duration(seconds: 1),
              delay: Duration(seconds: 1),
              animate: true,
              from: 10,
            ),
            duration: Duration(seconds: 2),
            crossFadeState:
            selected ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            alignment: Alignment.center,
            firstCurve: Curves.bounceIn,
            reverseDuration: Duration(seconds: 1),
            secondCurve: Curves.bounceOut,
            sizeCurve: Curves.easeIn,
            secondChild: Bounce(
              child: IconButton(
                alignment: Alignment.center,
                icon: Icon(
                  Icons.expand_less,
                  size: 48,
                  color: Colors.amber,
                ),
                onPressed: () {
                  selected = !selected;
//TODO Align calendar to the bottom of page, rotate the button
                  setState(() {
//                  animationController2.reverse();
//                  animationController1.reverse();
                    if (selected) {
                      calendarController
                          .setCalendarFormat(CalendarFormat.twoWeeks);
                    } else {
                      calendarController.setCalendarFormat(
                          CalendarFormat.month);
                    }
                  });
                },
              ),
              infinite: true,
              duration: Duration(seconds: 2),
              delay: Duration(seconds: 1),
              animate: true,
              from: 10,
            ),
          ),


          Stack(alignment: Alignment.bottomCenter,
            overflow: Overflow.clip,
//              alignment: Alignment( MediaQuery.of(context).size.width * 0.5,  MediaQuery.of(context).size.height,),
            children: [
              SlideTransition(
                position: slideAnimation,
                child: FadeTransition(
                    opacity: animationController1,
                    child: Column(mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        tableCalendar,
                      ],
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget displayEvents(context) {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height * 0.26,
      child: Center(
          child: Text(
            "No Events on ",
            style: TextStyle(
              fontFamily: "Phenomena",
              fontSize: 50,
              color: Color(0xFFC8C8C8).withOpacity(0.5),
            ),
          )),
    );
  }

  Widget displayRangedEvents(context) {
//    var count = 0;
    int numDayEvents = selected ? selectedDayEvents.length : 3;
    return Container(
      foregroundDecoration: BoxDecoration(

        gradient: LinearGradient(
          colors: [

            Colors.black.withOpacity(0.9),
            Theme
                .of(context)
                .primaryColor
                .withOpacity(0.01),
          ],
          begin: FractionalOffset.bottomCenter,
          end: FractionalOffset.topCenter,
          stops: <double>[selected ? 0.1 : 0.0, selected ? 0.4 : 0.0,],
        ),
      ),
      height: selected ? MediaQuery
          .of(context)
          .size
          .height * 0.5 : MediaQuery
          .of(context)
          .size
          .height * 0.26,
      child: ListView(shrinkWrap: true,
//      verticalDirection: VerticalDirection.down,mainAxisSize: ,
        children: <Widget>[
          ...selectedDayEvents.getRange(0,
              selectedDayEvents.length >= numDayEvents
                  ? numDayEvents
                  : selectedDayEvents.length).map(
                (event) {
              NewEvent user = NewEvent.fromJson(event);
//          print(user.toJson());
              return FadeIn(
                animate: true,
//                delay: Duration(milliseconds: 1500),
                duration: Duration(seconds: 2),
                child: Card(
                  elevation: 5,
                  shadowColor: Colors.black,
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  color: Theme
                      .of(context)
                      .primaryColor,
                  child: ListTile(
                    title: AnimatedDefaultTextStyle(
                      duration: Duration(seconds: 2),
                      style: calendarController.calendarFormat ==
                          CalendarFormat.twoWeeks
                          ? Theme
                          .of(context)
                          .textTheme
                          .headline4
                          .copyWith(
                          fontSize: 60.0 - selectedDayEvents.length)
                          : Theme
                          .of(context)
                          .textTheme
                          .headline4,
                      curve: Curves.ease,
                      child: Text(
                        user.title,
                        overflow: TextOverflow.ellipsis,
                      ),
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
//          }),
//        ),
        ],
      ),
    );

//      return LimitedBox(maxHeight: 200,maxWidth: MediaQuery.of(context).size.width,
//        child: Hero(tag: "events",
//          child: ListView.builder(itemCount: selectedDayEvents.length>=3?3:selectedDayEvents.length,itemBuilder: (context, index) {
//
//
//              var user = NewEvent.fromJson(selectedDayEvents[index]);
//
//  print(user.toJson());
//  print(user.title);
////  selectedDayEvents.forEach((element) {print(element);});
//
//            return FadeIn(
//              animate: true,
//          delay: Duration(milliseconds: 1500),
//          duration: Duration(seconds: 2),
//              child: Card(elevation:2 ,color: Colors.blueGrey,shadowColor: Colors.green,
//                child: ExpansionTile(
//
//                  title: Text(user.title),
//                  subtitle: Text(user.startDate),
//                ),
//              ),
//            );
//          },),
//        ),
//      );
//setState(() {
//  selectedDayEvents.forEach((element) {
//    var user = NewEvent.fromJson(element);
//    print(user.toJson());});
//  selectedDayEvents.map((events) {
////          print(selectedDayEvents);
////          var user = NewEvent.fromJson(events);
////          print(user.title);
////          print(user.startDate);
////          print(user.endDate);
////          print(user.description);
//
//    var user = NewEvent.fromJson(events);
////            var user=  json.decode(jsonDecode(selectedDayEvents[0]));
////    print(user.toJson());
////    print(user.title);
//    setState(() {
//      return FadeIn(
//        animate: true,
//        delay: Duration(milliseconds: 1500),
//        duration: Duration(seconds: 2),
//        child: Hero(tag: "events",
//          child: Card(
//            elevation: 8,
//            child: ListTile(
//              title: Text(user.title),
//              trailing: IconButton(
//                icon: Icon(MdiIcons.delete),
//                color: Colors.pinkAccent,
//                onPressed: () {
//                  setState(() {
//                    dayEvents.remove(0);
//                    selectedDayEvents.removeLast();
//                    print(selectedDayEvents);
//                    print(dayEvents);
//                  });
//                },
//              ),
//            ),
//          ),
//        ),
//      );
////    });
//
//  });
//});
  }
}

//        Card(
//          margin: EdgeInsets.all(20),
//          elevation: 10,
//          borderOnForeground: false,
//          shadowColor: Colors.blue,
//          semanticContainer: false,
//          shape: RoundedRectangleBorder(
//            borderRadius: BorderRadius.circular(15),
//          ),
//          child: Theme(
//            data: Theme.of(context).copyWith(
//              cardColor: Color.fromRGBO(24, 34, 49, 100),
//              dividerColor: Colors.transparent,
//              dividerTheme: DividerThemeData(thickness: 23, space: 20),
//
//              cardTheme: CardTheme(
////                    margin: EdgeInsets.all(6),
//                elevation: 3,
//                shadowColor: Colors.amber,
////                    shape: RoundedRectangleBorder(
////                        borderRadius: BorderRadius.circular(15)),
//              ),
//
////              textTheme: ,
//            ),
//            isMaterialAppTheme: true,
//            child: ExpansionPanelList(
//              animationDuration: Duration(seconds: 1),
//              expansionCallback: (int index, bool isExpanded) {
//                setState(
//                  () {
//                    _currentDayEvent[index].isExpanded =
//                        !_currentDayEvent[index].isExpanded;
//                  },
//                );
//              },
//              children: _currentDayEvent.map<ExpansionPanel>(
//                (CurrentEvent currentEvent) {
//                  return ExpansionPanel(
//                    headerBuilder: (BuildContext context, bool isExpanded) {
//                      return ClipRRect(
//                        borderRadius: BorderRadius.circular(20),
////                          ClipRRect(
////                            borderRadius: BorderRadius.circular(20),
//                        child: Text("data"),
////                          ListTile(isThreeLine: false,
////                            contentPadding: EdgeInsets.all(3.0),
////                            leading: Container(
////                              padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
//////                                decoration: BoxDecoration(
//////                                    border: Border(
//////                                        left: BorderSide(
//////                                            width: 3.0, color: Colors.white54))),
////                              child: Icon(
////                                Icons.account_circle,
////                                size: 30.0,
////                                color: Colors.black,
////                              ),
////                            ),
////                            title: ListTile(
////                              contentPadding: EdgeInsets.all(0.0),
////                              title: Text(
////                                currentEvent.header,
////                                style: TextStyle(
////                                  color: Colors.black,
////                                  fontSize: 14.0,
////                                ),
////                              ),
////                            ),
////                          ),
//                      );
////                          return Container(
//////                            color:Colors.blue,
////                            alignment: Alignment.center,
////                            //decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.blue),
////                            child: Text(
////                              currentEvent.header,
////                              style: textStyle1,
////                            ),
////                          );
//                    },
//                    isExpanded: currentEvent.isExpanded,
//                    canTapOnHeader: true,
//                    body: Container(
//                      color: Colors.blue,
//                      child: Text(
//                        currentEvent.body,
//                        style: Theme.of(context).textTheme.headline2,
//                        textAlign: TextAlign.left,
//                      ),
//                    ),
//                  );
//                },
//              ).toList(),
//              expandedHeaderPadding: EdgeInsets.all(0.0),
//            ),
//          ),
//        ),
//              Container(
//                child: Center(
//                  child: AnimatedIcon(
//                    icon: AnimatedIcons.add_event,
//                    progress: globals.animationController1,
//                    color: Colors.pinkAccent,
//                  ),
//                ),
//              ),
//        Container(
//          margin: EdgeInsets.symmetric(horizontal: 50.0),
//          child: Column(
//            children: <Widget>[
//              Container(
//                alignment: Alignment.bottomCenter,
//
////                  height: 100,
////                  color: Colors.black,
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
////                      mainAxisSize: MainAxisSize.max,
//                  children: <Widget>[
//                    Hero(tag:"currentMonth",transitionOnUserGestures: true,
//                      child: GestureDetector(onTap: () {
//                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Menu()));
//                      },
//                        child: Padding(
//                          padding: const EdgeInsets.only(left:10.0),
//                          child: Text(
//                            globals.currentMonth,
//                            style: TextStyle(
//                                fontFamily: "Phenomena",
//                                fontWeight: FontWeight.bold,
//                                fontSize: 24.0,
//                                color: CSSColors.deepPink),
//                          ),
//                        ),
//                      ),
//                    ),
//                    Row(
//                      children: <Widget>[
//                        IconButton(
//                          icon: Icon(Icons.chevron_left, size: 20),
//                          tooltip: globals.prevMonth,
//                          color: Colors.pink,
//                          iconSize: 15,
//                          onPressed: () {
//                            setState(() {
//                              globals.targetDateTime = DateTime(
//                                  globals.targetDateTime.year,
//                                  globals.targetDateTime.month - 1);
//                              globals.currentMonth =
//                                  DateFormat.yMMM().format(globals.targetDateTime);
//                              print(globals.currentMonth =
//                                  DateFormat.MMMM().format(globals.targetDateTime));
//                            });
//                          },
//                        ),
//                        IconButton(
//                          icon: Icon(
//                            Icons.chevron_right,
//                            size: 20,
//                          ),
//                          tooltip: globals.nextMonth,
//                          color: Colors.pink,
//                          iconSize: 15,
//                          onPressed: () {
//                            setState(() {
//                              globals.targetDateTime = DateTime(
//                                  globals.targetDateTime.year,
//                                  globals.targetDateTime.month + 1);
//                              globals.currentMonth =
//                                  DateFormat.yMMM().format(globals.targetDateTime);
//                              print(globals.currentMonth =
//                                  DateFormat.MMMM().format(globals.targetDateTime));
//                            });
//                          },
//                        ),
//                      ],
//                    )
//                  ],
//                ),
//              ),
//              //Calendar
//              Container(
////                    margin: EdgeInsets.fromLTRB(40.0, 2.0, 40.0, 10.0),
////                    padding: EdgeInsets.symmetric(horizontal: 5.0),
//                child: _calendarCarousel,
//              ),
//            ],
//          ),
//        ),
//icons for the previous and next button

//            Container(
////              alignment: Alignment.center,margin: EdgeInsets.symmetric(horizontal: 80),
////            child:FractionallySizedBox(alignment: Alignment.center,
////              widthFactor: 0.9,
//            height: 44,constraints: BoxConstraints.expand(height:80.0),
//
//              child: _newEvent,
////            ),
//            ),//    _calendarCarousel = CalendarCarousel<Event>(
////      todayBorderColor: null,
//      onDayPressed: (DateTime date, List<Event> events) {
//        this.setState(() => globals.selectedDate = date);
//        events.forEach((event) {
//          print(event.title);
////          event.dot;
//        });
//      },
//      markedDateMoreCustomDecoration: BoxDecoration(
//        borderRadius: BorderRadius.only(
//          topLeft: Radius.circular(75.0),
//          topRight: Radius.circular(
//            75.0,
//          ),
//        ),
//        color: Colors.blue[100],
//        boxShadow: [
//          BoxShadow(
//            color: Colors.red.withOpacity(0.5),
//            blurRadius: 10.0,
//            spreadRadius: 1.0,
//            offset: Offset(
//              0,
//              0,
//            ),
//          ),
//        ],
//      ),
//      pageSnapping: true,
////      scrollDirection: Axis.vertical,
//      daysHaveCircularBorder: null,
////      calendarStyle: CalendarStyle(),
////      scrollDirection: Axis.horizontal,
//      isScrollable: true,
//      showOnlyCurrentMonthDate: true,
//      height: 300,
////      width: MediaQuery.of(context).size.width,
//      weekendTextStyle: TextStyle(
//        color: CSSColors.grey,
//        fontFamily: "Phenomena",
//      ),
//      thisMonthDayBorderColor: Colors.transparent,
//
//      weekFormat: false,
//      weekdayTextStyle: TextStyle(
//        fontFamily: "Phenomena",
//        fontSize: 16,
//      ),
//
//      weekDayFormat: WeekdayFormat.standaloneNarrow,
//
//      selectedDateTime: globals.selectedDate,
//      targetDateTime: globals.targetDateTime,
//      daysTextStyle: TextStyle(
//        color: Colors.pinkAccent,
//        fontFamily: "Phenomena",
//        fontSize: 14,
//      ),
//      customGridViewPhysics: NeverScrollableScrollPhysics(),
//      showHeader: false,
//      todayTextStyle: TextStyle(
//        color: Colors.yellow,
//        fontSize: 16,
//        fontFamily: "Phenomena",
//        fontStyle: FontStyle.normal,
//      ),
//      todayButtonColor: Colors.pink,
//
//      markedDateShowIcon: true,
//      markedDateIconMaxShown: 1,
//      markedDateWidget: _eventIcon,
//      markedDateIconBuilder: (event) {
//        return event.icon;
//      },
//      markedDatesMap: _markedDateMap,
////      markedDateCustomTextStyle: TextStyle(
////        fontSize: 16,
////        color: Colors.deepOrange,
////      ),
////      markedDateCustomShapeBorder:
////    CircleBorder(side: BorderSide(color: Colors.yellow),
////
////    ),
//      markedDateMoreShowTotal: null,
//      // null for not showing hidden events indicator
//      markedDateIconMargin: 16,
////      markedDateIconOffset:  -10,
//
//      selectedDayTextStyle: TextStyle(
//        color: Colors.yellow,
//        fontSize: 18,
//        fontFamily: "Phenomena",
//      ),
//      //      Container(
////          margin: EdgeInsets.all(5),
////          alignment: Alignment.center,
////          decoration: BoxDecoration(
////              color: Color.fromRGBO(24, 34, 49, 100),
////              borderRadius: BorderRadius.circular(20.0),
////              boxShadow: [
////                  BoxShadow(
////                    color: Color.fromRGBO(0, 0, 0, 100),
////                    blurRadius: 20.0,
////                    spreadRadius: 5.0,
////                    offset: Offset(
////                      0,
////                      2,
////                    ),
////                  )
////              ])),
////       markedDateIconBuilder: (event) {
////         return event.icon;
////       },
//      // markedDateMoreShowTotal:
//      //     true,
//
//      selectedDayButtonColor: Colors.grey,
//      minSelectedDate: globals.currentDate.subtract(Duration(days: 360)),
//      maxSelectedDate: globals.currentDate.add(Duration(days: 360)),
//      onCalendarChanged: (DateTime date) {
//        this.setState(() {
//          globals.targetDateTime = date;
//          globals.currentMonth =
//              DateFormat.MMMM().format(globals.targetDateTime);
//        });
//      },
//      onDayLongPressed: (DateTime date) {
//        print('long pressed date $date');
//        //Long press to add an event
//      },
////      calendarController: null,
//    );//  List<CurrentEvent> _currentDayEvent = <CurrentEvent>[
//    CurrentEvent(header: "_markedDateMap.events.toString()", body: "df"),
//    CurrentEvent(header: "_markedDateMap.events.toString()2", body: "df"),
//    CurrentEvent(header: "_markedDateMap.events.toString()3", body: "df"),
//  ];
//
////  static List<String> monthNames = const <String>[
////    'Jan',
////    'Feb',
////    'Mar',
////    'Apr',
////    'May',
////    'Jun',
////    'Jul',
////    'Aug',
////    'Sep',
////    'Oct',
////    'Nov',
////    'Dec',
////  ];
//  EventList<Event> _markedDateMap = new EventList<Event>(
//    events: {},
//  );
//    /// Add more events to _markedDateMap EventList
//    _markedDateMap.add(
//        new DateTime(2020, 5, 25),
//        new Event(
//          date: new DateTime(2020, 5, 25, 9, 30),
//          title: DateTime(2020, 5, 25, 9, 30).toString(),
//          icon: _eventIcon,
//        ));
//    _markedDateMap.addAll(new DateTime(2020, 5, 26), [
//      new Event(
//        date: new DateTime(2020, 5, 26),
//        title: 'Event 6',
//        icon: _eventIcon,
//      ),
//      new Event(
//        date: new DateTime(2020, 5, 26),
//        title: 'Event 6',
//        icon: _eventIcon,
//      ),
//      new Event(
//        date: new DateTime(2020, 5, 26),
//        title: 'Event 6',
//        icon: _eventIcon,
//      ),
//    ]);
//
//    _markedDateMap.add(
//        new DateTime(2020, 5, 17),
//        new Event(
//          date: new DateTime(2020, 5, 17),
//          title: 'Event 4',
//          icon: _eventIcon,
//        ));
//
//    _markedDateMap.addAll(
//      new DateTime(2020, 5, 11),
//      [
//        new Event(
//          date: new DateTime(2020, 5, 11),
//          title: 'Event 1',
//          icon: _eventIcon,
//        ),
//        new Event(
//          date: new DateTime(2020, 5, 11),
//          title: 'Event 2',
//          icon: _eventIcon,
//        ),
//        new Event(
//          date: new DateTime(2020, 5, 11),
//          title: 'Event 3',
//          icon: _eventIcon,
//        ),
//        //get the day and set its icons to null
//      ],
//    );
//
//    _markedDateMap.addAll(
//      new DateTime(2020, 5, 10),
//      [
//        new Event(
//          date: new DateTime(2020, 5, 10),
//          title: '2020, 510',
//          icon: _eventIcon,
////          dot: Container(
////            margin: EdgeInsets.symmetric(horizontal: 1.0),
////            color: Colors.red,
////            height: 5.0,
////            width: 5.0,
////          ),
//        ),
//        new Event(
//          date: new DateTime(2020, 5, 10),
//          title: '2020, 5 10',
//          icon: _eventIcon,
//        ),
//        new Event(
//          date: new DateTime(2020, 5, 10),
//          title: '2020, 50',
//          icon: _eventIcon,
//        ),
//      ],
//    );
//    globals.opacity=0;static Widget _eventIcon = new Container(
////    height: 10,width: 10,
////    child:Center(
////    decoration: new BoxDecoration(
////        color: Colors.amberAccent,
////        borderRadius: BorderRadius.all(Radius.circular(1000)),
////        border: Border.all(color: Colors.blue, width: 0.05)),
//    child: Padding(
//      padding: const EdgeInsets.all(6.0),
//      child: new Icon(
//        Icons.trip_origin,
//        size: 10,
//        color: Colors.amber,
//      ),
//    ),
//  );
// if(globals.dayEvents.length<=1) { Container(child: Center(child: Text("No Events on",style: TextStyle(fontFamily: "Phenomena",fontSize: 50,color: Color(0xFFC8C8C8).withOpacity(0.5),),)),);}
//    (() {
//     if(globals.dayEvents.length>=1) {printEvents();}else {}
//    }()),
