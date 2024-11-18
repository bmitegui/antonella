import 'package:antonella/core/theme/app_theme.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/custom_text_form_field.dart';
import 'package:antonella/features/user/presentation/bloc/bloc.dart';
import 'package:antonella/features/user/presentation/widgets/auth_prompt_widget.dart';
import 'package:antonella/features/user/presentation/widgets/remember_me_widget.dart';
import 'package:antonella/features/user/presentation/widgets/terms_and_conditions_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late bool _value;
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _value = false;
  }

  @override
  void dispose() {
    _emailController.clear();
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
                        Image.asset('assets/icon/logo.png', width: 320),
                        const SizedBox(height: 16),
                        Text('Bienvenido de vuelta!',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: themeClass.lightEighthColor)),
                        const SizedBox(height: 64),
                        CustomTextFormField(
                            controller: _emailController,
                            title: 'Correo:',
                            hintText: 'Ingrese su correo',
                            prefixIcon: const Icon(Icons.email),
                            keyboardType: TextInputType.emailAddress,
                            validator: validateEmail),
                        const SizedBox(height: 16),
                        CustomTextFormField(
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
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                    rememberMe: _value));
                              }
                            },
                            child: const Text('Iniciar sesión')),
                        const SizedBox(height: 16),
                        const TermsAndConditionsWidget(),
                        const SizedBox(height: 16),
                        const AuthPromptWidget()
                      ]))))
          : const CircularProgressIndicator();
    })));
  }
}
