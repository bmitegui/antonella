import 'package:flutter/material.dart';
class CustomTitle extends StatelessWidget {
  final String title;
  final String? description;
  final String? index;
  final bool isExpanded; // <-- nuevo
  final VoidCallback? onTap; // <-- nuevo

  const CustomTitle({
    super.key,
    required this.title,
    this.description,
    this.index,
    this.isExpanded = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          (index == null)
              ? Container(
                  width: 6, height: 24, color: colorScheme.primary)
              : CircleAvatar(
                  backgroundColor: colorScheme.primary,
                  child: Text(
                    index!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: colorScheme.onPrimary),
                  ),
                ),
          const SizedBox(width: 8),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: colorScheme.onSurface),
                  ),
                ),
                if (description != null)
                  Expanded(
                    child: Text(description!),
                  ),
                if (onTap != null)
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: colorScheme.onSurface,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
