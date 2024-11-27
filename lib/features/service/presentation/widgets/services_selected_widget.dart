import 'package:antonella/core/theme/app_theme.dart';
import 'package:antonella/core/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';

class ServicesSelectedWidget extends StatelessWidget {
  final List<String> servicesSelected;
  const ServicesSelectedWidget({super.key, required this.servicesSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 8),
      child: Dialog(
          backgroundColor: themeClass.lightscaffoldBackgroundColor,
          alignment: Alignment.bottomCenter,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Align(
                  alignment: Alignment.centerRight,
                  child: CustomIconButton(
                      onTap: () => Navigator.pop(context),
                      iconData: Icons.close,
                      color: Colors.red)),
              const SizedBox(height: 8),
              Text('')
            ]),
          )),
    );
    ;
  }
}
