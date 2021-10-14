// ignore_for_file: prefer_const_declarations

const String tableContacts = 'contact';

class ContactFields {
  static final List<String> values = [
    /// Add all fields
    id, isImportant, firstName, lastName, phoneNumber, emailAddress, time
  ];

  static final String id = '_id';
  static final String isImportant = 'isImportant';
  static final String firstName = 'firstName';
  static final String lastName = 'lastName';

  static final String phoneNumber = 'phoneNumber';
  static final String emailAddress = 'emailAddress';
  static final String time = 'time';
}

class Contact {
  final int? id;
  final bool isImportant;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String emailAddress;
  final DateTime createdTime;

  const Contact({
    this.id,
    required this.isImportant,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.emailAddress,
    required this.createdTime,
  });

  Contact copy({
    int? id,
    bool? isImportant,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? emailAddress,
    DateTime? createdTime,
  }) =>
      Contact(
        id: id ?? this.id,
        isImportant: isImportant ?? this.isImportant,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        emailAddress: emailAddress ?? this.emailAddress,
        createdTime: createdTime ?? this.createdTime,
      );

  static Contact fromJson(Map<String, Object?> json) => Contact(
        id: json[ContactFields.id] as int?,
        isImportant: json[ContactFields.isImportant] == 1,
        firstName: json[ContactFields.firstName] as String,
        lastName: json[ContactFields.lastName] as String,
        phoneNumber: json[ContactFields.phoneNumber] as String,
        emailAddress: json[ContactFields.emailAddress] as String,
        createdTime: DateTime.parse(json[ContactFields.time] as String),
      );

  Map<String, Object?> toJson() => {
        ContactFields.id: id,
        ContactFields.isImportant: isImportant ? 1 : 0,
        ContactFields.firstName: firstName,
        ContactFields.lastName: lastName,
        ContactFields.phoneNumber: phoneNumber,
        ContactFields.emailAddress: emailAddress,
        ContactFields.time: createdTime.toIso8601String(),
      };
}
