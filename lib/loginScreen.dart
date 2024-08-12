import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'homepage.dart';
import 'regScreen.dart';
import 'button.dart';
import 'textfield.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController uname = TextEditingController();
  final TextEditingController pass = TextEditingController();

  Future<void> _login(BuildContext context) async {
    final url = Uri.parse('https://localhost:7232/Users/login?email=${uname.text}&password=${pass.text}');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
          if(response.body == true)
          {
            print('Login Successful!');
          }
          else
          {
            print('Login failed!');
          }
        final data = jsonDecode(response.body);
        Navigator.of(context).pushReplacement(_createRoute(Homepage()));
      } else {
        _showErrorDialog(context, 'Login failed. Please try again.');
      }
    } catch (e) {
      _showErrorDialog(context, 'An error occurred. Please try again.');
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xFF2c67f2),
                Color(0xFF62cff4),
              ]),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 60.0, left: 22),
              child: Text(
                'Hello\nSign in!',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Txtfield(
                          icon: Icons.email,
                          txt: uname,
                          hint: 'Enter Your Email Address',
                          pass: false,
                        ),
                        SizedBox(height: 20),
                        Txtfield(
                          icon: Icons.key,
                          txt: pass,
                          hint: 'Enter Your Password',
                          pass: true,
                        ),
                        const SizedBox(height: 70),
                        Column(
                          children: [
                            Button(
                              onTap: () {
                                _login(context); // Call the login function
                              },
                              content: "Sign in",
                            ),
                            SizedBox(height: 20),
                            Txtbutton(
                              onTap: () {
                                Navigator.of(context).pushReplacement(_createRoute(RegScreen()));
                              },
                              content: "Don't Have an account!",
                            ),
                          ],
                        ),
                        const SizedBox(height: 150),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }
}
