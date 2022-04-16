// ignore_for_file: unnecessary_const, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:appliences/homepage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

String? finalEmail;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  set _password(String? _password) {}
  /* Storage permission*/

  void requestPermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    var status1 = await Permission.manageExternalStorage.status;
    if (!status1.isGranted) {
      await Permission.manageExternalStorage.request();
    }
  }

  @override
  void initState() {
    requestPermission();

    getValidationData().whenComplete(() async => Timer(
        Duration(seconds: 2),
        () => (finalEmail == null
            ? Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const LoginPage()))
            : HomeScreen())));
    super.initState();
  }

  Future getValidationData() async {
    WidgetsFlutterBinding.ensureInitialized();
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getString('email');
    setState(() {
      finalEmail = obtainedEmail;
    });
    print(finalEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 45.0, 15.0, 5.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(220, 175, 157, 255),
                      Color.fromARGB(120, 14, 201, 226),
                      // Color.fromARGB(200, 101, 204, 104),
                    ],
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(35.0, 0.0, 35.0, 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28.0,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        Material(
                          elevation: 10.0,
                          borderRadius: BorderRadius.circular(30),
                          color: const Color.fromARGB(0, 255, 0, 0),
                          child: TextFormField(
                            controller: emailTextEditingController,
                            decoration: const InputDecoration(
                              fillColor: Color.fromARGB(255, 255, 255, 255),
                              filled: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 7.0, 20.0, 7.0),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1.0, color: Colors.green),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(30.0),
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1.0, color: Colors.red),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(30.0),
                                ),
                              ),
                              // icon: Icon(Icons.person),

                              labelText: 'Email *',
                            ),
                            onSaved: (String? value) {
                              // This optional block of code can be used to run
                              // code when the user saves the form.
                            },
                            validator: (String? value) {
                              return (value != null && value.contains('@'))
                                  ? 'Do not use the @ char.'
                                  : null;
                            },
                          ),
                        ),
                        const SizedBox(height: 15.0),
                        Material(
                          elevation: 10.0,
                          borderRadius: BorderRadius.circular(30),
                          color: const Color.fromARGB(0, 255, 0, 0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              fillColor: Color.fromARGB(255, 255, 255, 255),
                              filled: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 7.0, 20.0, 7.0),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1.0, color: Colors.green),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(30.0),
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1.0, color: Colors.red),
                              ),
                              // icon: Icon(Icons.person),
                              labelText: 'Password *',
                            ),
                            validator: (val) =>
                                val!.length < 6 ? 'Password too short.' : null,
                            onSaved: (val) => _password = val,
                            obscureText: true,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 133, 75, 187),
                              onPrimary: Colors.white,
                              minimumSize: const Size(255, 45),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              )),
                          onPressed: () async {
                            SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();
                            sharedPreferences.setString(
                                'email', emailTextEditingController.text);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext ctx) =>
                                        HomeScreen()));
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                                // color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 85,
            ),
            Text(
              "or continue with",
              style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 29, 129, 175),
                        onPrimary: Colors.white,
                        minimumSize: const Size(70, 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        )),
                    onPressed: () {},
                    child: Text("Facebook")),
                SizedBox(
                  width: 50.00,
                ),
                TextButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(230, 86, 75, 187),
                        onPrimary: Colors.white,
                        minimumSize: const Size(70, 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        )),
                    onPressed: () {},
                    child: Text(" Google ")),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Don't have an account? Create one.",
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            )
          ],
        ),
      ),

      // Text("or continue wiht", style: TextStyle(color: Colors.grey[800]))
    );
  }

  TextEditingController emailTextEditingController = TextEditingController();
}
