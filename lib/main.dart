import 'package:appliences/homepage.dart';
import 'package:appliences/loginpage.dart';
import 'package:appliences/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.openSansTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        initialRoute: MyRoutes.loginpageroutes,
        home: const LoginPage(),
        routes: {
          "/login": (context) => const LoginPage(),
          MyRoutes.homescreenroutes: (context) => const HomeScreen(),
          MyRoutes.loginpageroutes: (context) => const LoginPage(),
        });
  }
}
