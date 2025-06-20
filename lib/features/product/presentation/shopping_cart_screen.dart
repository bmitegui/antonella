import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';

class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: Text('Carrito de compras'),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)]),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: ElevatedButton(
          onPressed: () {
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFF44565),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            elevation: 0,
          ),
          child: const Text(
            'Comprar',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),

      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '2 Items',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 16),

            buildCartItem(
              imageUrl: 'https://i.imgur.com/yM7nq9c.png',
              title: 'Maquillaje',
              price: '\$4.74',
              quantity: 1,
            ),

            const SizedBox(height: 16),
            buildCartItem(
              imageUrl: 'https://i.imgur.com/6HhU7bS.png',
              title:
                  'Shampoo',
              price: '\$14.93',
              quantity: 1,
            ),

            const SizedBox(height: 24),

            buildPriceRow('Subtotal', '\$19.67'),
            const SizedBox(height: 8),
            buildPriceRow('IVA', '\$1.52'),
            const Divider(height: 32),
            buildPriceRow(
              'Total',
              '\$21.19',
              isBold: true,
              fontSize: 18,
            ),
          ],
        ),
      ),

      
    );
  }

  Widget buildCartItem({
    required String imageUrl,
    required String title,
    required String price,
    required int quantity,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Image.network(imageUrl, width: 60, height: 60),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Text('Qty $quantity'),
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(height: 40),
              Text(price, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }

  Widget buildPriceRow(String label, String value,
      {bool isBold = false, double fontSize = 14}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: fontSize,
            )),
        Text(value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: fontSize,
            )),
      ],
    );
  }
}