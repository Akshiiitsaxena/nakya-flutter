import 'package:flutter_riverpod/flutter_riverpod.dart';

class GeneralCellLineSelectionState {
  final String searchQuery;
  final String selectedCellLine;
  final List<String> cellLines;

  GeneralCellLineSelectionState({
    required this.searchQuery,
    required this.selectedCellLine,
    required this.cellLines,
  });

  GeneralCellLineSelectionState copyWith({
    String? searchQuery,
    String? selectedCellLine,
    List<String>? cellLines,
  }) {
    return GeneralCellLineSelectionState(
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCellLine: selectedCellLine ?? this.selectedCellLine,
      cellLines: cellLines ?? this.cellLines,
    );
  }
}

class GeneralCellLineSelectionNotifier
    extends StateNotifier<GeneralCellLineSelectionState> {
  GeneralCellLineSelectionNotifier()
      : super(GeneralCellLineSelectionState(
          searchQuery: '',
          selectedCellLine: '',
          cellLines: [
            'CHO',
            'HEK',
            'Stem cells',
            'Non Stem cells',
          ],
        ));

  // Update search query
  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  // Select a cell line
  void selectCellLine(String cellLine) {
    state = state.copyWith(selectedCellLine: cellLine);
  }

  // Get filtered cell lines based on search query
  List<String> get filteredCellLines {
    return state.cellLines
        .where((cellLine) =>
            cellLine.toLowerCase().contains(state.searchQuery.toLowerCase()))
        .toList();
  }
}

final generalCellLineSelectionProvider = StateNotifierProvider<
    GeneralCellLineSelectionNotifier, GeneralCellLineSelectionState>(
  (ref) => GeneralCellLineSelectionNotifier(),
);
