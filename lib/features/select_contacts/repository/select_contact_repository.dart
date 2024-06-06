import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final SelectContactRepositoryProvider = Provider(
  (ref) => SelectContactRepository(
    firestore: FirebaseFirestore.instance,
  ),
);

//burda şu işlemi yapıyoruz ki uygulama açıldığında kullanıcıdan izin istesin ve rehberi getirsin
class SelectContactRepository {
  final FirebaseFirestore firestore;
  SelectContactRepository({
    required this.firestore,
  });

//burda rehberi getirme işlemini yapıyoruz
  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = [];
    try {
      if (await FlutterContacts.requestPermission()) {
        await FlutterContacts.getContacts(
          withProperties: true,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return contacts;
  }
}
