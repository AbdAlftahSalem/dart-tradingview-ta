## Dart TradingView Technical Analysis (dart-tradingview-ta)

This project is a Dart implementation of
the [python-tradingview-ta](https://github.com/AnalyzerREST/python-tradingview-ta) package, originally developed in
Python. It provides technical analysis indicators and strategies for analyzing trading data from the TradingView
platform.

The Python package was rewritten in Dart to make it compatible with Dart-based projects and enable its usage within the
Dart ecosystem. The goal was to bring the functionality of the original Python package to Dart developers, allowing them
to perform technical analysis and build trading strategies using Dart.
Usage
===

Importing TradingView_TA
------------------------
This package requires the following dependency:

- [Dio](https://pub.dev/packages/dio): A powerful HTTP client for Dart, which is used for making HTTP requests and
  handling network operations.

Make sure to add `dio` to the `pubspec.yaml` file of your Dart project as a dependency. You can do this by adding the
following line under the `dependencies` section:

## Dependencies

- [Dio](https://pub.dev/packages/dio): A powerful HTTP client for Dart, used for making HTTP requests and interacting with APIs.


    import 'package:tradingview_ta/src/tradingview_ta/get_data.dart'
    import 'package:tradingview_ta/src/tradingview_ta/trading_view_model.dart'

Parameters:

    .. tip::

        You can search on https://tvdb.brianthe.dev to see which symbol, exchange, and screener to use.

        .. image:: https://raw.githubusercontent.com/brian-the-dev/python-tradingview-ta/main/images/tv-list.png

    * symbol (``list``) – Ticker symbols (e.g., ``"AAPL"``, ``"TLKM"``, ``"USDEUR"``, ``"BTCUSDT"``).
    * exchange (``str``) – Exchange (e.g., ``"nasdaq"``, ``"idx"``, ``Exchange.FOREX``, ``"binance"``).
    * screener (``str``) – Screener (e.g., ``"america"``, ``"indonesia"``, ``"forex"``, ``"crypto"``).

        .. note::

            * If you're looking for stocks, enter the exchange's country as the screener.
            * If you're looking for cryptocurrency, enter ``"crypto"`` as the screener.
            * If you're looking for forex, enter ``"forex"`` as the screener.

    * interval (``enum``) – Time frame

        .. note::

            Please see the Interval enum for available intervals.

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

Retrieving the analysis
-----------------------

    TradingViewTA tradingViewTA = TradingViewTA(
    tradingView: TradingViewModel(
      screener: "crypto",
      symbols: ["BINANCE:BTCUSDT", "BINANCE:ETHUSDT"],
    ),

Methods:

    * getAnalysis (``Future <List<Map<String , dynamic>>> ``)  – Technical indicators.
                # Example
                {ticker: BINANCE:BTCUSDT, indicators: [{indicatorsName: Recommend.Other, value: 0.09090909}, {indicatorsName: Recommend.All, value: 0.06468531}, {indicatorsName: Recommend.MA, value: 0.03846154}, {indicatorsName: RSI, value: 52.95145368}, {indicatorsName: RSI[1], value: 52.36483145}, {indicatorsName: Stoch.K, value: 64.98632479}, {indicatorsName: Stoch.D, value: 67.52644349}, {indicatorsName: Stoch.K[1], value: 67.85020375}, {indicatorsName: Stoch.D[1], value: 65.35905521}, {indicatorsName: CCI20, value: -29.02725177}, {indicatorsName: CCI20[1], value: -56.07703122}, {indicatorsName: ADX, value: 10.92131376}, {indicatorsName: ADX+DI, value: 20.06829653}, {indicatorsName: ADX-DI, value: 20.29459005}, {indicatorsName: ADX+DI[1], value: 20.55684792}, {indicatorsName: ADX-DI[1], value: 20.78865042}, {indicatorsName: AO, value: 141.51823529}, {indicatorsName: AO[1], value: 152.11738235}, {indicatorsName: Mom, value: -48.6}, {indicatorsName: Mom[1], value: -89.32}, {indicatorsName: MACD.macd, value: 67.00620367}, {indicatorsName: MACD.signal, value: 95.77583737}, {indicatorsName: Rec.Stoch.RSI, value: 0}, {indicatorsName: Stoch.RSI.K, value: 35.90243194}, {indicatorsName: Rec.WR, value: 0}, {indicatorsName: W.R, value: -37.15897436}, {indicatorsName: Rec.BBPower, value: 1}, {indicatorsName: BBPower, value: -43.28497601}, {indicatorsName: Rec.UO, value: 0}, {indicatorsName: UO, value: 59.03973628}, {indicatorsName: close, value: 30655.08}, {indicatorsName: EMA5, value: 30663.59316908}, {indicatorsName: SMA5, value: 30682.94}, {indicatorsName: EMA10, value: 30666.90985566}, {indicatorsName: SMA10, value: 30663.568}, {indicatorsName: EMA20, value: 30637.23701114}, {indicatorsName: SMA20, value: 30684.944}, {indicatorsName: EMA30, value: 30566.90842657}, {indicatorsName: SMA30, value: 30634.904}, {indicatorsName: EMA50, value: 30353.57483875}, {indicatorsName: SMA50, value: 30385.889}, {indicatorsName: EMA100, value: 29666.0189639}, {indicatorsName: SMA100, value: 29739.1288}, {indicatorsName: EMA200, value: 28616.35672233}, {indicatorsName: SMA200, value: 28093.04965}, {indicatorsName: Rec.Ichimoku, value: 0}, {indicatorsName: Ichimoku.BLine, value: 30671.505}, {indicatorsName: Rec.VWMA, value: -1}, {indicatorsName: VWMA, value: 30701.19323846}, {indicatorsName: Rec.HullMA9, value: -1}, {indicatorsName: HullMA9, value: 30678.05733333}, {indicatorsName: Pivot.M.Classic.S3, value: 21913.34}, {indicatorsName: Pivot.M.Classic.S2, value: 23953.33}, {indicatorsName: Pivot.M.Classic.S1, value: 25146.65}, {indicatorsName: Pivot.M.Classic.Middle, value: 25993.32}, {indicatorsName: Pivot.M.Classic.R1, value: 27186.64}, {indicatorsName: Pivot.M.Classic.R2, value: 28033.31}, {indicatorsName: Pivot.M.Classic.R3, value: 30073.3}, {indicatorsName: Pivot.M.Fibonacci.S3, value: 23953.33}, {indicatorsName: Pivot.M.Fibonacci.S2, value: 24732.60618}, {indicatorsName: Pivot.M.Fibonacci.S1, value: 25214.04382}, {indicatorsName: Pivot.M.Fibonacci.Middle, value: 25993.32}, {indicatorsName: Pivot.M.Fibonacci.R1, value: 26772.59618}, {indicatorsName: Pivot.M.Fibonacci.R2, value: 27254.03382}, {indicatorsName: Pivot.M.Fibonacci.R3, value: 28033.31}, {indicatorsName: Pivot.M.Camarilla.S3, value: 25778.97275}, {indicatorsName: Pivot.M.Camarilla.S2, value: 25965.97183333}, {indicatorsName: Pivot.M.Camarilla.S1, value: 26152.97091667}, {indicatorsName: Pivot.M.Camarilla.Middle, value: 25993.32}, {indicatorsName: Pivot.M.Camarilla.R1, value: 26526.96908333}, {indicatorsName: Pivot.M.Camarilla.R2, value: 26713.96816667}, {indicatorsName: Pivot.M.Camarilla.R3, value: 26900.96725}, {indicatorsName: Pivot.M.Woodie.S3, value: 23279.995}, {indicatorsName: Pivot.M.Woodie.S2, value: 24039.9975}, {indicatorsName: Pivot.M.Woodie.S1, value: 25319.985}, {indicatorsName: Pivot.M.Woodie.Middle, value: 26079.9875}, {indicatorsName: Pivot.M.Woodie.R1, value: 27359.975}, {indicatorsName: Pivot.M.Woodie.R2, value: 28119.9775}, {indicatorsName: Pivot.M.Woodie.R3, value: 29399.965}, {indicatorsName: Pivot.M.Demark.S1, value: 25569.985}, {indicatorsName: Pivot.M.Demark.Middle, value: 26204.9875}, {indicatorsName: Pivot.M.Demark.R1, value: 27609.975}, {indicatorsName: open, value: 30640.69}, {indicatorsName: P.SAR, value: 30809.65117793}, {indicatorsName: BB.lower, value: 30498.67363085}, {indicatorsName: BB.upper, value: 30871.21436915}, {indicatorsName: AO[2], value: 167.72323529}, {indicatorsName: volume, value: 388.41651}, {indicatorsName: change, value: 0.04696369}, {indicatorsName: low, value: 30612}, {indicatorsName: high, value: 30672.62}]}

    * getSupportAndResistant (``Future <List<Map<String , dynamic>>> ``)  – Technical indicators.
                # Example
                {ticker: BINANCE:BTCUSDT, SupportAndResistant: {r3: 114407.54225, r2: 110121.28948667, r1: 107846.18026333, s1: 101833.64973666999, s2: 98691.90551333001, s3: 94925.63775, middle: 104059.94750000001}}