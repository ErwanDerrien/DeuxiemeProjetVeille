import 'dart:convert';
import 'package:deuxieme_projet_veille/routes/models/offer_model.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';

// ignore: must_be_immutable
class ListOffers extends StatefulWidget {
  ListOffers({Key? key, required this.token, required this.offers})
      : super(key: key);

  final String token;
  List<Offer> offers = [];

  @override
  // ignore: no_logic_in_create_state
  State<ListOffers> createState() => _ListOffersState(token: token);
}

class _ListOffersState extends State<ListOffers> {
  _ListOffersState({required this.token});

  String token = '';

  var response;
  var responseJson;

  List<Offer> offers = [];

  final String baseUrl = 'http://localhost:8080/internshipOffer';

  String decodeJWTEmail(String jwt) {
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    return payload['sub'];
  }

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
        Offer newOffer = Offer.fromJson(offer);
        if (!newOffer.hasAlreadyApplied) {
          offers.add(newOffer);
        }
      });
    }
  }

  void appliquer(int index) async {
    String offerId = offers[index].getId();
    var url = (baseUrl + '/apply/$offerId');

    response = await http.patch(
      Uri.parse(url),
      headers: <String, String>{
        'Authorization': 'Bearer ' + token,
      },
    );

    setState(() {
      offers.remove(offers[index]);
    });
  }

  @override
  void initState() {
    getOffers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (offers.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Liste Offres'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Vous n\'avez aucune offre',
                  style: Theme.of(context).textTheme.headline6),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste Offres'),
      ),
      body: (Center(
        child: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: offers.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  color: Colors.grey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                offers[index].getCompanyName(),
                                style: DefaultTextStyle.of(context).style.apply(
                                      fontSizeFactor: 2.0,
                                      color: Colors.white,
                                    ),
                              )),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.blueGrey)),
                              onPressed: () {
                                appliquer(index);
                              },
                              child: const Text(
                                'APPLIQUER',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                          child: Text(
                            offers[index].getTitle(),
                            style: DefaultTextStyle.of(context)
                                .style
                                .apply(fontSizeFactor: 1.5),
                          ),
                          padding: const EdgeInsets.all(10)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  child: Text(
                                      'Debut : ${offers[index].getBeginningDate()}'),
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 0))),
                          Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                  child: Text(
                                      'Fin : ${offers[index].getEndingDate()}'),
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 0))),
                        ],
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              child: Text(
                                  'Date limite d\'application : ${offers[index].getBeginningDate()}'),
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0))),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              child: Text(
                                  'Taux horaire : ${offers[index].getBeginningDate()}'),
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0))),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              child: Text(
                                  'Description : ${offers[index].getDescription()}'),
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0))),
                    ],
                  ));
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
