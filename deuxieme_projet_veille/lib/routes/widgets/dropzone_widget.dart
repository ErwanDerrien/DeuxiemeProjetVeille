import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
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

    var request = http.MultipartRequest("POST", postUri);

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

  @override
  Widget build(BuildContext context) {
    if ((defaultTargetPlatform == TargetPlatform.iOS) ||
        (defaultTargetPlatform == TargetPlatform.android)) {
      return Container(
        color: Colors.green,
        child: Stack(children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.cloud_upload,
                  size: 80,
                  color: Colors.white,
                ),
                Text('Implementation mobile à venir...',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                SizedBox(height: 16),
              ],
            ),
          ),
        ]),
      );
    } else if ((defaultTargetPlatform == TargetPlatform.linux) ||
        (defaultTargetPlatform == TargetPlatform.macOS) ||
        (defaultTargetPlatform == TargetPlatform.windows)) {
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
                const Text('Déposez votre CV',
                    style: TextStyle(color: Colors.white, fontSize: 24)),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () async {
                    // ignore: unused_local_variable
                    final events = await controller.pickFiles();
                    if (events.isEmpty) return;

                    acceptFile(events.first);
                  },
                  icon: const Icon(Icons.search, size: 32),
                  label: const Text('Sélectionnez le fichier',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ]),
      );
    } else {
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
                const Text('Déposez votre CV',
                    style: TextStyle(color: Colors.white, fontSize: 24)),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () async {
                    // ignore: unused_local_variable
                    final events = await controller.pickFiles();
                    if (events.isEmpty) return;

                    acceptFile(events.first);
                  },
                  icon: const Icon(Icons.search, size: 32),
                  label: const Text(
                      'Implementation sur cette plateform à venir...',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ]),
      );
    }
  }
}
