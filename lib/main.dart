import 'dart:convert';
import 'dart:math';

import 'package:events/ScrollingYears.dart';
import 'package:events/settings.dart';
import 'package:events/themes.dart';
import 'package:events/viewDayEvents.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/date_symbol_data_local.dart'; // to show date and time in different languages
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

import 'body.dart';
import 'bottom_sheet.dart';
import 'globals.dart' as globals;
import 'themes.dart';

//import 'package:device_calendar/device_calendar.dart';
//import 'viewDayEvents.dart';

//import 'package:table_calendar/table_calendar.dart';
//import 'package:table_calendar/table_calendar.dart';
//import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
// import 'package:english_words/english_words.dart';
// import 'dart:html';

void main() {
  //=> runApp(MyApp());//one line functions or methods
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
          builder: (BuildContext context, ThemeNotifier notifier, child) {
        return MaterialApp(
          title: 'Task',
//      routes: ,
          theme: notifier.darkTheme ? dark : light,
//      ThemeData(
////        scaffoldBackgroundColor: Color(0xff182231),
////        backgroundColor: ,
//        textTheme: TextTheme(
//          headline1: TextStyle(
//            fontFamily: "Phenomena",
//            fontSize: 18,
//            fontStyle: FontStyle.normal,
//            color: Color.fromRGBO(255, 51, 102, 100),
//          ),
//          headline2: TextStyle(
//            fontFamily: "Phenomena",
//            fontSize: 24,
//            fontStyle: FontStyle.normal,
//            color: Color.fromRGBO(255, 51, 102, 100),
//          ),
//        ),
//      ),
          home: MyHomePage(),
        );
      }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //Unknown
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  double screenHeight;
  double screenWidth;
  List<Color> dkMdMenu = [
    Color(0xFF3f4754),
    Color(0xFF2b3442),
    Color(0xFF27303f),
    Color(0xFF232d3b)
  ];
  List<Color> lghtMdMenu = [
    Colors.blueGrey.shade200,
    Colors.blueGrey.shade300,
    Colors.blueGrey.shade400,
    Colors.blueGrey.shade500,
  ];

//  LinkedList<> _myEvents; // _calendarController;

  final _pageController = PageController(initialPage: 0, keepPage: true);

  switchPage() {
    switch (globals.switchWidget) {
      case 0:
        {
          return Year();
        }
        break;
      case 1:
        {
          return MyBody();
        }
        break;
      case 2:
        {
          return viewDayEvents(context);
        }
        break;
      case 3:
        {
          return Settings();
        }
        break;
      default:
        {
          return MyBody();
        }
        break;
    }
  }

  @override
  void initState() {
    //
    super.initState();
    globals.eventTitleController = TextEditingController();
    globals.calendarController = CalendarController();
    globals.dayEvents = {};
    globals.selectedEvents = [];
    initPrefs();
    switchPage();
//    _retrieveCalendars();

    globals.animationController1 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    globals.animationController2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      reverseDuration: Duration(seconds: 2),
      value: 1,
      lowerBound: 0.4,
      upperBound: 1,
    );
    globals.animation = CurvedAnimation(
        parent: globals.animationController2, curve: Curves.easeOut);
    globals.animationController2.forward();
    globals.animationController1.reverse();
  }

  @override
  void dispose() {
    //
    super.dispose();
    globals.calendarController.dispose();
    globals.animationController2.dispose();
    globals.animationController1.dispose();
    _pageController.dispose();
  }

  @override
  void deactivate() {
    //
    super.deactivate();
  }

  void initPrefs() async {
    globals.eventPrefs = await SharedPreferences.getInstance();
    setState(() {
      globals.dayEvents = Map<DateTime, List<dynamic>>.from(globals.decodeMap(
          json.decode(globals.eventPrefs.getString("events") ?? "{}")));
    });
  }

  @override
  Widget build(BuildContext context) {
//    Size size =MediaQuery.of(context).size;
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    final pageView = PageView(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      allowImplicitScrolling: true,
      pageSnapping: true,
      children: <Widget>[
        /*      MyHomePage(),*/
        body(context),
        viewDayEvents(context),
      ],
    ); /*Container _appbar=*/
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        height: double.infinity,
        /*        MediaQuery.of(context).size.height,*/
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: globals.menuGradient ? dkMdMenu : lghtMdMenu,
            /*        Color(0xff303947), Color(0xff161e2c), Color(0xFF1B2534), Color(0xFF1A2433), Color(0xFF182231), Color(0xFF182130), Color.fromRGBO(24, 36, 49, 100), Color.fromRGBO(24, 34, 49, 100), Color.fromRGBO(24, 32, 49, 100), Color.fromRGBO(24, 30, 49, 100), globals.HexColor("#242d3c"),//182431 globals.HexColor("#242d3c"),//182231 globals.HexColor("#182231"),//182031 globals.HexColor("#17202e"),//181e31 Colors.blueGrey.shade200, Colors.blueGrey.shade300, Colors.blueGrey.shade400, Colors.blueGrey.shade500, CSSColors.cadetBlue.,*/
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
            stops: [
              0.1,
              0.4,
              0.7,
              0.9
            ], /*          tileMode: TileMode.mirror,*/
          ),
        ),
        child: Stack(
          children: <Widget>[
            /*              Offstage( offstage: globals.visibility,child: , ),*/
            menu(context),
            AnimatedPositioned(
              duration: Duration(seconds: 2),
              top: globals.resized ? 0 : 0.2 * screenHeight,
              bottom: globals.resized ? 0 : screenWidth * 0.2,
              left: globals.resized ? 0 : screenWidth * 0.6,
              right: globals.resized ? 0 : screenWidth * -0.4,
              curve: Curves.easeIn,
              child: pageView,
            ),
          ],
        ),
      ),
    );
  }

  Widget appbar(context) {
    return Container(
      /*              foregroundDecoration: BoxDecoration(color: Colors.transparent),*/
      margin: EdgeInsets.only(top: 20),
      width: MediaQuery.of(context).size.width,
      /*      padding: EdgeInsets.all(10),*/
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Transform(
            transform: Matrix4.rotationX(pi),
            alignment: Alignment.center,
            child: Transform.rotate(
              angle: pi / 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    /*                              icon: Icon(MdiIcons.equalizerOutline),*/
                    icon: Icon(IconData(0xe800, fontFamily: "appicons")),
                    color: Colors.pink,
                    splashColor: Colors.blue,
                    hoverColor: Colors.green,
                    onPressed: () {
                      /*                        Transform.scale(scale: 0.5, child: _myBody);*/ setState(
                          () {
                        globals.resized = !globals.resized;
                      });
                    }),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.add),
            color: Colors.pink,
            iconSize: 30,
            onPressed: () {
              if (globals.modalOpen == false) {
                globals.modalOpen = true;
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SingleChildScrollView(
                      child: ModalBottomSheet(),
                    );
                  },
                  backgroundColor: Colors.blueGrey,
                  enableDrag: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25.0),
                    ),
                  ),
                  isScrollControlled: true,
                  useRootNavigator: true,
                  isDismissible: true,
                );
              }
              if (globals.modalOpen == true) {
                globals.modalOpen = false;
                setState(() {
                  globals.eventTitleController.clear();
                });
              }
            },
          ),
        ],
      ),
    );
  }

  Widget menu(context) {
    return AnimatedOpacity(
      /*          key: ValueKey(2), if menu is collapsed(resized) opacity is 0 otherwise it is 1*/
      opacity: globals.resized ? 0 : 1,
      duration: Duration(seconds: 1),
      curve: Curves.easeIn,
      child:
//      ListWheelScrollView(
////                mainAxisAlignment: MainAxisAlignment.center,
//        itemExtent: 100,
//        diameterRatio: 3,
//        /*          magnification: 1.5, useMagnifier: true,*/
//        offAxisFraction: 0.5,
//        perspective: 0.005,
//        physics: BouncingScrollPhysics(),
//        /*          clipToSize: true,*/
//        children: <Widget>[

          Container(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FlatButton(
              onPressed: () {
                setState(() {
                  globals.switchWidget = 0;
                });
              },
              child: Text(
                "Year",
                style: globals.switchWidget == 0
                    ? Theme.of(context).textTheme.headline1
                    : Theme.of(context).textTheme.headline2,
              ),
//                  color:Colors.amber ,
            ),
            FlatButton(
              onPressed: () {
                setState(() {
                  globals.switchWidget = 1;
                });
              },
              child: Text(
                "Month",
                style: globals.switchWidget == 1
                    ? Theme.of(context).textTheme.headline1
                    : Theme.of(context).textTheme.headline2,
              ),
//                  color:Colors.amber ,
            ),
            FlatButton(
              onPressed: () {
                setState(() {
                  globals.switchWidget = 2;
                });
              },
              child: Text(
                "Day",
                style: globals.switchWidget == 2
                    ? Theme.of(context).textTheme.headline1
                    : Theme.of(context).textTheme.headline2,
              ),
//                  color:Colors.amber ,
            ),
            FlatButton(
              onPressed: () {
                setState(() {
                  globals.switchWidget = 3;
                });
              },
              child: Text(
                "Settings",
                style: globals.switchWidget == 3
                    ? Theme.of(context).textTheme.headline1
                    : Theme.of(context).textTheme.headline2,
              ),
//                  color:Colors.amber ,
            ),
          ],
        ),
      ),

      /*          ListWheelScrollView( children: <Widget>[ MaterialButton(onPressed: () { setState(() { globals.switchWidget=!globals.switchWidget; }); //              Navigator.push( //                context, //                MaterialPageRoute( //                  builder: (context) => settings(context),),); // //body(context) },child: Text("data"), //                icon: Icon(Icons.settings), label: Text("settings"), ), Container( height: 100, color: Colors.amber, child: ListTile( title: Text( "data", style: TextStyle( fontFamily: "Phenomena", fontSize: 80, color: Colors.pink), ), ), ), Container( height: 100, color: Colors.amber, child: ListTile( title: Text( "data", style: TextStyle( fontFamily: "Phenomena", fontSize: 80, color: Colors.pink), ), ), ), Container( height: 100, color: Colors.amber, child: ListTile( title: Text( "data", style: TextStyle( fontFamily: "Phenomena", fontSize: 80, color: Colors.pink), ), ), ), Container( height: 100, color: Colors.amber, child: ListTile( title: Text( "data", style: TextStyle( fontFamily: "Phenomena", fontSize: 80, color: Colors.pink), ), ), ), Container( height: 80, color: Colors.amber, padding: EdgeInsets.only(top: 30, left: 40), child: ListTile( title: Text( "data", style: TextStyle( fontFamily: "Phenomena", fontSize: 80, color: Colors.pink), ), ), ), ], ),*/
