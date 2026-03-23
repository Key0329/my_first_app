import 'package:flutter/material.dart';
import 'package:my_first_app/l10n/app_localizations.dart';
import 'package:my_first_app/theme/design_tokens.dart';
import 'package:my_first_app/widgets/immersive_tool_scaffold.dart';
import 'package:my_first_app/widgets/staggered_fade_in.dart';
import 'note_edit_page.dart';
import 'note_model.dart';

/// 快速筆記列表頁面。
class QuickNotesPage extends StatefulWidget {
  const QuickNotesPage({super.key});

  @override
  State<QuickNotesPage> createState() => _QuickNotesPageState();
}

class _QuickNotesPageState extends State<QuickNotesPage> {
  static const Color _toolColor = Color(0xFFF59E0B);

  final NotesRepository _repo = NotesRepository();
  final TextEditingController _searchController = TextEditingController();

  List<Note> _notes = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadNotes() async {
    final notes = await _repo.loadNotes();
    notes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    if (mounted) setState(() => _notes = notes);
  }

  Future<void> _saveNotes() async {
    await _repo.saveNotes(_notes);
  }

  List<Note> get _filteredNotes {
    if (_searchQuery.isEmpty) return _notes;
    final q = _searchQuery.toLowerCase();
    return _notes.where((n) {
      return n.title.toLowerCase().contains(q) ||
          n.content.toLowerCase().contains(q);
    }).toList();
  }

  Future<void> _createNote() async {
    final now = DateTime.now();
    final note = Note(
      id: now.millisecondsSinceEpoch.toString(),
      createdAt: now,
      updatedAt: now,
    );

    final result = await Navigator.push<Note>(
      context,
      MaterialPageRoute(builder: (_) => NoteEditPage(note: note)),
    );

    if (result != null && !result.isEmpty) {
      setState(() {
        _notes.insert(0, result);
      });
      await _saveNotes();
    }
  }

  Future<void> _editNote(Note note) async {
    final result = await Navigator.push<Note>(
      context,
      MaterialPageRoute(builder: (_) => NoteEditPage(note: note)),
    );

    if (result != null) {
      setState(() {
        if (result.isEmpty) {
          _notes.removeWhere((n) => n.id == result.id);
        } else {
          final index = _notes.indexWhere((n) => n.id == result.id);
          if (index >= 0) {
            _notes[index] = result;
            _notes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
          }
        }
      });
      await _saveNotes();
    }
  }

  Future<void> _deleteNote(Note note) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.quickNotesDeleteTitle),
        content: Text(l10n.quickNotesDeleteMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.commonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.commonDelete),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      setState(() {
        _notes.removeWhere((n) => n.id == note.id);
      });
      await _saveNotes();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ImmersiveToolScaffold(
      toolColor: _toolColor,
      title: l10n.quickNotesTitle,
      headerFlex: 1,
      bodyFlex: 5,
      headerChild: Center(
        child: Text(
          l10n.quickNotesCount(_notes.length),
          style: const TextStyle(color: Colors.white70, fontSize: 16),
        ),
      ),
      bodyChild: Stack(
        children: [
          Column(
            children: [
              // ── 搜尋欄 ──
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    DT.spaceLg, DT.spaceLg, DT.spaceLg, DT.spaceSm),
                child: TextField(
                  controller: _searchController,
                  onChanged: (v) => setState(() => _searchQuery = v),
                  decoration: InputDecoration(
                    hintText: l10n.quickNotesSearchHint,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _searchQuery = '');
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(DT.radiusMd),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: DT.spaceLg,
                      vertical: DT.spaceSm,
                    ),
                  ),
                ),
              ),
              // ── 筆記列表 ──
              Expanded(child: _buildNotesList(l10n)),
            ],
          ),
          // ── FAB ──
          Positioned(
            right: DT.spaceLg,
            bottom: DT.spaceLg,
            child: FloatingActionButton(
              backgroundColor: _toolColor,
              foregroundColor: Colors.white,
              tooltip: l10n.quickNotesNewNote,
              onPressed: _createNote,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesList(AppLocalizations l10n) {
    final notes = _filteredNotes;

    if (_notes.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.note_add, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: DT.spaceLg),
            Text(l10n.quickNotesEmpty,
                style: TextStyle(
                    fontSize: 18, color: Colors.grey.shade500)),
            const SizedBox(height: DT.spaceSm),
            Text(l10n.quickNotesEmptyHint,
                style: TextStyle(color: Colors.grey.shade400)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(
          DT.spaceLg, DT.spaceSm, DT.spaceLg, 80),
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return StaggeredFadeIn(
          index: index,
          totalItems: notes.length,
          child: _buildNoteCard(note, l10n),
        );
      },
    );
  }

  Widget _buildNoteCard(Note note, AppLocalizations l10n) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final timeLabel = _formatTimeAgo(note.updatedAt, l10n);

    return Dismissible(
      key: Key(note.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: DT.spaceLg),
        margin: const EdgeInsets.only(bottom: DT.spaceSm),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(DT.radiusMd),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (_) async {
        await _deleteNote(note);
        return false; // We handle removal ourselves
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: DT.spaceSm),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DT.radiusMd),
        ),
        color: isDark ? Colors.white.withValues(alpha: 0.08) : null,
        child: InkWell(
          borderRadius: BorderRadius.circular(DT.radiusMd),
          onTap: () => _editNote(note),
          onLongPress: () => _deleteNote(note),
          child: Padding(
            padding: const EdgeInsets.all(DT.spaceLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        note.displayTitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      timeLabel,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? Colors.white54 : Colors.grey,
                      ),
                    ),
                  ],
                ),
                if (note.content.isNotEmpty &&
                    note.title.isNotEmpty) ...[
                  const SizedBox(height: DT.spaceXs),
                  Text(
                    note.preview,
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark ? Colors.white54 : Colors.black54,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatTimeAgo(DateTime dt, AppLocalizations l10n) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1) return l10n.quickNotesUpdated;
    if (diff.inMinutes < 60) return l10n.quickNotesMinutesAgo(diff.inMinutes);
    if (diff.inHours < 24) return l10n.quickNotesHoursAgo(diff.inHours);
    return l10n.quickNotesDaysAgo(diff.inDays);
  }
}
