import 'package:flutter/material.dart';
import 'package:icontact/db/contact_database.dart';
import 'package:icontact/model/contact.dart';
import 'package:icontact/widget/contact_form_widget.dart';

class AddEditContactPage extends StatefulWidget {
  final Contact? contact;

  const AddEditContactPage({
    Key? key,
    this.contact,
  }) : super(key: key);
  @override
  _AddEditContactPageState createState() => _AddEditContactPageState();
}

class _AddEditContactPageState extends State<AddEditContactPage> {
  final _formKey = GlobalKey<FormState>();
  late bool isImportant;
  late String firstName;
  late String lastName;
  late String phoneNumber;
  late String emailAddress;

  @override
  void initState() {
    super.initState();

    isImportant = widget.contact?.isImportant ?? false;
    firstName = widget.contact?.firstName ?? '';
    lastName = widget.contact?.lastName ?? '';
    phoneNumber = widget.contact?.phoneNumber ?? '';
    emailAddress = widget.contact?.emailAddress ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [buildButton()],
        ),
        body: Form(
          key: _formKey,
          child: ContactFormWidget(
            isImportant: isImportant,
            firstName: firstName,
            lastName: lastName,
            phoneNumber: phoneNumber,
            emailAddress: emailAddress,
            onChangedImportant: (isImportant) =>
                setState(() => this.isImportant = isImportant),
            onChangedfirstName: (firstName) =>
                setState(() => this.firstName = firstName),
            onChangedlastName: (lastName) =>
                setState(() => this.lastName = lastName),
            onChangedphoneNumber: (phoneNumber) =>
                setState(() => this.phoneNumber = phoneNumber),
            onChangedemailAddresss: (emailAddress) =>
                setState(() => this.emailAddress = emailAddress),
          ),
        ),
      );

  Widget buildButton() {
    final isFormValid = firstName.isNotEmpty && emailAddress.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateContact,
        child: const Text('Save'),
      ),
    );
  }

  void addOrUpdateContact() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.contact != null;

      if (isUpdating) {
        await updateContact();
      } else {
        await addContact();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateContact() async {
    final contact = widget.contact!.copy(
      isImportant: isImportant,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      emailAddress: emailAddress,
    );

    await ContactsDatabase.instance.update(contact);
  }

  Future addContact() async {
    final contact = Contact(
      isImportant: true,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      emailAddress: emailAddress,
      createdTime: DateTime.now(),
    );

    await ContactsDatabase.instance.create(contact);
  }
}
