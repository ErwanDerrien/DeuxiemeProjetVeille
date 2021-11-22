import 'package:deuxieme_projet_veille/routes/file_upload.dart';
import 'package:deuxieme_projet_veille/routes/liste_offers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key, required this.token, required this.role})
      : super(key: key);

  final String token;
  final String role;

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _Dashboard(token: token, role: role);
}

class _Dashboard extends State<Dashboard> {
  String token = '';
  String role = '';

  _Dashboard({required this.token, required this.role});

  @override
  Widget build(BuildContext context) {
    if (role == 'STUDENT') {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Dashboard Etudiant'),
          ),
          body: Center(
              child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ListOffers(
                                  token: token,
                                  offers: const [],
                                )));
                  },
                  child: const Text(
                    'Voir toutes les offres de stage',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[500],
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FileUpload(
                                  token: token,
                                )));
                  },
                  child: const Text(
                    'Téléverser son CV',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          )),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
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
                              builder: (_) => const Home(
                                    title: '',
                                    jwt: '',
                                  )));
                    },
                    tooltip: 'Retour accueil',
                    child: const Icon(Icons.home),
                  ),
                ),
              ],
            ),
          ));
    } else if (role == 'MONITOR') {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Dashboard Moniteur'),
          ),
          body: Center(
              child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Ajouter une offre de stage',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[500],
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Liste des postulations',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Évaluer un stagiaire',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          )),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
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
                              builder: (_) => const Home(
                                    title: '',
                                    jwt: '',
                                  )));
                    },
                    tooltip: 'Retour accueil',
                    child: const Icon(Icons.home),
                  ),
                ),
              ],
            ),
          ));
    } else if (role == 'SUPERVISOR') {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Dashboard Moniteur'),
          ),
          body: Center(
              child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Élèves assigné(e)s',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[500],
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Évaluer un stagiaire (mi-mandat)',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          )),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
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
                              builder: (_) => const Home(
                                    title: '',
                                    jwt: '',
                                  )));
                    },
                    tooltip: 'Retour accueil',
                    child: const Icon(Icons.home),
                  ),
                ),
              ],
            ),
          ));
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Unexpected role'),
        ),
      );
    }
  }
}
