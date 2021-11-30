import 'package:flutter/material.dart';

import 'home.dart';

import 'package:flutter/cupertino.dart';

class AddOffer extends StatefulWidget {
  const AddOffer({Key? key, required this.token}) : super(key: key);

  final String token;

  @override
  // ignore: no_logic_in_create_state
  _AddOffer createState() => _AddOffer(token: token);
}

class _AddOffer extends State<AddOffer> {
  _AddOffer({required this.token});

  String token = '';
  late BuildContext globalContext;

  void addOffer(
      String title,
      String limitDateToApply,
      String beginningDate,
      String endingDate,
      String monitorEmail,
      String companyName,
      String minSalary,
      String maxSalary,
      String description) {
    print('Offer successfuly added');
    redirect(token);
    return;
  }

  void redirect(String body) {
    Navigator.push(
        globalContext,
        MaterialPageRoute(
            builder: (context) => Home(
                  title: '',
                  jwt: body,
                )));
  }

  @override
  Widget build(BuildContext context) {
    globalContext = context;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajout Offre'),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Titre du poste',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Date limite pour appliquer'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Date de début'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Date de fin'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Courriel du Moniteur'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nom de la compagnie'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Taux horaire minimum'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Taux horaire maximum'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              scrollPadding: const EdgeInsets.all(10),
              obscureText: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description du poste'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 50.0),
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
                margin: const EdgeInsets.symmetric(horizontal: 50.0),
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {
                    addOffer(
                        'title',
                        'limitDateToApply',
                        'beginningDate',
                        'endingDate',
                        'monitorEmail',
                        'companyName',
                        'minSalary',
                        'maxSalary',
                        'description');
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
      )),
    );
  }
}
