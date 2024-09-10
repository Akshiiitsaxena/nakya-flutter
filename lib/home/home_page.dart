import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nakya/common/nakya_app_bar.dart';
import 'package:nakya/consts.dart';
import 'package:nakya/home/home_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);

    void handleLogout() {
      // Clear user session and navigate to login page
      // e.g., SharedPreferences or other local storage solution
      navigator.pushNamed('/login');
    }

    return Scaffold(
      body: Column(
        children: [
          NakyaAppBar(showTitle: false),
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.grey.shade800,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 48.0),
              color: bgColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 36),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Welcome, ',
                              style: GoogleFonts.spectral(
                                color: Colors.grey[700],
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: 'Akshit',
                              style: GoogleFonts.spectral(
                                color: Colors
                                    .grey[400], // Equivalent to text-gray-400
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(height: 4),
                      Text(
                        'Click on any card to get started!',
                        style: GoogleFonts.montserrat(
                          color:
                              Colors.grey[400], // Equivalent to text-gray-400
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 48),
                  Expanded(
                    // child: Container(
                    //   color: Colors.red,
                    // ),
                    child: Container(
                      alignment: Alignment.topCenter,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/create', (_) => false);
                            },
                            child: HomeCard(
                              backgroundColor:
                                  Colors.greenAccent.withOpacity(0.075),
                              textColor: Colors.greenAccent,
                              borderColor: Colors.green[800]!,
                              icon: Icon(Icons.science,
                                  color: Colors.green[400], size: 32),
                              title: 'Create Experiment',
                              content:
                                  'Kickstart your research—design and initiate your next experiment with ease.',
                            ),
                          ),
                          HomeCard(
                            backgroundColor:
                                Colors.orangeAccent.withOpacity(0.075),
                            textColor: Colors.orangeAccent,
                            borderColor: Colors.orangeAccent,
                            icon: Icon(Icons.assessment,
                                color: Colors.orangeAccent, size: 32),
                            title: 'Track Experiment',
                            content:
                                'Stay on top of your work—monitor and manage your experiments in real-time.',
                          ),
                          HomeCard(
                            backgroundColor: Colors.indigo.withOpacity(0.1),
                            textColor: Colors.indigo,
                            borderColor: Colors.indigo,
                            icon: Icon(Icons.insights,
                                color: Colors.indigo, size: 32),
                            title: 'Data Visualization',
                            content:
                                'Turn data into insights—visualize your findings with clarity and depth.',
                          ),
                          // HomeCard(
                          //   backgroundColor:
                          //       Colors.greenAccent.withOpacity(0.2),
                          //   textColor: Colors.greenAccent,
                          //   borderColor: Colors.green[800]!,
                          //   icon: Icon(Icons.science,
                          //       color: Colors.green[400], size: 32),
                          //   title: 'Create Experiment',
                          //   content:
                          //       'Kickstart your research—design and initiate your next experiment with ease.',
                          // ),
                          // HomeCard(
                          //   backgroundColor:
                          //       Colors.greenAccent.withOpacity(0.2),
                          //   textColor: Colors.greenAccent,
                          //   borderColor: Colors.green[800]!,
                          //   icon: Icon(Icons.science,
                          //       color: Colors.green[400], size: 32),
                          //   title: 'Create Experiment',
                          //   content:
                          //       'Kickstart your research—design and initiate your next experiment with ease.',
                          // ),
                          // HomeCard(
                          //   backgroundColor: Colors.amber[900]!,
                          //   textColor: Colors.amber[400]!,
                          //   borderColor: Colors.amber[600]!,
                          //   icon: Icon(Icons.assessment,
                          //       color: Colors.amber[400], size: 32),
                          //   title: 'Track Experiment',
                          //   content:
                          //       'Stay on top of your work—monitor and manage your experiments in real-time.',
                          // ),
                          // HomeCard(
                          //   backgroundColor: Colors.indigo[900]!,
                          //   textColor: Colors.indigo[400]!,
                          //   borderColor: Colors.indigo[600]!,
                          //   icon: Icon(Icons.insights,
                          //       color: Colors.indigo[400], size: 32),
                          //   title: 'Data Visualization',
                          //   content:
                          //       'Turn data into insights—visualize your findings with clarity and depth.',
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
