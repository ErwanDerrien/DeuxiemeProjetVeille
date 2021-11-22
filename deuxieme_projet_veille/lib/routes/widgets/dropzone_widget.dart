// import 'package:deuxieme_projet_veille/routes/widgets/dropzone_widget.dart';
// ignore_for_file: unnecessary_new

import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class DropzoneWidget extends StatefulWidget {
  const DropzoneWidget({Key? key, required this.token}) : super(key: key);

  final String token;

  @override
  _DropzoneWidgetState createState() => _DropzoneWidgetState(token: token);
}

class _DropzoneWidgetState extends State<DropzoneWidget> {
  _DropzoneWidgetState({required this.token});

  String token = '';
  final String baseUrl = 'http://localhost:8080';
  late DropzoneViewController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Stack(children: [
        DropzoneView(
            onCreated: (controller) => this.controller = controller,
            onDrop: acceptFile),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.cloud_upload,
                size: 80,
                color: Colors.white,
              ),
              Text('Drop Files here',
                  style: TextStyle(color: Colors.white, fontSize: 24)),
            ],
          ),
        ),
      ]),
    );
  }

  Future acceptFile(dynamic event) async {
    final filename = event.name;
    final mimeType = await controller.getFileMIME(event);

    Uint8List _bytesData = await controller.getFileData(event);
    List<int> _selectedFile = _bytesData;
    // var file = http.MultipartFile.fromBytes('file', _selectedFile,
    //     contentType: MediaType('application', 'octet-stream'),
    //     filename: filename) as Uint8List;

    var url = (baseUrl + "/file");

    // var map = new Map<String, dynamic>();
    // map['filename'] = event.name;
    // map['mimeType'] = mimeType;
    // map['type'] = 'CV';
    // map['file'] = file;

    // Map data = {
    //   'filename': filename,
    //   'type': 'CV',
    //   'mimeType': mimeType,
    //   'file': file
    // };
    // var body = json.encode(data);

    var postUri = Uri.parse(url);
    print(postUri);
    var request = new http.MultipartRequest("POST", postUri);
    request.headers['Authorization'] = 'Bearer ' + token;

    request.fields['type'] = 'CV';
    request.fields['filename'] = event.name;
    request.fields['mimeType'] = mimeType;

    request.files.add(new http.MultipartFile.fromBytes('file', _selectedFile,
        contentType: new MediaType('application', 'pdf')));

    request.send().then((response) {
      print(response.statusCode);
      if (response.statusCode == 200) print("Uploaded!");
    });

    // var response = HttpRequest.postFormData(url, formData,
    //     headers: {
    //       'Authorization': 'Bearer ' + token,
    //     },
    //     body: formData);
    // if (response.statusCode == 200) {
    //   print('Sucess');
    // } else if (response.statusCode == 401) {
    //   print('Unauthorized');
    // } else {
    //   print('Unexpected error');
    //   print(response.body);
    // }
  }
}
