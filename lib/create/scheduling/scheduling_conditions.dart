import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nakya/consts.dart';
import 'package:nakya/create/scheduling/scheduling_provider.dart';

class SchedulingConditions extends HookConsumerWidget {
  const SchedulingConditions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleState = ref.watch(scheduleSelectionProvider);
    final scheduleNotifier = ref.read(scheduleSelectionProvider.notifier);

    return Container(
      width: 300,
      decoration: BoxDecoration(color: bgColor),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Text(
              'Select one or more conditions',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                  color: Colors.grey.shade200, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 4,
                itemBuilder: (context, conditionIndex) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 12),
                    margin: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade900,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.tag,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'VR-24-PP-003-07-00$conditionIndex',
                              style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Column(
                          children: List.generate(6, (valueIndex) {
                            String title = "";
                            Color color = Colors.white;

                            switch (valueIndex) {
                              case 0:
                                title = "Feed";
                                color = Color(0xFF00796B);
                                break;
                              case 1:
                                title = "Nutrients";
                                color = Color(0xFFFFA000);
                                break;
                              case 2:
                                title = "Agitation";
                                color = Color(0xFFE64A19);
                                break;
                              case 3:
                                title = "Inoculation";
                                color = Color(0xFFAFB42B);
                                break;
                              case 4:
                                title = "Sample Volume";
                                color = Color(0xFF5E35B1);
                                break;
                              case 5:
                                title = "Harvest";
                                color = Color(0xFFD81B60);
                                break;
                              default:
                            }

                            final isSelected = scheduleState
                                    .selectedValues[conditionIndex]
                                    ?.contains(valueIndex) ??
                                false;

                            return InkWell(
                              onTap: () {
                                scheduleNotifier.toggleSelection(
                                    conditionIndex, valueIndex);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: isSelected
                                          ? Colors.grey.shade200
                                          : Colors.transparent,
                                      width: 2),
                                  color: Colors.grey.shade800
                                      .withOpacity(isSelected ? 1 : 0.5),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 15,
                                      width: 15,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: color,
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Text(
                                      title,
                                      style: GoogleFonts.montserrat(
                                        color: Colors.grey.shade200,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
