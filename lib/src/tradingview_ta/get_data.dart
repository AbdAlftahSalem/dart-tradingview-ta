import 'package:tradingview_ta/src/constant/list_contant.dart';
import 'package:tradingview_ta/src/core/extensions.dart';
import 'package:tradingview_ta/src/dio_maneger/dio_manger.dart';
import 'package:tradingview_ta/src/tradingview_ta/trading_view_model.dart';

class TradingViewTA {
  TradingViewModel tradingView;

  TradingViewTA({required this.tradingView}) {
    DioManagerClass.getInstance.init();
  }

  Future<List<Map<String, dynamic>>> getAnalysis() async {
    validationInput();
    final res = await DioManagerClass.getInstance.dioPostMethod(
      url: tradingView.screener.toLowerCase(),
      body: {
        "symbols": {
          "tickers": tradingView.symbols,
        },
        "columns": formatInputIndicators(),
      },
      header: {"User-Agent": "tradingview_ta/3.3.0"},
    );

    if (res.statusCode == 200) {
      return formatResToMap(res.data);
    } else {
      throw Exception(res.data);
    }
  }

  List<String> formatInputIndicators() {
    List<String> newIndicators = [];
    for (var i in ListsCont.indicators) {
      newIndicators.add("$i${tradingView.interval.getValueInterval()}");
    }
    return newIndicators;
  }

  List<Map<String, dynamic>> formatResToMap(Map res) {
    List<Map<String, dynamic>> outPut = [];
    for (int i = 0; i < res["data"].length; ++i) {
      outPut.add(
        {
          "ticker": res["data"][i]["s"],
          "indicators": formatOutPutIndicators(res["data"][0]['d']),
        },
      );
    }

    return outPut;
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

  void validationInput() {
    tickersValidation();
    screenerValidation();
  }

  void tickersValidation() {
    int length = tradingView.symbols
        .where((element) => element.split(":").length != 2)
        .length;
    if (length != 0) {
      throw Exception(
        "One symbol or multi symbols with exchange\nEnter valid symbols like : BINANCE:ETHUSDT",
      );
    }
  }

  void screenerValidation() {
    if (tradingView.screener.isEmpty) {
      throw Exception(
        "Screener is empty . check screen before start searching",
      );
    }
  }
}
