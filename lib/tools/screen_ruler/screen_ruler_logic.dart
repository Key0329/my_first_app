/// Calculates the pixels-per-inch (PPI) of the display.
///
/// [pixelWidth] is the measured width of a reference object in logical pixels.
/// [physicalWidthMm] is the known physical width of that object in millimetres
/// (e.g. a credit card is 85.6 mm).
///
/// Returns the PPI value: `(pixelWidth / physicalWidthMm) * 25.4`.
double calculatePpi(double pixelWidth, double physicalWidthMm) {
  return (pixelWidth / physicalWidthMm) * 25.4;
}

/// Converts a pixel measurement to centimetres.
///
/// Uses the formula: `pixels / ppi * 2.54`.
double pixelsToCm(double pixels, double ppi) {
  return pixels / ppi * 2.54;
}

/// Converts a pixel measurement to inches.
///
/// Uses the formula: `pixels / ppi`.
double pixelsToInches(double pixels, double ppi) {
  return pixels / ppi;
}

/// Converts a centimetre measurement to pixels.
///
/// Uses the formula: `cm / 2.54 * ppi`.
double cmToPixels(double cm, double ppi) {
  return cm / 2.54 * ppi;
}
