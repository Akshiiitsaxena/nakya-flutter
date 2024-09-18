import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Event> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getEventData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getEventData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getEventData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getEventData(index).background;
  }

  @override
  Object? convertAppointmentToObject(
      Object? customData, Appointment appointment) {
    if (customData is Event) {
      // Convert the appointment back to your Event object
      return Event(
        appointment.subject,
        appointment.startTime,
        appointment.endTime,
        appointment.color,
      );
    }
    return null;
  }

  Event _getEventData(int index) {
    return appointments![index] as Event;
  }
}

class Event {
  Event(this.eventName, this.from, this.to, this.background);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
}

class Condition {
  Condition(this.name, this.color);

  final String name;
  final Color color;
}
