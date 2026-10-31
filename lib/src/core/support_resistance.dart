/// The pivot point methods averaged into each support / resistance level.
const List<String> pivotMethods = [
  "Classic",
  "Fibonacci",
  "Camarilla",
  "Woodie"
];

/// Builds the support / resistance map from a formatted indicators list
/// (`[{"indicatorsName": ..., "value": ...}]`).
///
/// Each level is the average of the monthly pivot points of [pivotMethods]
/// that have a value. A level is `null` when none of them has a value.
Map<String, dynamic> supportAndResistanceFromIndicators(List indicators) {
  final Map<String, dynamic> values = {
    for (final element in indicators)
      element["indicatorsName"] as String: element["value"],
  };

  double? average(String level) {
    final List<double> found = [
      for (final method in pivotMethods)
        if (values["Pivot.M.$method.$level"] is num)
          (values["Pivot.M.$method.$level"] as num).toDouble(),
    ];
    if (found.isEmpty) return null;
    return found.reduce((a, b) => a + b) / found.length;
  }

  return {
    "r3": average("R3"),
    "r2": average("R2"),
    "r1": average("R1"),
    "s1": average("S1"),
    "s2": average("S2"),
    "s3": average("S3"),
    "middle": average("Middle"),
  };
}
