import 'package:events/globals.dart';
import 'package:events/main.dart';

class EventsSplashScreen extends StatefulWidget {
  // const EventsSplashScreen({
  // Key key,
  // @required this.homeWidget,
  // }) : super(key: key);
  //
  //  final Widget homeWidget;

  @override
  _EventsSplashScreenState createState() => _EventsSplashScreenState();
}

class _EventsSplashScreenState extends State<EventsSplashScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    splashController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..forward();
    homePage();
    super.initState();
  }

  homePage() async {
    return await Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return AnimatedSwitcher(
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              layoutBuilder: (currentChild, previousChildren) {
                return currentChild;
              },
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
              duration: Duration(milliseconds: 700),
              child: MyHomePage());
        },
      ));
    });
  }

  @override
  void dispose() {
    splashController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // appBar: PreferredSize(child: Col, preferredSize: null,),
      body: Center(
        child: Container(
          child: AnimatedBuilder(
            builder: (context, child) {
              return child;
            },
            animation: splashController,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Events",
                  style: Theme.of(context).textTheme.headline1.copyWith(
                        // fontWeight: FontWeight.w900,
                        fontSize: 70,
                        color: Color(0xFFFF0080),
                        // shadows: <Shadow>[
                        //   Shadow(
                        //     offset: Offset(20.0, 20.0),
                        //     blurRadius: 5.0,
                        //     color: Colors.black,
                        //   ),
                        // ],
                      ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.3,
                      vertical: 5.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  // padding: const EdgeInsets.all(8.0),
                  // child: LinearProgressIndicator(
                  //   backgroundColor: Theme.of(context).primaryColorDark,
                  //   minHeight: 4,
                  //   // value: splashController.value,
                  //   valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                  // ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
