import 'package:flutter/material.dart';

class CustomTextFormFieldWidget extends StatefulWidget {
  final String? title;
  final String hintText;
  final Widget? prefixIcon;
  final TextEditingController? textEditingController;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Iterable<String>? autofillHints;
  final void Function(PointerDownEvent)? onTapOutside;
  final void Function()? onEditingComplete;
  final Widget? suffixIcon;

  const CustomTextFormFieldWidget(
      {super.key,
      this.title,
      this.onTapOutside,
      this.autofillHints,
      this.hintText = '',
      this.prefixIcon,
      this.textEditingController,
      this.onChanged,
      this.keyboardType,
      this.obscureText = false,
      this.validator,
      this.onEditingComplete,
      this.suffixIcon});

  @override
  State<CustomTextFormFieldWidget> createState() =>
      _CustomTextFormFieldWidgetState();
}

class _CustomTextFormFieldWidgetState extends State<CustomTextFormFieldWidget> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (widget.title != null)
        Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(widget.title!,
                style: textTheme.bodyMedium!.copyWith(
                    color: colorScheme.primary, fontWeight: FontWeight.bold))),
      if (widget.title != null) const SizedBox(height: 8),
      TextFormField(
          keyboardType: widget.keyboardType,
          autofillHints: widget.autofillHints,
          validator: widget.validator,
          onChanged: widget.onChanged,
          obscureText: _obscureText,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          style: textTheme.bodyMedium,
          controller: widget.textEditingController,
          onEditingComplete: widget.onEditingComplete,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(20),
            //   borderSide: BorderSide.none,
            // ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.obscureText
                  ? GestureDetector(
                      child: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: colorScheme.onSurfaceVariant),
                      onTap: () => setState(() => _obscureText = !_obscureText))
                  : widget.suffixIcon,
              hintText: widget.hintText))
    ]);
  }
}
