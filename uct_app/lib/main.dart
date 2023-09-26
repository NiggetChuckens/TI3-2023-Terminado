import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:flutter_googlecalendar/flutter_googlecalendar.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  DateTime? _startTime;
  DateTime? _endTime;
  final TextEditingController _eventNameController = TextEditingController();

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: TextEditingController(
                text: _startTime != null
                    ? DateFormat('yyyy-MM-dd HH:mm').format(_startTime!)
                    : '',
              ),
              decoration: InputDecoration(
                labelText: 'Hora de inicio',
              ),
              onTap: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: _startTime ?? DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );
                if (selectedDate != null) {
                  final selectedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(_startTime ?? DateTime.now()),
                  );
                  if (selectedTime != null) {
                    setState(() {
                      _startTime = DateTime(
                        selectedDate.year,
                        selectedDate.month,
                        selectedDate.day,
                        selectedTime.hour,
                        selectedTime.minute,
                      );
                    });
                  }
                }
              },
            ),
            TextFormField(
              controller: TextEditingController(
                text: _endTime != null
                    ? DateFormat('yyyy-MM-dd HH:mm').format(_endTime!)
                    : '',
              ),
              decoration: InputDecoration(
                labelText: 'Hora de fin',
              ),
              onTap: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: _endTime ?? DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );
                if (selectedDate != null) {
                  final selectedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(_endTime ?? DateTime.now()),
                  );
                  if (selectedTime != null) {
                    setState(() {
                      _endTime = DateTime(
                        selectedDate.year,
                        selectedDate.month,
                        selectedDate.day,
                        selectedTime.hour,
                        selectedTime.minute,
                      );
                    });
                  }
                }
              },
            ),
            TextField(
              controller: _eventNameController,
              decoration: InputDecoration(
                labelText: 'Nombre del evento',
              ),
            ),
            ElevatedButton(
              child: const Text('Crear evento'),
              onPressed: () {
                if (_startTime != null && _endTime != null) {
                  final String eventName = _eventNameController.text;
                  print('Hora de inicio: $_startTime');
                  print('Hora de fin: $_endTime');
                  print('Nombre del evento: $eventName');
                  launchURL('https://www.google.com');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
