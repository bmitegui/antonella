import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';

class DescriptionServiceSection extends StatelessWidget {
  final String description;
  const DescriptionServiceSection({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        child: Text(description, style: bodyBlack54Style(context)));
  }
}
