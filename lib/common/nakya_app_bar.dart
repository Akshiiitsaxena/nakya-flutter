import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nakya/consts.dart';

class NakyaAppBar extends StatelessWidget {
  final String? title;
  const NakyaAppBar({super.key, this.title});

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
                    color: const Color.fromRGBO(105, 240, 174, 1),
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
          if (title != null)
            Text(
              title!,
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
