import 'package:antonella/core/utils/util.dart';
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
  final String? errorMessage;
  final void Function()? onTap;
  final bool readOnly;
  final Color? fillColor;
  final int maxLines;

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
      this.errorMessage,
      this.suffixIcon,
      this.onTap,
      this.readOnly = false,
      this.fillColor,
      this.maxLines = 1});

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
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
        decoration: widget.errorMessage != null
            ? BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: colorScheme.primary)
            : null,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (widget.title != null)
            Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(widget.title!,
                    style: textTheme.titleSmall!
                        .copyWith(color: colorScheme.onSurface))),
          if (widget.title != null) const SizedBox(height: 8),
          TextFormField(
              maxLines: widget.maxLines,
              readOnly: widget.readOnly,
              onTap: widget.onTap,
              keyboardType: widget.keyboardType,
              autofillHints: widget.autofillHints,
              validator: widget.validator,
              onChanged: widget.onChanged,
              obscureText: _obscureText,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              style: bodyBlack54Style(context),
              controller: widget.textEditingController,
              onEditingComplete: widget.onEditingComplete,
              decoration: InputDecoration(
                  prefixIconColor: colorScheme.onSurfaceVariant,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  hintStyle: bodyBlack54Style(context),
                  filled: true,
                  fillColor: widget.fillColor ?? colorScheme.secondaryContainer,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none),
                  prefixIcon: widget.prefixIcon,
                  suffixIcon: widget.obscureText
                      ? GestureDetector(
                          child: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: colorScheme.onSecondaryContainer),
                          onTap: () =>
                              setState(() => _obscureText = !_obscureText))
                      : widget.suffixIcon,
                  hintText: widget.hintText)),
          if (widget.errorMessage != null)
            Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                alignment: Alignment.center,
                height: 45,
                child: Text(widget.errorMessage!,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium!.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis)))
        ]));
  }
}
