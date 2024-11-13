import 'package:antonella/features/service/presentation/widgets/bienvenida_widget.dart';
import 'package:antonella/features/service/presentation/widgets/services_type_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: const BienvenidaWidget(),
            actions: [Image.asset('assets/icon/logo.png')]),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(children: [ServicesTypeWidget()]))));
  }
}
