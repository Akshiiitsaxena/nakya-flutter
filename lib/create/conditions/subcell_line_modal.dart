import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nakya/consts.dart';
import 'package:nakya/create/conditions/subcell_line_provider.dart';

class SubCellLineSelectionModal extends HookConsumerWidget {
  final Function(String) onSelect;
  final String? currentSelection;

  const SubCellLineSelectionModal({
    Key? key,
    required this.onSelect,
    required this.currentSelection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final hoveringIndex = useState(-1);
    final searchController = useTextEditingController();
    final selectedSubCellLine = useState<String?>(currentSelection);

    final state = ref.watch(subCellLineSelectionProvider);
    final notifier = ref.read(subCellLineSelectionProvider.notifier);

    final filteredSubCellLines = notifier.filteredSubCellLines;

    return Container(
      height: height / 2,
      width: width / 3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade900),
        color: bgColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ... (header and search field remain the same)
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: filteredSubCellLines.length,
              itemBuilder: (context, index) {
                final subCellLine = filteredSubCellLines[index];
                final isSelected = subCellLine == selectedSubCellLine.value;
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                  child: InkWell(
                    onTap: () {
                      selectedSubCellLine.value = subCellLine;
                      onSelect(subCellLine);
                      Navigator.of(context).pop();
                    },
                    onHover: (val) {
                      hoveringIndex.value = val ? index : -1;
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                        color: index == hoveringIndex.value
                            ? Colors.grey.shade800.withOpacity(0.5)
                            : (isSelected
                                ? Colors.greenAccent.withOpacity(0.2)
                                : Colors.transparent),
                        borderRadius: BorderRadius.circular(64),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              subCellLine,
                              style: GoogleFonts.montserrat(
                                color: Colors.grey.shade400,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          if (isSelected)
                            Icon(Icons.check,
                                color: Colors.greenAccent, size: 20),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
