import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'home.dart';

class Login extends StatelessWidget {
  final String baseUrl = 'http://localhost:8080';

  @override
  Widget build(BuildContext context) {
    Future<http.Response> postRequest(String email, String password) async {
      var url = (baseUrl + "/user/login");

      Map data = {'email': email, 'password': password};
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
        title: const Text('Connexion'),
      ),
      body: Center(
          child: SizedBox(
        height: 228.0,
        width: 400.0,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: email,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Courriel',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: password,
                obscureText: true,
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
                      border: Border.all(
                        color: Colors.grey,
                      ),
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
                      style: TextStyle(color: Colors.grey, fontSize: 12),
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
                      postRequest(email.text, password.text);
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
