import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nakya/consts.dart';
import 'package:nakya/create/setup/plot_selection_provider.dart';

class PlotSelectionModal extends HookConsumerWidget {
  const PlotSelectionModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final hoveringIndex = useState(-1);
    final searchController = useTextEditingController();

    // Get the state and notifier from the provider
    final state = ref.watch(plotSelectionProvider);
    final notifier = ref.read(plotSelectionProvider.notifier);

    // Filtered plots from the provider
    final filteredPlots = state.plots
        .where((plot) =>
            plot.toLowerCase().contains(state.searchQuery.toLowerCase()))
        .toList();

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
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 16,
            ),
            child: Text(
              'Select Plot Type',
              style: GoogleFonts.montserrat(
                color: Colors.grey.shade400,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade800.withOpacity(0.5),
            ),
            child: TextField(
              controller: searchController,
              cursorColor: Colors.greenAccent,
              scrollPadding: EdgeInsets.zero,
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                hintText: 'Search Plot Type',
                hintStyle: GoogleFonts.montserrat(
                  color: Colors.grey.shade700,
                  fontSize: 14,
                ),
              ),
              style: GoogleFonts.montserrat(
                color: Colors.grey.shade200,
                fontSize: 14,
              ),
              onChanged: (value) {
                notifier.setSearchQuery(value); // Update search query
              },
            ),
          ),
          const SizedBox(height: 16),

          // Display selected plot
          if (state.selectedPlot != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'Selected: ${state.selectedPlot}',
                style: GoogleFonts.montserrat(
                  color: Colors.grey.shade200,
                ),
              ),
            ),

          const SizedBox(height: 16),
          Divider(
            color: Colors.grey.shade800,
            height: 5,
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: filteredPlots.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                  child: InkWell(
                    onTap: () {
                      notifier.selectPlot(filteredPlots[index]);
                      Navigator.of(context)
                          .pop(); // Close modal after selection
                    },
                    onHover: (val) {
                      if (val) {
                        hoveringIndex.value = index;
                      } else {
                        hoveringIndex.value = -1;
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                        color: index == hoveringIndex.value
                            ? Colors.grey.shade800.withOpacity(0.5)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(64),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          filteredPlots[index],
                          style: GoogleFonts.montserrat(
                            color: Colors.grey.shade400,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.left,
                        ),
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
