import 'dart:async';
import 'dart:convert';

import 'package:app/all.dart';
import 'package:http/http.dart' as http;

class Api {
  static http.Client client = http.Client();

  static const base = 'http://localhost:3000/api/';
  static String authToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NWNkMmY0YzAyNjAwNDZhNDQzNTExYTIiLCJpYXQiOjE3MTM2NDg2NzgsImV4cCI6MjAyOTAwODY3OH0.HnX3iDxGkKdcgaxpZSAR34jXq5T1pASW6vaeEjuJ6EM';

  Api._();

  static FutureOr<dynamic> get(String path) async {
    Glob.loadStart();
    try {
      final response = await client.get(
        _url(path),
        headers: _headers(),
      );
      return _result(response);
    } catch (e) {
      Glob.logI(e);
    } finally {
      Glob.loadDone();
    }
  }

  static FutureOr<dynamic> post(String path, dynamic body) async {
    try {
      final response = await client
          .post(
        _url(path),
        body: jsonEncode(body),
        headers: _headers(),
      )
          .timeout(const Duration(seconds: 30), onTimeout: () {
        Glob.showSnack('Timeout. Is your internet connection ok?');
        return http.Response('Timeout', 408);
      });
      return _result(response);
    } catch (e) {
      Glob.logI(e);
    }
  }

  static void setAuthToken(String token) => authToken = token;

  static _headers() {
    final headers = <String, String>{};
    headers['authorization'] = 'Bearer $authToken';
    return headers;
  }

  static _result(response) {
    final body = jsonDecode(response.body);
    final data = body['data'];
    if (isArray(data)) {
      if (data.length == 0) {
        Glob.logI('0 Results');
      } else {
        Glob.logI(body['meta']);
        Glob.logI(data[0]);
      }
    } else {
      Glob.logI(data);
    }
    return data;
  }

  static _url(path) => Uri.parse(base + path);
}
