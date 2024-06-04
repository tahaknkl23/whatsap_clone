import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/common/utils/utils.dart';
import 'package:whatsapp_ui/features/auth/screens/otp_screen.dart';
import 'package:whatsapp_ui/features/auth/screens/user_information_screen.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
      auth: FirebaseAuth.instance,
      firestore: FirebaseFirestore.instance,
    ));

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRepository({required this.auth, required this.firestore});

  void signInWithPhoneNumber(BuildContext context, String phoneNumber) {
    try {
      //burda şunu yapıyoruz eğer kullanıcı telefon numarasını doğrulamışsa direk giriş yapmasını sağlıyoruz

      auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential); //credential ile giriş yap
        },
        verificationFailed: (e) {
          throw Exception(e.message);
        },
        codeSent: (String verificationId, int? resendToken) async {
          Navigator.pushNamed(context, OTPScreen.routeName, arguments: verificationId); //otp ekranına git
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          showSnackBar(context: context, content: 'Timeout'); //zaman aşımı mesajını göster
        },
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message!);
    }
  }

  void verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String userOTP,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOTP,
      );
      await auth.signInWithCredential(credential);
      Navigator.pushNamedAndRemoveUntil(context, UserInformationScreen.routeName, (route) => false);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message!);
    }
  }
}
