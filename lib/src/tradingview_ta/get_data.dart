import 'package:tradingview_ta/src/constant/list_contant.dart';
import 'package:tradingview_ta/src/core/extensions.dart';
import 'package:tradingview_ta/src/dio_maneger/dio_manger.dart';
import 'package:tradingview_ta/src/tradingview_ta/trading_view_model.dart';

class GetData {
  static GetData? _instance;
  TradingViewModel tradingView;

  factory GetData({required TradingViewModel tradingView}) {
    DioManagerClass.getInstance.init();
    _instance ??= GetData._internal(tradingView: tradingView);
    return _instance!;
  }

  GetData._internal({required this.tradingView});

  Future<Map<String, dynamic>> getAnalysis() async {
    Map<String, dynamic> output = {};

    Map<String, dynamic> body = {
      "symbols": {
        "tickers": tradingView.symbols,
      },
      "columns": formatIndicators()
    };

    final res = await DioManagerClass.getInstance.dioPostMethod(
      url: "url",
      body: {},
      header: {"User-Agent": "tradingview_ta/3.3.0"},
    );

    return output;
  }

  List<String> formatIndicators() {
    List<String> newIndicators = [];
    for (var i in ListsCont.indicators) {
      newIndicators.add("$i${tradingView.interval.getValueInterval()}");
    }
    return newIndicators;
  }
}
