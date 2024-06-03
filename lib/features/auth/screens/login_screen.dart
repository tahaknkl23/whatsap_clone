import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:whatsapp_ui/colors.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter your phone number'),
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: Column(
        children: [
          const Text("WhatsApp will need to verify your phone number"),
          TextButton(onPressed: () {}, child: const Text("Pick country")),
          const TextField(
            decoration: InputDecoration(
              hintText: "Phone number",
            ),
          ),
        ],
      ),
    );
  }
}
