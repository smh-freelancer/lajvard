// [OWNER] — Reusable settings selection tile widget.
// [OWNER] — Displays a title, current value, and a list of options to choose from.
// [DEV] — Generic for any setting type (temperature, language, theme).

import 'package:flutter/material.dart';

class SettingToggleTile<T> extends StatelessWidget {
  final String title;
  final T currentValue;
  final List<T> options;
  final String Function(T value) getLabel;
  final ValueChanged<T> onChanged;

  const SettingToggleTile({
    super.key,
    required this.title,
    required this.currentValue,
    required this.options,
    required this.getLabel,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .surfaceContainerHighest
            .withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.8),
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: options.map((option) {
              final isSelected = option == currentValue;
              return ChoiceChip(
                label: Text(getLabel(option)),
                selected: isSelected,
                onSelected: (_) => onChanged(option),
                labelStyle: TextStyle(
                  color: isSelected
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSurface,
                ),
                selectedColor: Theme.of(context).colorScheme.primary,
                backgroundColor: Theme.of(context)
                    .colorScheme
                    .surfaceContainerHighest
                    .withValues(alpha: 0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                side: BorderSide(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.outline,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
