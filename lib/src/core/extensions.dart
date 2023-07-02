import 'package:tradingview_ta/src/tradingview_ta/trading_view_model.dart';

extension GetValueEnum on Enum {
  String getValueIntervalToTradingView() {
    switch (this) {
      case Intervals.INTERVAL_1_MINUTE:
        return "|1";
      case Intervals.INTERVAL_5_MINUTES:
        return "|5";
      case Intervals.INTERVAL_15_MINUTES:
        return "|15";
      case Intervals.INTERVAL_30_MINUTES:
        return "|30";
      case Intervals.INTERVAL_1_HOUR:
        return "|60";
      case Intervals.INTERVAL_2_HOURS:
        return "|120";
      case Intervals.INTERVAL_4_HOURS:
        return "|240";
      case Intervals.INTERVAL_1_DAY:
        return "";
      case Intervals.INTERVAL_1_WEEK:
        return "|1W";
      case Intervals.INTERVAL_1_MONTH:
        return "|1M";
      default:
        return "|60";
    }
  }

  String getValueIntervalToResponse() {
    switch (this) {
      case Intervals.INTERVAL_1_MINUTE:
        return "1m";
      case Intervals.INTERVAL_5_MINUTES:
        return "5m";
      case Intervals.INTERVAL_15_MINUTES:
        return "15m";
      case Intervals.INTERVAL_30_MINUTES:
        return "30m";
      case Intervals.INTERVAL_1_HOUR:
        return "1h";
      case Intervals.INTERVAL_2_HOURS:
        return "|2h";
      case Intervals.INTERVAL_4_HOURS:
        return "4h";
      case Intervals.INTERVAL_1_DAY:
        return "1d";
      case Intervals.INTERVAL_1_WEEK:
        return "1W";
      case Intervals.INTERVAL_1_MONTH:
        return "|1M";
      default:
        return "1d";
    }
  }
}
