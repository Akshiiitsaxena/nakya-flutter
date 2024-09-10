import 'package:flutter_riverpod/flutter_riverpod.dart';

class CollaboratorSelectionState {
  final String searchQuery;
  final List<String> selectedCollaborators;
  final List<String> collaborators;
  final bool isHighlighted;

  CollaboratorSelectionState({
    required this.searchQuery,
    required this.selectedCollaborators,
    required this.collaborators,
    required this.isHighlighted,
  });

  CollaboratorSelectionState copyWith({
    String? searchQuery,
    List<String>? selectedCollaborators,
    List<String>? collaborators,
    bool? isHighlighted,
  }) {
    return CollaboratorSelectionState(
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCollaborators:
          selectedCollaborators ?? this.selectedCollaborators,
      collaborators: collaborators ?? this.collaborators,
      isHighlighted: isHighlighted ?? this.isHighlighted,
    );
  }
}

class CollaboratorSelectionNotifier
    extends StateNotifier<CollaboratorSelectionState> {
  CollaboratorSelectionNotifier()
      : super(
          CollaboratorSelectionState(
            searchQuery: '',
            selectedCollaborators: [],
            collaborators: [
              'Dr. Smith',
              'Dr. Johnson',
              'Dr. Williams',
              'Dr. Brown',
              'Dr. Jones',
              'Dr. Garcia',
              'Dr. Miller',
            ],
            isHighlighted: false,
          ),
        );

  // Update search query
  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  // Toggle collaborator selection
  void toggleCollaborator(String collaborator) {
    final isSelected = state.selectedCollaborators.contains(collaborator);
    final updatedCollaborators = isSelected
        ? state.selectedCollaborators.where((c) => c != collaborator).toList()
        : [...state.selectedCollaborators, collaborator];

    state = state.copyWith(selectedCollaborators: updatedCollaborators);
  }

  void setHighlighted(bool val) {
    state = state.copyWith(isHighlighted: val);
  }

  // Get filtered collaborators based on search query
  List<String> get filteredCollaborators {
    return state.collaborators
        .where((collaborator) => collaborator
            .toLowerCase()
            .contains(state.searchQuery.toLowerCase()))
        .toList();
  }
}

final collaboratorSelectionProvider = StateNotifierProvider<
    CollaboratorSelectionNotifier, CollaboratorSelectionState>(
  (ref) => CollaboratorSelectionNotifier(),
);
