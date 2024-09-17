import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProgressState {
  final int value;

  ProgressState({required this.value});

  ProgressState copyWith({int? value}) {
    return ProgressState(
      value: value ?? this.value,
    );
  }
}

class ProgressNotifier extends StateNotifier<ProgressState> {
  ProgressNotifier() : super(ProgressState(value: 2));

  // Set progress value to a specific integer
  void setProgress(int newValue) {
    state = state.copyWith(value: newValue);
  }

  // Increment progress value
  void incrementProgress() {
    state = state.copyWith(value: state.value + 1);
  }

  // Decrement progress value
  void decrementProgress() {
    if (state.value > 0) {
      state = state.copyWith(value: state.value - 1);
    }
  }
}

final progressProvider = StateNotifierProvider<ProgressNotifier, ProgressState>(
  (ref) => ProgressNotifier(),
);
