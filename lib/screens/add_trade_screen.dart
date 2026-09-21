import 'package:flutter/material.dart';
import '../services/trading_calculator.dart';

class AddTradeScreen extends StatefulWidget {
  final double accountBalance;

  const AddTradeScreen({Key? key, required this.accountBalance}) : super(key: key);

  @override
  State<AddTradeScreen> createState() => _AddTradeScreenState();
}

class _AddTradeScreenState extends State<AddTradeScreen> {
  final _symbolController = TextEditingController(text: 'EURUSD');
  final _entryController = TextEditingController();
  final _slController = TextEditingController();
  final _riskPctController = TextEditingController(text: '1.0');
  
  double _calculatedLotSize = 0.0;
  double _suggestedTP = 0.0;
  String _direction = 'BUY';

  void _calculatePosition() {
    double entry = double.tryParse(_entryController.text) ?? 0.0;
    double sl = double.tryParse(_slController.text) ?? 0.0;
    double riskPct = double.tryParse(_riskPctController.text) ?? 1.0;

    if (entry > 0 && sl > 0) {
      setState(() {
        _calculatedLotSize = TradingCalculator.calculateLotSize(
          accountBalance: widget.accountBalance,
          riskPct: riskPct,
          entryPrice: entry,
          stopLossPrice: sl,
          symbol: _symbolController.text,
        );

        _suggestedTP = TradingCalculator.calculateSuggestedTP(
          entryPrice: entry,
          stopLossPrice: sl,
          direction: _direction,
          targetRR: 2.0,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1419),
      appBar: AppBar(
        title: const Text('Log New Trade'),
        backgroundColor: const Color(0xFF161E2E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _symbolController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Instrument (e.g. EURUSD, XAUUSD)',
                  labelStyle: TextStyle(color: Colors.grey),
                ),
                onChanged: (_) => _calculatePosition(),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _entryController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Entry Price',
                  labelStyle: TextStyle(color: Colors.grey),
                ),
                onChanged: (_) => _calculatePosition(),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _slController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Stop Loss Price',
                  labelStyle: TextStyle(color: Colors.grey),
                ),
                onChanged: (_) => _calculatePosition(),
              ),
              const SizedBox(height: 20),

              // Position Calculator Results Box
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Calculated Lot Size:', style: TextStyle(color: Colors.grey)),
                        Text('$_calculatedLotSize Lots', style: const TextStyle(color: Colors.greenAccent, fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Suggested TP (1:2 R:R):', style: TextStyle(color: Colors.grey)),
                        Text(_suggestedTP.toStringAsFixed(4), style: const TextStyle(color: Colors.white, fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
