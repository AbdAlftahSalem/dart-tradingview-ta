// The interval names match the original Python tradingview-ta library and
// are part of the public API, so they keep their upper-case style.
// ignore_for_file: constant_identifier_names

/// What to request from TradingView.
class TradingViewModel {
  /// TradingView screener, e.g. `crypto`, `forex`, `america`, `egypt`.
  String screener;

  /// Candle interval of the analysis. Defaults to one hour.
  Intervals interval;

  /// Symbols with their exchange, e.g. `BINANCE:BTCUSDT` or `NASDAQ:AAPL`.
  List<String> symbols;

  /// Creates a request for [symbols] on [screener] at [interval].
  TradingViewModel({
    required this.screener,
    required this.symbols,
    this.interval = Intervals.INTERVAL_1_HOUR,
  });
}

/// Candle intervals supported by TradingView's technical analysis.
enum Intervals {
  /// 1 minute.
  INTERVAL_1_MINUTE,

  /// 5 minutes.
  INTERVAL_5_MINUTES,

  /// 15 minutes.
  INTERVAL_15_MINUTES,

  /// 30 minutes.
  INTERVAL_30_MINUTES,

  /// 1 hour.
  INTERVAL_1_HOUR,

  /// 2 hours.
  INTERVAL_2_HOURS,

  /// 4 hours.
  INTERVAL_4_HOURS,

  /// 1 day.
  INTERVAL_1_DAY,

  /// 1 week.
  INTERVAL_1_WEEK,

  /// 1 month.
  INTERVAL_1_MONTH
}
