/// 日期計算機的純計算邏輯（無 UI 依賴）。
///
/// 提供三種計算模式：
/// 1. 日期區間（兩日期之間的天數、週數、月數）
/// 2. 加減天數（從基準日期加減指定天數）
/// 3. 工作日計算（排除週六、週日）
library;

/// 日期區間計算結果。
class DateIntervalResult {
  const DateIntervalResult({
    required this.totalDays,
    required this.weeks,
    required this.remainingDays,
    required this.months,
    required this.monthRemainingDays,
  });

  /// 兩日期之間的總天數。
  final int totalDays;

  /// 總天數除以 7 的整數部分。
  final int weeks;

  /// 總天數除以 7 的餘數。
  final int remainingDays;

  /// 兩日期之間的完整月份數。
  final int months;

  /// 扣除完整月份後的剩餘天數。
  final int monthRemainingDays;
}

/// 工作日計算結果。
class BusinessDaysResult {
  const BusinessDaysResult({
    required this.calendarDays,
    required this.businessDays,
    required this.weekendDays,
  });

  /// 兩日期之間的日曆天數。
  final int calendarDays;

  /// 兩日期之間的工作日數（排除週六、週日）。
  final int businessDays;

  /// 兩日期之間的週末天數。
  final int weekendDays;
}

/// 日期計算邏輯。
class DateCalculatorLogic {
  DateCalculatorLogic._();

  /// 計算兩個日期之間的區間。
  ///
  /// 若 [end] 在 [start] 之前，會取絕對值回傳正數結果。
  static DateIntervalResult dateInterval(DateTime start, DateTime end) {
    // 標準化為只取日期部分（去除時間）
    var s = DateTime(start.year, start.month, start.day);
    var e = DateTime(end.year, end.month, end.day);

    // 確保 s <= e
    if (s.isAfter(e)) {
      final temp = s;
      s = e;
      e = temp;
    }

    final totalDays = e.difference(s).inDays;
    final weeks = totalDays ~/ 7;
    final remainingDays = totalDays % 7;

    // 計算月份差異
    final monthsDiff = _monthDifference(s, e);
    final months = monthsDiff.months;
    final monthRemainingDays = monthsDiff.days;

    return DateIntervalResult(
      totalDays: totalDays,
      weeks: weeks,
      remainingDays: remainingDays,
      months: months,
      monthRemainingDays: monthRemainingDays,
    );
  }

  /// 從基準日期加減指定天數。
  ///
  /// [days] 為正數表示往未來推進，負數表示往過去回溯。
  static DateTime addDays(DateTime base, int days) {
    final normalized = DateTime(base.year, base.month, base.day);
    return normalized.add(Duration(days: days));
  }

  /// 計算兩個日期之間的工作日數（排除週六、週日）。
  ///
  /// 若 [end] 在 [start] 之前，會取絕對值回傳正數結果。
  /// - [calendarDays]：end - start 的天數差（標準差值）。
  /// - [businessDays]：[start, end] 閉區間內的工作日數。
  /// - [weekendDays]：[start, end] 閉區間內的週末天數。
  static BusinessDaysResult businessDays(DateTime start, DateTime end) {
    var s = DateTime(start.year, start.month, start.day);
    var e = DateTime(end.year, end.month, end.day);

    if (s.isAfter(e)) {
      final temp = s;
      s = e;
      e = temp;
    }

    final calendarDays = e.difference(s).inDays;

    if (calendarDays == 0) {
      return const BusinessDaysResult(
        calendarDays: 0,
        businessDays: 0,
        weekendDays: 0,
      );
    }

    var bizDays = 0;
    var weekendCount = 0;

    // 遍歷 [s, e] 閉區間（包含起始和結束日期）
    for (var d = s;
        !d.isAfter(e);
        d = d.add(const Duration(days: 1))) {
      if (d.weekday == DateTime.saturday || d.weekday == DateTime.sunday) {
        weekendCount++;
      } else {
        bizDays++;
      }
    }

    return BusinessDaysResult(
      calendarDays: calendarDays,
      businessDays: bizDays,
      weekendDays: weekendCount,
    );
  }

  /// 計算兩個日期之間的月份差和剩餘天數。
  static ({int months, int days}) _monthDifference(
    DateTime start,
    DateTime end,
  ) {
    // start 一定 <= end（外層已處理）
    var months = (end.year - start.year) * 12 + (end.month - start.month);

    // 如果 end.day < start.day，代表不滿一個月，月份要減 1
    if (end.day < start.day) {
      months--;
      // 剩餘天數 = end.day + (start 月份的最後一天 - start.day)
      final daysInStartMonth = DateTime(start.year, start.month + 1, 0).day;
      final days = (daysInStartMonth - start.day) + end.day;
      return (months: months, days: days);
    }

    return (months: months, days: end.day - start.day);
  }
}
