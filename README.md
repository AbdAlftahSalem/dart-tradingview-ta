<h1 align="center">Dart TradingView Technical Analysis (dart-tradingview-ta)</h1>
<br>
<div align="center">
  <p>An unofficial API wrapper for TradingView that allows you to fetch technical analysis data, now under new management.</p>
  <img src="https://raw.githubusercontent.com/analyzerrest/python-tradingview-ta/main/images/tradingview.png" />
</div>

## Important

- Keep tradingview-ta up to date for new features and bug fixes: `flutter pub add tradingview_ta`
- This project is a Dart implementation of
the [python-tradingview-ta](https://github.com/AnalyzerREST/python-tradingview-ta) package, originally developed in
Python. It provides technical analysis indicators and strategies for analyzing trading data from the TradingView
platform.

## Features

* Support for multiple symbols
* Indicators (Only TradingView built-in, does not support Pine Script/custom indicators)

## Installation

[pub.dev](https://pub.dev/packages/tradingview_ta/install) (stable, recommended):

```flutter pub add tradingview_ta```

GitHub (latest):

```git clone https://github.com/AbdAlftahSalem/dart-tradingview-ta.git```

## Example

```python
from tradingview_ta import TA_Handler, Interval, Exchange

TradingViewTA tradingViewTA = TradingViewTA(
    tradingView: TradingViewModel(
      screener: "crypto",
      symbols: ["BINANCE:BTCUSDT", "BINANCE:ETHUSDT"],
      interval: Intervals.INTERVAL_1_HOUR,
    ),
  );
  
List<Map<String, dynamic>> resSupportAndResistant =
await tradingViewTA.getSupportAndResistant();
List<Map<String, dynamic>> resAnalysis = await tradingViewTA.getAnalysis();
print(resSupportAndResistant);
print(resAnalysis);
```

Tip: Use https://tvdb.analyzer.rest/ if you don't know what symbol, screener, and exchange to use.

## Methods

- getAnalysis()
- getSupportAndResistant ()

[Package on pub.dev](https://pub.dev/packages/tradingview_ta)

