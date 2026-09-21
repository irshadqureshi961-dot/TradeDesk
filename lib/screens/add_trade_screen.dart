import 'package:flutter/material.dart';

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
  double _stopLoss = 0.0;
  double _takeProfit = 0.0;
  double _lots = 0.01;
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
                decoration: const InputDecoration(labelText: 'Notes / Setup'),
                maxLines: 3,
                onSaved: (val) => _notes = val ?? '',
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.pop(context);
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
