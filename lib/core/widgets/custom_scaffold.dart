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
      this.paddingScroll =
          const EdgeInsets.only(right: 16, left: 16, bottom: 100)});

  @override
  Widget build(BuildContext context) {
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
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Color(0xFFF44565))))
            : null,
        backgroundColor: Color(0xFFF0F0F0),
        body: body ??
            SingleChildScrollView(padding: paddingScroll, child: child));
  }
}
