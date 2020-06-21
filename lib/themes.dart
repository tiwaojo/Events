import 'package:events/globals.dart';

final ThemeData light = ThemeData(
  textTheme: TextTheme(
    headline1: TextStyle(
      fontFamily: "Phenomena",
      fontSize: 30,
      color: Color(0xFFFF3366),
    ),
    headline2: TextStyle(
      fontFamily: "Phenomena",
      fontSize: 16,
      color: Color(0xFFFF3366),
    ),
  ),
  scaffoldBackgroundColor: Color(0xFF4a6a97),
);

final ThemeData dark = ThemeData(
  textTheme: TextTheme(
    headline1: TextStyle(
      fontFamily: "Phenomena",
      fontSize: 30,
      color: Color(0xFFFF3366),
    ),
    headline2: TextStyle(
      fontFamily: "Phenomena",
      fontSize: 16,
      color: Color(0xFFFF3366),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Color(0xff182231),
    contentPadding: EdgeInsets.only(left: 10),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.pink),
        borderRadius: BorderRadius.circular(10),
        gapPadding: 10),
    alignLabelWithHint: true,
  ),
  scaffoldBackgroundColor: Color(0xff182231),
  primaryColor: Color(0xff182231),
);

class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";
  SharedPreferences prefs;
  bool _darkTheme;

  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    _darkTheme = true;

    _loadFromPrefs();
  }

  toggleTheme() {
    _darkTheme = !_darkTheme;
//    globals.menuGradient=_darkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  //Initializes shared preferences for theme and awaits for the instance
  _initPrefs() async {
    if (prefs == null) prefs = await SharedPreferences.getInstance();
  }

  //Loads the _darkTheme bool value from memory and notifies the listeners to change the theme of the application
  _loadFromPrefs() async {
    await _initPrefs();
    _darkTheme = prefs.getBool(key) ?? true;
    menuGradient = _darkTheme;
    notifyListeners();
  }

//Saves _darkTheme bool value in memory after the preference has been initialized
  _saveToPrefs() async {
    await _initPrefs();
    prefs.setBool(key, _darkTheme);
  }
}
