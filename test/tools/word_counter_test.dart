import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/tools/word_counter/word_counter_page.dart';

void main() {
  group('computeTextStats', () {
    group('空字串輸入', () {
      test('回傳全部為 0 的 TextStats.empty', () {
        final stats = computeTextStats('');
        expect(stats.charsWithSpaces, 0);
        expect(stats.charsNoSpaces, 0);
        expect(stats.words, 0);
        expect(stats.lines, 0);
        expect(stats.paragraphs, 0);
        expect(stats.readingTimeMinutes, 0);
        expect(stats.isLessThanOneMinute, false);
      });
    });

    group('純英文輸入', () {
      test('"Hello beautiful world" — 字元數、字數、行數、段落數正確', () {
        final stats = computeTextStats('Hello beautiful world');
        // 含空格字元數：21（H-e-l-l-o 5 + 空格 + b-e-a-u-t-i-f-u-l 9 + 空格 + w-o-r-l-d 5 = 21）
        expect(stats.charsWithSpaces, 21);
        // 不含空格字元數：19（移除 2 個空格）
        expect(stats.charsNoSpaces, 19);
        expect(stats.words, 3);
        expect(stats.lines, 1);
        expect(stats.paragraphs, 1);
      });
    });

    group('純中文輸入', () {
      test('"你好世界" — 字元數、字數、行數、段落數正確', () {
        final stats = computeTextStats('你好世界');
        expect(stats.charsWithSpaces, 4);
        expect(stats.charsNoSpaces, 4);
        expect(stats.words, 4);
        expect(stats.lines, 1);
        expect(stats.paragraphs, 1);
      });
    });

    group('中英混合輸入', () {
      test('"Hello 你好 World" — 字數為 4', () {
        // CJK: 你(1) + 好(1) = 2
        // 移除 CJK 後："Hello   World"，英文 token: Hello, World = 2
        // 總計 = 2 + 2 = 4
        final stats = computeTextStats('Hello 你好 World');
        expect(stats.words, 4);
      });
    });

    group('多行輸入', () {
      test('"line1\\nline2\\nline3" — 行數為 3', () {
        final stats = computeTextStats('line1\nline2\nline3');
        expect(stats.lines, 3);
      });
    });

    group('多段落輸入', () {
      test('"para1\\n\\npara2" — 段落數為 2', () {
        final stats = computeTextStats('para1\n\npara2');
        expect(stats.paragraphs, 2);
      });
    });

    group('閱讀時間計算', () {
      test('100 個中文字 — ceil(100/300) = 1 分鐘，isLessThanOneMinute = false', () {
        // ceil(100 / 300) = ceil(0.333) = 1，不小於 1 分鐘
        final text = '一' * 100;
        final stats = computeTextStats(text);
        expect(stats.readingTimeMinutes, 1);
        expect(stats.isLessThanOneMinute, false);
      });

      test('600 個中文字 — ceil(600/300) = 2 分鐘', () {
        final text = '一' * 600;
        final stats = computeTextStats(text);
        expect(stats.readingTimeMinutes, 2);
        expect(stats.isLessThanOneMinute, false);
      });
    });
  });
}
