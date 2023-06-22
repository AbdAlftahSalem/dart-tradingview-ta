import 'package:tradingview_ta/src/constant/network_constant.dart';
import 'package:tradingview_ta/src/tradingview_ta/trading_view_model.dart';

extension GetValueEnum on Enum {
  String getValueScreener() {
    return this == Screener.crypto
        ? NetworkConst.cryptoEndPoint
        : NetworkConst.forexEndPoint;
  }

  String getValueInterval() {
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
        return "2h";
      case Intervals.INTERVAL_4_HOURS:
        return "4h";
      case Intervals.INTERVAL_1_DAY:
        return "1d";
      case Intervals.INTERVAL_1_WEEK:
        return "1w";
      case Intervals.INTERVAL_1_MONTH:
        return "1M";
      default:
        return "1h";
    }
  }
}
