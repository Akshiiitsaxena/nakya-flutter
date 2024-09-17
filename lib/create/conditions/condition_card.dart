import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nakya/consts.dart';
import 'package:nakya/create/conditions/condition_card_state_provider.dart.dart';
import 'package:nakya/create/conditions/subcell_line_modal.dart';
// import 'package:nakya/create/conditions/condition_card_state_provider.dart';
import 'package:nakya/create/create_container_box.dart';

class ConditionCard extends HookConsumerWidget {
  final int index;
  const ConditionCard({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final card = ref.watch(cardProvider)[index];
    final cardNotifier = ref.read(cardProvider.notifier);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade900,
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Vessel ID: ',
                    style: GoogleFonts.montserrat(
                      color: Colors.grey.shade200,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'VR-24-PP-003-07-001',
                    style: GoogleFonts.montserrat(color: Colors.grey.shade200),
                  ),
                ],
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      cardNotifier.duplicateCard(index);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.copy_all_rounded,
                        color: Colors.greenAccent,
                        size: 20,
                      ),
                    ),
                  ),
                  if (index > 0)
                    InkWell(
                      onTap: () {
                        cardNotifier.deleteCard(index);
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                        margin: EdgeInsets.only(left: 12),
                        decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.delete_outline_rounded,
                          color: Colors.redAccent,
                          size: 20,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8),
          Divider(
            color: Colors.grey.shade800,
          ),
          SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: Wrap(
              spacing: 36,
              runSpacing: 20,
              children: [
                CreateContainerBox(
                  text: 'Vessel Type',
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Select Vessel Type',
                        style:
                            GoogleFonts.montserrat(color: Colors.grey.shade600),
                      ),
                    ),
                  ),
                ),
                CreateContainerBox(
                  text: 'pH SP',
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                    width: 180,
                    height: 36,
                    alignment: Alignment.center,
                    child: TextField(
                      cursorColor: Colors.greenAccent,
                      decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        hintText: 'Enter pH (0.0 to 14.0)',
                        hintStyle: GoogleFonts.montserrat(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      style: GoogleFonts.montserrat(
                          color: Colors.grey.shade200,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                CreateContainerBox(
                  text: 'Sub Cell Line',
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Select Sub Cell Line',
                        style:
                            GoogleFonts.montserrat(color: Colors.grey.shade600),
                      ),
                    ),
                  ),
                ),
                CreateContainerBox(
                  text: 'Temperatures',
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                    width: 180,
                    height: 36,
                    alignment: Alignment.center,
                    child: TextField(
                      cursorColor: Colors.greenAccent,
                      decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        hintText: 'Select Temperatures',
                        hintStyle: GoogleFonts.montserrat(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      style: GoogleFonts.montserrat(
                          color: Colors.grey.shade200,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                CreateContainerBox(
                  text: 'Feed',
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Select Feed',
                        style:
                            GoogleFonts.montserrat(color: Colors.grey.shade600),
                      ),
                    ),
                  ),
                ),
                CreateContainerBox(
                  text: 'Nutrients/Supple',
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Select Nutrients/Supple',
                        style:
                            GoogleFonts.montserrat(color: Colors.grey.shade600),
                      ),
                    ),
                  ),
                ),
                CreateContainerBox(
                  text: 'Additional Elements',
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Select Additional Elements',
                        style:
                            GoogleFonts.montserrat(color: Colors.grey.shade600),
                      ),
                    ),
                  ),
                ),
                CreateContainerBox(
                  text: 'Specific Instruments',
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Select Specific Instruments',
                        style:
                            GoogleFonts.montserrat(color: Colors.grey.shade600),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 64),
                CreateContainerBox(
                  text: 'Final Culture volume',
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Enter final culture volume',
                        style:
                            GoogleFonts.montserrat(color: Colors.grey.shade600),
                      ),
                    ),
                  ),
                ),
                CreateContainerBox(
                  text: 'Seeding Density',
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Enter Seeding Density',
                        style:
                            GoogleFonts.montserrat(color: Colors.grey.shade600),
                      ),
                    ),
                  ),
                ),
                CreateContainerBox(
                  text: 'Source Density',
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Enter Source Density',
                        style:
                            GoogleFonts.montserrat(color: Colors.grey.shade600),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 108),
                CreateContainerBox(
                  text: 'Source Culture volume',
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Enter Source Culture Volume',
                        style:
                            GoogleFonts.montserrat(color: Colors.grey.shade600),
                      ),
                    ),
                  ),
                ),
                CreateContainerBox(
                  text: 'Media volume',
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Enter Media Volume',
                        style:
                            GoogleFonts.montserrat(color: Colors.grey.shade600),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Sub Cell Line Selection
          // CreateContainerBox(
          //   text: 'Sub Cell Line',
          //   child: InkWell(
          //     onTap: () {
          //       showDialog(
          //         context: context,
          //         builder: (context) => Dialog(
          //           child: SubCellLineSelectionModal(
          //             currentSelection: card.selectedSubCellLine,
          //             onSelect: (selectedSubCellLine) {
          //               cardNotifier.updateSubCellLine(
          //                   index, selectedSubCellLine);
          //             },
          //           ),
          //         ),
          //       );
          //     },
          //     child: Text(
          //       card.selectedSubCellLine ?? 'Select Sub Cell Line',
          //     ),
          //   ),
          // ),
          // Buttons for duplication and deletion
          // Row(
          //   children: [
          //     if (index != 0) // Prevent deleting the first card
          //       IconButton(
          //         icon: Icon(Icons.delete),
          //         onPressed: () => cardNotifier.deleteCard(index),
          //       ),
          //     IconButton(
          //       icon: Icon(Icons.copy),
          //       onPressed: () => cardNotifier.duplicateCard(index),
          //     ),
          //   ],
          // ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
