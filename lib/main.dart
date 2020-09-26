import 'dart:math';

import 'package:events/globals.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'custom_widgets.dart';

void main() {
  //=> runApp(MyApp());
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Set portrait orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    // SystemChrome.setSystemUIOverlayStyle(style)
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
          builder: (BuildContext context, ThemeNotifier notifier, child) {
        return MaterialApp(
          title: 'Events',
          theme: notifier.darkTheme ? dark : light,
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

switchPage() {
  switch (switchWidget) {
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
        return ViewDayEvents();
//            viewDayEvents(context);
      }
      break;
    case 3:
      {
        return SearchEvents();
      }
      break;
    case 4:
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

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  double screenHeight;
  double screenWidth;

  List<Color> dkMdMenu = [
    Color(0xFF101722), //5d646e), //3f4754),
    Color(0xFF131b27), //464e5a), //2b3442),
    Color(0xFF151e2c), //2f3845), //27303f),
    Color(0xff182231)
  ];
  List<Color> lghtMdMenu = [
    Color(0xFF74adec), //73AEF5),
    Color(0xFF60a1ea), //61A4F1),
    Color(0xFF4c95e7), //478DE0),
    Color(0xFF398AE5),
  ];
  double endVal = 0.0;
  final _pageController = PageController(initialPage: 0, keepPage: true);

  @override
  void initState() {
    mainController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    dayEvents = {};
    selectedDayEvents = [];
    switchPage();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    mainController.dispose();
    scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    final pageView = PageView(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      allowImplicitScrolling: true,
      pageSnapping: true,
      children: <Widget>[
        body(context)
      ],
    );
    resized ? mainController.reverse() : mainController.forward();
    mainAnimation = RelativeRectTween(
      begin: new RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
      end: new RelativeRect.fromLTRB(screenWidth * 0.65, screenWidth * 0.2,
          screenWidth * -0.4, screenWidth * 0.2),
    ).animate(CurvedAnimation(parent: mainController, curve: Curves.easeInOut));
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      key: scaffoldKey,
      body: AnimatedContainer(
        duration: duration,
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: menuGradient ? dkMdMenu : lghtMdMenu,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: <double>[0.1, 0.4, 0.7, 0.9],
          ),
        ),
        child: Stack(
          children: <Widget>[
            menu(context),
            // Menu(),
            PositionedTransition(rect: mainAnimation, child: pageView),
          ],
        ),
      ),
    );
  }

  Widget appbar(context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      width: MediaQuery
          .of(context)
          .size
          .width,
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
                    icon: Icon(const IconData(0xe800, fontFamily: "appicons")),
                    color: Colors.pink,
                    splashColor: Colors.blue,
                    hoverColor: Colors.green,
                    onPressed: () {
                      setState(() {
                        resized = !resized;
                        if (resized == false) {
                          scaleController.forward();
                        } else if (resized == true) {
                          scaleController.reverse();
                        }
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
              if (modalOpen == false) {
                modalOpen = true;
                setState(() {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SingleChildScrollView(
                        child: ModalBottomSheet(),
                      );
                    },
                    backgroundColor: Theme
                        .of(context)
                        .disabledColor,
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
                });
              }
              if (modalOpen == true) {
                modalOpen = false;
              }
            },
          ),
        ],
      ),
    );
  }

  Widget menu(context) {
    return AnimatedOpacity(
      opacity: resized ? 0 : 1,
      duration: Duration(seconds: 1),
      curve: Curves.easeIn,
      child:
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
        child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width * 0.60,
          margin: EdgeInsets.only(bottom: 50.0, top: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: CircleAvatar(
                        backgroundImage:
                        AssetImage(
                          "images/jackson-david-7t7pFCjTmws-unsplash.jpg",),
                        maxRadius: 30,
                        minRadius: 10,
                      ),
                    ),
                    Text("Events", overflow: TextOverflow.fade,
                      textAlign: TextAlign.justify,
                      semanticsLabel: "Events",
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline1,)
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 2,
                    margin: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Theme
                          .of(context)
                          .backgroundColor,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  FlatButtonWidget(switchVal: 0,
                      label: "Year",
                      icon: MdiIcons.calendarBlankMultiple),
                  FlatButtonWidget(switchVal: 1,
                      label: "Month",
                      icon: MdiIcons.calendarMonth),
                  FlatButtonWidget(
                      switchVal: 2, label: "Day", icon: Icons.calendar_today),
                  FlatButtonWidget(
                      switchVal: 3, label: "Search", icon: Icons.search),
                  Container(
                    width: double.infinity, height: 2,
                    margin: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Theme
                          .of(context)
                          .backgroundColor,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    // child: Divider()
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: FlatButtonWidget(
                  switchVal: 4, label: "Settings", icon: Icons.settings,),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget body(context) {
    return
      ClipRRect(
        borderRadius: BorderRadius.circular(resized ? 0 : 16),
        child: Container(
          color: Theme
              .of(context)
              .primaryColor,
          child: Wrap(
            direction: Axis.horizontal,
            children: <Widget>[
              appbar(context),
              AnimatedSwitcher(
                transitionBuilder: (Widget child, Animation<double> animation) {
                  final offsetAnimation = Tween<Offset>(
                      begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
                      .animate(animation);
                  return SlideTransition(
                      position: offsetAnimation,
                      child: child);
                },
                switchInCurve: Curves.easeInOut,
                switchOutCurve: Curves.easeInOut,
                duration: duration,
                child: switchWidget == 1 ? MyBody() : switchPage(),
//                  (() {
//                    switchPage()
//                  }()),
              ),
            ],
          ),
        ),
      );
  }
}

//Flat button widget for the menu items
class FlatButtonWidget extends StatefulWidget {

  const FlatButtonWidget({
    Key key,
    @required this.switchVal,
    @required this.label,
    @required this.icon,
  }) : super(key: key);

  final int switchVal;
  final String label;
  final IconData icon;

  @override
  _FlatButtonWidgetState createState() => _FlatButtonWidgetState();
}

class _FlatButtonWidgetState extends State<FlatButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      onPressed: () {
        setState(() {
          switchWidget = widget.switchVal;
        });
      },
      label: Text(
        widget.label, textAlign: TextAlign.start,
        style: switchWidget == widget.switchVal
            ? Theme
            .of(context)
            .textTheme
            .headline6
            .copyWith(fontWeight: FontWeight.w600, fontSize: 24)
            : Theme
            .of(context)
            .textTheme
            .headline6,
      ), icon: Icon(widget.icon, color: Theme
        .of(context)
        .focusColor
        .withOpacity(0.7),),
    );
  }
}


