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
            _authRequest();
          },
          child: const Text('authRequest'),
        ),
        const Gap(6),
        ElevatedButton(
          onPressed: () {
            _getData('');
          },
          child: const Text('get index'),
        ),
        const Gap(6),
        ElevatedButton(
          onPressed: () {
            _getData('users');
          },
          child: const Text('get Users'),
        ),
        const Gap(6),
        ElevatedButton(
          onPressed: () {
            _getData('wizards');
          },
          child: const Text(' get Wizards'),
        ),
        const Gap(6),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Toggle Auth State'),
        ),
        const Gap(6),
        Consumer<AuthProvider>(
          builder: (context, cart, child) {
            return Text('isAuthenticated: ${cart.isAuthenticated}',
                style: TextStyle(
                    color: cart.isAuthenticated ? Colors.green : Colors.red));
          },
        )
      ],
    );
  }

  _authRequest() async {
    try {
      final result = await Api.post(
          'auth/authenticate', {'email': email, 'password': password});

      final user = User.fromJson(result['user']);
      Provider.of<AuthProvider>(context, listen: false).setUser(user);
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
