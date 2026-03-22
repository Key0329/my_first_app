/// Converts a heading in degrees (0–360) to a cardinal/intercardinal direction
/// string.
///
/// Returns one of: `'N'`, `'NE'`, `'E'`, `'SE'`, `'S'`, `'SW'`, `'W'`, `'NW'`.
///
/// The heading is normalised to the 0–360 range so values outside that range
/// (including negative angles and values >= 360) are handled correctly.
String degreeToDirection(double heading) {
  const directions = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'];
  final index = ((heading % 360 + 360 + 22.5) % 360 / 45).floor();
  return directions[index];
}

/// Converts a heading in degrees to a Chinese cardinal/intercardinal direction
/// string.
///
/// Returns one of: `'北'`, `'東北'`, `'東'`, `'東南'`, `'南'`, `'西南'`, `'西'`,
/// `'西北'`.
String degreeToDirectionChinese(double heading) {
  const directions = ['北', '東北', '東', '東南', '南', '西南', '西', '西北'];
  final index = ((heading % 360 + 360 + 22.5) % 360 / 45).floor();
  return directions[index];
}
