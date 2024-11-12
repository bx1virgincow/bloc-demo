import 'dart:convert';
import 'dart:developer';

import 'package:bloc_demo/core/results.dart';
import 'package:bloc_demo/features/home/data/model/todo_model.dart';
import 'package:http/http.dart' as http;

abstract class HomeRemoteSource {
  Future<List<TodoModel>> getTodos();
  Future<void> deleteTodo(String id);
}

class HomeRemoteSourceImpl extends HomeRemoteSource {
  @override
  Future<List<TodoModel>> getTodos() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        List<TodoModel> todos =
            jsonResponse.map((todo) => TodoModel.fromJson(todo)).toList();
        return todos;
      } else {
        throw FailureResults(errorMessage: response.toString());
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> deleteTodo(String id) async {
    try {
      log('todoId: $id');
      final response = await http
          .delete(Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'));
      if (response.statusCode != 200) {
        throw FailureResults(errorMessage: response.toString());
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
