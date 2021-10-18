import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:contactus/contactus.dart';

import 'package:flutter/material.dart';

import 'package:icontact/page/add_contact_page.dart';
import 'package:icontact/model/contact.dart';
import 'package:icontact/db/database_provider.dart';

class DisplayContactPage extends StatefulWidget {
  const DisplayContactPage({Key? key, required this.contact}) : super(key: key);
  final Contact contact;

  @override
  State<DisplayContactPage> createState() =>
      // ignore: no_logic_in_create_state
      _DisplayContactPageState(contact: contact);
}

class _DisplayContactPageState extends State<DisplayContactPage> {
  _DisplayContactPageState({required this.contact});
  final Contact contact;
  final dbProvider = DatabaseProvider.instance;

  void _addToFavorite(Contact contact) async {
    await dbProvider.addToFavorite(contact);
    Navigator.of(context).pop();
  }

  void _delete(int id) async {
    await dbProvider.delete(id);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("iContact"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(
                  top: 20.0,
                ),
                height: 300.0,
                color: Colors.indigo,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black, blurRadius: 5.0)
                    ],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Image.asset("assets/person.png"),
                      Container(
                        margin: const EdgeInsets.only(right: 20.0),
                        width: 20.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.max,
                          children: <IconButton>[
                            IconButton(
                                onPressed: () => {},
                                icon: const Icon(Icons.call)),
                            IconButton(
                                onPressed: () => {},
                                icon: const Icon(Icons.mail)),
                            IconButton(
                                onPressed: () => {_addToFavorite(contact)},
                                icon: const Icon(Icons.star)),
                            IconButton(
                                onPressed: () => {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (_) => AddContactPage(
                                                    contact: contact,
                                                    title: 'Modifier',
                                                  )))
                                    },
                                icon: const Icon(Icons.edit)),
                            IconButton(
                                onPressed: () async {
                                  if (await confirm(
                                    context,
                                    title: const Text('Delete'),
                                    content:
                                        const Text('Delete this contact ?'),
                                    textOK: const Text('Yes'),
                                    textCancel: const Text('No'),
                                  )) {
                                    _delete(contact.id!);
                                  }
                                },
                                icon: const Icon(Icons.delete))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 50.0),
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  contact.name,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              ContactUs(
                cardColor: Colors.white,
                textColor: Colors.teal.shade900,
                email: contact.email,
                companyName: "",
                companyColor: Colors.blue,
                dividerThickness: 0,
                phoneNumber: contact.phone,
                tagLine: contact.location,
                taglineColor: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
