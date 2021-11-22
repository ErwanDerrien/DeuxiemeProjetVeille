import 'package:deuxieme_projet_veille/routes/widgets/dropzone_widget.dart';
import 'package:flutter/material.dart';

class FileUpload extends StatefulWidget {
  const FileUpload({Key? key, required this.token}) : super(key: key);

  final String token;

  @override
  State<FileUpload> createState() => _FileUpload(token: token);
}

class _FileUpload extends State<FileUpload> {
  _FileUpload({required this.token});

  String token = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Téléversement'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16),
          child: DropzoneWidget(token: token),
        ));
  }
}
