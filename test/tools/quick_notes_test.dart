import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_first_app/tools/quick_notes/note_model.dart';

void main() {
  // ---------------------------------------------------------------------------
  // 測試用固定時間戳
  // ---------------------------------------------------------------------------
  final DateTime kCreatedAt = DateTime(2024, 1, 15, 10, 0, 0);
  final DateTime kUpdatedAt = DateTime(2024, 1, 15, 12, 30, 0);

  Note makeNote({
    String id = 'note-1',
    String title = '測試標題',
    String content = '測試內容',
  }) {
    return Note(
      id: id,
      title: title,
      content: content,
      createdAt: kCreatedAt,
      updatedAt: kUpdatedAt,
    );
  }

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  // ---------------------------------------------------------------------------
  // Note.toJson / Note.fromJson
  // ---------------------------------------------------------------------------
  group('Note JSON roundtrip', () {
    test('toJson 包含所有必要欄位', () {
      final note = makeNote();
      final json = note.toJson();

      expect(json['id'], equals('note-1'));
      expect(json['title'], equals('測試標題'));
      expect(json['content'], equals('測試內容'));
      expect(json['createdAt'], equals(kCreatedAt.toIso8601String()));
      expect(json['updatedAt'], equals(kUpdatedAt.toIso8601String()));
    });

    test('fromJson 正確還原所有欄位', () {
      final json = {
        'id': 'note-42',
        'title': 'Hello',
        'content': 'World',
        'createdAt': kCreatedAt.toIso8601String(),
        'updatedAt': kUpdatedAt.toIso8601String(),
      };

      final note = Note.fromJson(json);

      expect(note.id, equals('note-42'));
      expect(note.title, equals('Hello'));
      expect(note.content, equals('World'));
      expect(note.createdAt, equals(kCreatedAt));
      expect(note.updatedAt, equals(kUpdatedAt));
    });

    test('toJson → fromJson roundtrip 保持資料一致', () {
      final original = makeNote(
        id: 'rt-1',
        title: '往返測試',
        content: '多行\n內容\n第三行',
      );
      final restored = Note.fromJson(original.toJson());

      expect(restored.id, equals(original.id));
      expect(restored.title, equals(original.title));
      expect(restored.content, equals(original.content));
      expect(restored.createdAt, equals(original.createdAt));
      expect(restored.updatedAt, equals(original.updatedAt));
    });

    test('fromJson 缺少 title/content 欄位時預設為空字串', () {
      final json = {
        'id': 'no-title',
        'createdAt': kCreatedAt.toIso8601String(),
        'updatedAt': kUpdatedAt.toIso8601String(),
      };
      final note = Note.fromJson(json);

      expect(note.title, equals(''));
      expect(note.content, equals(''));
    });
  });

  // ---------------------------------------------------------------------------
  // Note.displayTitle
  // ---------------------------------------------------------------------------
  group('Note.displayTitle', () {
    test('有 title 時回傳 title', () {
      final note = makeNote(title: '我的標題', content: '內容文字');
      expect(note.displayTitle, equals('我的標題'));
    });

    test('title 為空時回傳 content 第一行', () {
      final note = makeNote(title: '', content: '第一行\n第二行\n第三行');
      expect(note.displayTitle, equals('第一行'));
    });

    test('title 為空且 content 第一行超過 50 字元時截斷並加省略號', () {
      final longFirstLine = 'A' * 60;
      final note = makeNote(title: '', content: '$longFirstLine\n第二行');
      expect(note.displayTitle, equals('${'A' * 50}...'));
    });

    test('title 為空且 content 第一行剛好 50 字元時不截斷', () {
      final exactLine = 'B' * 50;
      final note = makeNote(title: '', content: exactLine);
      expect(note.displayTitle, equals(exactLine));
    });

    test('title 為空且 content 無換行時回傳整行（未超過 50）', () {
      final note = makeNote(title: '', content: '短內容');
      expect(note.displayTitle, equals('短內容'));
    });

    test('title 與 content 均為空時 displayTitle 為空字串', () {
      final note = makeNote(title: '', content: '');
      expect(note.displayTitle, equals(''));
    });
  });

  // ---------------------------------------------------------------------------
  // Note.preview
  // ---------------------------------------------------------------------------
  group('Note.preview', () {
    test('content 未超過 100 字元時回傳完整 content', () {
      final note = makeNote(content: '短短的預覽');
      expect(note.preview, equals('短短的預覽'));
    });

    test('content 剛好 100 字元時不截斷', () {
      final exact100 = 'C' * 100;
      final note = makeNote(content: exact100);
      expect(note.preview, equals(exact100));
    });

    test('content 超過 100 字元時截斷並加省略號', () {
      final long = 'D' * 150;
      final note = makeNote(content: long);
      expect(note.preview, equals('${'D' * 100}...'));
    });

    test('content 為空時 preview 回傳空字串', () {
      final note = makeNote(content: '');
      expect(note.preview, equals(''));
    });
  });

  // ---------------------------------------------------------------------------
  // Note.isEmpty
  // ---------------------------------------------------------------------------
  group('Note.isEmpty', () {
    test('title 與 content 均為空字串時為 true', () {
      final note = makeNote(title: '', content: '');
      expect(note.isEmpty, isTrue);
    });

    test('title 與 content 均為純空白時為 true', () {
      final note = makeNote(title: '   ', content: '\t\n  ');
      expect(note.isEmpty, isTrue);
    });

    test('title 有內容時為 false', () {
      final note = makeNote(title: '有標題', content: '');
      expect(note.isEmpty, isFalse);
    });

    test('content 有內容時為 false', () {
      final note = makeNote(title: '', content: '有內容');
      expect(note.isEmpty, isFalse);
    });

    test('title 與 content 均有內容時為 false', () {
      final note = makeNote(title: '標題', content: '內容');
      expect(note.isEmpty, isFalse);
    });

    test('title 為空白但 content 有非空白字元時為 false', () {
      final note = makeNote(title: '  ', content: 'x');
      expect(note.isEmpty, isFalse);
    });
  });

  // ---------------------------------------------------------------------------
  // NotesRepository
  // ---------------------------------------------------------------------------
  group('NotesRepository', () {
    late NotesRepository repo;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      repo = NotesRepository();
    });

    test('loadNotes 在未儲存任何資料時回傳空列表', () async {
      final notes = await repo.loadNotes();
      expect(notes, isEmpty);
    });

    test('saveNotes 後 loadNotes 可取回相同筆記（單筆）', () async {
      final note = makeNote();
      await repo.saveNotes([note]);

      final loaded = await repo.loadNotes();
      expect(loaded.length, equals(1));
      expect(loaded.first.id, equals(note.id));
      expect(loaded.first.title, equals(note.title));
      expect(loaded.first.content, equals(note.content));
      expect(loaded.first.createdAt, equals(note.createdAt));
      expect(loaded.first.updatedAt, equals(note.updatedAt));
    });

    test('saveNotes 後 loadNotes 可取回相同筆記（多筆）', () async {
      final notes = [
        makeNote(id: 'n1', title: '第一筆', content: '內容一'),
        makeNote(id: 'n2', title: '第二筆', content: '內容二'),
        makeNote(id: 'n3', title: '', content: '無標題筆記'),
      ];
      await repo.saveNotes(notes);

      final loaded = await repo.loadNotes();
      expect(loaded.length, equals(3));
      for (var i = 0; i < notes.length; i++) {
        expect(loaded[i].id, equals(notes[i].id));
        expect(loaded[i].title, equals(notes[i].title));
        expect(loaded[i].content, equals(notes[i].content));
      }
    });

    test('saveNotes 空列表後 loadNotes 回傳空列表', () async {
      // 先存有資料，再覆蓋成空列表
      await repo.saveNotes([makeNote()]);
      await repo.saveNotes([]);

      final loaded = await repo.loadNotes();
      expect(loaded, isEmpty);
    });

    test('多次 saveNotes 以最後一次為準', () async {
      await repo.saveNotes([makeNote(id: 'old', title: '舊資料')]);
      await repo.saveNotes([makeNote(id: 'new', title: '新資料')]);

      final loaded = await repo.loadNotes();
      expect(loaded.length, equals(1));
      expect(loaded.first.id, equals('new'));
      expect(loaded.first.title, equals('新資料'));
    });
  });
}
