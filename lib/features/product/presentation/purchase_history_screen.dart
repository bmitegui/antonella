import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/core/widgets/arrow_back.dart';

class Purchase {
  final String id;
  final DateTime createdAt;
  final double total;
  final PurchaseStatus status;
  final List<PurchaseItem> items;

  Purchase({
    required this.id,
    required this.createdAt,
    required this.total,
    required this.status,
    required this.items,
  });
}

class PurchaseItem {
  final String name;
  final String imageUrl;
  final int quantity;
  final double price;

  PurchaseItem({
    required this.name,
    required this.imageUrl,
    required this.quantity,
    required this.price,
  });
}

enum PurchaseStatus { delivered, processing, cancelled }

class PurchaseHistoryScreen extends StatelessWidget {
  const PurchaseHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final purchases = _dummyPurchases;

    return CustomScaffold(
      leading: const ArrowBack(),
      text: 'Historial de compras',
      body: purchases.isEmpty
          ? const _EmptyHistory()
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: purchases.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, index) => _PurchaseCard(purchase: purchases[index]),
            ),
    );
  }
}

class _PurchaseCard extends StatelessWidget {
  const _PurchaseCard({required this.purchase});

  final Purchase purchase;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final date = DateFormat('dd/MM/yyyy').format(purchase.createdAt);

    final (icon, color) = switch (purchase.status) {
      PurchaseStatus.delivered  => (Icons.check_circle,  Colors.green),
      PurchaseStatus.processing => (Icons.schedule,      Colors.orange),
      PurchaseStatus.cancelled  => (Icons.cancel,        Colors.red),
    };

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(blurRadius: 3, color: Colors.black12)],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 18),
              const SizedBox(width: 4),
              Text(date, style: theme.textTheme.bodySmall),
              const Spacer(),
              Text('Total: \$${purchase.total.toStringAsFixed(2)}',
                  style: theme.textTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          ..._buildItemLines(purchase.items, theme),
        ],
      ),
    );
  }

  List<Widget> _buildItemLines(List<PurchaseItem> items, ThemeData theme) {
    const maxLines = 3;
    final visibleItems = items.take(maxLines).toList();
    final overflow = items.length - visibleItems.length;

    return [
      for (var item in visibleItems)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(item.imageUrl,
                    width: 40, height: 40, fit: BoxFit.cover),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text('${item.name}  x${item.quantity}',
                    style: theme.textTheme.bodyMedium),
              ),
              Text('\$${(item.price * item.quantity).toStringAsFixed(2)}',
                  style: theme.textTheme.bodyMedium),
            ],
          ),
        ),
      if (overflow > 0)
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text('+ $overflow producto(s) más…',
              style: theme.textTheme.bodySmall!.copyWith(color: Colors.grey)),
        ),
    ];
  }
}

class _EmptyHistory extends StatelessWidget {
  const _EmptyHistory();

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.receipt_long,
                size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 12),
            const Text('Aún no tienes compras',
                style: TextStyle(fontSize: 16, color: Colors.grey)),
          ],
        ),
      );
}

final _dummyPurchases = [
  Purchase(
    id: 'o1',
    createdAt: DateTime.now().subtract(const Duration(days: 3)),
    total: 37.00,
    status: PurchaseStatus.delivered,
    items: [
      PurchaseItem(
        name: 'aceite de romero test',
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBIn3S1GGKiBuT7GN5cHOOLRNpmluzl7AkIg&s',
        quantity: 2,
        price: 8.0,
      ),
      PurchaseItem(
        name: 'ejemplo test',
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBIn3S1GGKiBuT7GN5cHOOLRNpmluzl7AkIg&s',
        quantity: 1,
        price: 21.0,
      ),
    ],
  ),
  Purchase(
    id: 'o2',
    createdAt: DateTime.now().subtract(const Duration(days: 15)),
    total: 74.80,
    status: PurchaseStatus.processing,
    items: [
      PurchaseItem(
        name: 'aceite de lavanda test',
        imageUrl: 'https://images.ctfassets.net/a8l3ylu84syn/6hqIbk57KXINJUNVWKyMCm/42b1022e6a4eda2536cefbbfafdc4341/3.png',
        quantity: 2,
        price: 14.0,
      ),
      PurchaseItem(
        name: 'aceite de romero test',
        imageUrl: 'https://images.ctfassets.net/a8l3ylu84syn/6hqIbk57KXINJUNVWKyMCm/42b1022e6a4eda2536cefbbfafdc4341/3.png',
        quantity: 3,
        price: 8.0,
      ),
    ],
  ),
];
