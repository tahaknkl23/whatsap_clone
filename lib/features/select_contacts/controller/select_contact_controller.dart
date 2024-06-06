import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/features/select_contacts/repository/select_contact_repository.dart';

//burda rehberi getirme işlemini yapıyoruz
final getContactsProvider = FutureProvider(
  (ref) {
    final selectContactRepository = ref.watch(SelectContactRepositoryProvider);
    return selectContactRepository.getContacts();
  },
);
