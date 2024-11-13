



import 'package:antonella/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ServicesTypeWidget extends StatelessWidget {
  const ServicesTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: ['Todo','Maquillaje','Cabello','Spa','Uñas'].map((type) {
            return ChoiceChip(
              

                backgroundColor: Colors.white,
                checkmarkColor: Colors.white,
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(type.toString().split('.').last,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.white)),
                    
                  ],
                ),
                selected: true,
                onSelected: (selected) {
                 
                },
                selectedColor: themeClass.lightPrimaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)));
          }).toList());
  }
}