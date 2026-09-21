import 'package:flutter/material.dart';

class RiskEngine {
  static void checkLimits({
    required BuildContext context,
    required double accountBalance,
    required double currentDailyLoss,
    required double maxDailyLoss,
  }) {
    double lossPercentage = (currentDailyLoss / maxDailyLoss) * 100;

    if (lossPercentage >= 100) {
      _showAlert(
        context,
        title: '⛔ Daily Limit Reached',
        message: 'Trading disabled: You have exceeded your Daily Loss Limit!',
        color: Colors.red,
      );
    } else if (lossPercentage >= 80) {
      _showAlert(
        context,
        title: '⚠️ Risk Warning',
        message: 'You have used ${lossPercentage.toStringAsFixed(1)}% of your Daily Loss Limit.',
        color: Colors.orange,
      );
    }
  }

  static void _showAlert(BuildContext context, {required String title, required String message, required Color color}) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Acknowledge'),
          ),
        ],
      ),
    );
  }
}
