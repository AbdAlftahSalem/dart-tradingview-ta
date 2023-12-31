<h1 align="center">Dart TradingView Technical Analysis (dart-tradingview-ta)</h1>
<br>
<div align="center">
  <p>An unofficial API wrapper for TradingView that allows you to fetch technical analysis data, now under new management.</p>
  <img src="https://cdn.pixabay.com/photo/2016/11/27/21/42/stock-1863880_1280.jpg" />
</div>

## Important

- Keep tradingview-ta up to date for new features and bug fixes: `flutter pub add tradingview_ta`
- This project is a Dart implementation of

## Features

* Support for multiple symbols
* Get multi symbols with multi intervals
* Indicators (Only TradingView built-in, does not support Pine Script/custom indicators)

## Installation

[pub.dev](https://pub.dev/packages/tradingview_ta/install) (stable, recommended):

```flutter pub add tradingview_ta```

GitHub (latest):

```git clone https://github.com/AbdAlftahSalem/dart-tradingview-ta.git```

## Example

```python
// to get multi ticekr data with signal interval


  TradingViewTA tradingViewTA = TradingViewTA(
      tradingView: TradingViewModel(
        screener: "crypto",
        symbols: ["BINANCE:BTCUSDT", "BINANCE:ETHUSDT"],
        interval: Intervals.INTERVAL_1_HOUR,
      ),
    );
  
// to get multi ticekr data with multi interval


  List<Map<String, dynamic>> resAnalysis = await tradingViewTA.getAnalysis();


// to get multi ticekr data with multi interval
  
  
  List<Map<String, dynamic>> res =
        await tradingViewTA.getAnalysisWithMultiFrame(
        intervals: [
          Intervals.INTERVAL_1_MONTH,
          Intervals.INTERVAL_1_HOUR,
        ],
    );
    print(res);
  
// to get support and resistant for tickers
  
  List<Map<String, dynamic>> resSupportAndResistant = await tradingViewTA.getSupportAndResistant();
  print(resSupportAndResistant);
  print(resAnalysis);
```

Tip: Use https://tvdb.analyzer.rest/ if you don't know what symbol, screener, and exchange to use.

## Methods

- getAnalysis()
- getSupportAndResistant ()
- getAnalysisWithMultiFrame()
  
[Package on pub.dev](https://pub.dev/packages/tradingview_ta)

