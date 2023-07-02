import 'package:dio/dio.dart';
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
    _validationInput();
    final res = await DioManagerClass.getInstance.dioPostMethod(
      url: tradingView.screener.toLowerCase(),
      body: {
        "symbols": {
          "tickers": tradingView.symbols,
        },
        "columns": _formatInputIndicators(),
      },
      header: {"User-Agent": "tradingview_ta/3.3.0"},
    );
    if (res.statusCode == 200) {
      return _formatResToMapSingleInterval(res.data);
    } else {
      throw Exception(res.data);
    }
  }

  Future<List> getAnalysisWithMultiFrame({
    required List<Intervals> intervals,
  }) async {
    _validationInput(
      validateMultiTickers: true,
      intervals: intervals,
    );

    List<String> indicatorsSend =
        _formatInputIndicatorsMultiIntervals(intervals: intervals);
    final res = await DioManagerClass.getInstance.dioPostMethod(
      url: tradingView.screener.toLowerCase(),
      body: {
        "symbols": {
          "tickers": tradingView.symbols,
        },
        "columns": indicatorsSend,
      },
      header: {"User-Agent": "tradingview_ta/3.3.0"},
    );

    if (res.statusCode == 200) {
      List<dynamic> output = _formatResToMapMultiInterval(res, intervals);

      return output;
    } else {
      throw Exception(res.data);
    }
  }

  List<dynamic> _formatResToMapMultiInterval(
      Response<dynamic> res, List<Intervals> intervals) {
    List output = [];
    for (var item in res.data["data"]) {
      List fullIndicators = [];
      int counter = 0;

      for (var interval in intervals) {
        var output = _formatOutPutIndicators(
            (item['d'] as List).sublist(counter, counter + 91));

        fullIndicators.add({
          "interval": interval.getValueIntervalToResponse(),
          "indicators": output,
        });
        counter += 91;
      }

      output.add({
        "ticker": item['s'],
        "indicators": fullIndicators,
      });
    }
    return output;
  }

  Future<List<Map<String, dynamic>>> getSupportAndResistant() async {
    List<Map<String, dynamic>> output = [];
    _validationInput();
    List<Map<String, dynamic>> analysis = await getAnalysis();

    for (var i in analysis) {
      output.add(
        {
          "ticker": i["ticker"],
          "SupportAndResistant": _getSupportAndResistantAsMap(i["indicators"]),
        },
      );
    }

    return output;
  }

  List<String> _formatInputIndicators() {
    List<String> newIndicators = [];
    for (var i in ListsCont.indicators) {
      newIndicators
          .add("$i${tradingView.interval.getValueIntervalToTradingView()}");
    }
    return newIndicators;
  }

  List<String> _formatInputIndicatorsMultiIntervals({
    required List<Intervals> intervals,
  }) {
    List<String> newIndicators = [];
    for (var interval in intervals) {
      for (var indicator in ListsCont.indicators) {
        newIndicators
            .add("$indicator${interval.getValueIntervalToTradingView()}");
      }
    }
    return newIndicators;
  }

  List<Map<String, dynamic>> _formatResToMapSingleInterval(Map res) {
    List<Map<String, dynamic>> outPut = [];
    for (int i = 0; i < res["data"].length; ++i) {
      outPut.add({
        "ticker": res["data"][i]["s"],
        "interval": tradingView.interval.getValueIntervalToResponse(),
        "indicators": _formatOutPutIndicators(res["data"][i]['d']),
      });
    }

    return outPut;
  }

  List _formatOutPutIndicators(List input) {
    List<Map<String, dynamic>> outPut = [];

    for (int i = 0; i < ListsCont.indicators.length; ++i) {
      outPut.add({
        "indicatorsName": ListsCont.indicators[i],
        "value": input[i],
      });
    }

    return outPut;
  }

  Map<String, dynamic> _getSupportAndResistantAsMap(List indicators) {
    double pivotMClassicS3 = indicators.firstWhere((element) =>
        element["indicatorsName"] == "Pivot.M.Classic.S3")["value"];

    double pivotMClassicS2 = indicators.firstWhere((element) =>
        element["indicatorsName"] == "Pivot.M.Classic.S2")["value"];

    double pivotMClassicS1 = indicators.firstWhere((element) =>
        element["indicatorsName"] == "Pivot.M.Classic.S1")["value"];

    double pivotMClassicR3 = indicators.firstWhere((element) =>
        element["indicatorsName"] == "Pivot.M.Classic.R3")["value"];

    double pivotMClassicR2 = indicators.firstWhere((element) =>
        element["indicatorsName"] == "Pivot.M.Classic.R2")["value"];

    double pivotMClassicR1 = indicators.firstWhere((element) =>
        element["indicatorsName"] == "Pivot.M.Classic.R1")["value"];

    double pivotMClassicMiddle = indicators.firstWhere((element) =>
        element["indicatorsName"] == "Pivot.M.Classic.Middle")["value"];

    double pivotMFibonacciS3 = indicators.firstWhere((element) =>
        element["indicatorsName"] == "Pivot.M.Fibonacci.S3")["value"];

    double pivotMFibonacciS2 = indicators.firstWhere((element) =>
        element["indicatorsName"] == "Pivot.M.Fibonacci.S2")["value"];

    double pivotMFibonacciS1 = indicators.firstWhere((element) =>
        element["indicatorsName"] == "Pivot.M.Fibonacci.S1")["value"];

    double pivotMFibonacciR3 = indicators.firstWhere((element) =>
        element["indicatorsName"] == "Pivot.M.Fibonacci.R3")["value"];

    double pivotMFibonacciR2 = indicators.firstWhere((element) =>
        element["indicatorsName"] == "Pivot.M.Fibonacci.R2")["value"];

    double pivotMFibonacciR1 = indicators.firstWhere((element) =>
        element["indicatorsName"] == "Pivot.M.Fibonacci.R1")["value"];

    double pivotMFibonacciMiddle = indicators.firstWhere((element) =>
        element["indicatorsName"] == "Pivot.M.Fibonacci.Middle")["value"];

    double pivotMCamarillaS3 = indicators.firstWhere((element) =>
        element["indicatorsName"] == "Pivot.M.Camarilla.S3")["value"];

    double pivotMCamarillaS2 = indicators.firstWhere((element) =>
        element["indicatorsName"] == "Pivot.M.Camarilla.S2")["value"];

    double pivotMCamarillaS1 = indicators.firstWhere((element) =>
        element["indicatorsName"] == "Pivot.M.Camarilla.S1")["value"];

    double pivotMCamarillaR3 = indicators.firstWhere((element) =>
        element["indicatorsName"] == "Pivot.M.Camarilla.R3")["value"];

    double pivotMCamarillaR2 = indicators.firstWhere((element) =>
        element["indicatorsName"] == "Pivot.M.Camarilla.R2")["value"];

    double pivotMCamarillaR1 = indicators.firstWhere((element) =>
        element["indicatorsName"] == "Pivot.M.Camarilla.R1")["value"];

    double pivotMCamarillaMiddle = indicators.firstWhere((element) =>
        element["indicatorsName"] == "Pivot.M.Camarilla.Middle")["value"];

    double pivotMWoodieS3 = indicators.firstWhere(
        (element) => element["indicatorsName"] == "Pivot.M.Woodie.S3")["value"];

    double pivotMWoodieS2 = indicators.firstWhere(
        (element) => element["indicatorsName"] == "Pivot.M.Woodie.S2")["value"];

    double pivotMWoodieS1 = indicators.firstWhere(
        (element) => element["indicatorsName"] == "Pivot.M.Woodie.S1")["value"];

    double pivotMWoodieR3 = indicators.firstWhere(
        (element) => element["indicatorsName"] == "Pivot.M.Woodie.R3")["value"];

    double pivotMWoodieR2 = indicators.firstWhere(
        (element) => element["indicatorsName"] == "Pivot.M.Woodie.R2")["value"];

    double pivotMWoodieR1 = indicators.firstWhere(
        (element) => element["indicatorsName"] == "Pivot.M.Woodie.R1")["value"];

    double pivotMWoodieMiddle = indicators.firstWhere((element) =>
        element["indicatorsName"] == "Pivot.M.Woodie.Middle")["value"];

    return {
      "r3": pivotMWoodieR3 +
          pivotMCamarillaR3 +
          pivotMClassicR3 +
          pivotMFibonacciR3,
      "r2": pivotMWoodieR2 +
          pivotMCamarillaR2 +
          pivotMClassicR2 +
          pivotMFibonacciR2,
      "r1": pivotMWoodieR1 +
          pivotMCamarillaR1 +
          pivotMClassicR1 +
          pivotMFibonacciR1,
      "s1": pivotMWoodieS1 +
          pivotMCamarillaS1 +
          pivotMClassicS1 +
          pivotMFibonacciS1,
      "s2": pivotMWoodieS2 +
          pivotMCamarillaS2 +
          pivotMClassicS2 +
          pivotMFibonacciS2,
      "s3": pivotMWoodieS3 +
          pivotMCamarillaS3 +
          pivotMClassicS3 +
          pivotMFibonacciS3,
      "middle": pivotMWoodieMiddle +
          pivotMCamarillaMiddle +
          pivotMClassicMiddle +
          pivotMFibonacciMiddle,
    };
  }

  void _validationInput({
    bool validateMultiTickers = false,
    List<Intervals> intervals = const [],
  }) {
    multiIntervalsValidation(validateMultiTickers, intervals);
    _tickersValidation();
    _screenerValidation();
  }

  void multiIntervalsValidation(
      bool validateMultiTickers, List<Intervals> intervals) {
    if (validateMultiTickers) {
      if (intervals.isEmpty) {
        throw Exception(
            "You can`t use multi ticker with multi intervals without and interval");
      }
    }
  }

  void _tickersValidation() {
    int length = tradingView.symbols
        .where((element) => element.split(":").length != 2)
        .length;
    if (length != 0) {
      throw Exception(
        "One symbol or multi symbols with exchange\nEnter valid symbols like : BINANCE:ETHUSDT",
      );
    }
  }

  void _screenerValidation() {
    if (tradingView.screener.isEmpty) {
      throw Exception(
        "Screener is empty . check screen before start searching",
      );
    }
  }
}
