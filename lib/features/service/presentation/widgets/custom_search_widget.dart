import 'package:antonella/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class CustomSearchWidget extends StatefulWidget {
  const CustomSearchWidget({super.key});

  @override
  State<CustomSearchWidget> createState() => _CustomSearchWidgetState();
}

class _CustomSearchWidgetState extends State<CustomSearchWidget> {
  late bool enable;

  @override
  void initState() {
    super.initState();
    enable = false;
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
        onChanged: (value) {
          setState(() {
            enable = value.trim().isNotEmpty;
          });
        },
        hintText: '¿Qué buscas?',
        prefixIcon: const Icon(Icons.search),
        onTapOutside: (event) {
          setState(() {
            enable = false;
          });
          FocusScope.of(context).unfocus();
        },
        onEditingComplete: () {
          setState(() {
            enable = false;
          });
          FocusScope.of(context).unfocus();
        },
        suffixIcon: enable
            ? GestureDetector(
                child: const Icon(Icons.send),
                onTap: () {
                  showTopSnackBar(
                      Overlay.of(context),
                      const CustomSnackBar.error(
                          message: 'No está implementado aún'));
                })
            : null);
  }
}
