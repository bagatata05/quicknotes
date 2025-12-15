import 'package:flutter/material.dart';
import '../models/note.dart';
import '../theme/theme.dart';

class CategoryPicker extends StatelessWidget {
  final NoteCategory selectedCategory;
  final ValueChanged<NoteCategory> onCategorySelected;

  const CategoryPicker({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final categories = NoteCategory.values;
    
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          categories.length,
          (index) {
            final category = categories[index];
            final isSelected = selectedCategory == category;
            
            return Padding(
              padding: EdgeInsets.only(
                left: index == 0 ? 0 : 8,
                right: index == categories.length - 1 ? 0 : 0,
              ),
              child: FilterChip(
                label: Text(
                  category.name.toUpperCase(),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: isSelected
                        ? Colors.white
                        : AppTheme.textSecondary,
                  ),
                ),
                selected: isSelected,
                onSelected: (_) => onCategorySelected(category),
                backgroundColor: Colors.transparent,
                selectedColor: AppTheme.primaryColor,
                side: BorderSide(
                  color: isSelected
                      ? AppTheme.primaryColor
                      : const Color(0xFFE8EAEF),
                  width: 1.5,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
