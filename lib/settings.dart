import 'package:events/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'globals.dart' as globals;

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

bool x = true;

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Consumer<ThemeNotifier>(builder: (context, notifier, child) {
            return SwitchListTile(
              value: notifier.darkTheme,
              title: Text(notifier.darkTheme ? "DarkTheme" : "Light THeme"),
              onChanged: (bool value) {
                notifier.toggleTheme();
                globals.menuGradient = !globals.menuGradient;
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
