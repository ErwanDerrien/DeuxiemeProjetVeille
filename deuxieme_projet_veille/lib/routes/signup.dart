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

    Future<http.Response> postRequest(String email, String lastName,
        String firstName, String phone, String password) async {
      var url = '';

      if (role == 'Étudiant') {
        url = (baseUrl + "/student/register");
      } else if (role == 'Moniteur') {
        url = (baseUrl + "/monitor/register");
      } else if (role == 'SUPERVISOR') {
        url = (baseUrl + "/superviseur/register");
      }

      Map data = {
        'email': email,
        'lastName': lastName,
        'firstName': firstName,
        'phone': phone,
        'password': password
      };

      print('url ' + url);
      print('data ' + data.toString());

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

    void test(String input) {
      print(input);
    }

    TextEditingController email = TextEditingController()
      ..text = 'erwan1derrien@gmail.com';
    TextEditingController password = TextEditingController()
      ..text = 'bonjoursoir';
    TextEditingController lastName = TextEditingController()..text = 'Derrien';
    TextEditingController firstName = TextEditingController()..text = 'Erwan';
    TextEditingController phone = TextEditingController()
      ..text = '514-123-4567';

    return Scaffold(
      appBar: AppBar(
        title: Text('Inscription ' + role),
      ),
      body: Center(
          child: Container(
        height: 445.0,
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
                controller: lastName,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Prenom'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: firstName,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Nom'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: phone,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Téléphone'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                obscureText: true,
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
                      postRequest(email.text, lastName.text, firstName.text,
                          phone.text, password.text);
                    },
                    child: const Text(
                      'Soumettre',
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
