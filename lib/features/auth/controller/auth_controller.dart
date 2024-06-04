// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/features/auth/repository/auth_repository.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository);
});

class AuthController {
  final AuthRepository authRepository;
  AuthController({
    required this.authRepository,
  });

  void signInWithPhoneNumber(BuildContext context, String phoneNumber) {
    authRepository.signInWithPhoneNumber(context, phoneNumber);
  }

  void verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String userOTP,
  }) async {
    authRepository.verifyOTP(context: context, verificationId: verificationId, userOTP: userOTP);
  }
}
