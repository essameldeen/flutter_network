import 'package:flutter_network/model/Todo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Apis {
  static Future<Todo> getPostById() async {
    http.Response post = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));
    if (post.statusCode == 200) {
      return Todo.fromJson(json.decode(post.body));
    } else {
      throw Exception("Error Happen in Server !");
    }
  }

  static Future<Todo> postTodo(Todo todo) async {
    http.Response response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/todos'),
        headers: <String, String>{
          'Content-type': 'application/json;charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'title': todo.title,
          'userId': todo.userId,
          'completed': todo.completed
        }));


    if (response.statusCode == 201) {
      return Todo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error Happen in Server !");
    }
  }
}
