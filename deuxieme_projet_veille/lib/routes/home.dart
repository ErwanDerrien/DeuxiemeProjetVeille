import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:jwt_decode/jwt_decode.dart';

import 'login.dart';

class Home extends StatefulWidget {
  Home({Key? key, required this.title, this.jwt = ''}) : super(key: key);

  final String title;
  final String jwt;

  @override
  State<Home> createState() => _HomeState(jwt: jwt);
}

class _HomeState extends State<Home> {
  String jwt = '';
  String name = 'visiteur';
  String role = '';

  _HomeState({this.jwt = ''});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Bienvenue $name',
                style: Theme.of(context).textTheme.headline6),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        },
        tooltip: 'Login',
        child: const Icon(Icons.person),
      ),
    );
  }
}
