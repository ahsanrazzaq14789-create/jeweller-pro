import 'package:flutter/material.dart';

void main() => runApp(const JewellerPro());

const gold = Color(0xFFD4AF37);
const dark = Color(0xFF101010);

class JewellerPro extends StatelessWidget {
  const JewellerPro({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Jeweller Pro',
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: dark,
      colorScheme: ColorScheme.fromSeed(seedColor: gold, brightness: Brightness.dark),
      appBarTheme: const AppBarTheme(backgroundColor: dark, foregroundColor: gold),
      inputDecorationTheme: InputDecorationTheme(
        filled: true, fillColor: const Color(0xFF202020),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    home: const HomePage(),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String shopName = 'Jeweller Pro';
  double goldRate = 0;
  double silverRate = 0;
  final List<Map<String, String>> customers = [];
  final List<Map<String, String>> entries = [];

  Future<void> editShop() async {
    final c = TextEditingController(text: shopName);
    final result = await showDialog<String>(context: context, builder: (ctx) => AlertDialog(
      title: const Text('Shop profile'),
      content: TextField(controller: c, decoration: const InputDecoration(labelText: 'Shop name')),
      actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
        FilledButton(onPressed: () => Navigator.pop(ctx, c.text.trim()), child: const Text('Save'))],
    ));
    if (result != null && result.isNotEmpty) setState(() => shopName = result);
  }

  Future<void> editRates() async {
    final g = TextEditingController(text: goldRate == 0 ? '' : goldRate.toString());
    final s = TextEditingController(text: silverRate == 0 ? '' : silverRate.toString());
    final result = await showDialog<List<double>>(context: context, builder: (ctx) => AlertDialog(
      title: const Text('Daily metal rates'),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(controller: g, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Gold rate per tola (PKR)')),
        const SizedBox(height: 12),
        TextField(controller: s, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Silver rate per tola (PKR)')),
      ]),
      actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
        FilledButton(onPressed: () => Navigator.pop(ctx, [double.tryParse(g.text) ?? 0, double.tryParse(s.text) ?? 0]), child: const Text('Save'))],
    ));
    if (result != null) setState(() { goldRate = result[0]; silverRate = result[1]; });
  }

  Future<void> addCustomer() async {
    final name = TextEditingController(), phone = TextEditingController();
    final result = await showDialog<List<String>>(context: context, builder: (ctx) => AlertDialog(
      title: const Text('Add customer'),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(controller: name, decoration: const InputDecoration(labelText: 'Customer name')),
        const SizedBox(height: 12),
        TextField(controller: phone, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: 'Phone (optional)')),
      ]),
      actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
        FilledButton(onPressed: () => Navigator.pop(ctx, [name.text.trim(), phone.text.trim()]), child: const Text('Save'))],
    ));
    if (result != null && result[0].isNotEmpty) setState(() => customers.add({'name': result[0], 'phone': result[1]}));
  }

  Future<void> addEntry(String type) async {
    final desc = TextEditingController(), amount = TextEditingController();
    final result = await showDialog<List<String>>(context: context, builder: (ctx) => AlertDialog(
      title: Text(type),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(controller: desc, decoration: const InputDecoration(labelText: 'Details')),
        const SizedBox(height: 12),
        TextField(controller: amount, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Amount (PKR)')),
      ]),
      actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
        FilledButton(onPressed: () => Navigator.pop(ctx, [desc.text.trim(), amount.text.trim()]), child: const Text('Save'))],
    ));
    if (result != null && result[0].isNotEmpty) {
      setState(() => entries.insert(0, {'type': type, 'details': result[0], 'amount': result[1]}));
    }
  }

  Widget tile(IconData icon, String title, String subtitle, VoidCallback onTap) => Card(
    color: const Color(0xFF1D1D1D),
    child: ListTile(leading: CircleAvatar(backgroundColor: gold.withOpacity(.15), child: Icon(icon, color: gold)),
      title: Text(title, style: const TextStyle(color: gold, fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle), trailing: const Icon(Icons.chevron_right), onTap: onTap),
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(shopName, style: const TextStyle(fontWeight: FontWeight.bold)), actions: [
      IconButton(onPressed: editShop, icon: const Icon(Icons.storefront))
    ]),
    body: ListView(padding: const EdgeInsets.all(16), children: [
      Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF30270D), Color(0xFF171717)]),
        borderRadius: BorderRadius.circular(18), border: Border.all(color: gold.withOpacity(.5))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('JEWELLER PRO', style: TextStyle(color: gold, letterSpacing: 2, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Shop management dashboard', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 14),
          Text('Customers: ${customers.length}    Entries: ${entries.length}', style: const TextStyle(color: Colors.white70)),
        ])),
      const SizedBox(height: 12),
      tile(Icons.currency_exchange, 'Gold & Silver Rates', 'Gold: ${goldRate.toStringAsFixed(0)} | Silver: ${silverRate.toStringAsFixed(0)} PKR / tola', editRates),
      tile(Icons.people_alt, 'Customers', '${customers.length} saved customers', addCustomer),
      tile(Icons.point_of_sale, 'Sales', 'Record a jewellery sale', () => addEntry('Sale')),
      tile(Icons.shopping_bag, 'Purchases', 'Record a purchase', () => addEntry('Purchase')),
      tile(Icons.inventory_2, 'Stock', 'Add stock record', () => addEntry('Stock')),
      tile(Icons.account_balance_wallet, 'Udhar / Receivables', 'Record a credit or payment', () => addEntry('Udhar / Payment')),
      tile(Icons.receipt_long, 'Expenses', 'Record shop expenses', () => addEntry('Expense')),
      tile(Icons.settings, 'Shop Settings', 'Change shop name and profile', editShop),
      const SizedBox(height: 8),
      const Text('Recent entries', style: TextStyle(color: gold, fontSize: 17, fontWeight: FontWeight.bold)),
      if (entries.isEmpty) const Padding(padding: EdgeInsets.all(16), child: Text('No entries yet. Add your first transaction.')),
      ...entries.take(20).map((e) => Card(color: const Color(0xFF1D1D1D), child: ListTile(
        title: Text(e['type'] ?? ''), subtitle: Text(e['details'] ?? ''),
        trailing: Text('${e['amount'] ?? ''} PKR', style: const TextStyle(color: gold))))),
      if (customers.isNotEmpty) ...[
        const SizedBox(height: 8), const Text('Customers', style: TextStyle(color: gold, fontSize: 17, fontWeight: FontWeight.bold)),
        ...customers.map((c) => ListTile(leading: const Icon(Icons.person, color: gold), title: Text(c['name']!), subtitle: Text(c['phone']!))),
      ],
    ]),
  );
}
