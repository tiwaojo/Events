import 'dart:math';

import 'package:events/globals.dart';

import 'custom_widgets.dart';

class Appbar extends StatefulWidget {
  Appbar({Key key, this.isResized: true, this.onChanged}) : super(key: key);

  // var isResized;
  final bool isResized;
  final ValueChanged<bool> onChanged;

  @override
  _AppbarState createState() => _AppbarState();
// Appbar(context);
}

class _AppbarState extends State<Appbar> {
  void _handleTap() {
    setState(() {
      widget.onChanged(!widget.isResized);
      print(widget.isResized);
    });
  }

  @override
  Widget build(BuildContext context) {
//    Widget appbar(context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width,
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
                child: GestureDetector(
                  onTap: _handleTap,
                  child: IconButton(
                      icon: Icon(IconData(0xe800, fontFamily: "appicons")),
                      color: Colors.pink,
                      splashColor: Colors.blue,
                      hoverColor: Colors.green,
                      onPressed: () {
                        setState(() {
                          widget.onChanged(!widget.isResized);
                        });
                        // print();
                        // setState(() {
                        //   // if(resized)scaleController.forward();else scaleController.reverse();
                        //   resized = !resized;
                        //   // widget.isResized=widget.isResized=
                        // });
                      }),
                ),
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
//                setState(() {
//                  eTitleController.clear();
//                });
              }
            },
          ),
        ],
      ),
    );
  }
}

