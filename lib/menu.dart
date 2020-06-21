//import 'package:events_globals/events_globals.dart';
import 'package:events/globals.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
//          key: ValueKey(2),
      //if menu is collapsed(resized) opacity is 0 otherwise it is 1
      opacity: resized ? 0 : 1,
      duration: Duration(seconds: 1),
      curve: Curves.easeIn,

      child: ListWheelScrollView(
        itemExtent: 100,
        diameterRatio: 3,
//          magnification: 1.5,
//          useMagnifier: true,
        offAxisFraction: 0.5,
        perspective: 0.005,
        physics: BouncingScrollPhysics(),
//          clipToSize: true,
        children: <Widget>[
          FlatButton(
              onPressed: () {
                setState(() {
//                  globals.switchWidget = !globals.switchWidget;
                });
              },
              child: Text("data")),
          Container(
              height: 100,
              color: Colors.amber,
              child: FlatButton.icon(
                onPressed: () {
//              Navigator.push(
//                context,
//                MaterialPageRoute(
//                  builder: (context) => settings(context),),);
                },
                icon: Icon(Icons.settings),
                label: Text("settings"),
              )),
          Container(
            height: 100,
            color: Colors.amber,
            child: ListTile(
              title: Text(
                "data",
                style: TextStyle(
                    fontFamily: "Phenomena", fontSize: 80, color: Colors.pink),
              ),
            ),
          ),
          Container(
            height: 100,
            color: Colors.amber,
            child: ListTile(
              title: Text(
                "data",
                style: TextStyle(
                    fontFamily: "Phenomena", fontSize: 80, color: Colors.pink),
              ),
            ),
          ),
          Container(
            height: 100,
            color: Colors.amber,
            child: ListTile(
              title: Text(
                "data",
                style: TextStyle(
                    fontFamily: "Phenomena", fontSize: 80, color: Colors.pink),
              ),
            ),
          ),
          Container(
            height: 100,
            color: Colors.amber,
            child: ListTile(
              title: Text(
                "data",
                style: TextStyle(
                    fontFamily: "Phenomena", fontSize: 80, color: Colors.pink),
              ),
            ),
          ),
          Container(
            height: 80,
            color: Colors.amber,
            padding: EdgeInsets.only(top: 30, left: 40),
            child: ListTile(
              title: Text(
                "data",
                style: TextStyle(
                    fontFamily: "Phenomena", fontSize: 80, color: Colors.pink),
              ),
            ),
          ),
        ],
      ),
//      ),
    );
  }
//  Widget settings(context){
//
//  }
}
