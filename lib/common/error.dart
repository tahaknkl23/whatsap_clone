// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    Key? key,
    required this.error,
  }) : super(key: key);
  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        error,
        style: const TextStyle(
          fontSize: 24,
          color: Colors.red,
        ),
      ),
    );
  }
}
