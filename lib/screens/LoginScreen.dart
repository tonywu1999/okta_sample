import 'package:flutter/material.dart';
import 'package:phoenix/providers/OktaProvider.dart';
import 'package:phoenix/screens/SplashScreen.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: ElevatedButton(
            onPressed: () async {
              await AuthProvider.of(context).authService.authorize();
              Navigator.of(context).pushNamed(SplashScreen.routeName);
            },
            child: Text('Authorize'),
          ),
        ),
      ),
    );
  }
}
