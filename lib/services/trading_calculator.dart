import 'dart:math';

class TradingCalculator {
  static double calculateLotSize({
    required double accountBalance,
    required double riskPct,
    required double entryPrice,
    required double stopLossPrice,
    required String symbol,
  }) {
    if (entryPrice == stopLossPrice || accountBalance <= 0 || riskPct <= 0) {
      return 0.0;
    }

    double riskAmount = accountBalance * (riskPct / 100.0);
    String cleanSymbol = symbol.toUpperCase().replaceAll('/', '');

    if (cleanSymbol.contains('XAU') || cleanSymbol.contains('GOLD')) {
      double priceDistance = (entryPrice - stopLossPrice).abs();
      double lotSize = riskAmount / (priceDistance * 100.0);
      return double.parse(lotSize.toStringAsFixed(2));
    }

    double pipMultiplier = cleanSymbol.contains('JPY') ? 100.0 : 10000.0;
    double stopLossPips = (entryPrice - stopLossPrice).abs() * pipMultiplier;
    double pipValuePerStandardLot = 10.0;

    double lotSize = riskAmount / (stopLossPips * pipValuePerStandardLot);
    return double.parse(lotSize.toStringAsFixed(2));
  }

  static double calculateSuggestedTP({
    required double entryPrice,
    required double stopLossPrice,
    required String direction,
    required double targetRR,
  }) {
    double riskDistance = (entryPrice - stopLossPrice).abs();
    if (direction.toUpperCase() == 'BUY') {
      return entryPrice + (riskDistance * targetRR);
    } else {
      return entryPrice - (riskDistance * targetRR);
    }
  }

  static double calculateDrawdownUsage({
    required double accountSize,
    required double currentBalance,
    required double maxDrawdownPct,
  }) {
    if (accountSize <= 0 || maxDrawdownPct <= 0) return 0.0;

    double maxAllowedDrawdownDollars = accountSize * (maxDrawdownPct / 100.0);
    double currentDrawdownDollars = accountSize - currentBalance;

    if (currentDrawdownDollars <= 0) return 0.0;

    double usagePct = (currentDrawdownDollars / maxAllowedDrawdownDollars) * 100.0;
    return min(100.0, double.parse(usagePct.toStringAsFixed(2)));
  }

  static double calculateDailyLossUsage({
    required double accountSize,
    required double todayPnL,
    required double dailyLossLimitPct,
  }) {
    if (accountSize <= 0 || dailyLossLimitPct <= 0 || todayPnL >= 0) {
      return 0.0;
    }

    double maxDailyLossDollars = accountSize * (dailyLossLimitPct / 100.0);
    double lossUsedPct = (todayPnL.abs() / maxDailyLossDollars) * 100.0;

    return min(100.0, double.parse(lossUsedPct.toStringAsFixed(2)));
  }
}
