import 'package:flutter/material.dart';

class PaymentMethod extends StatelessWidget {
  final String metodo;
  final Function(String) onChange;
  const PaymentMethod(
      {super.key, required this.metodo, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.white),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Método de pago'),
          const SizedBox(height: 16),
          Row(
            children: [
              metodoPagoOpcion("EFECTIVO"),
              const Spacer(),
              metodoPagoOpcion("TARJETA")
            ],
          ),
          if (metodo == "TARJETA") ...[
            const SizedBox(height: 16),
            Divider(color: Colors.grey.shade300),
            const SizedBox(height: 16),
            metodoPagoOpcion("CRÉDITO/DÉBITO", enabled: false), // solo visual
            const SizedBox(height: 16),
            Divider(color: Colors.grey.shade300),
            const SizedBox(height: 16),
            Row(children: [
              const Icon(Icons.payment),
              const SizedBox(width: 8),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                    Text('Mastercard 5110 **** **** 6646'),
                    Text('Nombre en la tarjeta')
                  ])),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward)
            ])
          ]
        ]));
  }

  Widget metodoPagoOpcion(String text, {bool enabled = true}) {
    final bool isSelected =
        metodo == text || (metodo == "TARJETA" && text == "CRÉDITO/DÉBITO");

    return GestureDetector(
        onTap: enabled
            ? () {
                onChange(text);
              }
            : null,
        child: Row(children: [
          CircleAvatar(
              backgroundColor: Colors.black,
              radius: 8,
              child: CircleAvatar(
                  backgroundColor:
                      isSelected ? const Color(0xFFF44565) : Colors.white,
                  radius: 7)),
          const SizedBox(width: 8),
          Text(text,
              style: TextStyle(
                  color: isSelected ? const Color(0xFFF44565) : Colors.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal))
        ]));
  }
}
