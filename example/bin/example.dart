import 'package:tradingview_ta/src/tradingview_ta/get_data.dart';
import 'package:tradingview_ta/src/tradingview_ta/trading_view_model.dart';

void main(List<String> arguments) async {
  TradingViewTA tradingViewTA = TradingViewTA(
    tradingView: TradingViewModel(
      screener: "crypto",
      symbols: ["BINANCE:BTCUSDT", "BINANCE:ETHUSDT"],
    ),
  );
  List<Map<String, dynamic>> resSupportAndResistant =
      await tradingViewTA.getSupportAndResistant();
  List<Map<String, dynamic>> resAnalysis = await tradingViewTA.getAnalysis();
  print(resSupportAndResistant);
  print(resAnalysis);
}
