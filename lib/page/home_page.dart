import 'package:flutter/material.dart';
import 'package:icontact/page/add_contact_page.dart';
import 'package:icontact/model/contact.dart';
import 'package:icontact/db/database_provider.dart';
import 'package:icontact/page/display_contact_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState() {
    _queryAll(); //Initializing contact list
    _queryFavoriteContacts(); // initializing favorite contact list
  }
  final dbProvider = DatabaseProvider.instance;
  List<Contact> contacts = [];
  List<Contact> contactsBySearch = [];
  List<Contact> favoriteContacts = [];
  int id = 0;
  bool _search = false;
  TextEditingController searchController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () => {
                setState(() {
                  _search = true;
                })
              },
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () => {},
              icon: const Icon(Icons.share),
            ),
          ],
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                icon: Icon(Icons.person),
              ),
              Tab(
                icon: Icon(Icons.star),
              ),
            ],
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              !_search
                  ? IconButton(
                      onPressed: () => {}, icon: const Icon(Icons.menu))
                  : IconButton(
                      onPressed: () => {
                        setState(() {
                          _search = false;
                        })
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
              !_search
                  ? const Text("iContact")
                  : Container(
                      width: MediaQuery.of(context).size.width - 160,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                searchController.value = TextEditingValue.empty;
                              },
                            ),
                            hintText: 'search...',
                            border: InputBorder.none,
                          ),
                          onChanged: (text) {
                            if (text.length >= 2) {
                              setState(() {
                                _query(text);
                              });
                            } else {
                              setState(() {
                                contactsBySearch.clear();
                              });
                            }
                          },
                        ),
                      ),
                    ),
            ],
          ),
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 20.0),
          color: Colors.indigo,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: TabBarView(
              children: [
                ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: contacts.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == contacts.length) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              child: const Text('Refresh'),
                              onPressed: () {
                                setState(() {
                                  _queryAll();
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    }
                    return Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      height: 40,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => DisplayContactPage(
                                    contact: contacts[index],
                                  )));
                        },
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/person.png"),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 5.0),
                                child: Text(
                                  contacts[index].name,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: favoriteContacts.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == favoriteContacts.length) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              child: const Text('Refresh'),
                              onPressed: () {
                                setState(() {
                                  _queryFavoriteContacts();
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    }
                    return Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      height: 40,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => DisplayContactPage(
                                    contact: favoriteContacts[index],
                                  )));
                        },
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/person.png"),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 5.0),
                                child: Text(
                                  favoriteContacts[index].name,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Add new contact',
          onPressed: () => {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => const AddContactPage(title: "Add new contact")))
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _queryAll() async {
    final allRows = await dbProvider.queryAllRows();
    contacts.clear();
    for (var row in allRows) {
      contacts.add(Contact.fromMap(row));
    }
    setState(() {});
  }

  void _query(String text) async {
    final allRows = await dbProvider.queryRows(text);
    contactsBySearch.clear();
    for (var row in allRows) {
      contactsBySearch.add(Contact.fromMap(row));
    }
    setState(() {});
  }

  void _queryFavoriteContacts() async {
    final allRows = await dbProvider.queryFavoriteContacts();
    favoriteContacts.clear();
    for (var row in allRows) {
      favoriteContacts.add(Contact.fromMap(row));
    }
    setState(() {});
  }
}
