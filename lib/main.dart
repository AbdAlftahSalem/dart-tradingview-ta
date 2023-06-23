import 'package:tradingview_ta/src/tradingview_ta/trading_view_model.dart';

import 'src/tradingview_ta/get_data.dart';

main() {
  GetData x = GetData(
    tradingView: TradingViewModel(
      screener: Screener.crypto,
      symbols: ["BINANCE:BTCUSDT", "BINANCE:ETHUSDT"],
    ),
  );
  x.getAnalysis();
}
