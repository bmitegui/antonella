import 'package:antonella/core/theme/responsive_size.dart';
import 'package:flutter/material.dart';

class CustomModalBottomSheetWidget extends StatelessWidget {
  final String? title;
  final bool? closeAction;
  final Widget? otherAction;
  final Widget body;
  final Widget? titleWidget;
  const CustomModalBottomSheetWidget(
      {super.key,
      this.title,
      this.titleWidget,
      required this.body,
      this.closeAction = true,
      this.otherAction});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
              width: 48.rh(context),
              height: 4,
              decoration: BoxDecoration(
                  color: const Color(0XFF484850),
                  borderRadius: BorderRadius.circular(4))),
          const SizedBox(height: 16),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            IconButton(
                onPressed: closeAction! ? () => Navigator.pop(context) : null,
                icon: Icon(Icons.close,
                    color: closeAction!
                        ? const Color(0XFFADADAD)
                        : Colors.transparent)),
            (title != null)
                ? Expanded(
                    child: Text(title!,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: const Color(0XFF484850),
                            fontWeight: FontWeight.bold)))
                : titleWidget!,
            otherAction ??
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close, color: const Color(0XFFADADAD)))
          ]),
          const SizedBox(height: 16),
          body
        ]));
  }
}
