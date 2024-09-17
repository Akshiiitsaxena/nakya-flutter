import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubCellLineSelectionState {
  final String searchQuery;
  final String? selectedSubCellLine;
  final List<String> subCellLines;

  SubCellLineSelectionState({
    required this.searchQuery,
    required this.selectedSubCellLine,
    required this.subCellLines,
  });

  SubCellLineSelectionState copyWith({
    String? searchQuery,
    String? selectedSubCellLine,
    List<String>? subCellLines,
  }) {
    return SubCellLineSelectionState(
      searchQuery: searchQuery ?? this.searchQuery,
      selectedSubCellLine: selectedSubCellLine ?? this.selectedSubCellLine,
      subCellLines: subCellLines ?? this.subCellLines,
    );
  }
}

class SubCellLineSelectionNotifier
    extends StateNotifier<SubCellLineSelectionState> {
  SubCellLineSelectionNotifier()
      : super(SubCellLineSelectionState(
          searchQuery: '',
          selectedSubCellLine: null,
          subCellLines: [
            'CHO-K1',
            'CHO-S',
            'CHO-DG44',
            'HEK293',
            'HEK293T',
            'HEK293F',
            'Vero',
            'MDCK',
          ],
        ));

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void selectSubCellLine(String subCellLine) {
    state = state.copyWith(selectedSubCellLine: subCellLine);
  }

  List<String> get filteredSubCellLines {
    return state.subCellLines
        .where((subCellLine) =>
            subCellLine.toLowerCase().contains(state.searchQuery.toLowerCase()))
        .toList();
  }
}

final subCellLineSelectionProvider = StateNotifierProvider<
    SubCellLineSelectionNotifier, SubCellLineSelectionState>(
  (ref) => SubCellLineSelectionNotifier(),
);
