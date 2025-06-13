import 'package:antonella/core/widgets/custom_text_form_field_widget.dart';
import 'package:antonella/core/widgets/arrow_back.dart';
import 'package:antonella/features/user/presentation/bloc/password/password_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class RecoverForgotPasswordScreen extends StatefulWidget {
  const RecoverForgotPasswordScreen({super.key});

  @override
  State<RecoverForgotPasswordScreen> createState() =>
      _RecoverForgotPasswordScreenState();
}

class _RecoverForgotPasswordScreenState
    extends State<RecoverForgotPasswordScreen> {
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidht = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
            leading: ArrowBack(route: '/signIn', color: Color(0xFFF08DA2)),
            backgroundColor: Color(0xFFFAE2E1)),
        backgroundColor: Color(0xFFFAE2E1),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: SizedBox(
                    width: screenWidht * 0.80,
                    child: Column(children: [
                      SizedBox(height: 32),
                      Text('¿Olvidaste tu contraseña?',
                          style: textTheme.bodyLarge!.copyWith(
                              color: Color(0XFFF44565),
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 32),
                      Text(
                          ' Ingresa tu correo electrónico asociado a tu cuenta',
                          style: textTheme.bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                      SizedBox(height: 16),
                      CustomTextFormFieldWidget(
                          textEditingController: emailController,
                          hintText: 'Correo',
                          keyboardType: TextInputType.emailAddress),
                      SizedBox(height: 32),
                      BlocConsumer<PasswordBloc, PasswordState>(listener:
                          (BuildContext context, PasswordState state) {
                        if (state is PasswordLoaded) {
                          showTopSnackBar(
                              Overlay.of(context),
                              const CustomSnackBar.success(
                                  message: 'Código enviado'));
                          GoRouter.of(context).go('/confirmation');
                        } else if (state is PasswordError) {
                          showTopSnackBar(
                              Overlay.of(context),
                              CustomSnackBar.error(
                                  message: state.message, maxLines: 3));
                        }
                      }, builder: (context, state) {
                        return state is PasswordLoading
                            ? CircularProgressIndicator()
                            : SizedBox(
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
                                      context.read<PasswordBloc>().add(
                                          PasswordCodeEvent(
                                              email: emailController.text));
                                    },
                                    child: Text('Enviar')));
                      })
                    ])))));
  }
}
