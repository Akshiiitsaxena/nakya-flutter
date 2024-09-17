import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late MeetingDataSource _events;
  String? _selectedAppointmentType;
  final List<AppointmentType> _appointmentTypes = [
    AppointmentType('Meeting', Colors.blue),
    AppointmentType('Conference', Colors.green),
    AppointmentType('Holiday', Colors.red),
    AppointmentType('Personal', Colors.orange),
  ];

  @override
  void initState() {
    super.initState();
    _events = MeetingDataSource(_getDataSource());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left side - Appointment type boxes
          Container(
            width: 150,
            child: ListView.builder(
              itemCount: _appointmentTypes.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedAppointmentType = _appointmentTypes[index].name;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _appointmentTypes[index].color,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: _selectedAppointmentType ==
                                _appointmentTypes[index].name
                            ? Colors.black
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      _appointmentTypes[index].name,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          // Right side - Calendar
          Expanded(
            child: SfCalendar(
              view: CalendarView.month,
              dataSource: _events,
              allowAppointmentResize: true,
              allowDragAndDrop: true,
              onTap: (calendarTapDetails) {
                // calendarTapDetails.
                if (calendarTapDetails.targetElement ==
                    CalendarElement.calendarCell) {
                  _addAppointment(calendarTapDetails.date!);
                } else if (calendarTapDetails.targetElement ==
                    CalendarElement.appointment) {
                  Meeting meeting = calendarTapDetails.appointments![0];
                  _showAppointmentDialog(context, meeting);
                }
              },
              dragAndDropSettings:
                  DragAndDropSettings(autoNavigateDelay: Duration(seconds: 1)),
              monthViewSettings: MonthViewSettings(
                appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
                appointmentDisplayCount: 4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addAppointment(DateTime date) {
    if (_selectedAppointmentType != null) {
      final AppointmentType selectedType = _appointmentTypes.firstWhere(
        (type) => type.name == _selectedAppointmentType,
      );

      final Meeting newMeeting = Meeting(
        _selectedAppointmentType!,
        date,
        date.add(Duration(hours: 1)),
        selectedType.color,
        false,
      );

      setState(() {
        _events.appointments!.add(newMeeting);
        _events.notifyListeners(CalendarDataSourceAction.add, [newMeeting]);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Added $_selectedAppointmentType on ${DateFormat('MMM dd, yyyy').format(date)}')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an appointment type first')),
      );
    }
  }

  void _showAppointmentDialog(BuildContext context, Meeting meeting) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(meeting.eventName),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  'Start: ${DateFormat('MMM dd, yyyy hh:mm a').format(meeting.from)}'),
              Text(
                  'End: ${DateFormat('MMM dd, yyyy hh:mm a').format(meeting.to)}'),
              Text('All Day: ${meeting.isAllDay ? 'Yes' : 'No'}'),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Meeting(
      'Conference',
      startTime,
      endTime,
      const Color(0xFF0F8644),
      false,
    ));
    meetings.add(Meeting(
      'Conference Also',
      startTime.add(Duration(days: 2)),
      endTime.add(Duration(days: 2)),
      const Color(0xFF0F6844),
      false,
    ));
    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    return appointments![index] as Meeting;
  }

  @override
  Object? convertAppointmentToObject(
      Object? customData, Appointment appointment) {
    // Create a new Meeting instance from the Appointment
    final Meeting meeting = Meeting(
      appointment.subject,
      appointment.startTime,
      appointment.endTime,
      appointment.color,
      appointment.isAllDay,
    );
    return meeting;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}

class AppointmentType {
  AppointmentType(this.name, this.color);

  final String name;
  final Color color;
}
