import 'package:flutter/material.dart';
import 'package:my_first_app/l10n/app_localizations.dart';
import 'package:my_first_app/theme/design_tokens.dart';
import 'note_model.dart';

/// 筆記編輯頁面。
///
/// 接收一個 [Note]，編輯後透過 Navigator.pop 回傳更新後的 Note。
/// 若使用者沒有輸入任何內容，回傳原始 Note（isEmpty 為 true 時列表頁會移除）。
class NoteEditPage extends StatefulWidget {
  final Note note;

  const NoteEditPage({super.key, required this.note});

  @override
  State<NoteEditPage> createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<NoteEditPage> {
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveAndPop() {
    final note = widget.note
      ..title = _titleController.text.trim()
      ..content = _contentController.text.trim()
      ..updatedAt = DateTime.now();
    Navigator.pop(context, note);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _saveAndPop();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.quickNotesEditNote),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: _saveAndPop,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(DT.spaceLg),
          child: Column(
            children: [
              // ── 標題 ──
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: l10n.quickNotesTitleHint,
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Divider(
                color: isDark ? Colors.white24 : Colors.grey.shade300,
              ),
              // ── 內容 ──
              Expanded(
                child: TextField(
                  controller: _contentController,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintText: l10n.quickNotesContentHint,
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(fontSize: 15, height: 1.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
