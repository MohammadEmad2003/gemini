import 'package:flutter/material.dart';
import 'Colors.dart';
import 'button.dart';
import 'regScreen.dart';
import 'loginScreen.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(alignment: Alignment.center,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 800), // Set max width for content
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.all(30),
                sliver: SliverToBoxAdapter(
                  child: Image.asset('assets/Welcome.png'),
                ),
              ),
              const SliverPadding(
                padding: EdgeInsets.only(bottom: 10),
                sliver: SliverAppBar(
                  expandedHeight: 60,
                  title: Center(child: Text('Welcome Back', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30),)),
                  backgroundColor: colours.prim,
                  pinned: true,
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.all(20),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 20), // Spacing between buttons
                      Button(
                        onTap: () {
                          Navigator.of(context).push(
                            _createRoute(LoginScreen()),
                          );
                        },
                        content: 'Sign in',
                      ),
                        Button(
                        onTap: () {
                          Navigator.of(context).push(
                            _createRoute(RegScreen()),
                          );
                        },
                        content: 'Sign Up',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
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

