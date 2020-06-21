import 'dart:math';

import 'package:events/globals.dart';

import 'custom_widgets.dart';

class Appbar extends StatefulWidget {
  @override
  _AppbarState createState() => _AppbarState();
}

class _AppbarState extends State<Appbar> {
  Widget build(BuildContext context) {
    return Container(
//              foregroundDecoration: BoxDecoration(color: Colors.transparent),
      margin: EdgeInsets.only(top: 20),
      width: MediaQuery.of(context).size.width,
//      padding: EdgeInsets.all(10),
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
//                              icon: Icon(MdiIcons.equalizerOutline),
                    icon: Icon(IconData(0xe800, fontFamily: "appicons")),
                    color: Colors.pink,
                    splashColor: Colors.blue,
                    hoverColor: Colors.green,
                    onPressed: () {
//                        Transform.scale(scale: 0.5, child: _myBody);

                      setState(() {
                        resized = !resized;
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
//                            modalOpen=true;
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SingleChildScrollView(child: ModalBottomSheet());
                  },
                  backgroundColor: Colors.blueGrey,
                  enableDrag: true,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25.0)),
                  ),
                  isScrollControlled: true,
                  useRootNavigator: true,
                  isDismissible: true,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
