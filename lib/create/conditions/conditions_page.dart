import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nakya/create/conditions/condition_card.dart';
import 'package:nakya/create/conditions/condition_card_state_provider.dart.dart';
import 'package:nakya/create/progress_provider.dart';

class ConditionsPage extends HookConsumerWidget {
  const ConditionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cards = ref.watch(cardProvider);

    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
              child: Container(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(64),
                        color: Colors.grey.shade900
                        // border: Border.all(),
                        ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Number of Conditions: ',
                          style: GoogleFonts.montserrat(
                              color: Colors.grey.shade400,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '4',
                          style: GoogleFonts.montserrat(
                            color: Colors.greenAccent,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    // color: Colors.red,
                    // height: 100,
                    // width: 100,
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      ...List.generate(
                        cards.length,
                        (index) => ConditionCard(index: index),
                      ),
                      // ElevatedButton(
                      //   onPressed: () =>
                      //       ref.read(cardProvider.notifier).addCard(),
                      //   child: Text('Add Card'),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          )),
          Container(
            width: 1,
            height: double.infinity,
            color: Colors.grey.shade800,
          ),
          Container(
            width: 150,
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 36),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(128),
                    gradient: LinearGradient(
                      colors: [Colors.greenAccent, Colors.greenAccent.shade400],
                    ),
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 12),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                    size: 24,
                  ),
                ),
                SizedBox(width: 16),
                InkWell(
                  onTap: () {
                    ref.read(progressProvider.notifier).setProgress(3);
                  },
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(128),
                      gradient: LinearGradient(
                        colors: [
                          Colors.greenAccent,
                          Colors.greenAccent.shade400
                        ],
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
            // color: Colors.red,
          )
        ],
      ),
    );
  }
}
