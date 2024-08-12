import 'package:flutter/material.dart';
import 'Colors.dart';

class Button extends StatefulWidget {

  final VoidCallback onTap;
  final String content;

  Button({required this.onTap, required this.content});
  
  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late VoidCallback act; 
  late String content;

  @override
  void initState() {
    super.initState();
    act = widget.onTap;
    content = widget.content;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: act,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                color: colours.sec,
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: [
                  BoxShadow(
                    color: colours.sec.withOpacity(_animation.value),
                    blurRadius: 5 * _animation.value,
                    spreadRadius: 3 * _animation.value,
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              child: Center(
                child: Text(
                  content,
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Txtbutton extends StatefulWidget {
  
  final VoidCallback onTap;
  final String content;

  Txtbutton({required this.onTap, required this.content});

  @override
  State<Txtbutton> createState() => _TxtbuttonState();
}

class _TxtbuttonState extends State<Txtbutton> {
  late VoidCallback act;
  late String content;
  @override
  void initState() {
    super.initState();
    act = widget.onTap;
    content = widget.content;
  }
  @override
  Widget build(BuildContext context) {
    return TextButton(
              onPressed: act,
              child: Text(content,
                style: TextStyle(
                  color: colours.sec,
                  decoration: TextDecoration.underline, decorationColor: colours.sec
                ),
              ),
            );
  }
}