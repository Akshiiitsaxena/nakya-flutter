import 'package:hooks_riverpod/hooks_riverpod.dart';

class CardState {
  final List<String> selectedInstruments;
  final String? selectedSubCellLine;

  CardState({
    required this.selectedInstruments,
    required this.selectedSubCellLine,
  });

  CardState copyWith({
    List<String>? selectedInstruments,
    String? selectedSubCellLine,
  }) {
    return CardState(
      selectedInstruments: selectedInstruments ?? this.selectedInstruments,
      selectedSubCellLine: selectedSubCellLine ?? this.selectedSubCellLine,
    );
  }
}

class CardNotifier extends StateNotifier<List<CardState>> {
  CardNotifier()
      : super([
          CardState(selectedInstruments: [], selectedSubCellLine: null),
        ]); // Start with one default card

  // Add a new blank card
  void addCard() {
    state = [
      ...state,
      CardState(selectedInstruments: [], selectedSubCellLine: null)
    ];
  }

  // Duplicate a card
  void duplicateCard(int index) {
    final cardToDuplicate = state[index];
    state = [
      ...state,
      cardToDuplicate.copyWith(),
    ];
  }

  // Delete a card (except the first one)
  void deleteCard(int index) {
    if (index == 0) return; // Prevent deleting the first card
    state = List.from(state)..removeAt(index);
  }

  // Update instruments for a specific card
  void updateInstruments(int index, List<String> selectedInstruments) {
    final updatedCard =
        state[index].copyWith(selectedInstruments: selectedInstruments);
    state = List.from(state)..[index] = updatedCard;
  }

  // Update Sub Cell Line for a specific card
  void updateSubCellLine(int index, String? selectedSubCellLine) {
    final updatedCard =
        state[index].copyWith(selectedSubCellLine: selectedSubCellLine);
    state = List.from(state)..[index] = updatedCard;
  }
}

final cardProvider = StateNotifierProvider<CardNotifier, List<CardState>>(
  (ref) => CardNotifier(),
);
