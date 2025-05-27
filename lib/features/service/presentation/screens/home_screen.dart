import 'package:antonella/features/service/presentation/widgets/home_screen/bienvenida_widget.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/custom_search_widget.dart';
import 'package:antonella/features/service/presentation/widgets/services_filter_widget.dart';
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
      backgroundColor: Color(0xFFF0F0F0),
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 254, 254, 254),
            title: const BienvenidaWidget(),
            actions: [Image.asset('assets/icon/logo.png')]),
        body:  SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(children: [
                  CustomSearchWidget(),
                  SizedBox(height: 16),
                  ServicesFilterWidget()
                ]))));
  }
}