//          ],
//        ),
    );
  }

  Widget body(context) {
    return /*    ScaleTransition _myBody = ScaleTransition( alignment: globals.alignment, */ Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(16),
      /*         shadowColor: Colors.black, type: MaterialType.transparency,*/
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              appbar(context),
              AnimatedSwitcher(
                switchOutCurve: Curves.easeInOut,
                duration: Duration(seconds: 1),
                child: globals.switchWidget == 1 ? MyBody() : switchPage()
//                  (() {
//                    switchPage()
//                  }())
                ,
              ),
//                  globals.switchWidget==4 ? MyBody() : Settings(),),
            ],
          ),
        ),
      ),
    );
  }
} //    Curve _curve = Curves.fastOutSlowIn; DraggableScrollableSheet _newEvent= new DraggableScrollableSheet( initialChildSize: 0.4, minChildSize: 0.2, maxChildSize: 0.6,expand: true, builder: (context, scrollController){ return SingleChildScrollView( controller:scrollController, child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."), ); } );Fher ScrollController scrollController = ScrollController( initialScrollOffset: 50, // or whatever offset you wish keepScrollOffset: true, ); ListView( padding: EdgeInsets.zero, shrinkWrap: true, children: <Widget>[ DrawerHeader( child: Text( "Drawer header", style: TextStyle(color: Colors.amber), ), ), ListTile( //            contentPadding: EdgeInsetsGeometry.infinity, leading: IconButton( icon: Icon(Icons.calendar_today), onPressed: () {}, ), title: Text("Year", style: Theme.of(context).textTheme.headline1), ), ListTile( //            contentPadding: EdgeInsetsGeometry.infinity, leading: IconButton( icon: Icon(Icons.calendar_today), onPressed: () {}, ), title: Text("Year", style: Theme.of(context).textTheme.headline1), ), ListTile( //            contentPadding: EdgeInsetsGeometry.infinity, leading: IconButton( icon: Icon(Icons.calendar_today), onPressed: () {}, ), title: Text("Year", style: Theme.of(context).textTheme.headline1), ), //          UserAccountsDrawerHeader(accountName: Text(), accountEmail: null) ], ), ), ), double _top, _bottom, _left, _right = 0; TextStyle textStyle1 = Theme.of(context).textTheme.headline1; DraggableScrollableSheet _newEvent = DraggableScrollableSheet( initialChildSize: 0.05, minChildSize: 0.05, maxChildSize: 0.99, expand: true, //      expand: _expand, builder: (context, scrollController) { return Container( //            color: Colors.blue[100], decoration: BoxDecoration( borderRadius: BorderRadius.only( topLeft: Radius.circular(75.0), topRight: Radius.circular( 75.0, ), ), color: Colors.blue[100], boxShadow: [ BoxShadow( color: Colors.red.withOpacity(0.5), blurRadius: 10.0, spreadRadius: 1.0, offset: Offset( 0, 0, ), ), ], ), child: ListView.builder( controller: scrollController, itemCount: 12, itemBuilder: (BuildContext context, int index) { return ListTile(title: Text(monthNames[index])); }, ), ); }); _myDrawer = new Container( width: 150, //      color: Colors.blue, child: Drawer( elevation: 0, child: Container( color: Color.fromRGBO(24, 34, 49, 100), //backgroundColor: , //backgroundColor: Colors.transparent, child: Column( mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[ ListView( padding: EdgeInsets.zero, shrinkWrap: true, children: <Widget>[ DrawerHeader( child: Text( "Drawer header", style: TextStyle(color: Colors.amber), ), ), ListTile( //            contentPadding: EdgeInsetsGeometry.infinity, leading: IconButton( icon: Icon(Icons.calendar_today), onPressed: () {}, ), title: Text("Year"), ), ListTile( //            contentPadding: EdgeInsetsGeometry.infinity, leading: IconButton( icon: Icon(Icons.calendar_today), onPressed: () {}, ), title: Text("Year"), ), ListTile( //            contentPadding: EdgeInsetsGeometry.infinity, leading: IconButton( icon: Icon(Icons.calendar_today), onPressed: () {}, ), title: Text("Year"), ), //          UserAccountsDrawerHeader(accountName: Text(), accountEmail: null) ], ), ], ), ), ), );
