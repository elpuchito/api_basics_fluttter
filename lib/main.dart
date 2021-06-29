import 'dart:convert';
import 'package:api_basics/datatable.dart';
import 'package:api_basics/filter_test.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'grid_test.dart';
import 'model.dart';

//static dummy data
var posts = [
  {
    'userId': 1,
    'body':
        "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
  },
  {
    'userId': 2,
    'body':
        "sads asas asass it\nsuscgfdgfdgfd gfdgfdgf dfdfdf edita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
  }
];

var users = [
  {
    'id': 1,
    'name': 'oscra',
    'phone': '76786778989',
    'email': 'oscar@gmail.com'
  },
  {
    'id': 2,
    'name': 'dario',
    'phone': '45454354589',
    'email': 'dario@gmail.com'
  },
];

void main() {
  runApp(const MyApp());
}

// Future<dynamic> fetchAlbum(http.Client client) async {
//   final response = await client
//       .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
//   if (response.statusCode == 200) {
//     return jsonDecode(response.body) as Map<String, dynamic>;
//   } else {
//     throw Exception('failed to fetch album');
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyStatelessWidget());
  }
}

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<User> _allUsers = <User>[];
  List<User> _shownUsers = <User>[];

  Future<List<User>> fetchUsers() async {
    List<User> users = <User>[];

    final res =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (res.statusCode == 200) {
      final jsonData = jsonDecode(res.body);
      jsonData.forEach((json) => {users.add(User.fromJson(json))});
    } else {
      throw Exception('failed to load users');
    }
    return users;
  }

  initState() {
    super.initState();

    fetchUsers().then((value) => setState(() {
          _allUsers.addAll(value);
          _shownUsers = _allUsers;
        }));
  }

  void _runFilter(String enteredKeyword) {
    List<User> results = <User>[];
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
      _shownUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    //static example
    // return Scaffold(
    //   body: ListView.builder(
    //       itemCount: users.length,
    //       itemBuilder: (BuildContext context, index) {
    //         return Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: CustomCard(
    //               title: users[index]['name'].toString(),
    //               subtitle1: users[index]['phone'].toString(),
    //               subtitle2: users[index]['email'].toString(),
    //             ));
    //       }),
    // );
    //UI withoursearchbar example
    // return Scaffold(
    //     body: FutureBuilder<dynamic>(
    //         future: fetchUsers(),
    //         builder: (context, snapshot) {
    //           if (snapshot.hasData) {
    //             return ListView.builder(
    //                 itemCount: snapshot.data.length,
    //                 itemBuilder: (BuildContext context, index) {
    //                   // final userId = snapshot.data[index]['id'];
    //                   return Padding(
    //                     padding: EdgeInsets.all(8),
    //                     child: CustomCard(
    //                       onPressed: () {
    //                         Navigator.push(
    //                             context,
    //                             MaterialPageRoute(
    //                                 builder: (context) => PostPage(
    //                                       userId: snapshot.data[index]['id'],
    //                                     )));
    //                       },
    //                       title: snapshot.data[index]['name'],
    //                       subtitle1: snapshot.data[index]['phone'],
    //                       subtitle2: snapshot.data[index]['email'],
    //                     ),
    //                   );
    //                 });
    //           } else if (snapshot.hasError) {
    //             return Text("${snapshot.error}");
    //           }

    //           // By default, show a loading spinner.
    //           return CircularProgressIndicator();
    //         }));
//UI with filter search
    return Scaffold(
      appBar: AppBar(
        title: Text('prueba de ingreso'),
        leading: Text(''),
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
              child: _shownUsers.length > 0
                  ? ListView.builder(
                      itemCount: _shownUsers.length,
                      itemBuilder: (BuildContext context, index) {
                        return Padding(
                          padding: EdgeInsets.all(8),
                          child: CustomCard(
                            key: ValueKey(_shownUsers[index].id),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PostPage(
                                            userId: _shownUsers[index].id,
                                          )));
                            },
                            title: _shownUsers[index].name,
                            subtitle1: _shownUsers[index].phone,
                            subtitle2: _shownUsers[index].email,
                          ),
                        );
                      })
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

class PostPage extends StatefulWidget {
  final int userId;
  const PostPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future fetchPosts() async {
    final res = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/posts?userId=${widget.userId}'));
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception('failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    //static example
    // return Scaffold(
    //   body: ListView.builder(
    //       itemCount: 1,
    //       itemBuilder: (BuildContext context, index) {
    //         return Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             // child: ListTile(
    //             //   title: Text(arr[index]),
    //             //   subtitle: Text('wahtever'),
    //             // ),
    //             child: ListTile(
    //               title: userId == 1
    //                   ? Text(posts[index]['body'].toString())
    //                   : Text('no posts found'),
    //             ));
    //       }),
    // );
    return Scaffold(
        appBar: AppBar(
          title: Text('Posts'),
        ),
        body: FutureBuilder<dynamic>(
            future: fetchPosts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Text('user ID is: ${widget.userId}'),
                    Expanded(
                      child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (BuildContext context, index) {
                            return Padding(
                              padding: EdgeInsets.all(8),
                              child: ListTile(
                                title: Text(snapshot.data[index]['title']),
                                subtitle: Text(snapshot.data[index]['body']),
                              ),
                            );
                          }),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return Center(child: CircularProgressIndicator());
            }));
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.title,
    required this.subtitle1,
    required this.subtitle2,
    required this.onPressed,
  }) : super(key: key);
  final String title;
  final String subtitle1;
  final String subtitle2;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        // color: Colors.red,
        padding: EdgeInsets.all(10),
        height: 200,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //personal data column
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                Row(
                  children: [
                    Icon(Icons.phone),
                    Text(
                      subtitle1,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    )
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.email),
                    Text(
                      subtitle2,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    )
                  ],
                ),
              ],
            ),
            //ver publicaiones column
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              TextButton(
                onPressed: onPressed,
                child: Text('VER PUBLICACIONES'),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
