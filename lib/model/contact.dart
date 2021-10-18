import 'package:icontact/db/database_provider.dart';

class Contact {
  int? id = 0;
  String name = '';
  String phone = '(+226)';
  String email = '';
  String location = '';
  String avatar = '';
  int favorite = 0;

  Contact(
      this.id, this.name, this.phone, this.email, this.location, this.avatar);

  Contact.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    name = map["name"];
    phone = map["phone"];
    email = map["email"];
    location = map["location"];
    avatar = map["avatar"];
    favorite = map["favorite"];
  }

  Map<String, dynamic> toMap() {
    return {
      DatabaseProvider.columnId: id,
      DatabaseProvider.columnName: name,
      DatabaseProvider.columnPhone: phone,
      DatabaseProvider.columnEmail: email,
      DatabaseProvider.columnLocation: location,
      DatabaseProvider.columnAvatar: avatar,
      DatabaseProvider.columnFavorite: favorite
    };
  }
}
