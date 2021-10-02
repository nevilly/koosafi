import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'model/user_model.dart';

void main() {
  runApp(MyApp());
}

//Future method to hit API
// Future<List<Users>> fetchUsers() async {
//   final response = await http
//       .post(Uri.parse('https://appmwansa.000webhostapp.com/index.php'));
//   print('check me heree...' + response.body);
//   if (response.statusCode == 200) {
//     return Users.fromJson(jsonDecode(response.body));
//   } else {
//     //return error
//     print('check me heree... Not');
//     throw Exception('Failed to load album');
//   }

Future<List<Users>> fetchUsers() async {
  final response = await http
      .post(Uri.parse('https://appmwansa.000webhostapp.com/index.php'));
  print('check me heree...' + response.body);
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);

    return jsonResponse.map((data) => new Users.fromJson(data)).toList();
  } else {
    //return error
    print('check me heree... Not');
    throw Exception('Failed to load album');
  }

  // var url = ('https://appmwansa.000webhostapp.com/index.php');
  // http.Response response = await http
  //     .get(Uri.parse('https://appmwansa.000webhostapp.com/index.php'));
  // var data = jsonDecode(response.body);
  // print(data.toString());

  // return data;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Users>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Json Parsing'),
      ),
      body: Column(
        children: [
          Center(
              child: FutureBuilder<List<Users>>(
            future: futureUsers,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Users>? data = snapshot.data;
                print(data);
                return ListView.builder(
                    itemCount: data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 75,
                        color: Colors.white,
                        child: Center(
                          child: Text(data[index].username),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else {
                return Text('still loading');
              }
            },
          )),
        ],
      ),
    );
  }
}
