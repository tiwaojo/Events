import 'dart:convert';

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
    );
    slideAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    slideAnimation =
        Tween<Offset>(begin: Offset(0.0, 0.7), end: Offset(0.0, 0.0))
            .animate(slideAnimationController);
    animation = CurvedAnimation(
        parent: opacityController,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut);

    rotateController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    rotateAnimation = Tween(begin: 0.5, end: 1.0).animate(CurvedAnimation(
        parent: rotateController,
        curve: Curves.easeIn,
        reverseCurve: Curves
            .easeOut)); //..addStatusListener((AnimationStatus status) {selected?animationController.reverse():animationController.forward(); });
//  posAnimation =CurvedAnimation(parent: animationController2, curve: Curves.easeOut);
//    animation = Tween(begin: 0.0, end: 1.0).animate(animationController1);
    opacityController.forward();
    slideAnimationController.forward();
    rotateController.forward();
//  animationController1.reverse();
  }

  @override
  void dispose() {
    slideAnimationController.dispose();
    opacityController.dispose();
    rotateController.dispose();
    super.dispose();
  }

  void initPrefs() async {
    eventPrefs = await SharedPreferences.getInstance();
    setState(() {
      dayEvents = Map<DateTime, List<dynamic>>.from(
          decodeMap(json.decode(eventPrefs.getString("events") ?? "{}")));
    });
  }

  @override
  Widget build(BuildContext context) {
    var _color = Colors.black;
//    double _angle = pi;
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
              fontSize: 14),
          weekendStyle: TextStyle(
            color: Color.fromRGBO(200, 200, 200, 90),
            fontSize: 14,
            fontFamily: "Phenomena",
          )
