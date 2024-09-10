import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateContainerBox extends StatelessWidget {
  final String text;
  final Widget child;
  final bool focus;
  const CreateContainerBox(
      {super.key, required this.child, required this.text, this.focus = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: GoogleFonts.montserrat(
              color: Colors.grey.shade600,
              fontSize: 14,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: focus ? Colors.grey.shade400 : Colors.grey.shade800),
            borderRadius: BorderRadius.circular(12),
          ),
          child: child,
        ),
      ],
    );
  }
}
