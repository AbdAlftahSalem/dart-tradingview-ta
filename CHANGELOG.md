## 2.1.0

- **Fix:** `getSupportAndResistant()` added up the four pivot methods instead of averaging them, so every level came back about 4× too high (BTC at ~77k showed R3 ≈ 390k). Levels are now averaged, and a missing or integer value no longer throws.
- **Fix:** the `interval` label in results was `|2h` and `|1M` for 2-hour and 1-month data. It is now `2h` and `1M`.
- `getAnalysisWithMultiFrame()` now returns `List<Map<String, dynamic>>` (it was untyped) and no longer hard-codes the indicator count.
- New main library `package:tradingview_ta/tradingview_ta.dart`. `exports.dart` still works.
- Dart 3 SDK constraint (`^3.0.0`), `lints` ^6.0.0, analyzer clean.
- Doc comments on the public API.
- The example is now a single file using the public API, and the demo `main()` was moved out of `lib/`.
- Unit tests (intervals, support/resistance maths, validation) and GitHub Actions CI.
- README rewritten: real usage, result shapes, API table. The dead tvdb.analyzer.rest link was removed.
- Removed the committed `pubspec.lock` and IDE files. LICENSE now names the right copyright holder.

## 2.0.0

- Finish multi symbols with multi intervals
