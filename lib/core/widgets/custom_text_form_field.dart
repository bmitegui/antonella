import 'package:antonella/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? title;
  final Widget prefixIcon;
  final String hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final bool enable;
  final String? Function(String?)? validator;
  const CustomTextFormField(
      {super.key,
      this.controller,
      this.title,
      required this.hintText,
      required this.prefixIcon,
      this.obscureText = false,
      this.keyboardType,
      this.enable = true,
      this.validator});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (widget.title != null)
        Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(widget.title!,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold))),
      TextFormField(
          validator: widget.validator,
          enabled: widget.enable,
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          obscureText: _obscureText,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: InputDecoration(
              suffixIcon: widget.obscureText
                  ? GestureDetector(
                      onTap: () => setState(() => _obscureText = !_obscureText),
                      child: Icon(_obscureText
                          ? Icons.visibility_off
                          : Icons.visibility))
                  : null,
              prefixIconColor: themeClass.lightSixthColor,
              suffixIconColor: themeClass.lightSixthColor,
              labelStyle: Theme.of(context).textTheme.bodyMedium,
              hintText: widget.hintText,
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: themeClass.lightSixthColor),
              prefixIcon: widget.prefixIcon,
              contentPadding: const EdgeInsets.only(left: 16),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: themeClass.lightPrimaryColor)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: themeClass.lightSixthColor)),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: themeClass.lightSixthColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: themeClass.lightPrimaryColor))))
    ]);
  }
}
