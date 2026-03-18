/// 台灣統一發票 QR Code 資料解析器
class InvoiceParser {
  /// 發票號碼格式：2 個大寫英文字母 + 8 位數字
  static final RegExp _invoicePattern = RegExp(r'^[A-Z]{2}[0-9]{8}$');

  /// 從 QR Code 原始資料中解析發票號碼
  ///
  /// 台灣統一發票 QR Code 的前 10 個字元為發票號碼
  /// 格式：2 個大寫英文字母 + 8 位數字（例如 AB12345678）
  ///
  /// 若資料格式無效，拋出 [FormatException]
  static String parseQrCode(String rawData) {
    if (rawData.length < 10) {
      throw const FormatException('QR Code 資料長度不足，無法解析發票號碼');
    }

    final invoiceNumber = rawData.substring(0, 10);
    return validateAndNormalize(invoiceNumber);
  }

  /// 驗證並正規化發票號碼
  ///
  /// 接受手動輸入的發票號碼，自動轉為大寫後驗證格式
  /// 若格式無效，拋出 [FormatException]
  static String validateAndNormalize(String input) {
    final normalized = input.trim().toUpperCase();

    if (normalized.length != 10) {
      throw FormatException('發票號碼必須為 10 個字元，目前為 ${normalized.length} 個字元');
    }

    if (!_invoicePattern.hasMatch(normalized)) {
      throw const FormatException('發票號碼格式無效，須為 2 個英文字母 + 8 位數字');
    }

    return normalized;
  }

  /// 檢查字串是否為有效的發票號碼格式
  static bool isValidFormat(String input) {
    final normalized = input.trim().toUpperCase();
    return _invoicePattern.hasMatch(normalized);
  }
}
