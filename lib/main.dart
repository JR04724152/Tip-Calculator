import 'package:flutter/material.dart';

void main() => runApp(const TipApp());

class TipApp extends StatelessWidget {
  const TipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tip Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
        ),
        useMaterial3: true,
      ),
      home: const TipPage(),
    );
  }
}

double? parseBill(String input) {
  return double.tryParse(input.trim());
}

({double tip, double total}) computeTip(
  double bill,
  int percent,
) {
  final tip = bill * percent / 100;
  return (
    tip: tip,
    total: bill + tip,
  );
}

class TipPage extends StatefulWidget {
  const TipPage({super.key});

  @override
  State<TipPage> createState() => _TipPageState();
}

class _TipPageState extends State<TipPage> {
  final TextEditingController _billController =
      TextEditingController();

  int _selectedPercent = 15;

  @override
  void dispose() {
    _billController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bill = parseBill(_billController.text);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tip Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _billController,
              keyboardType:
                  const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Bill Amount',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) {
                setState(() {});
              },
            ),

            const SizedBox(height: 20),

            SegmentedButton<int>(
              segments: const [
                ButtonSegment(
                  value: 10,
                  label: Text('10%'),
                ),
                ButtonSegment(
                  value: 15,
                  label: Text('15%'),
                ),
                ButtonSegment(
                  value: 20,
                  label: Text('20%'),
                ),
              ],
              selected: {_selectedPercent},
              onSelectionChanged: (value) {
                setState(() {
                  _selectedPercent = value.first;
                });
              },
            ),

            const SizedBox(height: 24),

            if (bill == null)
              const Text(
                'Enter a valid amount',
                style: TextStyle(
                  color: Colors.red,
                ),
              )
            else ...[
              Builder(
                builder: (context) {
                  final result =
                      computeTip(
                    bill,
                    _selectedPercent,
                  );

                  return Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tip: ${result.tip.toStringAsFixed(2)}',
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Total: ${result.total.toStringAsFixed(2)}',
                      ),
                    ],
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}