import 'package:flutter/material.dart';
import 'package:test_app/services.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  static String id = 'second_screen';

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _updateList = TextEditingController();
  List<User> toAdd = [];

  _addToList(value) {
    setState(() {
      toAdd.add(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SECOND SCREEN')),
      body: Container(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _updateList,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addToList(_updateList.value);
        },
        tooltip: 'ADD',
        child: Icon(Icons.add),
      ),
    );
  }
}
