import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/custom_text_form_field_widget.dart';
import 'package:antonella/features/user/presentation/bloc/bloc.dart';
import 'package:antonella/features/user/presentation/widgets/auth_prompt_widget.dart';
import 'package:antonella/features/user/presentation/widgets/forgot_password_widget.dart';
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
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        body: Center(
            child: BlocConsumer<UserBloc, UserState>(
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
              child: Column(
                children: [
                  ClipPath(
                    clipper: CurvaSuperior(),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      color: Color.fromARGB(255, 244, 69, 101),
                      //width: double.infinity,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(0, -130),
                    child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                        key: _formKey,
                        child: AutofillGroup(
                          child: Column(children: [
                            ClipOval(
                              child: Container(
                                height: MediaQuery.of(context).size.height / 6,
                                width: MediaQuery.of(context).size.height / 6,
                                child: Image.asset('assets/icon/logo.png',
                                        height: MediaQuery.of(context).size.height / 4),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(texts.welcome,
                                style: textTheme.bodyLarge!
                                    .copyWith(color: colorScheme.primary)),
                            const SizedBox(height: 32),
                            CustomTextFormFieldWidget(
                                autofillHints: const [AutofillHints.email],
                                textEditingController: _accountController,
                                title: texts.account,
                                hintText: texts.account_hint,
                                prefixIcon: const Icon(Icons.person),
                                keyboardType: TextInputType.emailAddress,
                                validator: validateEmail),
                            const SizedBox(height: 16),
                            CustomTextFormFieldWidget(
                                autofillHints: const [AutofillHints.password],
                                textEditingController: _passwordController,
                                title: texts.password,
                                hintText: texts.password_hint,
                                prefixIcon: const Icon(Icons.lock),
                                obscureText: true,
                                validator: validatePassword),
                            const ForgotPasswordWidget(),
                            const SizedBox(height: 16),
                            RememberMeWidget(
                                value: _value,
                                onChanged: (value) =>
                                    setState(() => _value = !_value)),
                            const SizedBox(height: 16),
                            SizedBox(
                                width: double.infinity,
                                child: FilledButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<UserBloc>().add(SignInEvent(
                                            account:
                                                _accountController.text.trim(),
                                            password:
                                                _passwordController.text.trim(),
                                            rememberMe: _value));
                                      }
                                    },
                                    child: Text(texts.sign_in))),
                            const SizedBox(height: 16),
                            const TermsAndConditionsWidget(),
                            const SizedBox(height: 16),
                            const AuthPromptWidget()
                          ]),
                        )))
                  ),
                  
                ],
              )
            )
          : const CircularProgressIndicator();
    })));
  }
}

class CurvaSuperior extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width*0.0005917,size.height*-0.0005571);
    path_0.lineTo(size.width*0.0014417,size.height*0.9289571);
    path_0.quadraticBezierTo(size.width*0.0334750,size.height*0.9282571,size.width*0.0833750,size.height*0.9284571);
    path_0.cubicTo(size.width*0.2939917,size.height*0.9306714,size.width*0.1679167,size.height*0.4645857,size.width*0.4995417,size.height*0.4291571);
    path_0.cubicTo(size.width*0.8207667,size.height*0.4557714,size.width*0.7051333,size.height*0.9301857,size.width*0.9155667,size.height*0.9302000);
    path_0.quadraticBezierTo(size.width*0.9572000,size.height*0.9306571,size.width*1.0005500,size.height*0.9301571);
    path_0.lineTo(size.width*0.9998917,size.height*-0.0017143);
    return path_0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

