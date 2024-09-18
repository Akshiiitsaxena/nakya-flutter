import 'package:hooks_riverpod/hooks_riverpod.dart';

class ScheduleSelectionState {
  final Map<int, Set<int>> selectedValues;

  ScheduleSelectionState({required this.selectedValues});

  ScheduleSelectionState copyWith({Map<int, Set<int>>? selectedValues}) {
    return ScheduleSelectionState(
      selectedValues: selectedValues ?? this.selectedValues,
    );
  }
}

class ScheduleSelectionNotifier extends StateNotifier<ScheduleSelectionState> {
  ScheduleSelectionNotifier()
      : super(ScheduleSelectionState(selectedValues: {}));

  void toggleSelection(int conditionIndex, int valueIndex) {
    final currentSelected = Map<int, Set<int>>.from(state.selectedValues);

    if (!currentSelected.containsKey(conditionIndex)) {
      currentSelected[conditionIndex] = {};
    }

    if (currentSelected[conditionIndex]!.contains(valueIndex)) {
      currentSelected[conditionIndex]!.remove(valueIndex);
    } else {
      currentSelected[conditionIndex]!.add(valueIndex);
    }

    state = state.copyWith(selectedValues: currentSelected);
  }

  bool isSelected(int conditionIndex, int valueIndex) {
    return state.selectedValues[conditionIndex]?.contains(valueIndex) ?? false;
  }

  void clearAll() {
    state = state.copyWith(selectedValues: {});
  }
}

final scheduleSelectionProvider =
    StateNotifierProvider<ScheduleSelectionNotifier, ScheduleSelectionState>(
  (ref) => ScheduleSelectionNotifier(),
);
