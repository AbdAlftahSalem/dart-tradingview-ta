import 'package:test/test.dart';
import 'package:tradingview_ta/src/constant/list_contant.dart';
import 'package:tradingview_ta/src/core/support_resistance.dart';
import 'package:tradingview_ta/tradingview_ta.dart';

List<Map<String, dynamic>> pivots(Map<String, num?> values) => [
      for (final entry in values.entries)
        {"indicatorsName": entry.key, "value": entry.value},
    ];

void main() {
  group('intervals', () {
    test('every interval has a request suffix and a clean label', () {
      for (final interval in Intervals.values) {
        expect(interval.getValueIntervalToResponse(), isNot(contains('|')));
        final suffix = interval.getValueIntervalToTradingView();
        expect(suffix.isEmpty || suffix.startsWith('|'), isTrue);
      }
    });

    test('labels', () {
      expect(Intervals.INTERVAL_1_HOUR.getValueIntervalToResponse(), '1h');
      expect(Intervals.INTERVAL_2_HOURS.getValueIntervalToResponse(), '2h');
      expect(Intervals.INTERVAL_1_MONTH.getValueIntervalToResponse(), '1M');
      expect(Intervals.INTERVAL_1_DAY.getValueIntervalToTradingView(), '');
      expect(
          Intervals.INTERVAL_4_HOURS.getValueIntervalToTradingView(), '|240');
    });
  });

  group('support and resistance', () {
    test('averages the four pivot methods', () {
      final result = supportAndResistanceFromIndicators(pivots({
        for (final method in pivotMethods) ...{
          "Pivot.M.$method.R1": 100 + pivotMethods.indexOf(method) * 2,
          "Pivot.M.$method.S1": 90,
          "Pivot.M.$method.Middle": 95.5,
        },
      }));
      expect(result["r1"], 103.0); // (100 + 102 + 104 + 106) / 4
      expect(result["s1"], 90.0);
      expect(result["middle"], 95.5);
    });

    test('skips missing values and returns null when all are missing', () {
      final result = supportAndResistanceFromIndicators(pivots({
        "Pivot.M.Classic.R2": 10,
        "Pivot.M.Fibonacci.R2": null,
        "Pivot.M.Camarilla.R2": 20.0,
      }));
      expect(result["r2"], 15.0);
      expect(result["r3"], isNull);
    });
  });

  test('the indicator list contains each pivot level used', () {
    for (final method in pivotMethods) {
      for (final level in ["S3", "S2", "S1", "Middle", "R1", "R2", "R3"]) {
        expect(ListsCont.indicators, contains("Pivot.M.$method.$level"));
      }
    }
  });

  group('validation', () {
    test('symbol without exchange throws', () {
      final ta = TradingViewTA(
        tradingView: TradingViewModel(screener: "crypto", symbols: ["BTCUSDT"]),
      );
      expect(ta.getAnalysis, throwsA(isA<Exception>()));
    });

    test('multi frame without intervals throws', () {
      final ta = TradingViewTA(
        tradingView:
            TradingViewModel(screener: "crypto", symbols: ["BINANCE:BTCUSDT"]),
      );
      expect(() => ta.getAnalysisWithMultiFrame(intervals: []),
          throwsA(isA<Exception>()));
    });
  });
}
