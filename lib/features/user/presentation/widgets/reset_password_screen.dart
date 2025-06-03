import 'package:antonella/core/widgets/custom_text_form_field_widget.dart';
import 'package:antonella/core/widgets/retroceder_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late TextEditingController passwordController;
  late TextEditingController repeatPasswordController;

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
    repeatPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    passwordController.dispose();
    repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidht = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
            leading:
                ArrowBack(route: '/confirmation', color: Color(0xFFF08DA2)),
            backgroundColor: Color(0xFFFAE2E1)),
        backgroundColor: Color(0xFFFAE2E1),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SizedBox(
              width: screenWidht * 0.80,
              child: Column(
                children: [
                  SizedBox(height: 32),
                  Text('Restablecer contraseña',
                      style: textTheme.bodyLarge!.copyWith(
                          color: Color(0XFFF44565),
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 32),
                  Text('Escriba su nueva contraseña',
                      style: textTheme.bodyMedium!.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                  SizedBox(height: 32),
                  CustomTextFormFieldWidget(
                    title: 'Nueva Contraseña',
                    textEditingController: passwordController,
                    hintText: 'Contraseña',
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  SizedBox(height: 32),
                  CustomTextFormFieldWidget(
                    title: 'Confirmar Contraseña',
                    textEditingController: passwordController,
                    hintText: ' Repetir Contraseña',
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  SizedBox(height: 32),
                  SizedBox(
                      width: screenWidht * 0.35,
                      child: FilledButton(
                          style: ButtonStyle(
                              textStyle: WidgetStateProperty.all(
                                  TextStyle(fontWeight: FontWeight.bold)),
                              backgroundColor:
                                  WidgetStateProperty.all(Color(0xFFF44565))),
                          onPressed: () => GoRouter.of(context).go('/signIn'),
                          child: Text('Guardar'))),
                ],
              ),
            ),
          ),
        ));
  }
}
