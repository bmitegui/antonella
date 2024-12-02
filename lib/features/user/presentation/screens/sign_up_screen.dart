import 'package:antonella/core/theme/app_theme.dart';
import 'package:antonella/core/theme/responsive_size.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/custom_text_form_field.dart';
import 'package:antonella/features/user/presentation/bloc/bloc.dart';
import 'package:antonella/features/user/presentation/widgets/auth_prompt_widget.dart';
import 'package:antonella/features/user/presentation/widgets/bithdate_widget.dart';
import 'package:antonella/features/user/presentation/widgets/terms_and_conditions_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _birthdateController;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _birthdateController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _birthdateController.clear();
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
            const CustomSnackBar.success(message: 'Registro exitoso'));
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
                        Text('Crea tu propia cuenta!',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: themeClass.lightEighthColor)),
                        const Text(
                            'Completa los campos a continuación con tu información de contacto'),
                        const SizedBox(height: 8),
                        Container(
                            alignment: Alignment.centerLeft,
                            child: const AuthPromptWidget(isSignIn: false)),
                        const SizedBox(height: 32),
                        CustomTextFormField(
                            controller: _nameController,
                            title: 'Nombre:',
                            hintText: 'Ingrese su nombre',
                            prefixIcon: const Icon(Icons.person),
                            validator: validateName),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                            controller: _emailController,
                            title: 'Correo:',
                            hintText: 'Ingrese su correo',
                            prefixIcon: const Icon(Icons.email),
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
                        const SizedBox(height: 16),
                        BirthdateWidget(
                            bithdateController: _birthdateController,
                            onChanged: (value) => setState(
                                () => _birthdateController.text = value),
                            validator: validateBirthdate),
                        const SizedBox(height: 16),
                        ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<UserBloc>().add(SignUpEvent(
                                    name: _nameController.text.trim(),
                                    birthdate: _birthdateController.text.trim(),
                                    account: _emailController.text.trim(),
                                    password: _passwordController.text.trim()));
                              }
                            },
                            child: const Text('Registrarse')),
                        const SizedBox(height: 16),
                        const TermsAndConditionsWidget(isSignIn: false),
                        const SizedBox(height: 8)
                      ]))))
          : const CircularProgressIndicator();
    })));
  }
}
