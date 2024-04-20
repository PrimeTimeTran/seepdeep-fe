import 'dart:convert';

import 'package:app/all.dart';
import 'package:http/http.dart' as http;

class Api {
  static const url = 'http://localhost:3000/api/';
  static http.Client client = http.Client();
  static String authToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NWNkMmY0YzAyNjAwNDZhNDQzNTExYTIiLCJpYXQiOjE3MTM2NDg2NzgsImV4cCI6MjAyOTAwODY3OH0.HnX3iDxGkKdcgaxpZSAR34jXq5T1pASW6vaeEjuJ6EM';

  Api._();

  static Future<dynamic> get(String route) async {
    try {
      final response = await client.get(
        Uri.parse(url + route),
        headers: _headers(),
      );
      Glob.logI(response.body);
      return jsonDecode(response.body);
    } catch (e) {
      Glob.logI('Error: $e');
    }
  }

  static Future<dynamic> post(String route, dynamic body) async {
    try {
      final response = await client.post(
        Uri.parse(url + route),
        body: body,
        headers: _headers(),
      );
      Glob.logI(response.body);
      return jsonDecode(response.body);
    } catch (e) {
      Glob.logI(e);
    }
  }

  static void setAuthToken(String token) {
    authToken = token;
  }

  static _headers() {
    final headers = <String, String>{};
    headers['authorization'] = 'Bearer $authToken';
    return headers;
  }
}
