import 'package:flutter/material.dart';
import 'package:whatsapp_ui/common/error.dart';
import 'package:whatsapp_ui/features/auth/screens/login_screen.dart';

MaterialPageRoute generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (context) => const LoginScreen());

    default:
      return MaterialPageRoute(
          builder: (context) => const Scaffold(
                body: ErrorScreen(error: "This page doesn't exist"),
              ));
  }
}
