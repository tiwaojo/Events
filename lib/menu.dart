import 'package:events/globals.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'custom_widgets.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
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

class _MenuState extends State<Menu> {
  @override
  void initState() {
    super.initState();
    switchPage();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      /*          key: ValueKey(2), if menu is collapsed(resized) opacity is 0 otherwise it is 1*/
      opacity: resized ? 0 : 1,
      duration: Duration(seconds: 1),
      curve: Curves.easeIn,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.60,
          margin: EdgeInsets.only(bottom: 50.0, top: 80),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: CircleAvatar(
                        backgroundImage: AssetImage(
                          "images/jackson-david-7t7pFCjTmws-unsplash.jpg",
                        ),
                        // child: Image.asset("images/jackson-david-7t7pFCjTmws-unsplash.jpg",alignment: Alignment.topCenter,
                        //  fit: BoxFit.fill,gaplessPlayback: true, // placeholder: 'images/loading.gif',
                        //   // image: 'images/jackson-david-7t7pFCjTmws-unsplash.jpg',
                        // ),
                        // child: Image.asset("assets/images/jackson-david-7t7pFCjTmws-unsplash.jpg",matchTextDirection: true,),
                        maxRadius: 30,
                        minRadius: 10,
                      ),
                    ),
                    Text(
                      "Events",
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.justify,
                      semanticsLabel: "Events",
                      style: Theme.of(context).textTheme.headline1,
                    )
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
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    // child: Divider()
                  ),
                  flatButtonWidget(
                      context, 0, "Year", MdiIcons.calendarBlankMultiple),
                  flatButtonWidget(context, 1, "Month", MdiIcons.calendarMonth),
                  flatButtonWidget(context, 2, "Day", Icons.calendar_today),
                  flatButtonWidget(context, 3, "Search", Icons.search),
//                   FlatButton.icon(
//                     onPressed: () {
//                       setState(() {
//                         switchWidget = 1;
//                       });
//                     },
//                     icon: Icon(MdiIcons.calendarMonth),
//                     label: Text(
//                     "Month",
//                     style: switchWidget == 1
//                         ?  Theme
//                         .of(context)
//                         .textTheme
//                         .headline6.copyWith(fontWeight: FontWeight.w600,fontSize: 24)
//                         : Theme
//                         .of(context)
//                         .textTheme
//                         .headline6,
//                   ),
//                   ),
//                   FlatButton.icon(
//                     onPressed: () {
//                       setState(() {
//                         // switchWidget = 2;
//                       });
//                     },icon: Icon(Icons.calendar_today),label: Text(
//                     "Day",
//                     style: switchWidget == 2
//                         ?  Theme
//                         .of(context)
//                         .textTheme
//                         .headline6.copyWith(fontWeight: FontWeight.w600,fontSize: 24)
//                         : Theme
//                         .of(context)
//                         .textTheme
//                         .headline6,
//                   ),
// //                  color:Colors.amber ,
//                   ),
//                   FlatButton.icon(
//                     onPressed: () {
//                       setState(() {
//                         // switchWidget = 2;
//                       });
//                     },icon: Icon(Icons.search,semanticLabel: "Calendar Search",),
//                     label: Text(
//                     "Search",
//                     style: switchWidget == 3
//                         ?  Theme
//                         .of(context)
//                         .textTheme
//                         .headline6.copyWith(fontWeight: FontWeight.w600,fontSize: 24)
//                           : Theme
//                       .of(context)
//                       .textTheme
//                       .headline6,
//                   ),
// //                  color:Colors.amber ,
//                   ),
                  Container(
                    width: double.infinity, height: 2,
                    margin: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    // child: Divider()
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: flatButtonWidget(context, 4, "Settings", Icons.settings),
              ),
            ],
          ),
        ),
      ),
    );
  }

  FlatButton flatButtonWidget(context, switchVal, label, icon) {
    return FlatButton.icon(
      onPressed: () {
        setState(() {
          switchWidget = switchVal;
        });
      },
      // disabledTextColor: Theme.of(context).disabledColor.withOpacity(0.5),
      label: Text(
        label,
        textAlign: TextAlign.start,
        style: switchWidget == switchVal
            ? Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontWeight: FontWeight.w600, fontSize: 24)
            : Theme.of(context).textTheme.headline6,
      ),
      icon: Icon(icon),
    );
  }
}
