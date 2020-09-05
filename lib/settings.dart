//import 'package:events_globals/events_globals.dart';
import 'package:events/globals.dart';

import 'custom_widgets.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

bool x = true;

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height,
      child: Column(
        children: <Widget>[
          Consumer<ThemeNotifier>(builder: (context, notifier, child) {
            return SwitchListTile(
              value: notifier.darkTheme,
              title: Text(notifier.darkTheme ? "DarkTheme" : "Light THeme"),
              onChanged: (bool value) {
                notifier.toggleTheme();
                menuGradient = !menuGradient;
                setState(() {
//                          notifier.toggleTheme();

                  x = notifier.toggleTheme();
                  value = x;
                  print(notifier.toggleTheme());
                });
              },
            );
          })
        ],
      ),
    );
  }
}
