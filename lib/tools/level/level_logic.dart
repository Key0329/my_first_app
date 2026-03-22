import 'dart:math';

/// Converts a single-axis accelerometer value (m/s^2) to a tilt angle in
/// degrees.
///
/// The value is clamped to [-g, g] before the computation so that out-of-range
/// readings (e.g. due to sudden motion) never produce NaN.
///
/// Returns a value in the range [-90, 90].
double accelToAngle(double accelValue, {double g = 9.81}) {
  return asin((accelValue / g).clamp(-1.0, 1.0)) * 180 / pi;
}

/// Returns `true` when both tilt angles are within [tolerance] degrees of
/// zero, indicating the device is level.
bool isLevel(double angleX, double angleY, {double tolerance = 0.5}) {
  return angleX.abs() < tolerance && angleY.abs() < tolerance;
}
