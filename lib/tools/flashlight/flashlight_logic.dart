/// SOS 模式中的單一閃爍步驟。
class SosStep {
  /// 亮燈持續時間（毫秒）。
  final int onMs;

  /// 熄燈持續時間（毫秒）。
  final int offMs;

  const SosStep({required this.onMs, required this.offMs});
}

/// 完整 SOS 閃爍模式：S (···) O (---) S (···)。
///
/// 短閃（dot）= 200ms on，長閃（dash）= 600ms on。
/// 字母間額外間隔 400ms（off 從 200→600），
/// 整組結束間隔 1400ms（word gap）。
const List<SosStep> sosPattern = [
  // S: 3 short (dot)
  SosStep(onMs: 200, offMs: 200),
  SosStep(onMs: 200, offMs: 200),
  SosStep(onMs: 200, offMs: 600), // extra gap after letter
  // O: 3 long (dash)
  SosStep(onMs: 600, offMs: 200),
  SosStep(onMs: 600, offMs: 200),
  SosStep(onMs: 600, offMs: 600), // extra gap after letter
  // S: 3 short (dot)
  SosStep(onMs: 200, offMs: 200),
  SosStep(onMs: 200, offMs: 200),
  SosStep(onMs: 200, offMs: 1400), // word gap before repeat
];

/// 計算完整 SOS 週期的總持續時間（毫秒）。
int sosPatternTotalDurationMs() {
  return sosPattern.fold<int>(
    0,
    (sum, step) => sum + step.onMs + step.offMs,
  );
}

/// 判斷該步驟是否為短閃（dot）：onMs <= 200。
bool isDot(SosStep step) => step.onMs <= 200;

/// 判斷該步驟是否為長閃（dash）：onMs > 200。
bool isDash(SosStep step) => step.onMs > 200;
