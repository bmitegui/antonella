import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/custom_pick_date_widget.dart';
import 'package:antonella/core/widgets/custom_text_form_field_widget.dart';
import 'package:antonella/core/widgets/dropdown_search_widget.dart';
import 'package:antonella/features/user/presentation/bloc/bloc.dart';
import 'package:antonella/features/user/presentation/widgets/auth_prompt_widget.dart';
import 'package:antonella/features/user/presentation/widgets/terms_and_conditions_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
  DateTime? _birthdate;
  String? genero;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    final screenWidht = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () => GoRouter.of(context).go('/signIn'),
                icon: Icon(Icons.arrow_back))),
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
                            Text('Crear Cuenta',
                                style: textTheme.bodyLarge!
                                    .copyWith(color: Color(0XFFF44565))),
                            const SizedBox(height: 32),
                            Center(
                              child: SizedBox(
                                width: screenWidht * 0.8,
                                child: Column(
                                  children: [
                                    CustomTextFormFieldWidget(
                                        textEditingController: _nameController,
                                        title: texts.name,
                                        //hintText: texts.name_hint,
                                        //prefixIcon: const Icon(Icons.person),
                                        validator: validateName),
                                    const SizedBox(height: 16),
                                    CustomTextFormFieldWidget(
                                        //celular
                                        textEditingController: _emailController,
                                        title: 'Celular',
                                        //hintText: texts.account_hint,
                                        //prefixIcon: const Icon(Icons.email),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: validateEmail),
                                    const SizedBox(height: 16),
                                    CustomTextFormFieldWidget(
                                        //correo
                                        textEditingController: _emailController,
                                        title: 'Correo',
                                        //hintText: texts.account_hint,
                                        //prefixIcon: const Icon(Icons.email),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: validateEmail),

                                    const SizedBox(height: 16),
                                    CustomPickDateWidget(
                                        title: texts.birthdate,
                                        dateTime: _birthdate,
                                        onSelectDate: (value) =>
                                            setState(() => _birthdate = value)),
                                    const SizedBox(height: 16),
                                    CustomDropdownSearchWidget(
                                        title: 'Género',
                                        showSearchBox: false,
                                        selectedItem: genero,
                                        initialText: 'Seleccionar género',
                                        options: [
                                          'Masculino',
                                          'Femenino',
                                          'Otro'
                                        ],
                                        onChange: (value) {
                                          setState(() {
                                            genero = value;
                                          });
                                        }),
                                    const SizedBox(height: 16),
                                    CustomTextFormFieldWidget(
                                        textEditingController:
                                            _passwordController,
                                        title: texts.password,
                                        //hintText: texts.password_hint,
                                        //prefixIcon: const Icon(Icons.lock),
                                        obscureText: true,
                                        validator: validatePassword),
                                    const SizedBox(height: 40),
                                    SizedBox(
                                        width: screenWidht * 0.35,
                                        child: FilledButton(
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                context.read<UserBloc>().add(
                                                    SignUpEvent(
                                                        name: _nameController
                                                            .text
                                                            .trim(),
                                                        birthdate:
                                                            formatDateTime(
                                                                _birthdate),
                                                        account:
                                                            _emailController
                                                                .text
                                                                .trim(),
                                                        password:
                                                            _passwordController
                                                                .text
                                                                .trim()));
                                              }
                                            },
                                            child: Text('Registrar')))
                                  ],
                                ),
                              ),
                            )
                          ]))))
              : const CircularProgressIndicator();
        })));
  }
}
