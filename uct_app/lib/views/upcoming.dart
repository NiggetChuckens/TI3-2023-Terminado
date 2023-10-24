import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:googleapis/calendar/v3.dart' as gcal;
import 'package:uct_app/views/login.dart';

class UpcomingEventsPage extends StatefulWidget {
  final List<gcal.Event>? events;

  UpcomingEventsPage({Key? key, this.events}) : super(key: key);

  @override
  _UpcomingEventsPageState createState() => _UpcomingEventsPageState();
}

class _UpcomingEventsPageState extends State<UpcomingEventsPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    print('Page loaded. Number of events: ${widget.events?.length ?? 0}');
  }
  Widget build(BuildContext context) {
    List<gcal.Event>? events = Provider.of<EventsModel>(context).events;
    print('Events: $events');
    return Scaffold(
      appBar: AppBar(
        title: Text('Upcoming Events'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            eventLoader: (day) {
              return widget.events?.where((event) {
                final eventDate = event.start?.dateTime?.toLocal();
                return eventDate != null &&
                    eventDate.isAfter(DateTime.now()) &&
                    eventDate.isBefore(DateTime.now().add(Duration(days: 365)));
              }).toList() ?? [];
            },
            calendarStyle: CalendarStyle(
              markerDecoration: BoxDecoration(
                color: Colors.blue[400],
                shape: BoxShape.circle,
              ),
            ),
          ),
          Expanded(
  child: ListView.builder(
    itemCount: widget.events?.isEmpty ?? true ? 1 : widget.events!.length,
    itemBuilder: (context, index) {
      if (widget.events?.isEmpty ?? true) {
        return ListTile(
          title: Text('No events'),
        );
      } else {
        final event = widget.events![index];
        return ListTile(
          title: Text(event.summary ?? 'No title'),
          subtitle: Text(event.start?.dateTime?.toLocal().toString() ?? 'No date'),
        );
      }
    },
  ),
),
        ],
      ),
    );
  }
}