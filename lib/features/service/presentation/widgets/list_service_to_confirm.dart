import 'package:antonella/features/service/presentation/widgets/info_service_to_confirm.dart';
import 'package:flutter/material.dart';

class ListServiceToConfirm extends StatefulWidget {
  final int quantity;
  const ListServiceToConfirm({super.key, required this.quantity});

  @override
  State<ListServiceToConfirm> createState() => _ListServiceToConfirmState();
}

class _ListServiceToConfirmState extends State<ListServiceToConfirm> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: widget.quantity,
        itemBuilder: (BuildContext context, int value) =>
            InfoServiceToConfirm(),
        separatorBuilder: (BuildContext context, int index) =>
            SizedBox(height: 16));
  }
}
