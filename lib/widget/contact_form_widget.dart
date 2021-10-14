import 'package:flutter/material.dart';

class ContactFormWidget extends StatelessWidget {
  final bool? isImportant;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? emailAddress;
  final ValueChanged<bool> onChangedImportant;
  final ValueChanged<String> onChangedfirstName;
  final ValueChanged<String> onChangedlastName;
  final ValueChanged<String> onChangedphoneNumber;
  final ValueChanged<String> onChangedemailAddresss;

  const ContactFormWidget({
    Key? key,
    this.isImportant = false,
    this.firstName = '',
    this.lastName = '',
    this.phoneNumber = '',
    this.emailAddress = '',
    required this.onChangedImportant,
    required this.onChangedfirstName,
    required this.onChangedlastName,
    required this.onChangedphoneNumber,
    required this.onChangedemailAddresss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Switch(
                    value: isImportant ?? false,
                    onChanged: onChangedImportant,
                  ),
                  /* Expanded(
                    child: Slider(
                      value: (number ?? 0).toDouble(),
                      min: 0,
                      max: 5,
                      divisions: 5,
                      onChanged: (number) => onChangedNumber(number.toInt()),
                    ),
                  ) */
                ],
              ),
              buildfirstName(),
              const SizedBox(height: 16),
              buildlasstName(),
              const SizedBox(height: 16),
              buildphoneNumber(),
              const SizedBox(height: 16),
              buildemailAddress(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      );

  Widget buildfirstName() => TextFormField(
        maxLines: 1,
        initialValue: firstName,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'First Name',
          hintStyle: TextStyle(color: Colors.black),
        ),
        validator: (firstName) => firstName != null && firstName.isEmpty
            ? 'The First Name cannot be empty'
            : null,
        onChanged: onChangedfirstName,
      );
  Widget buildlasstName() => TextFormField(
        maxLines: 1,
        initialValue: lastName,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Last Name',
          hintStyle: TextStyle(color: Colors.black),
        ),
        validator: (lastName) => lastName != null && lastName.isEmpty
            ? 'The Last name cannot be empty'
            : null,
        onChanged: onChangedlastName,
      );
  Widget buildphoneNumber() => TextFormField(
        maxLines: 1,
        initialValue: phoneNumber,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Phone Number',
          hintStyle: TextStyle(color: Colors.black),
        ),
        validator: (phoneNumber) => phoneNumber != null && phoneNumber.isEmpty
            ? 'The phone number cannot be empty'
            : null,
        onChanged: onChangedphoneNumber,
      );
  Widget buildemailAddress() => TextFormField(
        maxLines: 1,
        initialValue: emailAddress,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Email Address',
          hintStyle: TextStyle(color: Colors.black),
        ),
        validator: (emailAddress) =>
            emailAddress != null && emailAddress.isEmpty
                ? 'The email cannot be empty'
                : null,
        onChanged: onChangedemailAddresss,
      );
}
