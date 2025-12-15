import 'package:flutter/material.dart';

enum NoteCategory { personal, work, ideas, urgent, other }

class Note {
  String id;
  String title;
  String content;
  Color color;
  DateTime createdAt;
  DateTime lastModified;
  bool isFavorite;
  NoteCategory category;
  List<String> tags;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.color,
    required this.createdAt,
    required this.lastModified,
    this.isFavorite = false,
    this.category = NoteCategory.personal,
    this.tags = const [],
  });

  // Copy constructor for updates
  Note copyWith({
    String? id,
    String? title,
    String? content,
    Color? color,
    DateTime? createdAt,
    DateTime? lastModified,
    bool? isFavorite,
    NoteCategory? category,
    List<String>? tags,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      lastModified: lastModified ?? this.lastModified,
      isFavorite: isFavorite ?? this.isFavorite,
      category: category ?? this.category,
      tags: tags ?? this.tags,
    );
  }

  // Convert to JSON for local storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'color': color.value,
      'createdAt': createdAt.toIso8601String(),
      'lastModified': lastModified.toIso8601String(),
      'isFavorite': isFavorite,
      'category': category.name,
      'tags': tags,
    };
  }

  // Create from JSON
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      color: Color(json['color'] as int),
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastModified: DateTime.parse(json['lastModified'] as String),
      isFavorite: json['isFavorite'] as bool? ?? false,
      category: NoteCategory.values.firstWhere(
        (c) => c.name == json['category'],
        orElse: () => NoteCategory.personal,
      ),
      tags: List<String>.from(json['tags'] as List? ?? []),
    );
  }
}
