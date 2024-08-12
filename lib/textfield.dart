import 'package:flutter/material.dart';

import 'Colors.dart';

class Txtfield extends StatefulWidget {
  final TextEditingController txt;
  final String hint;
  final IconData icon;
  final bool pass;

  Txtfield({required this.txt, required this.hint, required this.icon, required this.pass});

  @override
  _TxtfieldState createState() => _TxtfieldState();
}

class _TxtfieldState extends State<Txtfield> {
  bool _isFocused = false;
  late String hint;
  late TextEditingController _controller;
  late IconData icon;
  late bool pass;

  @override
  void initState() {
    super.initState();
    hint = widget.hint;
    _controller = widget.txt;
    icon = widget.icon;
    pass = widget.pass;  // Initialize the controller here
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          _isFocused = hasFocus;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: _isFocused
              ? [
                  BoxShadow(
                    color: colours.prim.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 0,
                  ),
                ]
              : [],
        ),
        child: Padding(
          padding: EdgeInsets.all(7),
          child: TextField(
            obscureText: pass,
            controller: _controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(icon, color: colours.prim),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(color: colours.prim.withOpacity(0.7), width: 2.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(color: colours.prim.withOpacity(0.7), width: 2.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(color: colours.prim, width: 2.0),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
            ),
            style: TextStyle(color: Colors.black, fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
