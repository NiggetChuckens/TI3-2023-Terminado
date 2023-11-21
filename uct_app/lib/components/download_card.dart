import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class DownloadCard extends StatelessWidget {
  const DownloadCard({Key? key, 
                      required this.url, 
                      required this.coursename,
                      required this.filename}) : super(key: key);
                      final String url;
                      final String filename;
                      final String coursename;


  Future<void> downloadFile() async {
    var response = await http.get(Uri.parse(url));
    var documentDirectory = await getApplicationDocumentsDirectory();
    var file = File('${documentDirectory.path}/');
    await file.writeAsBytes(response.bodyBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Text( coursename,
                style: const TextStyle(fontSize: 12.0)),
          ElevatedButton(
            onPressed: downloadFile,
            child: const Text('Download'),
          ),
        ],
      ),
    );
  }
}