import 'package:flutter/material.dart';
import '../models/note.dart';

class NoteCard extends StatefulWidget {
  final Note note;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final ValueChanged<bool> onFavoriteToggle;

  const NoteCard({
    super.key,
    required this.note,
    required this.onTap,
    required this.onDelete,
    required this.onFavoriteToggle,
  });

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _favoriteController;

  @override
  void initState() {
    super.initState();
    _favoriteController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _favoriteController.dispose();
    super.dispose();
  }

  void _toggleFavorite() {
    if (widget.note.isFavorite) {
      _favoriteController.reverse();
    } else {
      _favoriteController.forward();
    }
    widget.onFavoriteToggle(!widget.note.isFavorite);
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${date.month}/${date.day}/${date.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final luminance = widget.note.color.computeLuminance();
    final textColor = luminance > 0.5 ? Colors.black87 : Colors.white;
    final contentColor = luminance > 0.5 
        ? Colors.black54  // Darker for light backgrounds
        : Colors.white.withOpacity(0.9);  // Light for dark backgrounds

    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: widget.note.color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: widget.note.color.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with favorite button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.note.title.isNotEmpty)
                          Text(
                            widget.note.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: textColor,
                                  fontWeight: FontWeight.w700,
                                ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        if (widget.note.category != NoteCategory.personal)
                          Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: textColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                widget.note.category.name.toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                      color: textColor,
                                      fontSize: 10,
                                    ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  ScaleTransition(
                    scale: Tween<double>(begin: 1.0, end: 1.2)
                        .animate(_favoriteController),
                    child: GestureDetector(
                      onTap: _toggleFavorite,
                      child: Icon(
                        widget.note.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border_rounded,
                        color: textColor.withOpacity(
                          widget.note.isFavorite ? 1.0 : 0.6,
                        ),
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Content preview
              Text(
                widget.note.content,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: contentColor,
                    ),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),

              // Tags
              if (widget.note.tags.isNotEmpty)
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: widget.note.tags
                      .take(2)
                      .map((tag) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: textColor.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '#$tag',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: textColor.withOpacity(0.8),
                                  ),
                            ),
                          ))
                      .toList(),
                ),
              const SizedBox(height: 8),

              // Footer with date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    child: Text(
                      _formatDate(widget.note.lastModified),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: textColor.withOpacity(0.6),
                          ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Delete Note'),
                          content: const Text(
                            'Are you sure you want to delete this note?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                widget.onDelete();
                              },
                              child: const Text('Delete',
                                  style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Icon(
                      Icons.delete_outline_rounded,
                      size: 18,
                      color: textColor.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}