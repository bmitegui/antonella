import 'package:flutter/material.dart';
import 'package:antonella/features/service/domain/entities/order_entity.dart';
import 'package:antonella/core/utils/util.dart';

class TotalOrderContainer extends StatelessWidget {
  final OrderEntity orderEntity;
  const TotalOrderContainer({super.key, required this.orderEntity});

  @override
  Widget build(BuildContext context) {
    final totals = calculateTotals(orderEntity);

    TextStyle labelStyle = bodyBlack54Style(context);
    TextStyle totalStyle = bodyBlack54Style(context)
        .copyWith(fontWeight: FontWeight.bold, fontSize: 18);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildRow("Subtotal", totals['subtotal']!, labelStyle),
          const SizedBox(height: 8),
          _buildRow("IVA", totals['iva']!, labelStyle),
          const Divider(height: 24, thickness: 1),
          _buildRow("Total", totals['total']!, totalStyle),
        ],
      ),
    );
  }

  Widget _buildRow(String label, double value, TextStyle style) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text("\$${value.toStringAsFixed(2)}", style: style),
      ],
    );
  }
}
