import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/common/error.dart';
import 'package:whatsapp_ui/common/widgets/loader.dart';
import 'package:whatsapp_ui/features/select_contacts/controller/select_contact_controller.dart';

class SelectContactsScreen extends ConsumerWidget {
  const SelectContactsScreen({super.key});
  static const String routeName = '/select-contacts';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Contacts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: ref.watch(getContactsProvider).when(
            data: (contactsList) => ListView.builder(
                itemCount: contactsList.length,
                itemBuilder: (context, index) {
                  final contact = contactsList[index];
                  return ListTile(
                    title: Text(contact.displayName),
                    leading: contact.photo == null
                        ? CircleAvatar(
                            child: Text(contact.displayName[0]),
                            radius: 30,
                          )
                        : CircleAvatar(
                            backgroundImage: MemoryImage(contact.photo!),
                            radius: 30,
                          ),
                  );
                }),
            error: (err, trace) => ErrorScreen(
              error: err.toString(),
            ),
            loading: () => const Loader(),
          ),
    );
  }
}
