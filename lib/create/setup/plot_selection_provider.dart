import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlotSelectionState {
  final String searchQuery;
  final String? selectedPlot;
  final List<String> plots;

  PlotSelectionState({
    required this.searchQuery,
    required this.selectedPlot,
    required this.plots,
  });

  PlotSelectionState copyWith({
    String? searchQuery,
    String? selectedPlot,
    List<String>? plots,
  }) {
    return PlotSelectionState(
      searchQuery: searchQuery ?? this.searchQuery,
      selectedPlot: selectedPlot ?? this.selectedPlot,
      plots: plots ?? this.plots,
    );
  }
}

class PlotSelectionNotifier extends StateNotifier<PlotSelectionState> {
  PlotSelectionNotifier()
      : super(PlotSelectionState(
          searchQuery: '',
          selectedPlot: null,
          plots: ['Bar Graph', 'Pie Chart', 'Scatter Plot'],
        ));

  // Update search query
  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  // Select a plot
  void selectPlot(String plot) {
    state = state.copyWith(selectedPlot: plot);
  }

  // Get filtered plots based on search query
  List<String> get filteredPlots {
    return state.plots
        .where((plot) =>
            plot.toLowerCase().contains(state.searchQuery.toLowerCase()))
        .toList();
  }
}

final plotSelectionProvider =
    StateNotifierProvider<PlotSelectionNotifier, PlotSelectionState>(
  (ref) => PlotSelectionNotifier(),
);
