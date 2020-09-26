import 'package:events/globals.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Year extends StatefulWidget {
  @override
  _YearState createState() => _YearState();
}

class _YearState extends State<Year> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.height,
      child: Center(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text.rich(
            TextSpan(
              style: Theme.of(context).textTheme.headline2.copyWith(
                    color: Color(0XFFC8C8C8).withOpacity(0.5),
                  ),
              children: <TextSpan>[
                TextSpan(
                  text: DateFormat("MMM ")
                      .format(calendarController.selectedDay)
                      .toString(),
                  style: Theme.of(context).textTheme.headline1.copyWith(
                    fontWeight: FontWeight.w900,
                    fontSize: 50,
                    color: Color(0xFFFF0080),
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(20.0, 20.0),
                        blurRadius: 10.0,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
                TextSpan(
                  text: DateFormat("d, ")
                      .format(calendarController.selectedDay)
                      .toString(),
                  style: Theme.of(context).textTheme.headline1.copyWith(
                    fontWeight: FontWeight.w900,
                    fontSize: 50,
                    color: Color(0xFFFF0080),
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(20.0, 20.0),
                        blurRadius: 10.0,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
                TextSpan(
                  text: DateFormat("yyyy")
                      .format(calendarController.selectedDay)
                      .toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(10.0, 12.0),
                        blurRadius: 3.5,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
