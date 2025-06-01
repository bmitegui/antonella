import 'package:antonella/core/widgets/custom_text_form_field_widget.dart';
import 'package:antonella/core/widgets/retroceder_logo_widget.dart';
import 'package:flutter/material.dart';

class ResetPasswordWidget extends StatefulWidget {
  const ResetPasswordWidget({super.key});

  @override
  State<ResetPasswordWidget> createState() => _ResetPasswordWidgetState();
}

class _ResetPasswordWidgetState extends State<ResetPasswordWidget> {
  late TextEditingController codeController;

  @override
  void initState() {
    super.initState();
    codeController = TextEditingController();
  }

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidht = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(leading: RetrocederLogoWidget(route: '/forgotPassword'), backgroundColor: Color(0xFFFAE2E1)),
      backgroundColor: Color(0xFFFAE2E1),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SizedBox(
            width: screenWidht * 0.80,
            child: Column(
              children: [
                SizedBox(height: 32),
                Text('Confirmación',
                  style: textTheme.bodyLarge!.copyWith(color: Color(0XFFF44565),
                              fontWeight: FontWeight.bold)),
                SizedBox(height: 32),
                Text('El código ha sido enviado a su número telefónico',
                  style: textTheme.bodyMedium!.copyWith(color: Colors.black,
                              fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
                SizedBox(height: 32),
                CustomTextFormFieldWidget(
                  textEditingController: codeController,
                  hintText: 'Ingrese Código',
                  keyboardType: TextInputType.number,
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
                      onPressed: () {
                        print('Enviado');
                      },
                      child: Text('Enviar'))),
              ],
            ),
          ),
        ),
      )
    );
  }
}
