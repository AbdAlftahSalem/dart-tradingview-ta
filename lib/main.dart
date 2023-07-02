import 'package:tradingview_ta/src/tradingview_ta/trading_view_model.dart';

import 'src/tradingview_ta/get_data.dart';

main() async {
  TradingViewTA tradingViewTA = TradingViewTA(
    tradingView: TradingViewModel(
      screener: "crypto",
      symbols: ["BINANCE:BTCUSDT", "BINANCE:ETHUSDT", "BINANCE:SOLUSDT"],
      interval: Intervals.INTERVAL_1_DAY,
    ),
  );

  List res = await tradingViewTA.getAnalysisWithMultiFrame(
    intervals: [
      Intervals.INTERVAL_1_DAY,
      Intervals.INTERVAL_1_MONTH,
    ],
  );

  print(res);
}
