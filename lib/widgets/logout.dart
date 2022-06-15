
import 'package:shared_preferences/shared_preferences.dart';

class Logout{
  late SharedPreferences logout;
  Future<void> accountLogout()async{
    logout = await SharedPreferences.getInstance();
    logout.setBool('login', true);
    logout.remove('email');
    logout.remove('password');
    logout.remove('roll');
  }
}