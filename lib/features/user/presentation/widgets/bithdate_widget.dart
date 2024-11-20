import 'package:antonella/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class BirthdateWidget extends StatelessWidget {
  final TextEditingController bithdateController;
  final Function(String) onChanged;
  final String? Function(String?)? validator;
  const BirthdateWidget(
      {super.key,
      required this.bithdateController,
      required this.onChanged,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text('Fecha de nacimiento:',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.bold)),
      const SizedBox(width: 8),
      Expanded(
          flex: 7,
          child: GestureDetector(
              onTap: () async => _selectDate(context: context),
              child: CustomTextFormField(
                  validator: validator,
                  enable: false,
                  controller: bithdateController,
                  hintText: 'yyyy-MM-dd',
                  prefixIcon: const Icon(Icons.date_range))))
    ]);
  }

  Future<void> _selectDate({required BuildContext context}) async {
    DateTime? picked = await showDatePicker(
        context: context,
        locale: const Locale('es', 'EC'),
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2100));

    if (picked != null) {
      onChanged(picked.toString().split(" ")[0]);
    }
  }
}
