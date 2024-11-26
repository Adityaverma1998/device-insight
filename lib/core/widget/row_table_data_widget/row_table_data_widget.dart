import 'package:flutter/material.dart';

class RowTableDataWidget extends StatelessWidget {

  final String label;
  final String value;
  final bool isDivider;
  const RowTableDataWidget({super.key, required this.label, required this.value, required this.isDivider});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
              ),
              const SizedBox(
                width: 2.0,
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                maxLines: 2,

              ),
            ],
          ),
        ),
        isDivider
            ? Divider(
          color: Theme.of(context).colorScheme.primaryContainer,
          // The color of the line
          height: 20,
          // The space around the divider
          thickness: 1,
          // The thickness of the divider line
          indent: 0,
          // The starting indent on the left side
          endIndent: 0, // The ending indent on the right side
        )
            : const SizedBox.shrink()
      ],
    );
  }

}
