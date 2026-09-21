import 'package:flutter/material.dart';
import '../models/trade_models.dart';
import '../services/trading_calculator.dart';

class DashboardScreen extends StatelessWidget {
  final PropAccount account;
  final double todayPnL;

  const DashboardScreen({
    Key? key,
    required this.account,
    this.todayPnL = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double drawdownUsage = TradingCalculator.calculateDrawdownUsage(
      accountSize: account.accountSize,
      currentBalance: account.currentBalance,
      maxDrawdownPct: account.maxDrawdownPct,
    );

    double dailyLossUsage = TradingCalculator.calculateDailyLossUsage(
      accountSize: account.accountSize,
      todayPnL: todayPnL,
      dailyLossLimitPct: account.dailyLossLimitPct,
    );

    return Scaffold(
      backgroundColor: const Color(0xFF0F1419),
      appBar: AppBar(
        title: Text(account.firmName, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF161E2E),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Account Balance Card
            Card(
              color: const Color(0xFF1E293B),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${account.phase} Account Balance',
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '\$${account.currentBalance.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Risk & Drawdown Monitor Section
            const Text(
              'Risk Limits',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Daily Loss Progress Bar
            _buildProgressBar(
              title: 'Daily Loss Limit Used',
              percentage: dailyLossUsage,
            ),
            const SizedBox(height: 12),

            // Max Drawdown Progress Bar
            _buildProgressBar(
              title: 'Max Drawdown Used',
              percentage: drawdownUsage,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar({required String title, required double percentage}) {
    Color progressColor = percentage > 70
        ? Colors.red
        : percentage > 40
            ? Colors.orange
            : Colors.green;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(color: Colors.white70, fontSize: 14)),
              Text(
                '${percentage.toStringAsFixed(1)}%',
                style: TextStyle(color: progressColor, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: (percentage / 100).clamp(0.0, 1.0),
            backgroundColor: Colors.white10,
            valueColor: AlwaysStoppedAnimation<Color>(progressColor),
            minHeight: 8,
          ),
        ],
      ),
    );
  }
}
