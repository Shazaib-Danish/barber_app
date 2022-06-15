import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gromify/data%20manager/data_manager.dart';
import 'package:gromify/firebase_authentications/firebase_authen.dart';
import 'package:gromify/screens/barber/barber_dashboard.dart';
import 'package:gromify/screens/dashboard.dart';
import 'package:gromify/screens/authentications/login%20_screen.dart';
import 'package:map_location_picker/generated/l10n.dart' as location_picker;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return DataManagerProvider();
      },
      child: MaterialApp(
        title: "DeveStyle",
        localizationsDelegates: const [
          location_picker.S.delegate,
        ],
        supportedLocales: const <Locale>[
          Locale('en', ''),
          Locale('ar', ''),
        ],
        // --------------------- Add Theme Data ---------------------- //
        // Add theme data here
        theme: ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.light,
          primaryColor: Colors.blueGrey[900],
          accentColor: Colors.cyan[600],

          // Define the default font family.

          // Define the default TextTheme. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: const TextTheme(
            headline1: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.black),
            headline2: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal),
            headline6: TextStyle(fontSize: 20.0, fontStyle: FontStyle.normal),
            bodyText2: TextStyle(
              fontSize: 14.0,
            ),
          ),
        ),
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  // -------------- for start page
  Widget defaultPage = Container();
  late SharedPreferences login;
  bool loginSuccess = false;
  late String roll;

  Future<void> checkIfAlreadyLogin() async {
    login = await SharedPreferences.getInstance();
    bool newUser = (login.getBool('login') ?? true);
    if (newUser == false) {
      setState(() {
        loginSuccess = true;
        roll = login.getString('roll').toString();
      });
      signIn(login.getString('email').toString(),
          login.getString('password').toString(), roll, context);
    }
  }

//------------ check if the user is using app for first time or not
//   void checkSharedPrefs() async {
//     var sharedPrefs = await SharedPreferences.getInstance();
//     if (sharedPrefs.containsKey("firstTime")) {
//       defaultPage = Container();
//     }
//   }

//-------- initialize with a Timer that will push to new screen after few seconds
  @override
  void initState() {
    super.initState();
    checkIfAlreadyLogin();
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => loginSuccess
              ? roll == 'Customer'
                  ? HomePageScreen()
                  : BarberDashboard()
              : LoginScreen(),
        ),
      );
    });
  }

// ---------------- Splash Screen Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // -------------------- temp background color can be changed.... in THEME DATA
      backgroundColor: Colors.blueGrey[900],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/splash_screen.gif",
            height: (60 / 100) * MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          CircularProgressIndicator(
            strokeWidth: 4,
            backgroundColor: Colors.amberAccent[400],
          )
        ],
      ),
    );
  }
}
