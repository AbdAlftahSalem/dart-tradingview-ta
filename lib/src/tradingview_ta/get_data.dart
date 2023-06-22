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

  static Future<Map<String, dynamic>> getAnalysis() async {
    Map<String, dynamic> output = {};

    return output;
  }
}
