part of scalify;

extension Scaliify on num {
  double get h => (this * Scalify.screenHeightWithPadding) / 100;

  double get w => (this * Scalify.screenWidthWithPadding) / 100;
}
