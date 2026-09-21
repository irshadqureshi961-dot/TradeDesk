import 'package:flutter/material.dart';
import '../models/trade.dart';
import '../services/database_helper.dart';

class AddTradeScreen extends StatefulWidget {
  const AddTradeScreen({super.key});

  @override
  State<AddTradeScreen> createState() => _AddTradeScreenState();
}

class _AddTradeScreenState extends State<AddTradeScreen> {
  final _formKey = GlobalKey<FormState>();
  String _symbol = 'XAUUSD';
  String _type = 'BUY';
  double _entryPrice = 0.0;
  double _exitPrice = 0.0;
  double _stopLoss = 0.0;
  double _takeProfit = 0.0;
  double _lots = 0.01;
  double _pnl = 0.0;
  String _notes = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Log New Trade')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                value: _symbol,
                items: ['XAUUSD', 'EURUSD', 'GBPUSD', 'US30', 'NAS100']
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (val) => setState(() => _symbol = val!),
                decoration: const InputDecoration(labelText: 'Symbol'),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('BUY'),
                      value: 'BUY',
                      groupValue: _type,
                      onChanged: (val) => setState(() => _type = val!),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('SELL'),
                      value: 'SELL',
                      groupValue: _type,
                      onChanged: (val) => setState(() => _type = val!),
                    ),
                  ),
                ],
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Entry Price'),
                keyboardType: TextInputType.number,
                onSaved: (val) => _entryPrice = double.tryParse(val ?? '0') ?? 0.0,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Exit Price'),
                keyboardType: TextInputType.number,
                onSaved: (val) => _exitPrice = double.tryParse(val ?? '0') ?? 0.0,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Stop Loss'),
                keyboardType: TextInputType.number,
                onSaved: (val) => _stopLoss = double.tryParse(val ?? '0') ?? 0.0,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Take Profit'),
                keyboardType: TextInputType.number,
                onSaved: (val) => _takeProfit = double.tryParse(val ?? '0') ?? 0.0,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Lot Size'),
                keyboardType: TextInputType.number,
                onSaved: (val) => _lots = double.tryParse(val ?? '0.01') ?? 0.01,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Profit / Loss (\$)'),
                keyboardType: TextInputType.number,
                onSaved: (val) => _pnl = double.tryParse(val ?? '0') ?? 0.0,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Notes / Setup'),
                maxLines: 2,
                onSaved: (val) => _notes = val ?? '',
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final trade = Trade(
                      symbol: _symbol,
                      type: _type,
                      entryPrice: _entryPrice,
                      exitPrice: _exitPrice,
                      stopLoss: _stopLoss,
                      takeProfit: _takeProfit,
                      lots: _lots,
                      pnl: _pnl,
                      notes: _notes,
                      date: DateTime.now().toIso8601String().split('T')[0],
                    );
                    await DatabaseHelper.instance.insertTrade(trade);
                    if (context.mounted) Navigator.pop(context, true);
                  }
                },
                child: const Text('Save Trade Entry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
