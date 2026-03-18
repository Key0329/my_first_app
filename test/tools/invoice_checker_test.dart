import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/tools/invoice_checker/invoice_api.dart';
import 'package:my_first_app/tools/invoice_checker/invoice_parser.dart';

void main() {
  group('InvoiceParser', () {
    group('parseQrCode', () {
      test('解析有效 QR Code 資料，回傳前 10 個字元作為發票號碼', () {
        const qrData = 'AB12345678SomeOtherData...';
        expect(InvoiceParser.parseQrCode(qrData), equals('AB12345678'));
      });

      test('解析剛好 10 個字元的 QR Code 資料', () {
        expect(InvoiceParser.parseQrCode('CD98765432'), equals('CD98765432'));
      });

      test('QR Code 資料不足 10 字元時拋出 FormatException', () {
        expect(
          () => InvoiceParser.parseQrCode('AB1234'),
          throwsFormatException,
        );
      });

      test('QR Code 前 10 字元格式無效時拋出 FormatException', () {
        expect(
          () => InvoiceParser.parseQrCode('1234567890ExtraData'),
          throwsFormatException,
        );
      });
    });

    group('validateAndNormalize', () {
      test('有效發票號碼直接回傳', () {
        expect(
          InvoiceParser.validateAndNormalize('AB12345678'),
          equals('AB12345678'),
        );
      });

      test('小寫字母轉為大寫', () {
        expect(
          InvoiceParser.validateAndNormalize('ab12345678'),
          equals('AB12345678'),
        );
      });

      test('前後空白自動去除', () {
        expect(
          InvoiceParser.validateAndNormalize('  AB12345678  '),
          equals('AB12345678'),
        );
      });

      test('長度不足時拋出 FormatException', () {
        expect(
          () => InvoiceParser.validateAndNormalize('AB1234'),
          throwsFormatException,
        );
      });

      test('長度過長時拋出 FormatException', () {
        expect(
          () => InvoiceParser.validateAndNormalize('AB123456789'),
          throwsFormatException,
        );
      });

      test('只有數字（缺少字母）時拋出 FormatException', () {
        expect(
          () => InvoiceParser.validateAndNormalize('1234567890'),
          throwsFormatException,
        );
      });

      test('只有字母時拋出 FormatException', () {
        expect(
          () => InvoiceParser.validateAndNormalize('ABCDEFGHIJ'),
          throwsFormatException,
        );
      });

      test('字母在中間位置時拋出 FormatException', () {
        expect(
          () => InvoiceParser.validateAndNormalize('A1B2345678'),
          throwsFormatException,
        );
      });
    });

    group('isValidFormat', () {
      test('有效格式回傳 true', () {
        expect(InvoiceParser.isValidFormat('AB12345678'), isTrue);
      });

      test('小寫也視為有效', () {
        expect(InvoiceParser.isValidFormat('ab12345678'), isTrue);
      });

      test('無效格式回傳 false', () {
        expect(InvoiceParser.isValidFormat('1234567890'), isFalse);
      });

      test('空字串回傳 false', () {
        expect(InvoiceParser.isValidFormat(''), isFalse);
      });
    });
  });

  group('InvoiceApi', () {
    group('getWinningNumbers', () {
      test('回傳 WinningNumbers 物件', () async {
        final api = InvoiceApi();
        final numbers = await api.getWinningNumbers();

        expect(numbers.period, isNotEmpty);
        expect(numbers.specialPrize, hasLength(8));
        expect(numbers.grandPrize, hasLength(8));
        expect(numbers.firstPrizes, isNotEmpty);
      });
    });

    group('checkPrize', () {
      const winningNumbers = WinningNumbers(
        period: '測試期別',
        specialPrize: '01234567',
        grandPrize: '98765432',
        firstPrizes: ['11122233', '44455566', '77788899'],
        additionalSixthPrizes: ['038', '941'],
      );

      test('特別獎：8 碼全部相同', () {
        final result = InvoiceApi.checkPrize('XX01234567', winningNumbers);
        expect(result, isNotNull);
        expect(result!.tierName, equals('特別獎'));
        expect(result.amount, equals(10000000));
      });

      test('特獎：8 碼全部相同', () {
        final result = InvoiceApi.checkPrize('XX98765432', winningNumbers);
        expect(result, isNotNull);
        expect(result!.tierName, equals('特獎'));
        expect(result.amount, equals(2000000));
      });

      test('頭獎：8 碼全部與頭獎號碼相同', () {
        final result = InvoiceApi.checkPrize('XX11122233', winningNumbers);
        expect(result, isNotNull);
        expect(result!.tierName, equals('頭獎'));
        expect(result.amount, equals(200000));
      });

      test('頭獎：匹配第二組頭獎號碼', () {
        final result = InvoiceApi.checkPrize('XX44455566', winningNumbers);
        expect(result, isNotNull);
        expect(result!.tierName, equals('頭獎'));
        expect(result.amount, equals(200000));
      });

      test('二獎：末 7 碼相同', () {
        final result = InvoiceApi.checkPrize('XX01122233', winningNumbers);
        expect(result, isNotNull);
        expect(result!.tierName, equals('二獎'));
        expect(result.amount, equals(40000));
      });

      test('三獎：末 6 碼相同', () {
        final result = InvoiceApi.checkPrize('XX00122233', winningNumbers);
        expect(result, isNotNull);
        expect(result!.tierName, equals('三獎'));
        expect(result.amount, equals(10000));
      });

      test('四獎：末 5 碼相同', () {
        final result = InvoiceApi.checkPrize('XX00022233', winningNumbers);
        expect(result, isNotNull);
        expect(result!.tierName, equals('四獎'));
        expect(result.amount, equals(4000));
      });

      test('五獎：末 4 碼相同', () {
        final result = InvoiceApi.checkPrize('XX00002233', winningNumbers);
        expect(result, isNotNull);
        expect(result!.tierName, equals('五獎'));
        expect(result.amount, equals(1000));
      });

      test('六獎：末 3 碼相同', () {
        final result = InvoiceApi.checkPrize('XX00000233', winningNumbers);
        expect(result, isNotNull);
        expect(result!.tierName, equals('六獎'));
        expect(result.amount, equals(200));
      });

      test('增開六獎：末 3 碼與增開號碼相同', () {
        final result = InvoiceApi.checkPrize('XX00000038', winningNumbers);
        expect(result, isNotNull);
        expect(result!.tierName, equals('增開六獎'));
        expect(result.amount, equals(200));
      });

      test('增開六獎：第二組增開號碼', () {
        final result = InvoiceApi.checkPrize('XX00000941', winningNumbers);
        expect(result, isNotNull);
        expect(result!.tierName, equals('增開六獎'));
        expect(result.amount, equals(200));
      });

      test('未中獎', () {
        final result = InvoiceApi.checkPrize('XX99999999', winningNumbers);
        expect(result, isNull);
      });

      test('末 2 碼相同不中獎', () {
        final result = InvoiceApi.checkPrize('XX00000033', winningNumbers);
        expect(result, isNull);
      });

      test('特別獎優先於其他獎項', () {
        // 若號碼剛好與特別獎相同，應回傳特別獎
        final result = InvoiceApi.checkPrize('AB01234567', winningNumbers);
        expect(result, isNotNull);
        expect(result!.tierName, equals('特別獎'));
      });

      test('不同英文字母前綴不影響比對結果', () {
        final result1 = InvoiceApi.checkPrize('AB11122233', winningNumbers);
        final result2 = InvoiceApi.checkPrize('ZZ11122233', winningNumbers);
        expect(result1?.tierName, equals(result2?.tierName));
        expect(result1?.amount, equals(result2?.amount));
      });
    });
  });
}
