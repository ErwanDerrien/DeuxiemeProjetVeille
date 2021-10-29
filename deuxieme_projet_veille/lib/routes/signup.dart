import 'package:flutter/material.dart';

import 'home.dart';

class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
      ),
      body: Center(
          child: ElevatedButton(
              child: Text('Go to home'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Home(
                            title: '',
                            jwt: '',
                          )),
                );
              })),
    );
  }
}
