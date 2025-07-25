import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/utils/error_messages_util.dart';
import 'package:antonella/core/widgets/custom_text_form_field_widget.dart';
import 'package:antonella/core/widgets/arrow_back.dart';
import 'package:antonella/features/user/presentation/bloc/password/password_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

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
    final texts = AppLocalizations.of(context)!;
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
                    child: Column(children: [
                      SizedBox(height: 32),
                      Text(texts.reset_password,
                          style: textTheme.bodyLarge!.copyWith(
                              color: Color(0XFFF44565),
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 32),
                      Text(texts.write_new_password,
                          style: textTheme.bodyMedium!.copyWith(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                      SizedBox(height: 32),
                      CustomTextFormFieldWidget(
                        title: texts.new_password,
                        textEditingController: passwordController,
                        hintText: texts.password,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      SizedBox(height: 32),
                      CustomTextFormFieldWidget(
                        title: texts.confirm_password,
                        textEditingController: repeatPasswordController,
                        hintText: texts.repeat_password,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      SizedBox(height: 32),
                      BlocConsumer<PasswordBloc, PasswordState>(
                          listener: (context, state) {
                        if (state is PasswordReseted) {
                          showTopSnackBar(
                              Overlay.of(context),
                               CustomSnackBar.success(
                                  message: texts.updated_password));
                          GoRouter.of(context).go('/signIn');
                        } else if (state is PasswordError) {
                          showTopSnackBar(
                              Overlay.of(context),
                              CustomSnackBar.error(
                                  message: mapFailureToMessage(
                                      context: context,
                                      failure: state.failure)));
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
                                      if (passwordController.text.trim() !=
                                          repeatPasswordController.text
                                              .trim()) {
                                        showTopSnackBar(
                                            Overlay.of(context),
                                            CustomSnackBar.error(
                                                message:
                                                    texts.not_same_password));
                                      } else if (state is PasswordLoaded) {
                                        context.read<PasswordBloc>().add(
                                            PasswordResetEvent(
                                                id: state.userId,
                                                code: state.code,
                                                password: passwordController
                                                    .text
                                                    .trim()));
                                      }
                                    },
                                    child: Text(texts.save)));
                      })
                    ])))));
  }
}
