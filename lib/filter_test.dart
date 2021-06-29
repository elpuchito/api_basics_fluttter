import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

// This holds a list of fiction users
// You can use data fetched from a database or cloud as well
// final List<Map<String, dynamic>> _allUsers = [
//   {"id": 1, "name": "Andy", "age": 29},
//   {"id": 2, "name": "Aragon", "age": 40},
//   {"id": 3, "name": "Bob", "age": 5},
//   {"id": 4, "name": "Barbara", "age": 35},
//   {"id": 5, "name": "Candy", "age": 21},
//   {"id": 6, "name": "Colin", "age": 55},
//   {"id": 7, "name": "Audra", "age": 30},
//   {"id": 8, "name": "Banana", "age": 14},
//   {"id": 9, "name": "Caversky", "age": 100},
//   {"id": 10, "name": "Becky", "age": 32},
// ];

class User1 {
  int id;
  String username;
  String name;
  String phone;
  String email;

  User1(
      {required this.name,
      required this.phone,
      required this.id,
      required this.username,
      required this.email});

  factory User1.fromJson(Map<String, dynamic> json) {
    return User1(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
    );
  }
}

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  List<User1> _allUsers = <User1>[];
  List<User1> _foundUsers = <User1>[];
  Future<List<User1>> fetchUsers() async {
    List<User1> users = <User1>[];

    final res =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (res.statusCode == 200) {
      final jsonData = jsonDecode(res.body);
      jsonData.forEach((json) => {users.add(User1.fromJson(json))});
    } else {
      throw Exception('failed to load users');
    }
    return users;
  }

  // This list holds the data for the list view

  @override
  initState() {
    fetchUsers().then((value) => setState(() {
          _allUsers.addAll(value);
          _foundUsers = _allUsers;
        }));
    // at the beginning, all users are shown

    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<User1> results = <User1>[];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
              user.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('filter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: _foundUsers.length > 0
                  ? ListView.builder(
                      itemCount: _foundUsers.length,
                      itemBuilder: (context, index) => Card(
                        key: ValueKey(_foundUsers[index].id),
                        color: Colors.amberAccent,
                        elevation: 4,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          leading: Text(
                            _foundUsers[index].id.toString(),
                            style: TextStyle(fontSize: 24),
                          ),
                          title: Text(_foundUsers[index].name),
                          subtitle: Text(
                              'username is ${_foundUsers[index].username}'),
                        ),
                      ),
                    )
                  : Text(
                      'No results found',
                      style: TextStyle(fontSize: 24),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
