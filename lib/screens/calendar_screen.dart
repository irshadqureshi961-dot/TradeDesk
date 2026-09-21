import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Economic Calendar')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNewsTile('USD', 'Non-Farm Payrolls (NFP)', 'High Impact', '17:30 PKT', Colors.red),
          _buildNewsTile('USD', 'CPI Inflation Rate y/y', 'High Impact', '17:30 PKT', Colors.red),
          _buildNewsTile('EUR', 'ECB Monetary Policy Statement', 'Medium Impact', '18:15 PKT', Colors.orange),
          _buildNewsTile('GBP', 'GDP Quarterly Growth', 'Low Impact', '11:00 PKT', Colors.yellow),
        ],
      ),
    );
  }

  static Widget _buildNewsTile(String currency, String event, String impact, String time, Color impactColor) {
    return Card(
      color: const Color(0xFF1E293B),
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blueGrey[800],
          child: Text(currency, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
        ),
        title: Text(event, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        subtitle: Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: impactColor, shape: BoxShape.circle),
            ),
            const SizedBox(width: 6),
            Text(impact, style: TextStyle(color: impactColor, fontSize: 12)),
          ],
        ),
        trailing: Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ),
    );
  }
}
