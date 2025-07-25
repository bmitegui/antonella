// ignore_for_file: use_build_context_synchronously

import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/services/key_value_storage_service_impl.dart';
import 'package:antonella/core/utils/error_messages_util.dart';
import 'package:antonella/core/widgets/arrow_back.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/core/widgets/custom_text_form_field_widget.dart';
import 'package:antonella/features/user/presentation/bloc/password/password_bloc.dart';
import 'package:antonella/features/user/presentation/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class UpdatePaswordScreen extends StatefulWidget {
  const UpdatePaswordScreen({super.key});

  @override
  State<UpdatePaswordScreen> createState() => _UpdatePaswordScreenState();
}

class _UpdatePaswordScreenState extends State<UpdatePaswordScreen> {
  late TextEditingController passwordController;
  late TextEditingController repeatPasswordController;
  late TextEditingController passwordBackController;

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
    repeatPasswordController = TextEditingController();
    passwordBackController = TextEditingController();
  }

  @override
  void dispose() {
    passwordController.dispose();
    repeatPasswordController.dispose();
    passwordBackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    final screenWidht = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return CustomScaffold(
        leading: ArrowBack(
            color: Color(0XFFF44565),
            onBack: () {
              Navigator.pop(context);
            }),
        child: BlocBuilder<UserBloc, UserState>(builder: (context, stateUser) {
          return (stateUser is UserAuthenticated)
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: SizedBox(
                          width: screenWidht * 0.80,
                          child: Column(children: [
                            SizedBox(height: 32),
                            Text(texts.change_password,
                                style: textTheme.bodyLarge!.copyWith(
                                    color: Color(0XFFF44565),
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 32),
                            Text(texts.change_password_full_info,
                                style: textTheme.bodyMedium!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center),
                            SizedBox(height: 32),
                            CustomTextFormFieldWidget(
                              title: texts.last_password,
                              textEditingController: passwordBackController,
                              hintText: texts.password,
                              keyboardType: TextInputType.visiblePassword,
                            ),
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
                                Navigator.pop(context);
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
                                              textStyle:
                                                  WidgetStateProperty.all(
                                                      TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                              backgroundColor:
                                                  WidgetStateProperty.all(
                                                      Color(0xFFF44565))),
                                          onPressed: () async {
                                            if (passwordController.text
                                                    .trim() !=
                                                repeatPasswordController.text
                                                    .trim()) {
                                              showTopSnackBar(
                                                  Overlay.of(context),
                                                  CustomSnackBar.error(
                                                      message: texts
                                                          .not_same_password));
                                            } else if (await sl<
                                                        KeyValueStorageServiceImpl>()
                                                    .getValue<String>(
                                                        'password') !=
                                                passwordBackController.text
                                                    .trim()) {
                                              showTopSnackBar(
                                                  Overlay.of(context),
                                                  CustomSnackBar.error(
                                                      message: texts
                                                          .wrong_password));
                                            } else {
                                              context.read<PasswordBloc>().add(
                                                  PasswordResetEvent(
                                                      id: stateUser.user.id,
                                                      code: '',
                                                      password:
                                                          passwordController
                                                              .text
                                                              .trim()));
                                            }
                                          },
                                          child: Text(texts.save)));
                            })
                          ]))))
              : const SizedBox.shrink();
        }));
  }
}
