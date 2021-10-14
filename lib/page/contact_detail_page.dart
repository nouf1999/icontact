import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';
import 'package:icontact/db/contact_database.dart';
import 'package:icontact/model/contact.dart';
import 'package:intl/intl.dart';

import 'edit_contact_page.dart';

class ContactDetailPage extends StatefulWidget {
  final int contactId;

  const ContactDetailPage({
    Key? key,
    required this.contactId,
  }) : super(key: key);

  @override
  _ContactDetailPageState createState() => _ContactDetailPageState();
}

class _ContactDetailPageState extends State<ContactDetailPage> {
  late Contact contact;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshContact();
  }

  Future refreshContact() async {
    setState(() => isLoading = true);

    contact = await ContactsDatabase.instance.readContact(widget.contactId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [editButton(), deleteButton()],
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(12),
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: [
                    const SizedBox(height: 8),
                    ContactUs(
                      cardColor: Colors.white,
                      textColor: Colors.teal
                          .shade900, // logo: AssetImage("images/icon.png"),
                      email: contact.emailAddress,
                      companyName: contact.firstName,
                      companyColor: Colors.blue,
                      dividerThickness: 2,
                      phoneNumber: contact.phoneNumber,
                      // website: 'https://abhishekdoshi.godaddysites.com',
                      // githubUserName: 'AbhishekDoshi26',
                      //  linkedinURL:
                      //      'https://www.linkedin.com/in/abhishek-doshi-520983199/',
                      tagLine: contact.lastName,
                      taglineColor: Colors.blue,
                      //  twitterHandle: 'AbhishekDoshi26',
                      //  instagram: '_abhishek_doshi',
                      // facebookHandle: 'lazone'
                    ),
                  ],
                ),
              ),
      );

  Widget editButton() => IconButton(
      icon: const Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditContactPage(contact: contact),
        ));

        refreshContact();
      });

  Widget deleteButton() => IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () async {
          await ContactsDatabase.instance.delete(widget.contactId);

          Navigator.of(context).pop();
        },
      );
}
