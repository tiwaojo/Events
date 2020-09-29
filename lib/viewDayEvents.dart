import 'package:events/custom_widgets.dart';
import 'package:events/globals.dart';


class ViewDayEvents extends StatefulWidget {
  @override
  _ViewDayEventsState createState() => _ViewDayEventsState();
}

class _ViewDayEventsState extends State<ViewDayEvents> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        duration: duration,
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        child: selectedDayEvents.isEmpty
            ? Container(
                height: MediaQuery.of(context).size.height,
                child: DisplayNoEventsWidget())
            : Container(
                foregroundDecoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black87,
                      Colors.transparent,
                    ],
                    begin: FractionalOffset.bottomCenter,
                    end: FractionalOffset.topCenter,
                    stops: <double>[
                      0.12,
                      0.35,
                    ],
                  ),
                  // backgroundBlendMode: BlendMode.overlay,
                ),
                child: DisplayEventsWidget(
                  numEvents: selectedDayEvents.length,
                  eventListHeight: 1.0,
                )));
  }
}