//              weekdayStyle:WeekdayFormat.short,
      ),
      onDaySelected: (day, events) {
        setState(() {
          selectedDayEvents = events;
//        selectedDayEvents.isEmpty
//            ? displayEvents(context)
//            : displayRangedEvents(context);
////          eventDisplay
        });
      },
      builders: CalendarBuilders(
        todayDayBuilder: (context, date, events) {
          return Container(
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
                  fontFamily: "Phenomena", fontSize: 18, color: Colors.pink),
            ),
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
      duration: duration,
      curve: Curves.easeInOut,
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
//        shrinkWrap: false,
//        mainAxisSize: MainAxisSize.max,
//        verticalDirection: VerticalDirection.down,

        children: <Widget>[
//                Appbar(context),
          eventDisplaySwitcher,
//          SizedBox(
//            height: 30,
//          ),
//          AnimatedCrossFade(
////          turns: selected?animation:null,
//            firstChild: Bounce(
//              child: IconButton(
//                alignment: Alignment.center,
//                icon: Icon(
//                  Icons.expand_more,
//                  size: 48,
//                  color: Colors.amber,
//                ),
//                onPressed: () {
//                  selected = !selected;
//
//                  setState(() {
////                  animationController2.reverse();
////                  animationController1.reverse();
//                    calendarController.setCalendarFormat(CalendarFormat.week);
//                  });
//                },
//              ),
//              infinite: true,
//              duration: Duration(seconds: 1),
//              delay: Duration(seconds: 1),
//              animate: true,
//              from: 10,
//            ),
//            duration: Duration(seconds: 2),
//            crossFadeState:
//            selected ? CrossFadeState.showSecond : CrossFadeState.showFirst,
//            alignment: Alignment.center,
//            firstCurve: Curves.bounceIn,
//            reverseDuration: Duration(seconds: 1),
//            secondCurve: Curves.bounceOut,
//            sizeCurve: Curves.easeIn,
//            secondChild: Bounce(
//              child: IconButton(
//                alignment: Alignment.center,
//                icon: Icon(
//                  Icons.expand_less,
//                  size: 48,
//                  color: Colors.amber,
//                ),
//                onPressed: () {
//                  selected = !selected;

//                  setState(() {
////                  animationController2.reverse();
////                  animationController1.reverse();
//                    if (selected) {
//                      calendarController
//                          .setCalendarFormat(CalendarFormat.twoWeeks);
//                    } else {
//                      calendarController.setCalendarFormat(
//                          CalendarFormat.month);
//                    }
//                  });
//                },
//              ),
//              infinite: true,
//              duration: Duration(seconds: 2),
//              delay: Duration(seconds: 1),
//              animate: true,
//              from: 10,
//            ),
//          ),


          Column(mainAxisAlignment: MainAxisAlignment.end,
            children: [ RotationTransition(
              turns: rotateAnimation,
//            duration: Duration(seconds: 2),
//            transform: Matrix4.rotationX(selected ? pi : 0),
              alignment: Alignment.center,
//            curve: Curves.easeInOut,
//                          curve: Curves.easeInOutQuint,
              child: Bounce(
                child: IconButton(
                  alignment: Alignment.centerLeft,
                  icon: Icon(
                    Icons.expand_more,
                    size: 40,
                    color: Colors.amber,
                  ),
                  onPressed: () {
                    setState(() {
//                  animationController2.reverse();
//                  animationController1.reverse();
                      selected = !selected;
//animationController.reverse();
                      selected
                          ? rotateController.reverse()
                          : rotateController.forward();
                      selected
                          ? calendarController
                          .setCalendarFormat(CalendarFormat.week)
                          : calendarController
                          .setCalendarFormat(CalendarFormat.month);
//                      main();
                    });
                  },
                ),
                infinite: true,
                duration: Duration(seconds: 1),
                delay: Duration(seconds: 1),
                animate: true,
                from: 10,
              ),
            ),
              SlideTransition(
                position: slideAnimation,
                child: FadeTransition(
                    opacity: opacityController, child: tableCalendar),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget displayEvents(context) {
    return Container(alignment: Alignment.topCenter,
      child: Text(
        "No Events on ", textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: "Phenomena",
          fontSize: 50,
          color: Color(0xFFC8C8C8).withOpacity(0.5),
        ),
      ),
    );
  }

  Widget displayRangedEvents(context) {
    int numDayEvents = selected ? selectedDayEvents.length : 3;
    return Container(
      foregroundDecoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme
                .of(context)
                .primaryColor
                .withOpacity(0.01), // Colors.black.withOpacity(0.9),
            Theme
                .of(context)
                .primaryColor
                .withOpacity(0.2),
          ],
          begin: FractionalOffset.bottomCenter,
          end: FractionalOffset.topCenter,
          stops: <double>[
            selected ? 0.1 : 0.0,
            0.4,
          ],
        ),
      ),
//      height: selected ? MediaQuery.of(context).size.height * 0.5 : MediaQuery.of(context).size.height * 0.2,
      child: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        dragStartBehavior: DragStartBehavior.start,
        primary: true,
//      verticalDirection: VerticalDirection.down,mainAxisSize: ,
        children: <Widget>[
          ...selectedDayEvents.getRange(0,
              selectedDayEvents.length >= numDayEvents
                  ? numDayEvents
                  : selectedDayEvents.length).map(
                (event) {
              NewEvent user = NewEvent.fromJson(event);

              var date1 = DateFormat.jm().format(
                  DateTime.parse(user.startDate));
              var date2 = DateFormat.jm().format(DateTime.parse(user.endDate));

              return FadeIn(
                animate: true,
                /*                delay: Duration(milliseconds: 1500),*/
                duration: Duration(seconds: 2),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: EventCards(user.title, date1, date2, user.description),
                ),

              );
            },
          ).toList(), /*          }), ),*/
        ],
      ),
    ); /*      return LimitedBox(maxHeight: 200,maxWidth: MediaQuery.of(context).size.width, child: Hero(tag: "events", child: ListView.builder(itemCount: selectedDayEvents.length>=3?3:selectedDayEvents.length,itemBuilder: (context, index) { var user = NewEvent.fromJson(selectedDayEvents[index]); print(user.toJson()); print(user.title); //  selectedDayEvents.forEach((element) {print(element);}); return FadeIn( animate: true, delay: Duration(milliseconds: 1500), duration: Duration(seconds: 2), child: Card(elevation:2 ,color: Colors.blueGrey,shadowColor: Colors.green, child: ExpansionTile( title: Text(user.title), subtitle: Text(user.startDate), ), ), ); },), ), ); setState(() { selectedDayEvents.forEach((element) { var user = NewEvent.fromJson(element); print(user.toJson());}); selectedDayEvents.map((events) { //          print(selectedDayEvents); //          var user = NewEvent.fromJson(events); //          print(user.title); //          print(user.startDate); //          print(user.endDate); //          print(user.description); var user = NewEvent.fromJson(events); //            var user=  json.decode(jsonDecode(selectedDayEvents[0])); //    print(user.toJson()); //    print(user.title); setState(() { return FadeIn( animate: true, delay: Duration(milliseconds: 1500), duration: Duration(seconds: 2), child: Hero(tag: "events", child: Card( elevation: 8, child: ListTile( title: Text(user.title), trailing: IconButton( icon: Icon(MdiIcons.delete), color: Colors.pinkAccent, onPressed: () { setState(() { dayEvents.remove(0); selectedDayEvents.removeLast(); print(selectedDayEvents); print(dayEvents); }); }, ), ), ), ), ); //    }); }); });*/
  }
}
//        Card( margin: EdgeInsets.all(20), elevation: 10, borderOnForeground: false, shadowColor: Colors.blue, semanticContainer: false, shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(15), ), child: Theme( data: Theme.of(context).copyWith( cardColor: Color.fromRGBO(24, 34, 49, 100), dividerColor: Colors.transparent, dividerTheme: DividerThemeData(thickness: 23, space: 20), cardTheme: CardTheme( //                    margin: EdgeInsets.all(6), elevation: 3, shadowColor: Colors.amber, //                    shape: RoundedRectangleBorder( //                        borderRadius: BorderRadius.circular(15)), ), //              textTheme: , ), isMaterialAppTheme: true, child: ExpansionPanelList( animationDuration: Duration(seconds: 1), expansionCallback: (int index, bool isExpanded) { setState( () { _currentDayEvent[index].isExpanded = !_currentDayEvent[index].isExpanded; }, ); }, children: _currentDayEvent.map<ExpansionPanel>( (CurrentEvent currentEvent) { return ExpansionPanel( headerBuilder: (BuildContext context, bool isExpanded) { return ClipRRect( borderRadius: BorderRadius.circular(20), //                          ClipRRect( //                            borderRadius: BorderRadius.circular(20), child: Text("data"), //                          ListTile(isThreeLine: false, //                            contentPadding: EdgeInsets.all(3.0), //                            leading: Container( //                              padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0), ////                                decoration: BoxDecoration( ////                                    border: Border( ////                                        left: BorderSide( ////                                            width: 3.0, color: Colors.white54))), //                              child: Icon( //                                Icons.account_circle, //                                size: 30.0, //                                color: Colors.black, //                              ), //                            ), //                            title: ListTile( //                              contentPadding: EdgeInsets.all(0.0), //                              title: Text( //                                currentEvent.header, //                                style: TextStyle( //                                  color: Colors.black, //                                  fontSize: 14.0, //                                ), //                              ), //                            ), //                          ), ); //                          return Container( ////                            color:Colors.blue, //                            alignment: Alignment.center, //                            //decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.blue), //                            child: Text( //                              currentEvent.header, //                              style: textStyle1, //                            ), //                          ); }, isExpanded: currentEvent.isExpanded, canTapOnHeader: true, body: Container( color: Colors.blue, child: Text( currentEvent.body, style: Theme.of(context).textTheme.headline2, textAlign: TextAlign.left, ), ), ); }, ).toList(), expandedHeaderPadding: EdgeInsets.all(0.0), ), ), ), Container( child: Center( child: AnimatedIcon( icon: AnimatedIcons.add_event, progress: globals.animationController1, color: Colors.pinkAccent, ), ), ), Container( margin: EdgeInsets.symmetric(horizontal: 50.0), child: Column( children: <Widget>[ Container( alignment: Alignment.bottomCenter, //                  height: 100, //                  color: Colors.black, child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween, //                      mainAxisSize: MainAxisSize.max, children: <Widget>[ Hero(tag:"currentMonth",transitionOnUserGestures: true, child: GestureDetector(onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context)=>Menu())); }, child: Padding( padding: const EdgeInsets.only(left:10.0), child: Text( globals.currentMonth, style: TextStyle( fontFamily: "Phenomena", fontWeight: FontWeight.bold, fontSize: 24.0, color: CSSColors.deepPink), ), ), ), ), Row( children: <Widget>[ IconButton( icon: Icon(Icons.chevron_left, size: 20), tooltip: globals.prevMonth, color: Colors.pink, iconSize: 15, onPressed: () { setState(() { globals.targetDateTime = DateTime( globals.targetDateTime.year, globals.targetDateTime.month - 1); globals.currentMonth = DateFormat.yMMM().format(globals.targetDateTime);
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
//                Card(
//////                  elevation: 5,
//////                  shadowColor: Colors.black,
////                  margin: EdgeInsets.symmetric(vertical: 10.0),
////                  color: Colors.transparent,
////                  child:
////
////                  ),
