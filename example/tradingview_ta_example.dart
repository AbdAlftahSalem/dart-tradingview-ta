import 'package:tradingview_ta/tradingview_ta.dart';

Future<void> main() async {
  TradingViewTA tradingViewTA = TradingViewTA(
    tradingView: TradingViewModel(
      screener: "crypto",
      symbols: ["BINANCE:BTCUSDT", "BINANCE:ETHUSDT"],
      interval: Intervals.INTERVAL_1_HOUR,
    ),
  );

  // All indicators for every symbol at one interval.
  List<Map<String, dynamic>> resAnalysis = await tradingViewTA.getAnalysis();
  for (final symbol in resAnalysis) {
    final indicators = symbol["indicators"] as List;
    final rsi = indicators.firstWhere((e) => e["indicatorsName"] == "RSI");
    final recommendation =
        indicators.firstWhere((e) => e["indicatorsName"] == "Recommend.All");
    print("${symbol["ticker"]} (${symbol["interval"]}): "
        "RSI ${rsi["value"]}, Recommend.All ${recommendation["value"]}");
  }

  // The same symbols at several intervals, in one request.
  List<Map<String, dynamic>> resMultiFrame =
      await tradingViewTA.getAnalysisWithMultiFrame(
    intervals: [Intervals.INTERVAL_1_DAY, Intervals.INTERVAL_1_WEEK],
  );
  for (final symbol in resMultiFrame) {
    final frames = (symbol["indicators"] as List)
        .map((frame) => frame["interval"])
        .join(", ");
    print("${symbol["ticker"]}: $frames");
  }

  // Support and resistance levels.
  List<Map<String, dynamic>> resSupportAndResistant =
      await tradingViewTA.getSupportAndResistant();
  for (final symbol in resSupportAndResistant) {
    print("${symbol["ticker"]}: ${symbol["SupportAndResistant"]}");
  }
}
