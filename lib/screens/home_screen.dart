import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../providers/note_provider.dart';
import '../screens/note_edit_screen.dart';
import '../theme/theme.dart';
import '../widgets/empty_state.dart';
import '../widgets/loading_animation.dart';
import '../widgets/note_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      Provider.of<NoteProvider>(context, listen: false)
          .search(_searchController.text);
      setState(() {
        _isSearching = _searchController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightBg,
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: const Text('QuickNotes'),
        actions: [
          Consumer<NoteProvider>(
            builder: (context, noteProvider, _) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${noteProvider.totalNotes}',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<NoteProvider>(
        builder: (context, noteProvider, child) {
          // Show loading animation while fetching notes
          if (noteProvider.isLoading) {
            return const LoadingAnimation(
              message: 'Loading your notes...',
            );
          }

          final filteredNotes = noteProvider.filteredNotes;

          return CustomScrollView(
            slivers: [
              // Search Bar
              SliverAppBar(
                floating: true,
                pinned: false,
                snap: true,
                elevation: 0,
                backgroundColor: AppTheme.lightBg,
                surfaceTintColor: Colors.transparent,
                collapsedHeight: 80,
                expandedHeight: 80,
                toolbarHeight: 80,
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search notes...',
                        prefixIcon: const Icon(Icons.search_rounded),
                        suffixIcon: _isSearching
                            ? GestureDetector(
                                onTap: () {
                                  _searchController.clear();
                                  noteProvider.search('');
                                },
                                child: const Icon(Icons.close_rounded),
                              )
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFE8EAEF),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: AppTheme.primaryColor,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Filter Bar
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Row(
                    children: [
                      // Category Filter
                      FilterChip(
                        label: const Text('All'),
                        selected: noteProvider.selectedCategory == null,
                        onSelected: (selected) {
                          noteProvider.filterByCategory(null);
                        },
                      ),
                      const SizedBox(width: 8),
                      ...NoteCategory.values.map((category) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: FilterChip(
                            label: Text(category.name),
                            selected: noteProvider.selectedCategory == category,
                            onSelected: (selected) {
                              noteProvider.filterByCategory(selected ? category : null);
                            },
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),

              // Sort and Favorites section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PopupMenuButton<SortBy>(
                        onSelected: (sortBy) {
                          noteProvider.sort(sortBy);
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: SortBy.recent,
                            child: Text('Recent'),
                          ),
                          const PopupMenuItem(
                            value: SortBy.oldest,
                            child: Text('Oldest'),
                          ),
                          const PopupMenuItem(
                            value: SortBy.alphabetical,
                            child: Text('Alphabetical'),
                          ),
                        ],
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: const Color(0xFFE8EAEF),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.sort_rounded,
                                size: 18,
                                color: AppTheme.textSecondary,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Sort',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                      color: AppTheme.textSecondary,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Consumer<NoteProvider>(
                        builder: (context, noteProvider, _) {
                          return GestureDetector(
                            onTap: () => noteProvider.toggleFavoritesOnly(),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: noteProvider.showFavoritesOnly
                                    ? AppTheme.primaryColor.withOpacity(0.1)
                                    : Colors.transparent,
                                border: Border.all(
                                  color: noteProvider.showFavoritesOnly
                                      ? AppTheme.primaryColor
                                      : const Color(0xFFE8EAEF),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.favorite_rounded,
                                    size: 18,
                                    color: noteProvider.showFavoritesOnly
                                        ? AppTheme.accentColor
                                        : AppTheme.textSecondary,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '${noteProvider.favoriteCount}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                          color: noteProvider.showFavoritesOnly
                                              ? AppTheme.primaryColor
                                              : AppTheme.textSecondary,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Notes Grid
              if (filteredNotes.isEmpty)
                SliverFillRemaining(
                  child: EmptyState(
                    icon: Icons.note_outlined,
                    title: 'No notes yet',
                    subtitle: _isSearching
                        ? 'No notes match your search'
                        : 'Create your first note to get started',
                    onAction: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const NoteEditScreen(),
                        ),
                      );
                    },
                    actionLabel: 'Create Note',
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  sliver: SliverMasonryGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childCount: filteredNotes.length,
                    itemBuilder: (context, index) {
                      final note = filteredNotes[index];
                      return NoteCard(
                        note: note,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  NoteEditScreen(note: note),
                            ),
                          );
                        },
                        onDelete: () {
                          final noteProvider =
                              Provider.of<NoteProvider>(context, listen: false);
                          noteProvider.deleteNote(note.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Note deleted'),
                              duration: Duration(seconds: 2),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        onFavoriteToggle: (isFavorite) {
                          Provider.of<NoteProvider>(context, listen: false)
                              .toggleFavorite(note.id);
                        },
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const NoteEditScreen(),
            ),
          );
        },
        tooltip: 'Create new note',
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
