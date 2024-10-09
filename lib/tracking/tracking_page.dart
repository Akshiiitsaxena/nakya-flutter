import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nakya/common/nakya_app_bar.dart';
import 'package:nakya/consts.dart';

class TrackingPage extends HookConsumerWidget {
  const TrackingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final List<String> experiments = [
      'Protein production transient transfection',
      'Protein production stable cell line',
      'Viral vector production transient transfection',
      'Cell therapy cell expansion',
      'Cell therapy viral transduction',
      'Cell therapy CRISPR',
      'Seed train/expansion',
    ];

    final chosenExperiment = useState<String?>(null);

    final List<String> titles = [
      "Real-time Raw Data",
      "Experimental Summary",
      "Visualizaton",
      "Predictions",
      "Calculations & Optimizations"
    ];
    final List<IconData> icons = [
      Icons.graphic_eq_rounded,
      Icons.summarize_outlined,
      Icons.auto_graph_rounded,
      Icons.batch_prediction,
      Icons.calculate_outlined
    ];

    return Scaffold(
      body: Column(
        children: [
          const NakyaAppBar(title: "Track Experiment"),
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.grey.shade800,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              color: bgColor,
              padding: EdgeInsets.symmetric(vertical: 32, horizontal: 32),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: chosenExperiment.value == null
                            ? Colors.grey.shade800
                            : Colors.orangeAccent,
                        width: chosenExperiment.value == null ? 1 : 2,
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    width: width / 2,
                    child: DropdownButtonFormField<String>(
                      value: chosenExperiment.value,
                      items: experiments.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: GoogleFonts.montserrat(
                              color: Colors.grey.shade200,
                              fontSize: 16,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        chosenExperiment.value = newValue;
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: 'Select Experiment Type',
                        border: InputBorder.none,
                        labelStyle: GoogleFonts.montserrat(
                          color: Colors.grey.shade400,
                        ),
                      ),
                      dropdownColor: Colors.grey.shade900,
                    ),
                  ),
                  SizedBox(
                    height: height / 8,
                  ),
                  Container(
                    height: height / 2,
                    child: Wrap(
                      spacing: 24,
                      runSpacing: 24,
                      children: List.generate(5, (index) {
                        return HookConsumer(builder: (context, ref, _) {
                          final isHovering = useState(false);

                          return InkWell(
                            onHover: chosenExperiment.value == null
                                ? null
                                : (hover) {
                                    isHovering.value = hover;
                                  },
                            onTap: () {},
                            child: Container(
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Container(
                                    // duration: const Duration(milliseconds: 500),
                                    width: width / 3.5,
                                    height: height / 8,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 16),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: isHovering.value
                                            ? Colors.orangeAccent
                                            : bgColor,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                      color: chosenExperiment.value == null
                                          ? Colors.black12
                                          : Colors.orangeAccent
                                              .withOpacity(0.03),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          icons[index],
                                          color: chosenExperiment.value == null
                                              ? Colors.grey.shade800
                                              : Colors.orangeAccent,
                                          size: 38,
                                        ),
                                        const SizedBox(width: 16),
                                        Text(
                                          titles[index],
                                          style: GoogleFonts.montserrat(
                                            color:
                                                chosenExperiment.value == null
                                                    ? Colors.grey.shade800
                                                    : Colors.orangeAccent,
                                            fontSize: 18,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                      }),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


// graphic_eq_rounded, auto_graph_rounded, batch_prediction, summarize_outlined 