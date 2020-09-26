import 'package:events/globals.dart';

class DisplayNoEventsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Text.rich(
        TextSpan(
          style: Theme.of(context).textTheme.headline2.copyWith(
                color: Color(0XFFC8C8C8).withOpacity(0.5),
              ),
          children: <TextSpan>[
            TextSpan(
              text: 'Tap the ',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 30,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(4.0, 3.0),
                    blurRadius: 3,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
            TextSpan(
              text: '+',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).accentColor,
                fontSize: 45,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(8.0, 10.0),
                    blurRadius: 5,
                    color: Colors.black54,
                  ),
                  Shadow(
                    offset: Offset(0.0, 0.0),
                    blurRadius: 8,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
            TextSpan(
              text: ' to add a new event',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 30,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(4.0, 3.0),
                    blurRadius: 3,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
