import 'package:dio/dio.dart';
import 'package:tradingview_ta/src/constant/list_contant.dart';
import 'package:tradingview_ta/src/core/extensions.dart';
import 'package:tradingview_ta/src/core/support_resistance.dart';
import 'package:tradingview_ta/src/dio_maneger/dio_manger.dart';
import 'package:tradingview_ta/src/tradingview_ta/trading_view_model.dart';

/// Fetches TradingView technical analysis for one or more symbols.
///
/// ```dart
/// final ta = TradingViewTA(
///   tradingView: TradingViewModel(
///     screener: "crypto",
///     symbols: ["BINANCE:BTCUSDT"],
///     interval: Intervals.INTERVAL_1_HOUR,
///   ),
/// );
/// final analysis = await ta.getAnalysis();
/// ```
class TradingViewTA {
  /// The screener, symbols and interval to request.
  TradingViewModel tradingView;

  /// Creates a client for [tradingView].
  TradingViewTA({required this.tradingView}) {
    DioManagerClass.getInstance.init();
  }

  /// Returns every indicator for each symbol at [TradingViewModel.interval].
  ///
  /// One map per symbol:
  /// `{"ticker": "BINANCE:BTCUSDT", "interval": "1h", "indicators": [{"indicatorsName": "RSI", "value": 54.2}, ...]}`.
  /// An indicator TradingView has no value for comes back with `"value": null`.
  ///
  /// Throws an [Exception] when a symbol has no `EXCHANGE:` prefix, the
  /// screener is empty, or TradingView answers with an error.
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

  /// Returns every indicator for each symbol at each of [intervals], in one
  /// request.
  ///
  /// One map per symbol:
  /// `{"ticker": ..., "indicators": [{"interval": "1d", "indicators": [...]}, ...]}`.
  Future<List<Map<String, dynamic>>> getAnalysisWithMultiFrame({
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
      List<Map<String, dynamic>> output =
          _formatResToMapMultiInterval(res, intervals);

      return output;
    } else {
      throw Exception(res.data);
    }
  }

  List<Map<String, dynamic>> _formatResToMapMultiInterval(
      Response<dynamic> res, List<Intervals> intervals) {
    final int indicatorsCount = ListsCont.indicators.length;
    List<Map<String, dynamic>> output = [];
    for (var item in res.data["data"]) {
      List fullIndicators = [];
      int counter = 0;

      for (var interval in intervals) {
        var output = _formatOutPutIndicators(
            (item['d'] as List).sublist(counter, counter + indicatorsCount));

        fullIndicators.add({
          "interval": interval.getValueIntervalToResponse(),
          "indicators": output,
        });
        counter += indicatorsCount;
      }

      output.add({
        "ticker": item['s'],
        "indicators": fullIndicators,
      });
    }
    return output;
  }

  /// Returns support and resistance levels for each symbol.
  ///
  /// Each level (`s3`, `s2`, `s1`, `middle`, `r1`, `r2`, `r3`) is the average
  /// of TradingView's monthly Classic, Fibonacci, Camarilla and Woodie pivot
  /// points (`null` if TradingView has none of them for that symbol):
  /// `{"ticker": ..., "SupportAndResistant": {"r3": ..., ..., "middle": ...}}`.
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

  Map<String, dynamic> _getSupportAndResistantAsMap(List indicators) =>
      supportAndResistanceFromIndicators(indicators);

  void _validationInput({
    bool validateMultiTickers = false,
    List<Intervals> intervals = const [],
  }) {
    multiIntervalsValidation(validateMultiTickers, intervals);
    _tickersValidation();
    _screenerValidation();
  }

  /// Throws when a multi-interval request has no intervals.
  void multiIntervalsValidation(
      bool validateMultiTickers, List<Intervals> intervals) {
    if (validateMultiTickers) {
      if (intervals.isEmpty) {
        throw Exception(
            "getAnalysisWithMultiFrame needs at least one interval");
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
