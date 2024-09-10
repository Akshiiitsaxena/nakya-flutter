import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nakya/consts.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: width / 10),
        height: height,
        width: width,
        color: bgColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'N',
                      style: GoogleFonts.spectral(
                          color: Colors.greenAccent, fontSize: 82),
                    ),
                    Text(
                      'akya',
                      style: GoogleFonts.spectral(
                          color: Colors.grey.shade100, fontSize: 82),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: width / 3,
                  child: Text(
                    'Track, analyze, and optimize your research with predictive insights and comprehensive reports—streamlining your journey from data to discovery.',
                    style: GoogleFonts.spectral(
                      color: Colors.grey.shade700,
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            ),
            Container(
              width: width / 3,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade800.withOpacity(0.25),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Login',
                    style: GoogleFonts.montserrat(
                        color: Colors.grey.shade200,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade800.withOpacity(0.75),
                    ),
                    child: TextFormField(
                      cursorColor: Colors.greenAccent,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        hintText: 'Email',
                        hintStyle: GoogleFonts.montserrat(
                          color: Colors.grey.shade500,
                          fontSize: 16,
                        ),
                      ),
                      style: GoogleFonts.montserrat(
                        color: Colors.grey.shade200,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade800.withOpacity(0.75),
                    ),
                    child: TextFormField(
                      cursorColor: Colors.greenAccent,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        hintText: 'Password',
                        hintStyle: GoogleFonts.montserrat(
                          color: Colors.grey.shade500,
                          fontSize: 16,
                        ),
                      ),
                      style: GoogleFonts.montserrat(
                        color: Colors.grey.shade200,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  InkWell(
                    onHover: (value) {},
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/', (_) => false);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(64),
                        gradient: LinearGradient(
                          colors: [
                            Colors.greenAccent,
                            Colors.greenAccent.shade400
                          ],
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Submit',
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
