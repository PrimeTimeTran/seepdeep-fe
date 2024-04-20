import 'dart:convert';

import 'package:app/all.dart';
import 'package:http/http.dart' as http;

class Api {
  static const url = 'http://localhost:3000/api';
  static http.Client client = http.Client();
  static String authToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NWNkMmY0YzAyNjAwNDZhNDQzNTExYTIiLCJpYXQiOjE3MTM2NDU5MDUsImV4cCI6MjAyOTAwNTkwNX0.sxLZCqvzNl5AIFYjNB2npY-4oOWPeDmAdrrxNJNfqjg';

  Api._();

  static Future<dynamic> get(String route) async {
    try {
      final headers = <String, String>{};
      headers['Authorization'] = 'Bearer $authToken';
      final response = await http.get(Uri.parse(url + route));
      print(response.body);
      return jsonDecode(response.body);
    } catch (e) {
      Glob.logI('Error: $e');
    }
  }

  static Future<dynamic> post(String route, dynamic body) async {
    try {
      final headers = <String, String>{};
      headers['Authorization'] = 'Bearer $authToken';
      final response = await http.post(Uri.parse(url + route), body: body);
      return jsonDecode(response.body);
    } catch (e) {
      Glob.logI('Error: $e');
    }
  }

  static void setAuthToken(String token) {
    authToken = token;
  }
}
