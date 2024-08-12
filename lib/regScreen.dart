import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'loginScreen.dart';
import 'button.dart';
import 'homepage.dart';
import 'textfield.dart';

class RegScreen extends StatelessWidget {
  RegScreen({Key? key}) : super(key: key);

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  Future<void> _signUp(BuildContext context) async {
    final String url = 'https://localhost:7232/Users/';

    if (password.text != confirmPassword.text) {
      _showErrorDialog(context, 'Passwords do not match.');
      return;
    }

    try {
      final Map<String, dynamic> jsonData = {
      'id' : '',
      'name': name,
      'email': email,
      'password': password,
      'transcriptions' : [],
    };

    final String jsonString = json.encode(jsonData);
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonString,
    );


      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        Navigator.of(context).pushReplacement(_createRoute(Homepage()));
      } else {
        _showErrorDialog(context, 'Sign up failed. Please try again.');
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
              'Create Your\nAccount',
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
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              color: Colors.white,
            ),
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18),
                child: Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Txtfield(
                        icon: Icons.person,
                        txt: name,
                        hint: 'Enter Your Name',
                        pass: false,
                      ),
                      SizedBox(height: 10),
                      Txtfield(
                        icon: Icons.email,
                        txt: email,
                        hint: 'Enter Your Email Address',
                        pass: false,
                      ),
                      SizedBox(height: 10),
                      Txtfield(
                        icon: Icons.key,
                        txt: password,
                        hint: 'Enter Your Password',
                        pass: true,
                      ),
                      SizedBox(height: 10),
                      Txtfield(
                        icon: Icons.key,
                        txt: confirmPassword,
                        hint: 'Confirm Your Password',
                        pass: true,
                      ),
                      const SizedBox(height: 10),
                      Button(
                        onTap: () {
                          _signUp(context); // Call the sign-up function
                        },
                        content: "Sign up",
                      ),
                      SizedBox(height: 20),
                      Txtbutton(
                        onTap: () {
                          Navigator.of(context).pushReplacement(_createRoute(LoginScreen()));
                        },
                        content: "I have already registered!",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ));
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
