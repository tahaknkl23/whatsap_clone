// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:whatsapp_ui/features/select_contacts/repository/select_contact_repository.dart';

//burda rehberi getirme işlemini yapıyoruz
final getContactsProvider = FutureProvider(
  (ref) {
    final selectContactRepository = ref.watch(SelectContactRepositoryProvider);
    return selectContactRepository.getContacts();
  },
);

final selectContactControllerProvider = Provider((ref) {
  final selectContactRepository = ref.watch(SelectContactRepositoryProvider);
  return SelecContactController(
    ref: ref,
    selectContactRepository: selectContactRepository,
  );
});

class SelecContactController {
  final ProviderRef ref;
  final SelectContactRepository selectContactRepository;
  SelecContactController({
    required this.ref,
    required this.selectContactRepository,
  });

  void selectContact(Contact selectedContact, BuildContext context) {
    selectContactRepository.selectContact(selectedContact, context);
  }
}
