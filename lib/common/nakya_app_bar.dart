import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nakya/consts.dart';

class NakyaAppBar extends StatelessWidget {
  final bool showTitle;
  const NakyaAppBar({super.key, this.showTitle = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: double.infinity,
      color: bgColor,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'N',
                style: GoogleFonts.spectral(
                    color: Colors.greenAccent,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'akya',
                style: GoogleFonts.spectral(
                    color: Colors.grey.shade100,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          if (showTitle)
            Text(
              'Create Experiment',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          Icon(
            Icons.person,
            color: Colors.grey.shade200,
          )
        ],
      ),
    );
  }
}
