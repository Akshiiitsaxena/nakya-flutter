import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nakya/consts.dart';

class CalendarConditionModal extends HookConsumerWidget {
  final String conditionName;
  final Color color;
  final DateTime startDate;
  final DateTime endDate;

  const CalendarConditionModal({
    super.key,
    required this.conditionName,
    required this.color,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final List<String> feedValues = [
      'CHO-DG44',
      'CHO-DXB11',
      'CHO-GS',
      'CHO-K1SV',
      'CHO-M',
      'CHO-ZN',
      'CHO-3E7'
    ];

    final List<String> nutrientValues = [
      'Glucose (g/L or mg/ml)',
      'Glutamine (mM or M)',
      'Amino acids (5% v/v)',
      'Epidermal Growth Factor [EGF] (ng/ml or ug/L)',
      'Insulin-like Growth Factor [IGF] (ng/ml or ug/L)',
      'Fetal Bovine Serum [FBS] (5% v/v)',
      'Insulin-Transferrin-Selenium-Ethanolamine [ITSE] (2.5x)',
      'Insulin-Transferrin-Selenium (2.5x)',
      'Insulin-Transferrin-Selenium-Ethanolamine + Albumin [ITSE+A] (2.5x)',
      'Lipid mix (% v/v)'
    ];

    final List<int> sampleCounts = List<int>.generate(8, (index) => index + 1);

    String? selectedFeedValue;
    String? selectedNutrientValue;
    int? selectedSampleCount;

    String formattedDateRange() {
      final dateFormat = DateFormat('MM/dd');
      if (startDate.day == endDate.day) {
        return 'Enter $conditionName value for ${dateFormat.format(startDate)}';
      } else {
        return 'Enter $conditionName value for ${dateFormat.format(startDate)} - ${dateFormat.format(endDate)}';
      }
    }

    return Container(
      // width: width / 3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade900),
        color: bgColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 16,
            ),
            child: Row(
              children: [
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  formattedDateRange(),
                  style: GoogleFonts.montserrat(
                    color: Colors.grey.shade400,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          if (conditionName.toLowerCase().contains("feed")) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DropdownButtonFormField<String>(
                value: selectedFeedValue,
                items: feedValues.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: GoogleFonts.montserrat(
                        color: Colors.grey.shade400,
                        fontSize: 16,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  selectedFeedValue = newValue;
                },
                decoration: InputDecoration(
                  labelText: 'Select Feed Type',
                  labelStyle: GoogleFonts.montserrat(
                    color: Colors.grey.shade600,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade800),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade500),
                  ),
                ),
                dropdownColor: Colors.grey.shade900,
              ),
            ),
            SizedBox(height: 16),
          ],
          if (conditionName.toLowerCase().contains("nutrients")) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DropdownButtonFormField<String>(
                value: selectedNutrientValue,
                items: nutrientValues.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: GoogleFonts.montserrat(
                        color: Colors.grey.shade400,
                        fontSize: 16,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  selectedNutrientValue = newValue;
                },
                decoration: InputDecoration(
                  labelText: 'Select Nutrient Type',
                  labelStyle: GoogleFonts.montserrat(
                    color: Colors.grey.shade600,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade800),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade500),
                  ),
                ),
                dropdownColor: Colors.grey.shade900,
              ),
            ),
            SizedBox(height: 16),
          ],
          if (conditionName.toLowerCase().contains("volume")) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DropdownButtonFormField<int>(
                value: selectedSampleCount,
                items: sampleCounts.map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(
                      value.toString(),
                      style: GoogleFonts.montserrat(
                        color: Colors.grey.shade400,
                        fontSize: 16,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  selectedSampleCount = newValue;
                },
                decoration: InputDecoration(
                  labelText: 'Select Number of Samples',
                  labelStyle: GoogleFonts.montserrat(
                    color: Colors.grey.shade600,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade800),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade500),
                  ),
                ),
                dropdownColor: Colors.grey.shade900,
              ),
            ),
          ],
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              keyboardType: TextInputType.number,
              style: GoogleFonts.montserrat(
                color: Colors.grey.shade400,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                labelText:
                    '$conditionName Value ${getUnitLabel(conditionName)}',
                labelStyle: GoogleFonts.montserrat(
                  color: Colors.grey.shade600,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade800),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade500),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 36,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 12),
              margin: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(64),
                color: Colors.grey.shade100,
              ),
              alignment: Alignment.center,
              child: Text(
                'Confirm',
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 16)
        ],
      ),
    );
  }

  String getUnitLabel(String conditionName) {
    if (conditionName.toLowerCase().contains('feed') ||
        conditionName.toLowerCase().contains('nutrients') ||
        conditionName.toLowerCase().contains('volume') ||
        conditionName.toLowerCase().contains('harvest')) {
      return '(in ml)';
    } else if (conditionName.toLowerCase().contains('agitation')) {
      return '(in RPM)';
    } else {
      return '';
    }
  }
}
