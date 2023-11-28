import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DownloadCard extends StatelessWidget {
  final String coursename;
  final String url;

  const DownloadCard({super.key, 
    required this.coursename,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 164, 188, 250),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              coursename,
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(94, 175, 31, 240)),
              onPressed: () async {
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch ';
                }
              },
              child: const Text('Open Link'),
            ),
          ],
        ),
      ),
    );
  }
}
