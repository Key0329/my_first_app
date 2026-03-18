/// 中獎號碼資料模型
class WinningNumbers {
  /// 期別（例如 "113年11-12月"）
  final String period;

  /// 特別獎號碼（獎金 1,000 萬元）
  final String specialPrize;

  /// 特獎號碼（獎金 200 萬元）
  final String grandPrize;

  /// 頭獎號碼列表（獎金 20 萬元）
  final List<String> firstPrizes;

  /// 增開六獎號碼列表（獎金 200 元）
  final List<String> additionalSixthPrizes;

  const WinningNumbers({
    required this.period,
    required this.specialPrize,
    required this.grandPrize,
    required this.firstPrizes,
    this.additionalSixthPrizes = const [],
  });
}

/// 中獎結果
class PrizeResult {
  /// 獎項名稱
  final String tierName;

  /// 獎金金額
  final int amount;

  const PrizeResult({required this.tierName, required this.amount});

  @override
  String toString() => '$tierName — 獎金 \$amount 元';
}

/// 財政部統一發票 API 客戶端
///
/// MVP 版本使用模擬資料，未來可接入財政部開放 API
class InvoiceApi {
  /// 取得最新一期中獎號碼
  ///
  /// 目前回傳模擬資料，未來可替換為實際 API 呼叫
  Future<WinningNumbers> getWinningNumbers() async {
    // 模擬網路延遲
    await Future<void>.delayed(const Duration(milliseconds: 300));

    return const WinningNumbers(
      period: '113年11-12月',
      specialPrize: '01234567',
      grandPrize: '98765432',
      firstPrizes: ['11122233', '44455566', '77788899'],
      additionalSixthPrizes: ['038', '941'],
    );
  }

  /// 比對發票號碼與中獎號碼，回傳中獎結果
  ///
  /// [invoiceNumber] 為 10 位發票號碼（含英文字母）
  /// 比對時只使用後 8 位數字部分
  ///
  /// 回傳 [PrizeResult]（中獎）或 `null`（未中獎）
  static PrizeResult? checkPrize(
    String invoiceNumber,
    WinningNumbers winningNumbers,
  ) {
    // 取得發票後 8 碼數字
    final number = invoiceNumber.substring(2);

    // 特別獎：8 碼全部相同（獎金 1,000 萬元）
    if (number == winningNumbers.specialPrize) {
      return const PrizeResult(tierName: '特別獎', amount: 10000000);
    }

    // 特獎：8 碼全部相同（獎金 200 萬元）
    if (number == winningNumbers.grandPrize) {
      return const PrizeResult(tierName: '特獎', amount: 2000000);
    }

    // 頭獎至六獎：與頭獎號碼比對末幾碼
    for (final firstPrize in winningNumbers.firstPrizes) {
      // 頭獎：8 碼全部相同（獎金 20 萬元）
      if (number == firstPrize) {
        return const PrizeResult(tierName: '頭獎', amount: 200000);
      }

      // 二獎：末 7 碼相同（獎金 4 萬元）
      if (number.substring(1) == firstPrize.substring(1)) {
        return const PrizeResult(tierName: '二獎', amount: 40000);
      }

      // 三獎：末 6 碼相同（獎金 1 萬元）
      if (number.substring(2) == firstPrize.substring(2)) {
        return const PrizeResult(tierName: '三獎', amount: 10000);
      }

      // 四獎：末 5 碼相同（獎金 4 千元）
      if (number.substring(3) == firstPrize.substring(3)) {
        return const PrizeResult(tierName: '四獎', amount: 4000);
      }

      // 五獎：末 4 碼相同（獎金 1 千元）
      if (number.substring(4) == firstPrize.substring(4)) {
        return const PrizeResult(tierName: '五獎', amount: 1000);
      }

      // 六獎：末 3 碼相同（獎金 200 元）
      if (number.substring(5) == firstPrize.substring(5)) {
        return const PrizeResult(tierName: '六獎', amount: 200);
      }
    }

    // 增開六獎：末 3 碼與增開號碼相同（獎金 200 元）
    for (final additional in winningNumbers.additionalSixthPrizes) {
      if (number.endsWith(additional)) {
        return const PrizeResult(tierName: '增開六獎', amount: 200);
      }
    }

    return null;
  }
}
