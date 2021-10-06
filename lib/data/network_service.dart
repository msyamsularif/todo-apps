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
}
