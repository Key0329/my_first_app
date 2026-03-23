import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// 筆記資料模型。
class Note {
  final String id;
  String title;
  String content;
  final DateTime createdAt;
  DateTime updatedAt;

  Note({
    required this.id,
    this.title = '',
    this.content = '',
    required this.createdAt,
    required this.updatedAt,
  });

  /// 顯示用標題：有 title 就用 title，否則取 content 第一行。
  String get displayTitle {
    if (title.isNotEmpty) return title;
    final firstLine = content.split('\n').first;
    return firstLine.length > 50 ? '${firstLine.substring(0, 50)}...' : firstLine;
  }

  /// 預覽文字：content 前 100 字。
  String get preview {
    if (content.length <= 100) return content;
    return '${content.substring(0, 100)}...';
  }

  /// 是否為空筆記（沒有標題也沒有內容）。
  bool get isEmpty => title.trim().isEmpty && content.trim().isEmpty;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json['id'] as String,
        title: json['title'] as String? ?? '',
        content: json['content'] as String? ?? '',
        createdAt: DateTime.parse(json['createdAt'] as String),
        updatedAt: DateTime.parse(json['updatedAt'] as String),
      );
}

/// 筆記持久化服務。
class NotesRepository {
  static const String _key = 'quick_notes_list';

  /// 從 SharedPreferences 載入所有筆記。
  Future<List<Note>> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_key);
    if (jsonStr == null || jsonStr.isEmpty) return [];

    final List<dynamic> jsonList = json.decode(jsonStr) as List<dynamic>;
    return jsonList
        .map((e) => Note.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// 儲存所有筆記到 SharedPreferences。
  Future<void> saveNotes(List<Note> notes) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = json.encode(notes.map((n) => n.toJson()).toList());
    await prefs.setString(_key, jsonStr);
  }
}
