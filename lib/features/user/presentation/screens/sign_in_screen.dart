import 'package:antonella/core/theme/app_theme.dart';
import 'package:antonella/core/theme/responsive_size.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/custom_text_form_field.dart';
import 'package:antonella/features/user/presentation/bloc/bloc.dart';
import 'package:antonella/features/user/presentation/widgets/auth_prompt_widget.dart';
import 'package:antonella/features/user/presentation/widgets/remember_me_widget.dart';
import 'package:antonella/features/user/presentation/widgets/terms_and_conditions_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _accountController;
  late TextEditingController _passwordController;
  late bool _value;
  @override
  void initState() {
    super.initState();
    _accountController = TextEditingController();
    _passwordController = TextEditingController();
    _value = false;
  }

  @override
  void dispose() {
    _accountController.clear();
    _passwordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: BlocConsumer<UserBloc, UserState>(
                listener: (BuildContext context, UserState state) {
      if (state is UserAuthenticated) {
        showTopSnackBar(Overlay.of(context),
            const CustomSnackBar.success(message: 'Acceso exitoso'));
      } else if (state is UserError) {
        showTopSnackBar(Overlay.of(context),
            CustomSnackBar.error(message: state.message, maxLines: 3));
      }
    }, builder: (context, state) {
      return (state is UserUnauthenticated || state is UserError)
          ? SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                      key: _formKey,
                      child: Column(children: [
                        Image.asset('assets/icon/logo.png',
                            width: 300.rh(context)),
                        const SizedBox(height: 16),
                        Text('Bienvenido de vuelta!',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: themeClass.lightEighthColor)),
                        const SizedBox(height: 32),
                        CustomTextFormField(
                            controller: _accountController,
                            title: 'Correo o teléfono:',
                            hintText: 'Correo o teléfono',
                            prefixIcon: const Icon(Icons.person),
                            keyboardType: TextInputType.emailAddress,
                            validator: validateEmail),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                            maxLines: 1,
                            controller: _passwordController,
                            title: 'Contraseña:',
                            hintText: 'Ingrese su contraseña',
                            prefixIcon: const Icon(Icons.lock),
                            obscureText: true,
                            validator: validatePassword),
                        Container(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {},
                                child: Text('¿Has olvidado tu contraseña?',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall))),
                        const SizedBox(height: 16),
                        RememberMeWidget(
                            value: _value,
                            onChanged: (value) =>
                                setState(() => _value = !_value)),
                        const SizedBox(height: 16),
                        ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<UserBloc>().add(SignInEvent(
                                    account: _accountController.text.trim(),
                                    password: _passwordController.text.trim(),
                                    rememberMe: _value));
                              }
                            },
                            child: const Text('Iniciar sesión')),
                        const SizedBox(height: 16),
                        const TermsAndConditionsWidget(),
                        const SizedBox(height: 16),
                        const AuthPromptWidget(),
                        const SizedBox(height: 8)
                      ]))))
          : const CircularProgressIndicator();
    })));
  }
}
