import 'package:tradingview_ta/src/tradingview_ta/trading_view_model.dart';

import 'src/tradingview_ta/get_data.dart';

main() async {
  TradingViewTA tradingViewTA = TradingViewTA(
    tradingView: TradingViewModel(
      screener: "crypto",
      symbols: ["BINANCE:BTCUSDT", "BINANCE:ETHUSDT"],
    ),
  );
  List<Map<String, dynamic>> res = await tradingViewTA.getAnalysis();
}
