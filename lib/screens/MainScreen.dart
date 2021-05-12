import 'package:flutter/material.dart';
import 'package:phoenix/providers/OktaProvider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'dart:convert';

class MainScreen extends StatelessWidget {
  static const routeName = '/main';

  parseUser(Map<String, dynamic> json) {
    return json['name'] as String;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RaisedButton(
                onPressed: () async {
                  var userJson =
                      await AuthProvider.of(context).authService.getUser();
                  print(userJson);
                  Map<String, dynamic> user = jsonDecode(userJson);

                  Fluttertoast.showToast(msg: "Usuário: ${user['name']}");
                },
                child: const Text('GetUser', style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(height: 30),
              RaisedButton(
                onPressed: () async {
                  await AuthProvider.of(context).authService.logout();
                  await AuthProvider.of(context).authService.revokeAccessToken();
                  await AuthProvider.of(context).authService.revokeRefreshToken();
                  Navigator.of(context).pushReplacementNamed('/login');
                },
                child: const Text('Logout', style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(height: 30),
              RaisedButton(
                onPressed: () async {
                  var isAuthenticated = await AuthProvider.of(context)
                      .authService
                      .isAuthenticated();
                  Fluttertoast.showToast(
                      msg: "isAuthenticated: ${isAuthenticated.toString()}");
                },
                child: const Text('IsAuthenticated',
                    style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(height: 30),
              RaisedButton(
                onPressed: () async {
                  var accessToken = await AuthProvider.of(context)
                      .authService
                      .getAccessToken();
                  Fluttertoast.showToast(msg: "AccessToken: $accessToken");
                  print(accessToken);
                },
                child: const Text('GetAccessToken',
                    style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(height: 30),
              RaisedButton(
                onPressed: () async {
                  var idToken =
                      await AuthProvider.of(context).authService.getIdToken();
                  Fluttertoast.showToast(msg: "idToken: $idToken");
                },
                child: const Text('GetIdToken', style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(height: 30),
              RaisedButton(
                onPressed: () async {
                  var result = await AuthProvider.of(context)
                      .authService
                      .refreshTokens();
                  Fluttertoast.showToast(msg: "refreshTokens: $result");
                },
                child:
                    const Text('refreshTokens', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}