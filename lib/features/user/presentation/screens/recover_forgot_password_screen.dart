import 'package:antonella/core/widgets/custom_text_form_field_widget.dart';
import 'package:antonella/core/widgets/retroceder_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RecoverForgotPasswordScreen extends StatefulWidget {
  const RecoverForgotPasswordScreen({super.key});

  @override
  State<RecoverForgotPasswordScreen> createState() => _RecoverForgotPasswordScreenState();
}

class _RecoverForgotPasswordScreenState extends State<RecoverForgotPasswordScreen> {
  late TextEditingController numberController;

  @override
  void initState() {
    super.initState();
    numberController = TextEditingController();
  }

  @override
  void dispose() {
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidht = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(leading: ArrowBack(route: '/signIn', color: Color(0xFFF08DA2)), backgroundColor: Color(0xFFFAE2E1)),
      backgroundColor: Color(0xFFFAE2E1),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SizedBox(
            width: screenWidht * 0.80,
            child: Column(
              children: [
                SizedBox(height: 32),
                Text('¿Olvidaste tu contraseña?',
                  style: textTheme.bodyLarge!.copyWith(color: Color(0XFFF44565),
                              fontWeight: FontWeight.bold)),
                SizedBox(height: 32),
                Text('Ingresa tu número celular asociado a tu cuenta',
                  style: textTheme.bodyMedium!.copyWith(color: Colors.black,
                              fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
                SizedBox(height: 16),
                CustomTextFormFieldWidget(
                  textEditingController: numberController,
                  hintText: 'Celular',
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 32),
                SizedBox(
                  width: screenWidht * 0.35,
                  child: FilledButton(
                      style: ButtonStyle(
                          textStyle: WidgetStateProperty.all(
                              TextStyle(
                                  fontWeight: FontWeight.bold)),
                          backgroundColor:
                              WidgetStateProperty.all(
                                  Color(0xFFF44565))),
                      onPressed: () => GoRouter.of(context).go('/confirmation'),
                      child: Text('Enviar'))),
              ],
            ),
          ),
        ),
      )
    );
  }
}
