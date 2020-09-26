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
              title: Text(
                notifier.darkTheme ? "Dark Theme" : "Light Theme",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Theme.of(context).focusColor),
              ),
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
          }),
          SwitchListTile(value: autofocus, onChanged: (value) {
            setState(() {
              autofocus = !autofocus;
            });
          }, title: Text("AutoFocus TextField", style: Theme
              .of(context)
              .textTheme
              .headline5
              .copyWith(color: Theme
              .of(context)
              .focusColor),),)
        ],
      ),
    );
  }
}
