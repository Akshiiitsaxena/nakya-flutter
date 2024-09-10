import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nakya/common/nakya_app_bar.dart';
import 'package:nakya/consts.dart';
import 'package:nakya/create/collab_selection_model.dart';
import 'package:nakya/create/collab_selection_provider.dart';
import 'package:nakya/create/create_container_box.dart';
import 'package:nakya/create/experiment_selection_provider.dart';
import 'package:nakya/create/experiment_type_selection_model.dart';
import 'package:nakya/create/general_cell_selection_model.dart';
import 'package:nakya/create/general_cell_selection_provider.dart';
import 'package:nakya/create/progress_bar.dart';

class CreatePage extends HookConsumerWidget {
  const CreatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startDate = useState('mm/dd/yyyy');
    final endDate = useState('mm/dd/yyyy');

    final expState = ref.watch(experimentSelectionProvider);
    final expNotifier = ref.read(experimentSelectionProvider.notifier);

    final collabState = ref.watch(collaboratorSelectionProvider);
    final collabNotifier = ref.watch(collaboratorSelectionProvider.notifier);

    final cellLineState = ref.watch(generalCellLineSelectionProvider);
    final cellLineNotifier =
        ref.watch(generalCellLineSelectionProvider.notifier);

    return Scaffold(
      body: Column(
        children: [
          const NakyaAppBar(),
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.grey.shade800,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              color: bgColor,
              child: Row(
                children: [
                  const ProgressBar(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 32),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CreateContainerBox(
                                text: 'Collaborators',
                                focus: collabState.isHighlighted,
                                child: InkWell(
                                  onTap: () {
                                    collabNotifier.setSearchQuery('');
                                    collabNotifier.setHighlighted(true);
                                    showDialog(
                                      context: context,
                                      builder: (_) {
                                        return const AlertDialog(
                                          contentPadding: EdgeInsets.zero,
                                          content: CollaboratorSelectionModal(),
                                        );
                                      },
                                    ).then((_) {
                                      collabNotifier.setHighlighted(false);
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.people_alt_outlined,
                                          color: Colors.grey.shade700,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 12),
                                        // Display selected collaborators or the default "Add Collaborators" text
                                        collabState
                                                .selectedCollaborators.isEmpty
                                            ? Text(
                                                'Add Collaborators',
                                                style: GoogleFonts.montserrat(
                                                  color: Colors.grey.shade700,
                                                ),
                                              )
                                            : Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  // Display up to 2 selected collaborators
                                                  for (int i = 0;
                                                      i <
                                                          (collabState.selectedCollaborators
                                                                      .length >
                                                                  2
                                                              ? 2
                                                              : collabState
                                                                  .selectedCollaborators
                                                                  .length);
                                                      i++)
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8.0),
                                                      child: Text(
                                                        collabState
                                                            .selectedCollaborators[i],
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          color: Colors
                                                              .grey.shade200,
                                                        ),
                                                      ),
                                                    ),
                                                  // If more than 2 collaborators, show "and X more"
                                                  if (collabState
                                                          .selectedCollaborators
                                                          .length >
                                                      2)
                                                    Text(
                                                      'and ${collabState.selectedCollaborators.length - 2} more',
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        color: Colors
                                                            .grey.shade500,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                ],
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 64),
                              CreateContainerBox(
                                text: 'Department',
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.account_balance,
                                        color: Colors.grey.shade700,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        'Select Department',
                                        style: GoogleFonts.montserrat(
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 64),
                              CreateContainerBox(
                                text: 'Start Date',
                                child: InkWell(
                                  onTap: () async {
                                    DateTime? date = await showDatePicker(
                                      context: context,
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2101),
                                    );
                                    if (date != null) {
                                      startDate.value =
                                          DateFormat('MM-dd-yyyy').format(date);
                                    }
                                  },
                                  onHover: (_) {},
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_today,
                                          color: Colors.grey.shade700,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 12),
                                        Text(
                                          startDate.value,
                                          style: GoogleFonts.montserrat(
                                            color:
                                                startDate.value.startsWith('mm')
                                                    ? Colors.grey.shade700
                                                    : Colors.grey.shade500,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 24),
                              CreateContainerBox(
                                text: 'End Date',
                                child: InkWell(
                                  onTap: () async {
                                    DateTime? date = await showDatePicker(
                                      context: context,
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2101),
                                    );
                                    if (date != null) {
                                      endDate.value =
                                          DateFormat('MM-dd-yyyy').format(date);
                                    }
                                  },
                                  onHover: (_) {},
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_today,
                                          color: Colors.grey.shade700,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 12),
                                        Text(
                                          endDate.value,
                                          style: GoogleFonts.montserrat(
                                            color:
                                                endDate.value.startsWith('mm')
                                                    ? Colors.grey.shade700
                                                    : Colors.grey.shade500,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              CreateContainerBox(
                                text: 'Program Name',
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.topic_outlined,
                                        color: Colors.grey.shade700,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        'Select Program Name',
                                        style: GoogleFonts.montserrat(
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 64),
                              CreateContainerBox(
                                text: 'Experiment Type',
                                child: InkWell(
                                  onTap: () {
                                    expNotifier.setSearchQuery('');
                                    showDialog(
                                      context: context,
                                      builder: (_) {
                                        return const AlertDialog(
                                          contentPadding: EdgeInsets.zero,
                                          content:
                                              ExperimentTypeSelectionModal(),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.label_important_outline_sharp,
                                          color: Colors.grey.shade700,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 12),
                                        Text(
                                          expState.selectedExperiment.isEmpty
                                              ? 'Select Experiment Type'
                                              : expState.selectedExperiment,
                                          style: GoogleFonts.montserrat(
                                            color: expState
                                                    .selectedExperiment.isEmpty
                                                ? Colors.grey.shade700
                                                : Colors.grey.shade400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              CreateContainerBox(
                                text: 'Title',
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 0),
                                  width: 500,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.edit_note_rounded,
                                        color: Colors.grey.shade700,
                                        size: 24,
                                      ),
                                      const SizedBox(width: 12),
                                      SizedBox(
                                        width: 200,
                                        child: TextField(
                                          cursorColor: Colors.greenAccent,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.zero,
                                            hintText: 'Enter Title...',
                                            hintStyle: GoogleFonts.montserrat(
                                              color: Colors.grey.shade700,
                                              fontSize: 14,
                                            ),
                                          ),
                                          style: GoogleFonts.montserrat(
                                            color: Colors.grey.shade200,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              CreateContainerBox(
                                text: 'Objective',
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 0),
                                  width: 1000,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.description_outlined,
                                        color: Colors.grey.shade700,
                                        size: 24,
                                      ),
                                      const SizedBox(width: 12),
                                      SizedBox(
                                        width: 900,
                                        child: TextField(
                                          cursorColor: Colors.greenAccent,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.zero,
                                            hintText: 'Enter Objective...',
                                            hintStyle: GoogleFonts.montserrat(
                                              color: Colors.grey.shade700,
                                              fontSize: 14,
                                            ),
                                          ),
                                          style: GoogleFonts.montserrat(
                                            color: Colors.grey.shade200,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              CreateContainerBox(
                                text: 'General Cell Line',
                                child: InkWell(
                                  onTap: () {
                                    cellLineNotifier.setSearchQuery('');
                                    showDialog(
                                      context: context,
                                      builder: (_) {
                                        return const AlertDialog(
                                          contentPadding: EdgeInsets.zero,
                                          content:
                                              GeneralCellLineSelectionModal(),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.arrow_drop_down_circle_outlined,
                                          color: Colors.grey.shade700,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 12),
                                        Text(
                                          'Select Cell Line',
                                          style: GoogleFonts.montserrat(
                                            color: Colors.grey.shade700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 64),
                              CreateContainerBox(
                                text: 'Instruments',
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_drop_down_circle_outlined,
                                        color: Colors.grey.shade700,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        'Select Instrument',
                                        style: GoogleFonts.montserrat(
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 64),
                              CreateContainerBox(
                                text: 'Plots',
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.poll_outlined,
                                        color: Colors.grey.shade700,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        'Select Plots',
                                        style: GoogleFonts.montserrat(
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 48),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              onHover: (value) {},
                              onTap: () {
                                // Navigator.pushNamedAndRemoveUntil(
                                //     context, '/', (_) => false);
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                width: 160,
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
                                  'Start!',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
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
