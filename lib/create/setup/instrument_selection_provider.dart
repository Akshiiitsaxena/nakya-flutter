import 'package:flutter_riverpod/flutter_riverpod.dart';

class InstrumentSelectionState {
  final String searchQuery;
  final List<String> selectedInstruments;
  final List<String> instruments;

  InstrumentSelectionState({
    required this.searchQuery,
    required this.selectedInstruments,
    required this.instruments,
  });

  InstrumentSelectionState copyWith({
    String? searchQuery,
    List<String>? selectedInstruments,
    List<String>? instruments,
  }) {
    return InstrumentSelectionState(
      searchQuery: searchQuery ?? this.searchQuery,
      selectedInstruments: selectedInstruments ?? this.selectedInstruments,
      instruments: instruments ?? this.instruments,
    );
  }
}

class InstrumentSelectionNotifier
    extends StateNotifier<InstrumentSelectionState> {
  InstrumentSelectionNotifier()
      : super(InstrumentSelectionState(
          searchQuery: '',
          selectedInstruments: [],
          instruments: [
            'Vi-CELL BLU cell viability analyzer',
            'Vi-CELL XR Cell Viability Analyzer',
            'BioProfile® FLEX2',
            'Cedex® Bio HT Analyzer',
            'NucleoCounter® NC-200™',
            'NucleoCounter® NC-3000™',
            'REBEL',
            'BioTek Gen5',
          ],
        ));

  // Update search query
  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  // Toggle instrument selection
  void toggleInstrument(String instrument) {
    final isSelected = state.selectedInstruments.contains(instrument);
    final updatedInstruments = isSelected
        ? state.selectedInstruments.where((i) => i != instrument).toList()
        : [...state.selectedInstruments, instrument];

    state = state.copyWith(selectedInstruments: updatedInstruments);
  }

  // Get filtered instruments based on search query
  List<String> get filteredInstruments {
    return state.instruments
        .where((instrument) =>
            instrument.toLowerCase().contains(state.searchQuery.toLowerCase()))
        .toList();
  }
}

final instrumentSelectionProvider = StateNotifierProvider<
    InstrumentSelectionNotifier, InstrumentSelectionState>(
  (ref) => InstrumentSelectionNotifier(),
);
