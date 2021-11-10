import 'dart:convert';
import 'dart:io';

import 'package:deuxieme_projet_veille/routes/student_offer.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;

class ListOffers extends StatefulWidget {
  ListOffers({Key? key, required this.token, required this.offers})
      : super(key: key);

  final String token;
  List<StudentOffer> offers = [];

  @override
  // ignore: no_logic_in_create_state
  State<ListOffers> createState() => _ListOffersState(token: token);
}

class _ListOffersState extends State<ListOffers> {
  _ListOffersState({required this.token});

  String token = '';

  var response;
  var responseJson;

  List<StudentOffer> offers = [];

  final String baseUrl = 'http://localhost:8080/internshipOffer';

  void getOffers() async {
    var url = (baseUrl + '/studentInternshipOffers');

    response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token,
      },
    );
    var responseJson = jsonDecode(response.body);

    for (var offer in responseJson) {
      setState(() {
        offers.add(StudentOffer.fromJson(offer));
      });
    }
  }

  @override
  void initState() {
    getOffers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste Offres'),
      ),
      body: (Center(
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: offers.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 50,
                color: Colors.yellow,
                child: Center(child: Text('Title ${offers[index].getTitle()}')),
              );
            }),
      )),
    );
  }

  List<Widget> listWidget(jsonObject) {
    List<Widget> children = [];
    jsonObject.keys.forEach(
      (key) => {
        children.add(
          Padding(
              child: Text('${jsonObject[key]}'),
              padding: const EdgeInsets.all(8.0)),
        )
      },
    );
    return children;
  }
}