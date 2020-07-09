import 'package:shared_preferences/shared_preferences.dart';


Future  setToken(String val) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('token', val);
}

Future getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
 String val= prefs.getString('token');
 return val;
}