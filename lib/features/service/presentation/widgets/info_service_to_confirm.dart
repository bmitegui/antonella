import 'package:antonella/features/service/presentation/widgets/banner_widget.dart';
import 'package:antonella/features/service/presentation/widgets/services_group.dart';
import 'package:flutter/material.dart';

class InfoServiceToConfirm extends StatelessWidget {
  const InfoServiceToConfirm({super.key});

  @override
  Widget build(BuildContext context) {
  return Container(
          padding: EdgeInsets.only(right: 16, left: 16, bottom: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(style: BorderStyle.solid, color: Colors.white),
            color: Colors.white
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BannerWidget(child: ServicesGroup()),
                  Text('Cabellos - Varios', style: Theme.of(context).textTheme.titleMedium),
                  Icon(Icons.arrow_forward_ios)
                ]
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(width: 25),
                  Icon(Icons.calendar_month),
                  SizedBox(width: 20),
                  Text('15/05/2025 - 9:00 am')
                ]
              ),
              Divider(),
              Row(
                children: [
                  SizedBox(width: 25),
                  Icon(Icons.person),
                  SizedBox(width: 20),
                  Text('Mite Guillen Brian Andrei')
                ]
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(width: 25),
                  Icon(Icons.email),
                  SizedBox(width: 20),
                  Text('1234@email.com')
                ]
              )
            ]
          )
        );  }
}