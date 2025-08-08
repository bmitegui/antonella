import 'package:antonella/core/utils/util.dart';
import 'package:antonella/features/user/domain/entities/card_entity.dart';
import 'package:antonella/features/user/presentation/screens/card/card_main.dart';
import 'package:flutter/material.dart';

class PaymentMethod extends StatefulWidget {
  final String metodo;
  final Function(String) onChangeMetodo;
  final List<CardEntity> cards;
  final Function(CardEntity) onCardSelected;
  final CardEntity? selectedCard;

  const PaymentMethod({
    super.key,
    required this.metodo,
    required this.onChangeMetodo,
    required this.cards,
    required this.onCardSelected,
    this.selectedCard,
  });

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Método de pago'),
          const SizedBox(height: 16),
          Row(
            children: [
              metodoPagoOpcion("EFECTIVO"),
              const Spacer(),
              metodoPagoOpcion("TARJETA"),
            ],
          ),
          if (widget.metodo == "TARJETA") ...[
            const SizedBox(height: 16),
            Divider(color: Colors.grey.shade300),
            const SizedBox(height: 16),
            metodoPagoOpcion("CRÉDITO/DÉBITO", enabled: false), // solo visual
            const SizedBox(height: 16),
            Divider(color: Colors.grey.shade300),
            const SizedBox(height: 16),

            // Lista de tarjetas:
            ...widget.cards.map((card) => GestureDetector(
                  onTap: () {
                    widget.onCardSelected(card);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: widget.selectedCard == card
                          ? Colors.red.shade100
                          : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: widget.selectedCard == card
                            ? Colors.red
                            : Colors.grey.shade300,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text('${card.type} •••• ${card.hideNumber}'),
                      ],
                    ),
                  ),
                )),
            TextButton.icon(
                onPressed: () =>
                    navigateWithSlideTransition(context, CardMain()),
                label: Text('AÑADIR TARJETA'),
                icon: Icon(Icons.add)),
          ],
        ],
      ),
    );
  }

  Widget metodoPagoOpcion(String text, {bool enabled = true}) {
    final bool isSelected = widget.metodo == text ||
        (widget.metodo == "TARJETA" && text == "CRÉDITO/DÉBITO");

    return GestureDetector(
        onTap: enabled
            ? () {
                widget.onChangeMetodo(text);
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
