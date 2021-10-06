import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class NetworkService {
  final baseUrl = "https://615d443512571a00172074e9.mockapi.io/learn-api/";

  Future<List<dynamic>> fetchTodos() async {
    try {
      final response = await get(Uri.parse(baseUrl + '/todos'));
      debugPrint(response.body);
      return jsonDecode(response.body) as List;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<bool> patchTodo(Map<String, String> patchObj, String id) async {
    try {
      await patch(Uri.parse(baseUrl + "/todos/$id"), body: patchObj);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Map?> addTodo(Map<String, Object> todoObj) async{
    try {
      final response = await post(Uri.parse(baseUrl + "/todos"), body: todoObj);
      return jsonDecode(response.body);
    } catch (e) {
      return null;
    }
  }

  Future<bool> deleteTodo(String id) async{
    try {
      await delete(Uri.parse(baseUrl + "/todos/$id"));
      return true;
    } catch (e) {
      return false;
    }
  }
}
