import 'package:tradingview_ta/src/tradingview_ta/trading_view_model.dart';

import 'src/tradingview_ta/get_data.dart';

main() async {
  TradingViewTA tradingViewTA = TradingViewTA(
    tradingView: TradingViewModel(
        screener: "crypto",
        symbols: ["BINANCE:BTCUSDT", "BINANCE:ETHUSDT"],
        interval: Intervals.INTERVAL_1_DAY),
  );
  List<Map<String, dynamic>> res =
      await tradingViewTA.getAnalysisWithMultiFrame(
    intervals: [
      Intervals.INTERVAL_1_MONTH,
      Intervals.INTERVAL_1_HOUR,
    ],
  );
  print(res);
}
