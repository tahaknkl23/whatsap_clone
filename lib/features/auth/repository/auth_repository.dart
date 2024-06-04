import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/common/repositories/common_firebase_storage_repository.dart';
import 'package:whatsapp_ui/common/utils/utils.dart';
import 'package:whatsapp_ui/features/auth/screens/otp_screen.dart';
import 'package:whatsapp_ui/features/auth/screens/user_information_screen.dart';
import 'package:whatsapp_ui/models/user_model.dart';

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
      auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          throw Exception(e.message);
        },
        codeSent: (String verificationId, int? resendToken) async {
          Navigator.pushNamed(context, OTPScreen.routeName, arguments: verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          showSnackBar(context: context, content: 'Timeout');
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

  void saveUserDataFirebase({
    required String name,
    required File? profilePic,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    try {
      String uid = auth.currentUser!.uid;
      String photoUrl =
          'https://kajabi-storefronts-production.kajabi-cdn.com/kajabi-storefronts-production/file-uploads/themes/2154243091/settings_images/253c35-346-1eaa-0760-2cdf6c13af_312a66d1-b14c-4d2a-a3f5-210283ca3a00.png';
      if (profilePic != null) {
        photoUrl = await ref.read(commonFirebaseStorageRepositoryProvider).storeFileToFirebase('profile_pics/$uid', profilePic);
      }
      await firestore.collection('users').doc(uid).set({
        'name': name,
        'photoUrl': photoUrl,
        'uid': uid,
      });

      var user = UserModel(
        name: name,
        uid: uid,
        profilePic: photoUrl,
        isOnline: true,
        phoneNumber: auth.currentUser!.uid,
        groupId: [],
      );
      await firestore.collection('users').doc(uid).set(user.toMap()); // burda user'ı firebase'e kaydediyoruz
      Navigator.pushNamedAndRemoveUntil(context, UserInformationScreen.routeName, (route) => false);
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
