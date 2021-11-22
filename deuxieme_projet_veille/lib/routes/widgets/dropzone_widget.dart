// import 'package:deuxieme_projet_veille/routes/widgets/dropzone_widget.dart';
// ignore_for_file: unnecessary_new

import 'dart:html';
import 'dart:typed_data';

import 'package:deuxieme_projet_veille/routes/file_upload.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
import 'package:path/path.dart';
import 'package:dio/dio.dart';

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
            children: [
              const Icon(
                Icons.cloud_upload,
                size: 80,
                color: Colors.white,
              ),
              const Text('Drop Files here',
                  style: TextStyle(color: Colors.white, fontSize: 24)),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () async {
                  // ignore: unused_local_variable
                  final events = await controller.pickFiles();
                  if (events.isEmpty) return;

                  acceptFile(events.first);
                },
                icon: Icon(Icons.search, size: 32),
                label: const Text('Choose Files',
                    style: TextStyle(color: Colors.white)),
              ),
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
    http.MultipartFile file = http.MultipartFile.fromBytes(
        'file', _selectedFile,
        contentType: MediaType('application', 'octet-stream'),
        filename: filename);

    var url = (baseUrl + "/file");

    var postUri = Uri.parse(url);
    var request = new http.MultipartRequest("POST", postUri);
    request.headers['Authorization'] = 'Bearer ' + token;
    request.headers['content-type'] = 'multipart/form-data';
    request.headers['Content-Disposition'] =
        'attachment; filename="${event.name}"';
    request.fields['type'] = 'CV';
    request.fields['filename'] = event.name;
    request.fields['mimeType'] = mimeType;

    request.files.add(file);

    request.send().then((response) {
      print(response.statusCode);
    });
  }
}
