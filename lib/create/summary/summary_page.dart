// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nakya/consts.dart';
import 'package:nakya/create/scheduling/scheduling_conditions.dart';

class SummaryPage extends HookConsumerWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        color: bgColor,
        padding: EdgeInsets.symmetric(vertical: 32, horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SummaryTile(
                  title: "Program Name",
                  value: "Biology Program",
                ),
                SizedBox(width: 64),
                SummaryTile(
                  title: "Experiment Type",
                  value: "Cell Expansion",
                ),
              ],
            ),
            SizedBox(height: 24),
            SummaryTile(
              title: "Title",
              value: "Figuring out cell expansion",
            ),
            SizedBox(height: 24),
            SummaryTile(
              title: "Objective",
              value:
                  "Figuring out cell expansion in biology program as a biologist",
            ),
            SizedBox(height: 24),
            SummaryTile(
              title: "Instruments",
              value:
                  "BioProfile® FLEX2, Cedex® Bio HT Analyzer, NucleoCounter® NC-200™",
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 36),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade600),
                  // color: Colors.red,
                ),
                child: Table(
                  defaultColumnWidth: IntrinsicColumnWidth(),
                  border: TableBorder.all(
                    color: Colors.transparent, // Border around individual cells
                    style: BorderStyle.none,
                  ),
                  children: [
                    // Header row
                    TableRow(
                      decoration: BoxDecoration(
                        color: Colors
                            .grey.shade900, // Custom grey background for header
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      children: List.generate(
                        10,
                        (index) => Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: Text(
                              'Heading goes',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade200,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // 5 rows with transparent cells
                    for (int row = 0; row < 5; row++)
                      TableRow(
                        children: List.generate(
                          10,
                          (index) => Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Center(
                              child: Text('cell${row + 1}${index + 1}',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.grey.shade400,
                                  )),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SummaryTile extends StatelessWidget {
  final String title;
  final String value;

  const SummaryTile({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: GoogleFonts.montserrat(
              color: Colors.grey.shade600,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.montserrat(
              color: Colors.grey.shade400,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
