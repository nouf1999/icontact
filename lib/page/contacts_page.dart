import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:icontact/db/contact_database.dart';
import 'package:icontact/model/contact.dart';
import 'package:icontact/widget/contact_card_widget.dart';

import 'contact_detail_page.dart';
import 'edit_contact_page.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  late List<Contact> contacts;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshContacts();
  }

  @override
  void dispose() {
    ContactsDatabase.instance.close();

    super.dispose();
  }

  Future refreshContacts() async {
    setState(() => isLoading = true);

    contacts = await ContactsDatabase.instance.readAllContacts();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Contact',
            style: TextStyle(fontSize: 24),
          ),
          actions: const [Icon(Icons.search), SizedBox(width: 12)],
        ),
        body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : contacts.isEmpty
                  ? const Text(
                      'No contacts',
                      style: TextStyle(color: Colors.blue, fontSize: 24),
                    )
                  : buildContacts(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => const AddEditContactPage()),
            );

            refreshContacts();
          },
        ),
      );

  Widget buildContacts() => StaggeredGridView.countBuilder(
        padding: const EdgeInsets.all(8),
        itemCount: contacts.length,
        staggeredTileBuilder: (index) => const StaggeredTile.fit(4),
        crossAxisCount: 4,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        itemBuilder: (context, index) {
          final contact = contacts[index];

          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ContactDetailPage(contactId: contact.id!),
              ));

              refreshContacts();
            },
            child: ContactCardWidget(contact: contact, index: index),
          );
        },
      );
}
