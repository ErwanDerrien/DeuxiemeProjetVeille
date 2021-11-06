import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key, required this.token, required this.role})
      : super(key: key);

  final String token;
  final String role;

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _Dashboard(token: token, role: role);
}

class _Dashboard extends State<Dashboard> {
  _Dashboard({token, role});

  String token = '';
  String role = '';

  @override
  Widget build(BuildContext context) {
    if (role == 'STUDENT') {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Unexpected role'),
        ),
      );
    }
  }
}
