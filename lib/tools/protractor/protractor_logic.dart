import 'dart:math' as math;

/// Calculates the positive angle between two arms in degrees [0, 360).
///
/// [arm1Radians] and [arm2Radians] are the angles of the two arms in radians.
/// The result is the angle measured from arm1 to arm2 going counter-clockwise
/// (in standard math convention), converted to degrees.
double calculateAngleDegrees(double arm1Radians, double arm2Radians) {
  var diff = (arm2Radians - arm1Radians) * 180 / math.pi;
  diff = diff % 360;
  if (diff < 0) diff += 360;
  return diff;
}

/// Normalizes any angle to the range [0, 360).
///
/// Handles negative angles and angles >= 360 by wrapping appropriately.
double normalizeAngle(double degrees) {
  var result = degrees % 360;
  if (result < 0) result += 360;
  return result;
}

/// Calculates the angle between two points relative to a center point,
/// in degrees [0, 360).
///
/// The angle is measured from the vector (center -> point1) to the vector
/// (center -> point2), going counter-clockwise.
///
/// [x1], [y1] — coordinates of the first point
/// [x2], [y2] — coordinates of the second point
/// [cx], [cy] — coordinates of the center point
double angleBetweenPoints(
  double x1,
  double y1,
  double x2,
  double y2,
  double cx,
  double cy,
) {
  final angle1 = math.atan2(y1 - cy, x1 - cx);
  final angle2 = math.atan2(y2 - cy, x2 - cx);
  return calculateAngleDegrees(angle1, angle2);
}
