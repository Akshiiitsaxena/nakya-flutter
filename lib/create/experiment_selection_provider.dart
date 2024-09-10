import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExperimentSelectionState {
  final String searchQuery;
  final String selectedExperiment;
  final List<String> experiments;

  ExperimentSelectionState({
    required this.searchQuery,
    required this.selectedExperiment,
    required this.experiments,
  });

  ExperimentSelectionState copyWith({
    String? searchQuery,
    String? selectedExperiment,
    List<String>? experiments,
  }) {
    return ExperimentSelectionState(
      searchQuery: searchQuery ?? this.searchQuery,
      selectedExperiment: selectedExperiment ?? this.selectedExperiment,
      experiments: experiments ?? this.experiments,
    );
  }
}

class ExperimentSelectionNotifier
    extends StateNotifier<ExperimentSelectionState> {
  ExperimentSelectionNotifier()
      : super(ExperimentSelectionState(
          searchQuery: '',
          selectedExperiment: '',
          experiments: [
            'Protein production transient transfection',
            'Protein production stable cell line',
            'Viral vector production transient transfection',
            'Cell therapy cell expansion',
            'Cell therapy viral transduction',
            'Cell therapy CRISPR',
            'Seed train/expansion',
          ],
        ));

  // Update search query
  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  // Select an experiment
  void selectExperiment(String experiment) {
    state = state.copyWith(selectedExperiment: experiment);
  }

  // Get filtered experiments based on search query
  List<String> get filteredExperiments {
    return state.experiments
        .where((experiment) =>
            experiment.toLowerCase().contains(state.searchQuery.toLowerCase()))
        .toList();
  }
}

final experimentSelectionProvider = StateNotifierProvider<
    ExperimentSelectionNotifier, ExperimentSelectionState>(
  (ref) => ExperimentSelectionNotifier(),
);
