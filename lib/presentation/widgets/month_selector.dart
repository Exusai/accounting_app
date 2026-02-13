import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthSelector extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<int> onMonthChanged;

  const MonthSelector({
    super.key,
    required this.selectedDate,
    required this.onMonthChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => onMonthChanged(-1),
        ),
        Text(
          DateFormat.yMMMM(Localizations.localeOf(context).toString())
              .format(selectedDate),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: () => onMonthChanged(1),
        ),
      ],
    );
  }
}
