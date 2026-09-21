class Trade {
  final int? id;
  final String symbol;
  final String type;
  final double entryPrice;
  final double exitPrice;
  final double stopLoss;
  final double takeProfit;
  final double lots;
  final double pnl;
  final String notes;
  final String date;

  Trade({
    this.id,
    required this.symbol,
    required this.type,
    required this.entryPrice,
    required this.exitPrice,
    required this.stopLoss,
    required this.takeProfit,
    required this.lots,
    required this.pnl,
    required this.notes,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'symbol': symbol,
      'type': type,
      'entryPrice': entryPrice,
      'exitPrice': exitPrice,
      'stopLoss': stopLoss,
      'takeProfit': takeProfit,
      'lots': lots,
      'pnl': pnl,
      'notes': notes,
      'date': date,
    };
  }

  factory Trade.fromMap(Map<String, dynamic> map) {
    return Trade(
      id: map['id'],
      symbol: map['symbol'],
      type: map['type'],
      entryPrice: map['entryPrice'],
      exitPrice: map['exitPrice'],
      stopLoss: map['stopLoss'],
      takeProfit: map['takeProfit'],
      lots: map['lots'],
      pnl: map['pnl'],
      notes: map['notes'],
      date: map['date'],
    );
  }
}
