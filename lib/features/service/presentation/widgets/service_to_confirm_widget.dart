import 'package:antonella/features/service/presentation/widgets/banner_widget.dart';
import 'package:flutter/material.dart';

class ServiceToConfirmWidget extends StatefulWidget {
  final int quantity;
  const ServiceToConfirmWidget({super.key, required this.quantity});

  @override
  State<ServiceToConfirmWidget> createState() => _ServiceToConfirmWidgetState();
}

class _ServiceToConfirmWidgetState extends State<ServiceToConfirmWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: widget.quantity,
      itemBuilder: (BuildContext context, int value) {
        return Container(
          padding: EdgeInsets.only(right: 16, left: 16, bottom: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(style: BorderStyle.solid, color: Colors.white),
            color: Colors.white
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BannerWidget(),
                  Text('Cabellos - Varios'),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(width: 25),
                  Icon(Icons.calendar_month),
                  SizedBox(width: 20),
                  Text('15/05/2025 - 9:00 am')
                ],
              ),
              Divider(),
              Row(
                children: [
                  SizedBox(width: 25),
                  Icon(Icons.person),
                  SizedBox(width: 20),
                  Text('Mite Guillen Brian Andrei')
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(width: 25),
                  Icon(Icons.email),
                  SizedBox(width: 20),
                  Text('1234@email.com')
                ],
              ),
            ],
          )
        );
      },
      separatorBuilder: (BuildContext context, int index) => SizedBox(height: 16)  
    );
  }
}