# Dart TradingView Technical Analysis

[![pub package](https://img.shields.io/pub/v/tradingview_ta.svg)](https://pub.dev/packages/tradingview_ta)
[![pub points](https://img.shields.io/pub/points/tradingview_ta)](https://pub.dev/packages/tradingview_ta/score)
[![CI](https://github.com/AbdAlftahSalem/dart-tradingview-ta/actions/workflows/ci.yml/badge.svg)](https://github.com/AbdAlftahSalem/dart-tradingview-ta/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

An unofficial TradingView technical analysis client for Dart and Flutter. Get the same indicators, buy/sell recommendations and pivot levels you see on TradingView's technicals page, for many symbols and intervals at once.

A Dart take on the Python [tradingview-ta](https://github.com/AnalyzerREST/python-tradingview-ta) library.

## Features

- Many symbols in one request (crypto, stocks, forex: anything TradingView's screeners cover).
- 91 indicators per symbol: oscillators, moving averages, `Recommend.All` / `Recommend.MA` / `Recommend.Other`, pivot points and more.
- Several intervals in one request, from 1 minute to 1 month.
- Support and resistance levels (S3 to R3), averaged over the Classic, Fibonacci, Camarilla and Woodie monthly pivots.
- Built-in TradingView indicators only (Pine Script / custom indicators aren't available through this API).

## Installation

```bash
dart pub add tradingview_ta
```

or, in a Flutter project:

```bash
flutter pub add tradingview_ta
```

## Usage

```dart
import 'package:tradingview_ta/tradingview_ta.dart';

Future<void> main() async {
  final tradingViewTA = TradingViewTA(
    tradingView: TradingViewModel(
      screener: "crypto",
      symbols: ["BINANCE:BTCUSDT", "BINANCE:ETHUSDT"],
      interval: Intervals.INTERVAL_1_HOUR,
    ),
  );

  // Every indicator for each symbol at one interval
  List<Map<String, dynamic>> analysis = await tradingViewTA.getAnalysis();

  // The same symbols at several intervals, in one request
  List<Map<String, dynamic>> multiFrame =
      await tradingViewTA.getAnalysisWithMultiFrame(
    intervals: [Intervals.INTERVAL_1_DAY, Intervals.INTERVAL_1_WEEK],
  );

  // Support and resistance levels
  List<Map<String, dynamic>> levels =
      await tradingViewTA.getSupportAndResistant();

  print(analysis);
  print(multiFrame);
  print(levels);
}
```

A runnable version is in [`example/tradingview_ta_example.dart`](example/tradingview_ta_example.dart).

### Results

`getAnalysis()`: one map per symbol.

```text
{ticker: BINANCE:BTCUSDT, interval: 1h, indicators: [{indicatorsName: Recommend.All, value: -0.08}, {indicatorsName: RSI, value: 46.0}, ...]}
```

`getAnalysisWithMultiFrame()`: one map per symbol, one entry per interval.

```text
{ticker: BINANCE:BTCUSDT, indicators: [{interval: 1d, indicators: [...]}, {interval: 1W, indicators: [...]}]}
```

`getSupportAndResistant()`: one map per symbol.

```text
{ticker: BINANCE:BTCUSDT, SupportAndResistant: {r3: 87566.4, r2: 85003.3, r1: 82722.0, s1: 78538.8, s2: 77051.4, s3: 74011.9, middle: 81344.9}}
```

An indicator TradingView has no value for comes back as `null`. `Recommend.*` values run from -1 (strong sell) to 1 (strong buy).

## API

| Member | What it does |
|--------|--------------|
| `TradingViewModel(screener:, symbols:, interval:)` | What to request. `screener` is e.g. `crypto`, `forex`, `america`; each symbol needs its exchange (`BINANCE:BTCUSDT`, `NASDAQ:AAPL`). `interval` defaults to 1 hour. |
| `TradingViewTA.getAnalysis()` | All indicators for each symbol at `interval`. |
| `TradingViewTA.getAnalysisWithMultiFrame(intervals:)` | All indicators for each symbol at each interval. |
| `TradingViewTA.getSupportAndResistant()` | S3–R3 and middle pivot levels for each symbol. |
| `Intervals` | `INTERVAL_1_MINUTE`, `INTERVAL_5_MINUTES`, `INTERVAL_15_MINUTES`, `INTERVAL_30_MINUTES`, `INTERVAL_1_HOUR`, `INTERVAL_2_HOURS`, `INTERVAL_4_HOURS`, `INTERVAL_1_DAY`, `INTERVAL_1_WEEK`, `INTERVAL_1_MONTH` |

A symbol without an exchange, an empty screener, an empty `intervals` list or an error answer from TradingView throws an `Exception`.

**Finding the symbol and screener:** search the symbol on [tradingview.com](https://www.tradingview.com/). The exchange prefix is shown next to the name (for example `BINANCE:BTCUSDT`), and the screener is the market: `crypto`, `forex`, `cfd`, or the country for stocks (`america`, `uk`, `egypt`, …).

## Disclaimer

This package isn't affiliated with TradingView. It uses TradingView's public scanner endpoint, which can change without notice. Nothing here is financial advice.

## Contributing

Issues and pull requests are welcome. Before opening a pull request:

```bash
dart format .
dart analyze
dart test
```

## License

[MIT](LICENSE)
