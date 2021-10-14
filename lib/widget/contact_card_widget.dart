import 'package:flutter/material.dart';
import 'package:icontact/model/contact.dart';
import 'package:intl/intl.dart';

final _lightColors = [
  Colors.amber.shade300,
  Colors.lightGreen.shade300,
  Colors.lightBlue.shade300,
  Colors.orange.shade300,
  Colors.pinkAccent.shade100,
  Colors.tealAccent.shade100
];

class ContactCardWidget extends StatelessWidget {
  const ContactCardWidget({
    Key? key,
    required this.contact,
    required this.index,
  }) : super(key: key);

  final Contact contact;
  final int index;

  @override
  Widget build(BuildContext context) {
    /// Pick colors from the accent colors based on index
    final color = _lightColors[index % _lightColors.length];
    // ignore: unused_local_variable
    final time = DateFormat.yMMMd().format(contact.createdTime);
    // final minHeight = getMinHeight(index);

    return Card(
      color: color,
      child: Container(
        //constraints: BoxConstraints(minHeight: minHeight),
        padding: const EdgeInsets.all(0),
        child: Column(
          //  mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: ListTile(
                leading: SizedBox(
                  child: Image.asset(
                    "images/icon.png",
                  ),
                ),
                title: Text(contact.firstName),
                subtitle: Text(contact.lastName),
                /*   onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Scaffold(
                                body: LivreDetail(livre),
                              ),
                            ),
                          ), */
              ),
            ),

/* 
            Text(
              contact.firstName,
              style: TextStyle(color: Colors.grey.shade700),
            ),
            const SizedBox(height: 4),
            Text(
              contact.lastName,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),*/
          ],
        ),
      ),
    );
  }

  /// To return different height for different widgets
  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 150;
      case 2:
        return 150;
      case 3:
        return 100;
      default:
        return 100;
    }
  }
}
