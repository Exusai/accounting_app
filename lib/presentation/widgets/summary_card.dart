import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final double amount;
  final Color color;
  final IconData icon;

  const SummaryCard({
    super.key,
    required this.title,
    required this.amount,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Theme.of(context).cardTheme.color,
      surfaceTintColor: color.withValues(alpha: 0.1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                  ),
                ),
                Icon(icon, color: color),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              NumberFormat.currency(symbol: '\$').format(amount),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
