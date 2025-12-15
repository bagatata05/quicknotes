import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../providers/note_provider.dart';
import '../theme/theme.dart';
import '../widgets/color_picker.dart';

class NoteEditScreen extends StatefulWidget {
  final Note? note;

  const NoteEditScreen({super.key, this.note});

  @override
  State<NoteEditScreen> createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late Color _selectedColor;
  late NoteCategory _selectedCategory;
  late List<String> _selectedTags;

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController = TextEditingController(text: widget.note!.title);
      _contentController = TextEditingController(text: widget.note!.content);
      _selectedColor = widget.note!.color;
      _selectedCategory = widget.note!.category;
      _selectedTags = List.from(widget.note!.tags);
    } else {
      _titleController = TextEditingController();
      _contentController = TextEditingController();
      _selectedColor = noteColors.first;
      _selectedCategory = NoteCategory.personal;
      _selectedTags = [];
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveNote() {
    if (_titleController.text.trim().isEmpty &&
        _contentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Note cannot be empty'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
      return;
    }

    final noteProvider = Provider.of<NoteProvider>(context, listen: false);
    if (widget.note != null) {
      final updatedNote = widget.note!.copyWith(
        title: _titleController.text,
        content: _contentController.text,
        color: _selectedColor,
        category: _selectedCategory,
        tags: _selectedTags,
      );
      noteProvider.updateNote(updatedNote);
    } else {
      final newNote = Note(
        id: '',
        title: _titleController.text,
        content: _contentController.text,
        color: _selectedColor,
        createdAt: DateTime.now(),
        lastModified: DateTime.now(),
        isFavorite: false,
        category: _selectedCategory,
        tags: _selectedTags,
      );
      noteProvider.addNote(newNote);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(widget.note != null ? 'Note updated' : 'Note created'),
        duration: const Duration(milliseconds: 1500),
      ),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final textColor =
        _selectedColor.computeLuminance() > 0.5 ? Colors.black87 : Colors.white;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
        title: Text(
          widget.note != null ? 'Edit Note' : 'New Note',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: textColor,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.favorite_rounded,
              color: widget.note?.isFavorite == true ? textColor : textColor.withOpacity(0.5),
            ),
            onPressed: () {
              if (widget.note != null) {
                Navigator.pop(context);
                Provider.of<NoteProvider>(context, listen: false)
                    .toggleFavorite(widget.note!.id);
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.check_rounded, color: textColor),
            onPressed: _saveNote,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Input
              TextField(
                controller: _titleController,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w700,
                ),
                decoration: InputDecoration(
                  hintText: 'Note Title',
                  hintStyle: TextStyle(
                    color: textColor.withOpacity(0.4),
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const SizedBox(height: 16),

              // Category Selection
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'CATEGORY',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: textColor.withOpacity(0.6),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: NoteCategory.values.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final category = NoteCategory.values[index];
                    final isSelected = _selectedCategory == category;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedCategory = category),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? textColor.withOpacity(0.3)
                              : textColor.withOpacity(0.1),
                          border: Border.all(
                            color: textColor.withOpacity(0.5),
                            width: isSelected ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          category.name.toUpperCase(),
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: textColor,
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              // Content Input
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'CONTENT',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: textColor.withOpacity(0.6),
                  ),
                ),
              ),
              TextField(
                controller: _contentController,
                maxLines: null,
                minLines: 6,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: textColor,
                ),
                decoration: InputDecoration(
                  hintText: 'Start typing your note here...',
                  hintStyle: TextStyle(
                    color: textColor.withOpacity(0.4),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: textColor.withOpacity(0.3),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: textColor.withOpacity(0.3),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: textColor.withOpacity(0.6),
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: textColor.withOpacity(0.05),
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
              const SizedBox(height: 24),

              // Color Picker
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'COLOR',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: textColor.withOpacity(0.6),
                  ),
                ),
              ),
              ColorPicker(
                selectedColor: _selectedColor,
                onColorSelected: (color) {
                  setState(() {
                    _selectedColor = color;
                  });
                },
              ),
              const SizedBox(height: 32),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: textColor.withOpacity(0.4),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _saveNote,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: textColor.withOpacity(0.3),
                        foregroundColor: textColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Save Note',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
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
