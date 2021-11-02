import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'home.dart';

class Signup extends StatelessWidget {
  final String baseUrl = 'http://localhost:8080';
  String role = 'test';

  Signup({Key? key, this.role = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('role ' + this.role);

    Future<http.Response> postRequest(String email, String password) async {
      var url = '';

      if (role == 'STUDENT') {
        url = (baseUrl + "/student/register");
      } else if (role == 'MONITOR') {
        url = (baseUrl + "/monitor/register");
      } else if (role == 'SUPERVISOR') {
        url = (baseUrl + "/supervisor/register");
      }

      Map data = {'email': email, 'password': password};
      //encode Map to JSON
      var body = json.encode(data);

      var response = await http.post(url,
          headers: {"Content-Type": "application/json"}, body: body);
      if (response.statusCode == 200) {
        print('Sucess');
      } else if (response.statusCode == 401) {
        print('Unauthorized');
      } else {
        print('Unexpected error');
      }

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Home(
                    title: '',
                    jwt: response.body,
                  )));

      return response;
    }

    TextEditingController email = TextEditingController()
      ..text = '123456789@gmail.com';
    TextEditingController password = TextEditingController()
      ..text = 'travis123';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscription'),
      ),
      body: Center(
          child: Container(
        height: 228.0,
        width: 400.0,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: email,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Courriel',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: password,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Mot de passe'),
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 50.0),
                  height: 30,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Home(
                                    title: '',
                                    jwt: '',
                                  )));
                    },
                    child: const Text(
                      'Quitter',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 50.0),
                  height: 30,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    onPressed: () async {
                      postRequest('123456789@gmail.com', 'travis123');
                    },
                    child: const Text(
                      'Connexion',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
