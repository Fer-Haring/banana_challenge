import 'dart:convert';

import 'package:banana_challenge/models/login_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final authProvider = FutureProvider.family<LoginResponse, Map<String, String>>(
    (ref, loginData) async {
  final response = await http.post(
    Uri.parse('https://dummyjson.com/auth/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(loginData),
  );

  if (response.statusCode == 200) {
    return LoginResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to login');
  }
});
