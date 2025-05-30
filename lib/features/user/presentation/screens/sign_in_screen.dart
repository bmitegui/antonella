import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/custom_text_form_field_widget.dart';
import 'package:antonella/features/user/presentation/bloc/bloc.dart';
import 'package:antonella/features/user/presentation/widgets/auth_prompt_widget.dart';
import 'package:antonella/features/user/presentation/widgets/forgot_password_widget.dart';
import 'package:antonella/features/user/presentation/widgets/logo_sign_in_widget.dart';
import 'package:antonella/features/user/presentation/widgets/remember_me_widget.dart';
import 'package:antonella/features/user/presentation/widgets/terms_and_conditions_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:antonella/core/l10n/app_localizations.dart';

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
    final texts = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final screenWidht = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color(0xFFFAE2E1),
        body: BlocConsumer<UserBloc, UserState>(
            listener: (BuildContext context, UserState state) {
          if (state is UserAuthenticated) {
            showTopSnackBar(Overlay.of(context),
                CustomSnackBar.success(message: texts.successful_sign_in));
          } else if (state is UserError) {
            showTopSnackBar(Overlay.of(context),
                CustomSnackBar.error(message: state.message, maxLines: 3));
          }
        }, builder: (context, state) {
          return (state is UserUnauthenticated || state is UserError)
              ? SingleChildScrollView(
                  child: Column(children: [
                  LogoSignInWidget(),
                  SizedBox(height: 16),
                  Text(texts.welcome, style:
                        textTheme.bodyLarge!.copyWith(color: Color(0XFFF44565),fontWeight: FontWeight.bold)),
                  SizedBox(height: 32),
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: Form(
                          key: _formKey,
                          child: AutofillGroup(
                              child: Column(children: [
                            Center(
                                child: SizedBox(
                                    width: screenWidht * 0.85,
                                    child: Column(children: [
                                      CustomTextFormFieldWidget(
                                          autofillHints: const [
                                            AutofillHints.telephoneNumber
                                          ],
                                          textEditingController:
                                              _accountController,
                                          hintText: texts.account,
                                          keyboardType: TextInputType.phone),
                                      const SizedBox(height: 32),
                                      CustomTextFormFieldWidget(
                                          autofillHints: const [
                                            AutofillHints.password
                                          ],
                                          textEditingController:
                                              _passwordController,
                                          hintText: texts.password,
                                          obscureText: true,
                                          validator: validatePassword),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            RememberMeWidget(
                                                value: _value,
                                                onChanged: (value) => setState(
                                                    () => _value = !_value)),
                                            const ForgotPasswordWidget()
                                          ])
                                    ]))),
                            const SizedBox(height: 32),
                            SizedBox(
                                width: screenWidht * 0.35,
                                child: FilledButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<UserBloc>().add(
                                            SignInEvent(
                                                account: _accountController.text
                                                    .trim(),
                                                password: _passwordController
                                                    .text
                                                    .trim(),
                                                rememberMe: _value));
                                      }
                                    },
                                    child: Text(texts.sign_in))),
                            const SizedBox(height: 16),
                            SizedBox(
                                width: screenWidht * 0.85,
                                child: const TermsAndConditionsWidget()),
                            const SizedBox(height: 16),
                            const AuthPromptWidget()
                          ]))))
                ]))
              : Center(child: const CircularProgressIndicator());
        }));
  }
}
