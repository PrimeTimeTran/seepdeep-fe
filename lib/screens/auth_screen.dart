import 'dart:js' as js;

import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String email = 'datloiboi@gmail.com';
  String password = 'asdf!123';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
          height: getHeight(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 300),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                const Gap(25),
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
                const Gap(50),
                ElevatedButton(
                  onPressed: () {
                    _authRequest();
                  },
                  child: const Text('Sign In'),
                ),
                const Gap(50),
                ElevatedButton(
                  onPressed: () {
                    _getData('');
                  },
                  child: const Text('get index'),
                ),
                const Gap(50),
                ElevatedButton(
                  onPressed: () {
                    _getData('users');
                  },
                  child: const Text('get Users'),
                ),
                const Gap(50),
                ElevatedButton(
                  onPressed: () {
                    _getData('wizards');
                  },
                  child: const Text(' get Wizards'),
                ),
                const Gap(50),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Toggle Auth State'),
                ),
                const Gap(50),
                Consumer<AuthProvider>(
                  builder: (context, auth, child) {
                    return Text(
                      'isAuthenticated: ${auth.isAuthenticated}',
                      style: TextStyle(
                          color:
                              auth.isAuthenticated ? Colors.green : Colors.red),
                    );
                  },
                ),
                Consumer<AuthProvider>(
                  builder: (context, auth, child) {
                    return Text(
                      'isAuthenticated: ${auth.user?.email}',
                      style: TextStyle(
                          color:
                              auth.isAuthenticated ? Colors.green : Colors.red),
                    );
                  },
                )
              ],
            ),
          )),
    );
  }

  void detectTabChange() {
    try {
      js.context['document'].addEventListener('visibilitychange',
          (dynamic event) {
        if (js.context['document'].visibilityState == 'visible') {
          print('focused');
        } else {
          print('unfocused');
        }
      });
    } catch (e) {
      print('e $e');
    }
  }

  @override
  void initState() {
    super.initState();
    detectTabChange();
  }

  _authRequest() async {
    try {
      final result = await Api.post(
          'auth/authenticate', {'email': email, 'password': password});
      Provider.of<AuthProvider>(context, listen: false).setUser(result['user']);
    } catch (e) {
      Glob.logE('Error: $e');
    }
  }

  _getData(resource) async {
    try {
      final result = await Api.get(resource);
    } catch (e) {
      Glob.logE('Error: $e');
    }
  }
}
