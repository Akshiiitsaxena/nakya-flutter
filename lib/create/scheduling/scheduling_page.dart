import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nakya/consts.dart';
import 'package:nakya/create/scheduling/event_data_source.dart';
import 'package:nakya/create/scheduling/scheduling_conditions.dart';
import 'package:nakya/create/scheduling/scheduling_provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  late EventDataSource events;

  final List<Condition> conditions = [
    Condition('Feed', const Color(0xFF00796B)),
    Condition('Nutrients', const Color(0xFFFFA000)),
    Condition('Agitation', const Color(0xFFE64A19)),
    Condition('Inoculation', const Color(0xFFAFB42B)),
    Condition('Sample Volume', const Color(0xFF5E35B1)),
    Condition('Harvest', const Color(0xFFD81B60)),
  ];

  @override
  void initState() {
    super.initState();
    events = EventDataSource(getDataSource());
  }

  @override
  Widget build(BuildContext context) {
    final scheduleState = ref.watch(scheduleSelectionProvider);
    final scheduleNotifier = ref.read(scheduleSelectionProvider.notifier);

    return Scaffold(
      body: Row(
        children: [
          const SchedulingConditions(),
          Expanded(
            child: SfCalendar(
              backgroundColor: bgColor,
              headerStyle: CalendarHeaderStyle(
                backgroundColor: bgColor,
                textAlign: TextAlign.center,
                textStyle: GoogleFonts.montserrat(
                  color: Colors.grey.shade100,
                  fontWeight: FontWeight.bold,
                ),
              ),
              viewHeaderStyle: ViewHeaderStyle(
                backgroundColor: Colors.grey.shade900,
                dayTextStyle: GoogleFonts.montserrat(
                  color: Colors.grey.shade100,
                  fontWeight: FontWeight.bold,
                ),
              ),
              appointmentTextStyle: GoogleFonts.montserrat(
                  color: Colors.white, fontWeight: FontWeight.bold),
              cellBorderColor: Colors.grey.shade800,
              todayHighlightColor: Colors.white,
              view: CalendarView.month,
              todayTextStyle: const TextStyle(color: Colors.black),
              dataSource: events,
              allowAppointmentResize: true,
              allowDragAndDrop: true,
              onTap: (calendarTapDetails) {
                if (calendarTapDetails.targetElement ==
                    CalendarElement.calendarCell) {
                  addEventsForSelectedConditions(
                      calendarTapDetails.date!, scheduleState.selectedValues);
                } else if (calendarTapDetails.targetElement ==
                    CalendarElement.appointment) {
                  Event event = calendarTapDetails.appointments![0];
                  showEventDialog(context, event);
                }
              },
              monthViewSettings: MonthViewSettings(
                appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
                appointmentDisplayCount: 4,
                monthCellStyle: MonthCellStyle(
                  textStyle:
                      TextStyle(color: Colors.grey.shade400, fontSize: 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void addEventsForSelectedConditions(
      DateTime date, Map<int, Set<int>> selectedValues) {
    selectedValues.forEach((conditionIndex, valueIndices) {
      for (var valueIndex in valueIndices) {
        final Condition selectedCondition = conditions[valueIndex];
        final String vesselId = getVesselId(conditionIndex);
        final String eventName = '$vesselId ${selectedCondition.name}';

        final Event newEvent = Event(
          eventName,
          date,
          date.add(const Duration(hours: 1)),
          selectedCondition.color,
        );

        setState(() {
          events.appointments!.add(newEvent);
          events.notifyListeners(CalendarDataSourceAction.add, [newEvent]);
        });
      }
    });

    ref.read(scheduleSelectionProvider.notifier).clearAll();
  }

  void showEventDialog(BuildContext context, Event event) {
    // TODO: Add logic for interacting with added events
  }

  List<Event> getDataSource() {
    return <Event>[];
  }

  String getVesselId(int conditionIndex) {
    return conditionIndex.toString().padLeft(2, '0');
  }
}
