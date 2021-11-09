import 'package:deuxieme_projet_veille/routes/signup.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class SignupRole extends StatefulWidget {
  const SignupRole({Key? key}) : super(key: key);

  @override
  State<SignupRole> createState() => _SignupRole();
}

class _SignupRole extends State<SignupRole> {
  String role = 'Étudiant';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscription'),
      ),
      body: Center(
          child: SizedBox(
        height: 280.0,
        width: 400.0,
        child: Column(
          children: <Widget>[
            DropdownButton<String>(
              value: role,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.grey, fontSize: 24),
              underline: Container(
                height: 2,
                color: Colors.grey,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  role = newValue!;
                });
              },
              items: <String>['Étudiant', 'Moniteur', 'Superviseur']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 100.0),
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
                              builder: (_) => const Home(
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
                    onPressed: () {
                      if (role != '') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Signup(
                                      role: role,
                                    )));
                      }
                    },
                    child: const Text(
                      'Continuer',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
