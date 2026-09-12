import 'package:flutter/material.dart';

class CustomNoteItem extends StatelessWidget {
  final String noteId;
  final String title;
  final String description;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? descriptionColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final Future<bool?> Function(DismissDirection)? confirmDismiss;
  final DismissDirectionCallback? onDismissed;

  const CustomNoteItem({
    super.key,
    required this.noteId,
    required this.title,
    required this.description,
    this.backgroundColor,
    this.titleColor,
    this.descriptionColor,
    this.borderRadius = 12.0,
    this.padding = const EdgeInsets.all(16.0),
    this.onTap,
    this.confirmDismiss,
    this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dismissible(
      key: Key(noteId),
      direction: DismissDirection.horizontal,
      confirmDismiss: confirmDismiss,
      onDismissed: onDismissed,
      background: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: const Icon(Icons.delete, color: Colors.white, size: 28),
      ),
      secondaryBackground: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: const Icon(Icons.delete, color: Colors.white, size: 28),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          width: double.infinity,
          padding: padding,
          decoration: BoxDecoration(
            color: backgroundColor ?? theme.colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: 0.2),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: titleColor ?? theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: descriptionColor ?? theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
