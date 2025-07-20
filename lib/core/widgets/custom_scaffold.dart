import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final String? text;
  final Widget? title;
  final Widget? child;
  final Widget? body;
  final Widget? leading;
  final bool extendBodyBehindAppBar;
  final Widget? bottomNavigationBar;
  final EdgeInsetsGeometry? paddingScroll;
  final bool? resizeToAvoidBottomInset;
  final Color? backgroundColor;
  const CustomScaffold(
      {super.key,
      this.resizeToAvoidBottomInset,
      this.title,
      this.text,
      this.child,
      this.leading,
      this.body,
      this.extendBodyBehindAppBar = false,
      this.bottomNavigationBar,
      this.backgroundColor,
      this.paddingScroll =
          const EdgeInsets.only(right: 16, left: 16, bottom: 100)});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        bottomNavigationBar: bottomNavigationBar,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        appBar: (leading != null || title != null || text != null)
            ? AppBar(
                automaticallyImplyLeading: false,
                leading: leading,
                backgroundColor: Colors.transparent,
                title: title ??
                    Text(text ?? '',
                        style: Theme.of(context).textTheme.titleMedium))
            : null,
        backgroundColor: backgroundColor ?? colorScheme.surface,
        body: body ??
            SingleChildScrollView(padding: paddingScroll, child: child));
  }
}
