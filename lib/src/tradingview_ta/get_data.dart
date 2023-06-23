import 'package:tradingview_ta/src/constant/list_contant.dart';
import 'package:tradingview_ta/src/core/extensions.dart';
import 'package:tradingview_ta/src/dio_maneger/dio_manger.dart';
import 'package:tradingview_ta/src/tradingview_ta/trading_view_model.dart';

class GetData {
  TradingViewModel tradingView;

  GetData({required this.tradingView}) {
    DioManagerClass.getInstance.init();
  }

  Future<Map<String, dynamic>> getAnalysis() async {
    Map<String, dynamic> output = {};

    final res = await DioManagerClass.getInstance.dioPostMethod(
      url: tradingView.screener.getUrlScreener(),
      body: {
        "symbols": {
          "tickers": tradingView.symbols,
        },
        "columns": formatInputIndicators(),
      },
      header: {"User-Agent": "tradingview_ta/3.3.0"},
    );

    if (res.statusCode == 200) {
      formatResToMap(res.data);
    } else {
      throw Exception(res.data);
    }

    return output;
  }

  List<String> formatInputIndicators() {
    List<String> newIndicators = [];
    for (var i in ListsCont.indicators) {
      newIndicators.add("$i${tradingView.interval.getValueInterval()}");
    }
    return newIndicators;
  }

  Map<String, dynamic> formatResToMap(Map res) {
    List<Map<String, dynamic>> outPut = [];
    print(res["data"]);
    print(formatOutPutIndicators(res["data"]));
    for (int i = 0; i < res["data"].length; ++i) {
      outPut.add(
        {
          "ticker": res["data"][i]["s"],
          "indicators": [],
        },
      );
    }

    return {};
  }

  List formatOutPutIndicators(List input) {
    List<Map<String, dynamic>> outPut = [];

    for (int i = 0; i < input.length; ++i) {
      outPut.add({
        "indicatorsName": ListsCont.indicators[i],
        "value": input[i],
      });
    }

    return outPut;
  }
}
