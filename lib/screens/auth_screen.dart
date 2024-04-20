import 'dart:convert';

import 'package:app/all.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String email = 'datloiboi@gmail.com';
  String password = 'asdfas';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: (val) {
            setState(() {
              email = val;
            });
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Email',
          ),
        ),
        TextField(
          onChanged: (val) {
            setState(() {
              password = val;
            });
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Password',
          ),
        ),
        ElevatedButton(
            onPressed: () {
              podRequest();
            },
            child: const Text('podRequest')),
        ElevatedButton(
            onPressed: () {
              getData();
            },
            child: const Text('getData'))
      ],
    );
  }

  getData() async {
    try {
      final result = await Api.get('wizards');
      Glob.logIObj(jsonEncode(result));
      // final user = User.fromJson(result['user']);
      // print(user);
      // Glob.logIObj(jsonEncode(user));
    } catch (e) {
      print('Error: $e');

      return [];
    }
  }

  podRequest() async {
    try {
      final result = await Api.post(
          'auth/authenticate', {'email': email, 'password': password});
      final user = User.fromJson(result['user']);
      print(user);
      Glob.logIObj(jsonEncode(user));
    } catch (e) {
      print('Error: $e');

      return [];
    }
  }
}
