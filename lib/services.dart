import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Services {
  Future getData() async {
    const url = 'https://jsonplaceholder.typicode.com/users/';

    var parsedUrl = Uri.parse(url);
    var response = await http.get(parsedUrl);

    if (response.statusCode == 200) {
      Iterable body = jsonDecode(response.body);
      List<User> todoList = [];

      for (var t in body) {
        User todo = User(t["id"], t["name"], t["username"], t["email"]);
        todoList.add(todo);
      }
      return todoList;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}

class User {
  final int id;
  final String name;
  final String email;
  final String username;

  User(this.id, this.name, this.username, this.email);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(json['id'], json['name'], json['username'], json['email']);
  }
}
