import 'package:flutter/material.dart';
import 'package:flutterapi/Models/todo.dart';
import 'package:flutterapi/Repository/repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TodoRepository implements Repository {
  //use http

  String dataURL = 'https://jsonplaceholder.typicode.com';
  @override
  Future<String> deleteTodo(Todo todo) async {
    // TODO: implement deleteTodo
    var url = Uri.parse('$dataURL/todos/${todo.id}');
    var result = 'false';
    await http.delete(url).then((value) {
      return result = 'true';
    });
    return result;
  }

  @override
  Future<List<Todo>> getTodoList() async {
    //Future -> async
    //https://jsonplaceholder.typicode.com/todos
    List<Todo> todoList = [];
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    var response = await http.get(url);
    // print('status code : ${response.statusCode}');
    var body = json.decode(response.body);
    //parse
    for (var i = 0; i < body.length; i++) {
      todoList.add(Todo.fromJson(body[i]));
    }
    return todoList;
  }

  //make controller

  @override
  Future<String> patchCompleted(Todo todo) async {
    // TODO: implement patchCompleted
    var url = Uri.parse('$dataURL/todos/${todo.id}');
    // //call back data
    String resData = '';
    // //bool? ->String
    await http.patch(
      url,
      body: {'title': 'KIMESPOIL'},
      // headers: {'Authorization': 'Your_token'},
    ).then((response) {
      //homescreen-> data
      resData = response.body;
    });
    return resData;
  }

  @override
  Future<String> postTodo(Todo todo) async {
    // TODO: implement postTodo
    var url = Uri.parse('$dataURL/todos/');
    var response = await http.post(url, body: todo.toJson());
  
    print(response.body);
    return 'true';
  }

  @override
  Future<String> putCompleted(Todo todo) async {
    // TODO: implement putCompleted
    var url = Uri.parse('$dataURL/todos/${todo.id}');
    // //call back data
    String resData = '';
    // //bool? ->String
    await http.put(
      url,
      body: {'title': 'KIMESPOIL'},
      // headers: {'Authorization': 'Your_token'},
    ).then((response) {
      //homescreen-> data
      resData = response.body;
      print(resData);
    });
    return resData;
  }
}
