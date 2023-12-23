# PoshTrade: PowerShell Trading Algorithms

![PoshTrade: PowerShell Trading Algorithms](https://github.com/voytas75/PoshTrade/blob/main/images/trading.png?raw=true "PoshTrade: PowerShell Trading Algorithms")

PoshTrade is a comprehensive collection of PowerShell scripts implementing various trading algorithms for stock and other financial markets. The scripts analyze market data and make buy or sell decisions based on specific criteria. The repository also includes educational resources on trading strategies, technical and fundamental analysis, risk management, and more.

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/A0A6KYBUS)

## Installation

To use PoshTrade, you'll need to have PowerShell installed on your machine. You can download PowerShell from the Microsoft website.

Additionally, you will also need to have Git software installed to clone the PoshTrade repository to your local machine. If you don't have Git installed, you can download it from the official Git website.

Once you have both PowerShell and Git installed, you can clone the PoshTrade repository to your local machine using the following command:

```git
git clone https://github.com/voytas75/PoshTrade.git
```

## Usage

To use PoshTrade, you'll need to provide it with market data in the form of CSV files. You can use your own data or download data from a source like Yahoo Finance, Alpha Vantage, Google Finance, IEX Cloud, Quandl, Intrinio, Tiingo, AlphaQuantics, Polygon.io, EOD Historical Data, Quodd, Tradier, Marketstack, Coingecko or World Trading Data.

The PoshTrade repository will soon include several scripts that implement different trading algorithms. For now, the repository is in its initial state.

## Functions

1. [`Get-BollingerBands`](/code/Get-BollingerBands.ps1) *(updated: 2023-12-02)*
2. [`Get-DEMA`](/code/Get-DEMA.ps1) *(updated: 2023-07-04)*
   - Dependiecies: [`Get-EMA`](/code/Get-EMA.ps1)
3. [`Get-TEMA`](/code/Get-TEMA.ps1) *(updated: 2023-12-02)*
   - Dependiecies: [`Get-EMA`](/code/Get-EMA.ps1)
4. [`Get-EMA`](/code/Get-EMA.ps1) *(updated: 2023-07-04)*
5. [`Get-WeightedMovingAverage`](/code/Get-WMA.ps1) *(updated: 2023-12-02)*
6. [`Get-FibonacciRetracement`](/code/Get-FibonacciRetracement.ps1) *(updated: 2023-12-02)*
7. [`Get-IchimokuCloud`](/code/Get-IchimokuCloud.ps1) *(updated: 2023-12-02)*
8. [`Get-MACD`](/code/Get-MACD.ps1) *(updated: 2023-12-02)*
9. [`Get-OBV`](/code/Get-OBV.ps1) *(updated: 2023-12-02)*
10. [`Get-RSI`](/code/Get-RSI.ps1) *(updated: 2023-12-02)*
11. [`Get-SMA`](/code/Get-SMA.ps1) *(updated: 2023-12-02)*
12. [`Get-StochasticOscillator`](/code/Get-StochasticOscillator.ps1) *(updated: 2023-12-02)*
13. [`Get-VWAP`](/code/Get-VWAP.ps1) *(updated: 2023-12-02)*
14. [`Get-MovingAverageRibbon`](./code/Get-MovingAverageRibbon.ps1) *(updated: 2023-12-02)*
15. [`Get-ROC`](./code/Get-ROC.ps1) *(updated: 2023-12-02)*
16. [`Get-WilliamsRIndicator`](./code/Get-WilliamsRIndicator.ps1) *(updated: 2023-12-02)*
17. [`Get-CCI`](./code/Get-CCI.ps1) *(updated: 2023-12-02)*

## Knowledge

1. [Technical indicators](./knowledge/TechnicalIndicators.md)
2. [Financial Markets](./knowledge/FinancialMarkets.md)
3. [Trading Strategies](./knowledge/TradingStrategies.md)
4. [Technical Analysis](./knowledge/TechnicalAnalysis.md)
5. [Fundamental Analysis](./knowledge/FundamentalAnalysis.md)
6. [Quantitative Skills](./knowledge/QantitativeSkills.md)
7. [Risk Management](./knowledge/RiskManagement.md)
8. [Market Data and APIs](./knowledge/MarketDanaAPIs.md)
9. [Backtesting and Simulation](./knowledge/BacktestingSimulation.md)
10. [Regulatory and Legal Considerations](./knowledge/Regulatory.md)

## Contributing

We welcome contributions to PoshTrade! If you have an idea for a new trading algorithm or want to improve an existing one, please submit a pull request with your changes.

Before submitting a pull request, please make sure your code is well-documented and thoroughly tested. We also recommend discussing your changes in the issues section of the repository before submitting a pull request.

## License

PoshTrade is released under the MIT license. See the LICENSE file for more information.

## Contact

If you have any questions or comments about PoshTrade, please contact us through GitHub. We'd love to hear from you!
