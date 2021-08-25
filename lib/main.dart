import 'package:flutter/material.dart';
import 'package:test_app/second_screen.dart';
import 'package:test_app/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.blueGrey,
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: MyHomePage.id,
      routes: {
        MyHomePage.id: (context) => MyHomePage(title: 'TEST APP'),
        SecondScreen.id: (context) => SecondScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  static String id = 'my_home_page';

  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<User>> _getAll() async {
    var data = await Services().getData();
    return data;
  }

  @override
  void initState() {
    _getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Hero(
        tag: 'asd',
        child: Container(
          child: Card(
            child: FutureBuilder<List<User>>(
              future: _getAll(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data!.isNotEmpty) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, i) {
                      return Card(
                        color: Colors.blueGrey[900],
                        margin: EdgeInsets.all(10),
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: Row(
                          children: [
                            DataWidget(
                              data: '${snapshot.data![i].name}',
                            ),
                            DataWidget(
                              data: "${snapshot.data![i].email}",
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Container(child: Text("NO DATA FETCHED"));
                }
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, SecondScreen.id);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class DataWidget extends StatelessWidget {
  DataWidget({Key? key, required this.data});

  final String data;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {},
        child: Container(
          margin: EdgeInsets.all(15),
          child: Text(
            data,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          decoration: BoxDecoration(
            // color: Colors.blueGrey[900],
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
