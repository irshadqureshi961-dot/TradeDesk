import 'package:flutter/material.dart';
import 'models/trade_models.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(const TradeDeskApp());
}

class TradeDeskApp extends StatelessWidget {
  const TradeDeskApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample Account to preview UI
    final sampleAccount = PropAccount(
      id: '1',
      firmName: 'FTMO Challenge',
      accountSize: 100000.0,
      phase: 'Challenge',
      startDate: DateTime.now(),
      currentBalance: 98500.0,
      dailyLossLimitPct: 5.0,
      maxDrawdownPct: 10.0,
      profitTargetPct: 10.0,
    );

    return MaterialApp(
      title: 'TradeDesk',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F1419),
      ),
      home: DashboardScreen(account: sampleAccount, todayPnL: -1500.0),
    );
  }
}
