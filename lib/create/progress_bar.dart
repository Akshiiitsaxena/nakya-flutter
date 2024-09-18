import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nakya/create/progress_provider.dart';

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

class ProgressBox extends HookConsumerWidget {
  final int index;

  const ProgressBox({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressState =
        ref.watch(progressProvider); // Watch the progress state
    // Colors for active and inactive steps
    final bool isActive = index < progressState.value;
    final bool isBarColor = index < progressState.value - 1;
    final Color activeColor = Colors.greenAccent;
    final Color inactiveColor = Colors.grey.shade700;

    final List<Map<String, dynamic>> steps = [
      {'text': 'Setup', 'step': '1'},
      {'text': 'Conditions', 'step': '2'},
      {'text': 'Scheduling', 'step': '3'},
      {'text': 'Preferences', 'step': '4'},
    ];

    final currentStep = steps[index];
    final currentColor = isActive ? activeColor : inactiveColor;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: currentColor),
              ),
              padding: const EdgeInsets.all(12),
              child: Text(
                currentStep['step'],
                style: GoogleFonts.montserrat(
                  color: currentColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              currentStep['text'],
              style: GoogleFonts.montserrat(
                color: currentColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        // Add the connecting line between steps, except for the last step
        if (index < steps.length - 1)
          Container(
            margin: const EdgeInsets.fromLTRB(16, 6, 0, 6),
            height: 48,
            width: 2,
            decoration: BoxDecoration(
              color: isBarColor ? activeColor : inactiveColor,
              borderRadius: BorderRadius.circular(24),
            ),
          ),
      ],
    );
  }
}
