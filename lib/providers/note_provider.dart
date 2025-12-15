import 'dart:collection';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/note.dart';

String _generateId() => DateTime.now().millisecondsSinceEpoch.toString() + Random().nextInt(10000).toString();

class NoteProvider with ChangeNotifier {
  final List<Note> _notes = [];

  String _searchQuery = '';
  SortBy _sortBy = SortBy.recent;
  NoteCategory? _selectedCategory;
  bool _showFavoritesOnly = false;
  bool _isLoading = true;

  NoteProvider() {
    _initializeNotes();
  }

  Future<void> _initializeNotes() async {
    _isLoading = true;
    notifyListeners();
    
    // Load notes from shared preferences
    await _loadNotes();
    
    // Simulate loading delay for UX
    await Future.delayed(const Duration(milliseconds: 1500));
    
    _isLoading = false;
    notifyListeners();
  }

  Future<void> _loadNotes() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final notesJson = prefs.getStringList('notes') ?? [];
      _notes.clear();
      
      for (String json in notesJson) {
        try {
          final noteMap = jsonDecode(json) as Map<String, dynamic>;
          _notes.add(Note.fromJson(noteMap));
        } catch (e) {
          debugPrint('Error loading note: $e');
        }
      }
    } catch (e) {
      debugPrint('Error loading notes: $e');
    }
  }

  Future<void> _saveNotes() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final notesJson = _notes.map((note) => jsonEncode(note.toJson())).toList();
      await prefs.setStringList('notes', notesJson);
    } catch (e) {
      debugPrint('Error saving notes: $e');
    }
  }

  bool get isLoading => _isLoading;

  // Getters for UI access
  NoteCategory? get selectedCategory => _selectedCategory;
  bool get showFavoritesOnly => _showFavoritesOnly;

  UnmodifiableListView<Note> get notes => UnmodifiableListView(_notes);

  List<Note> get filteredNotes {
    List<Note> filtered = _notes;

    // Apply favorite filter
    if (_showFavoritesOnly) {
      filtered = filtered.where((note) => note.isFavorite).toList();
    }

    // Apply category filter
    if (_selectedCategory != null) {
      filtered = filtered.where((note) => note.category == _selectedCategory).toList();
    }

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((note) =>
          note.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          note.content.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          note.tags.any((tag) => tag.toLowerCase().contains(_searchQuery.toLowerCase()))
      ).toList();
    }

    // Apply sorting
    switch (_sortBy) {
      case SortBy.recent:
        filtered.sort((a, b) => b.lastModified.compareTo(a.lastModified));
        break;
      case SortBy.oldest:
        filtered.sort((a, b) => a.lastModified.compareTo(b.lastModified));
        break;
      case SortBy.alphabetical:
        filtered.sort((a, b) => a.title.compareTo(b.title));
        break;
    }

    // Always put favorites at the top when not filtering by favorites
    if (!_showFavoritesOnly) {
      final favorites = filtered.where((n) => n.isFavorite).toList();
      final nonFavorites = filtered.where((n) => !n.isFavorite).toList();
      filtered = [...favorites, ...nonFavorites];
    }

    return filtered;
  }

  List<Note> get favoriteNotes => _notes.where((note) => note.isFavorite).toList();

  int get favoriteCount => favoriteNotes.length;
  int get totalNotes => _notes.length;

  void addNote(Note note) {
    final newNote = Note(
      id: _generateId(),
      title: note.title,
      content: note.content,
      color: note.color,
      createdAt: DateTime.now(),
      lastModified: DateTime.now(),
      isFavorite: false,
      category: note.category,
      tags: note.tags,
    );
    _notes.insert(0, newNote);
    notifyListeners();
    _saveNotes();
  }

  void updateNote(Note note) {
    int index = _notes.indexWhere((n) => n.id == note.id);
    if (index != -1) {
      _notes[index] = note.copyWith(lastModified: DateTime.now());
      notifyListeners();
      _saveNotes();
    }
  }

  void deleteNote(String id) {
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
    _saveNotes();
  }

  void toggleFavorite(String id) {
    int index = _notes.indexWhere((n) => n.id == id);
    if (index != -1) {
      final note = _notes[index];
      _notes[index] = note.copyWith(isFavorite: !note.isFavorite);
      notifyListeners();
      _saveNotes();
    }
  }

  void search(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void sort(SortBy sortBy) {
    _sortBy = sortBy;
    notifyListeners();
  }

  void filterByCategory(NoteCategory? category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void toggleFavoritesOnly() {
    _showFavoritesOnly = !_showFavoritesOnly;
    notifyListeners();
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedCategory = null;
    _showFavoritesOnly = false;
    _sortBy = SortBy.recent;
    notifyListeners();
  }
}

enum SortBy { recent, oldest, alphabetical }
