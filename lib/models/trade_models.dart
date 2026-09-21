import 'package:cloud_firestore/cloud_firestore.dart';

class PropAccount {
  final String id;
  final String firmName;
  final double accountSize;
  final String phase;
  final DateTime startDate;
  final double currentBalance;
  final double dailyLossLimitPct;
  final double maxDrawdownPct;
  final double profitTargetPct;

  PropAccount({
    required this.id,
    required this.firmName,
    required this.accountSize,
    required this.phase,
    required this.startDate,
    required this.currentBalance,
    required this.dailyLossLimitPct,
    required this.maxDrawdownPct,
    required this.profitTargetPct,
  });

  Map<String, dynamic> toMap() {
    return {
      'firm_name': firmName,
      'account_size': accountSize,
      'phase': phase,
      'start_date': Timestamp.fromDate(startDate),
      'current_balance': currentBalance,
      'daily_loss_limit_pct': dailyLossLimitPct,
      'max_drawdown_pct': maxDrawdownPct,
      'profit_target_pct': profitTargetPct,
    };
  }

  factory PropAccount.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PropAccount(
      id: doc.id,
      firmName: data['firm_name'] ?? '',
      accountSize: (data['account_size'] ?? 0.0).toDouble(),
      phase: data['phase'] ?? 'Challenge',
      startDate: (data['start_date'] as Timestamp).toDate(),
      currentBalance: (data['current_balance'] ?? 0.0).toDouble(),
      dailyLossLimitPct: (data['daily_loss_limit_pct'] ?? 0.0).toDouble(),
      maxDrawdownPct: (data['max_drawdown_pct'] ?? 0.0).toDouble(),
      profitTargetPct: (data['profit_target_pct'] ?? 0.0).toDouble(),
    );
  }
}

class Trade {
  final String id;
  final String accountId;
  final DateTime date;
  final String instrument;
  final String session;
  final String direction;
  final String setup;
  final double entryPrice;
  final double stopLoss;
  final double takeProfit;
  final double lotSize;
  final double riskPct;
  final double exitPrice;
  final double pnl;
  final double rMultiple;
  final String outcome;
  final bool ruleFollowed;
  final String emotion;
  final String notes;

  Trade({
    required this.id,
    required this.accountId,
    required this.date,
    required this.instrument,
    required this.session,
    required this.direction,
    required this.setup,
    required this.entryPrice,
    required this.stopLoss,
    required this.takeProfit,
    required this.lotSize,
    required this.riskPct,
    required this.exitPrice,
    required this.pnl,
    required this.rMultiple,
    required this.outcome,
    required this.ruleFollowed,
    required this.emotion,
    required this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'account_id': accountId,
      'date': Timestamp.fromDate(date),
      'instrument': instrument,
      'session': session,
      'direction': direction,
      'setup': setup,
      'entry_price': entryPrice,
      'stop_loss': stopLoss,
      'take_profit': takeProfit,
      'lot_size': lotSize,
      'risk_pct': riskPct,
      'exit_price': exitPrice,
      'pnl': pnl,
      'r_multiple': rMultiple,
      'outcome': outcome,
      'rule_followed': ruleFollowed,
      'emotion': emotion,
      'notes': notes,
    };
  }

  factory Trade.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Trade(
      id: doc.id,
      accountId: data['account_id'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      instrument: data['instrument'] ?? '',
      session: data['session'] ?? '',
      direction: data['direction'] ?? 'Buy',
      setup: data['setup'] ?? '',
      entryPrice: (data['entry_price'] ?? 0.0).toDouble(),
      stopLoss: (data['stop_loss'] ?? 0.0).toDouble(),
      takeProfit: (data['take_profit'] ?? 0.0).toDouble(),
      lotSize: (data['lot_size'] ?? 0.0).toDouble(),
      riskPct: (data['risk_pct'] ?? 0.0).toDouble(),
      exitPrice: (data['exit_price'] ?? 0.0).toDouble(),
      pnl: (data['pnl'] ?? 0.0).toDouble(),
      rMultiple: (data['r_multiple'] ?? 0.0).toDouble(),
      outcome: data['outcome'] ?? 'BE',
      ruleFollowed: data['rule_followed'] ?? true,
      emotion: data['emotion'] ?? '',
      notes: data['notes'] ?? '',
    );
  }
}
