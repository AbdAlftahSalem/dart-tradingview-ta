class TradingViewModel {
  Screener screener;
  Intervals interval;

  List<String> symbols;

  TradingViewModel({
    required this.screener,
    required this.symbols,
    this.interval = Intervals.INTERVAL_1_HOUR,
  });
}

enum Intervals {
  INTERVAL_1_MINUTE,
  INTERVAL_5_MINUTES,
  INTERVAL_15_MINUTES,
  INTERVAL_30_MINUTES,
  INTERVAL_1_HOUR,
  INTERVAL_2_HOURS,
  INTERVAL_4_HOURS,
  INTERVAL_1_DAY,
  INTERVAL_1_WEEK,
  INTERVAL_1_MONTH
}

enum Screener {
  crypto,
  forex,
}
