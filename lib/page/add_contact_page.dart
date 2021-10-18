import 'package:flutter/material.dart';
import 'package:icontact/model/contact.dart';
import 'package:icontact/db/database_provider.dart';
import 'package:image_picker/image_picker.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({Key? key, required this.title, this.contact})
      : super(key: key);
  final String title;
  final Contact? contact;

  @override
  State<AddContactPage> createState() =>
      // ignore: no_logic_in_create_state
      _AddContactPageState(title: title, contact: contact);
}

class _AddContactPageState extends State<AddContactPage> {
  _AddContactPageState({this.contact, required this.title}) {
    if (contact != null) {
      nameController.value = TextEditingValue(text: contact!.name);
      phoneController.value = TextEditingValue(text: contact!.phone);
      emailController.value = TextEditingValue(text: contact!.email);
      locationController.value = TextEditingValue(text: contact!.location);
    }
  }
  final Contact? contact;
  final String title;
  final dbProvider = DatabaseProvider.instance;

//controllers used in insert operation UI
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  void _onSave() {
    String name = nameController.text;
    String phone = phoneController.text;
    String email = emailController.text;
    String location = locationController.text;
    if (contact != null) {
      _update(contact!.id, name, phone, email, location, "");
    } else {
      _insert(name, phone, email, location);
    }
    Navigator.of(context).pop();
  }

  void _importImage() async {
    // ignore: unused_local_variable
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(onPressed: _onSave, icon: const Icon(Icons.save)),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 20.0),
                height: 250.0,
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
                    children: [
                      Image.asset("assets/person.png"),
                      Container(
                        margin: const EdgeInsets.only(right: 20.0),
                        width: 15.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            IconButton(
                              onPressed: () => {_importImage()},
                              icon: const Icon(Icons.camera_alt),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 40.0),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    hintText: 'Name',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 40.0),
                child: TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    hintText: 'Phone',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 40.0),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    hintText: 'Email',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 40.0),
                child: TextField(
                  controller: locationController,
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    hintText: 'Location',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _insert(name, phone, email, location) async {
// row to insert
    Map<String, dynamic> row = {
      DatabaseProvider.columnName: name,
      DatabaseProvider.columnPhone: phone,
      DatabaseProvider.columnEmail: email,
      DatabaseProvider.columnLocation: location,
      DatabaseProvider.columnAvatar: "",
      DatabaseProvider.columnFavorite: 0,
    };
    Contact contact = Contact.fromMap(row);
    await dbProvider.insert(contact);
  }

  void _update(id, name, phone, email, location, avatar) async {
    // row to update
    Contact contact = Contact(id, name, phone, email, location, avatar);
    await dbProvider.update(contact);
  }
}
