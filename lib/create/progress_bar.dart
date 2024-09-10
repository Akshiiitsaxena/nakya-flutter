import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProgressBar extends HookConsumerWidget {
  const ProgressBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 36),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              4,
              (index) {
                return ProgressBox(index: index);
              },
            ),
          ),
        ),
        Container(
          width: 2,
          color: Colors.grey.shade800,
        )
      ],
    );
  }
}

class ProgressBox extends StatelessWidget {
  final int index;

  const ProgressBox({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> steps = [
      {'text': 'Setup', 'step': '1', 'color': Colors.greenAccent},
      {'text': 'Conditions', 'step': '2', 'color': Colors.grey.shade700},
      {'text': 'Scheduling', 'step': '3', 'color': Colors.grey.shade700},
      {'text': 'Preferences', 'step': '4', 'color': Colors.grey.shade700},
    ];

    final currentStep = steps[index];

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: currentStep['color']),
              ),
              padding: EdgeInsets.all(12),
              child: Text(
                currentStep['step'],
                style: GoogleFonts.montserrat(
                  color: currentStep['color'],
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              currentStep['text'],
              style: GoogleFonts.montserrat(
                color: currentStep['color'],
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            )
          ],
        ),
        if (index < 3)
          Container(
            margin: EdgeInsets.fromLTRB(16, 6, 0, 6),
            height: 48,
            width: 2,
            decoration: BoxDecoration(
              color: Colors.grey.shade700,
              borderRadius: BorderRadius.circular(24),
            ),
          )
      ],
    );
  }
}
