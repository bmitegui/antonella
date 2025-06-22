import 'package:flutter/material.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.white),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Método de pago'),
          const SizedBox(height: 16),
          Row(children: [
            info(Colors.white, "Efectivo"),
            Spacer(),
            info(Color(0xFFF44565), 'Tarjeta')
          ]),
          const SizedBox(height: 16),
          Divider(color: Colors.grey.shade300),
          const SizedBox(height: 16),
          info(Color(0xFFF44565), 'Crédito/Débito'),
          const SizedBox(height: 16),
          Divider(color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Row(children: [
            Icon(Icons.payment),
            const SizedBox(width: 8),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                Text('Mastercard 5110 **** **** 6646'),
                Text('Nombre en la tarjeta')
              ]),
            ),
            const SizedBox(width: 8),
            Icon(Icons.arrow_forward)
          ]),
        ]));
  }

  Widget info(Color color, String text) {
    return Row(children: [
      CircleAvatar(
          backgroundColor: Colors.black,
          radius: 8,
          child: CircleAvatar(backgroundColor: color, radius: 7)),
      SizedBox(width: 8),
      Text(text)
    ]);
  }
}
