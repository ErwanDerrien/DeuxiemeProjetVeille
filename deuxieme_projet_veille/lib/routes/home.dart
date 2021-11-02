import 'package:deuxieme_projet_veille/routes/signup_role.dart';
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
  State<Home> createState() => _HomeState(token: jwt);
}

class _HomeState extends State<Home> {
  String token = '';
  String name = 'visiteur';
  String role = '';

  _HomeState({this.token = ''});

  void decodeJWT(String jwt) {
    Map<String, dynamic> payload = Jwt.parseJwt(token);

    name = payload['sub'];
    role = payload['role'];
  }

  @override
  Widget build(BuildContext context) {
    if (token != '') {
      decodeJWT(token);
    }
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(25),
                child: FloatingActionButton(
                  heroTag: "btn1",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignupRole()),
                    );
                  },
                  tooltip: 'Incription',
                  child: const Icon(Icons.person_add),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: FloatingActionButton(
                  heroTag: "btn2",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  tooltip: 'Connexion',
                  child: const Icon(Icons.login),
                ),
              ),
            ],
          ),
        ));
  }
}
