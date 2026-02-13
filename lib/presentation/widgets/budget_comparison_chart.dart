import 'package:accounting_app/domain/model/concepto.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BudgetComparisonChart extends StatelessWidget {
  final List<Concepto> conceptos;
  final Map<String, double> actualSpending;

  const BudgetComparisonChart({
    super.key,
    required this.conceptos,
    required this.actualSpending,
  });

  @override
  Widget build(BuildContext context) {
    // Filter out conceptos with zero budget, "Ingreso", and sort by budget descending
    final validConceptos = conceptos
        .where((c) => c.presupuesto > 0 && c.nombreConcepto.toLowerCase() != 'ingreso')
        .toList()
      ..sort((a, b) => b.presupuesto.compareTo(a.presupuesto));

    if (validConceptos.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Text("No budget data available"),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Vertical slider items in a scrollable row
        SizedBox(
          height: 300,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: validConceptos.map((concepto) {
                final actual = actualSpending[concepto.nombreConcepto] ?? 0;
                final budget = concepto.presupuesto;
                final actualColor = actual > budget ? Colors.red : Colors.green;

                return _buildVerticalSliderItem(
                  context,
                  concepto.nombreConcepto,
                  budget,
                  actual,
                  budget,
                  actualColor,
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalSliderItem(
    BuildContext context,
    String name,
    double budget,
    double actual,
    double maxValue,
    Color actualColor,
  ) {
    final budgetPercent = budget / maxValue;
    final actualPercent = actual / maxValue;
    const barHeight = 220.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Bars container
          SizedBox(
            height: barHeight + 40, // Extra space for labels
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Budget bar
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Value label
                    SizedBox(
                      height: 16,
                      child: Text(
                        NumberFormat.compact().format(budget),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                            ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Vertical bar
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        // Background track
                        Container(
                          width: 32,
                          height: barHeight,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        // Budget fill
                        Container(
                          width: 32,
                          height: barHeight * budgetPercent,
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // Label
                    SizedBox(
                      height: 16,
                      child: Text(
                        'Budget',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 10,
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                // Actual bar
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Value label
                    SizedBox(
                      height: 16,
                      child: Text(
                        NumberFormat.compact().format(actual),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                              color: actual > budget ? Colors.red : null,
                            ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Vertical bar
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        // Background track
                        Container(
                          width: 32,
                          height: barHeight,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        // Actual fill
                        Container(
                          width: 32,
                          height: barHeight * actualPercent.clamp(0.0, 1.0),
                          decoration: BoxDecoration(
                            color: actualColor.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // Label
                    SizedBox(
                      height: 16,
                      child: Text(
                        'Actual',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 10,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Category name
          SizedBox(
            width: 80,
            child: Text(
              name,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.fade,
              softWrap: false,
            ),
          ),
        ],
      ),
    );
  }
}