// class MainBodyWidget extends StatefulWidget {
// //   MainBodyWidget({Key key,this.resize}):super(key:key);
// // final bool resize;
//   @override
//   _MainBodyWidgetState createState() => _MainBodyWidgetState();
// }
//
// class _MainBodyWidgetState extends State<MainBodyWidget> {
//
//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(resized ? 0 : 16),
//       child: Container(
//         color: Theme
//             .of(context)
//             .primaryColor,
//         child: Wrap(
//           direction: Axis.horizontal,
//           children: <Widget>[
//             // Appbar(isResized: resized,key: ValueKey(1),),
//             Appbar(onChanged: _handleTapboxChanged,isResized: _active,),
//             AnimatedSwitcher(
//               transitionBuilder: (Widget child, Animation<double> animation) {
//                 final offsetAnimation = Tween<Offset>(
//                     begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
//                     .animate(animation);
//                 return SlideTransition(
//                   position: offsetAnimation,
//                   child: child,
//                 );
//               },
//               switchInCurve: Curves.easeInOut,
//               switchOutCurve: Curves.easeInOut,
//               duration: Duration(seconds: 3),
//               child: switchWidget == 1 ? MyBody() : switchPage(),
// //                  (() {
// //                    switchPage()
// //                  }()),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
// //   Container appbar(context){
// //     return Container(
// //       margin: EdgeInsets.symmetric(vertical: 10),
// //       width: MediaQuery
// //           .of(context)
// //           .size
// //           .width,
// //       child: Row(
// //         crossAxisAlignment: CrossAxisAlignment.center,
// //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         children: <Widget>[
// //           Transform(
// //             transform: Matrix4.rotationX(pi),
// //             alignment: Alignment.center,
// //             child: Transform.rotate(
// //               angle: pi / 2,
// //               child: Padding(
// //                 padding: const EdgeInsets.all(8.0),
// //                 child: IconButton(
// //                     icon: Icon(IconData(0xe800, fontFamily: "appicons")),
// //                     color: Colors.pink,
// //                     splashColor: Colors.blue,
// //                     hoverColor: Colors.green,
// //                     onPressed: () {
// //                       setState(() {
// //                         // if(resized)scaleController.forward();else scaleController.reverse();
// //                         resized = !resized;
// //                         print(resized);
// //                         // scaffoldKey.currentContext.widget;
// //                         // MainBodyWidget();
// //                       });
// //                     }),
// //               ),
// //             ),
// //           ),
// //           IconButton(
// //             icon: Icon(Icons.add),
// //             color: Colors.pink,
// //             iconSize: 30,
// //             onPressed: () {
// //               if (modalOpen == false) {
// //                 modalOpen = true;
// //                 setState(() {
// //                   showModalBottomSheet(
// //                     context: context,
// //                     builder: (context) {
// //                       return SingleChildScrollView(
// //                         child: ModalBottomSheet(),
// //                       );
// //                     },
// //                     backgroundColor: Theme.of(context).disabledColor,
// //                     enableDrag: true,
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.vertical(
// //                         top: Radius.circular(25.0),
// //                       ),
// //                     ),
// //                     isScrollControlled: true,
// //                     useRootNavigator: true,
// //                     isDismissible: true,
// //                   );
// //                 });
// //               }
// //               if (modalOpen == true) {
// //                 modalOpen = false;
// // //                setState(() {
// // //                  eTitleController.clear();
// // //                });
// //               }
// //             },
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// }

