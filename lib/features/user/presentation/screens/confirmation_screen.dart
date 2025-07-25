import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/widgets/custom_text_form_field_widget.dart';
import 'package:antonella/core/widgets/arrow_back.dart';
import 'package:antonella/features/user/presentation/bloc/password/password_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({super.key});

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
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
    final texts = AppLocalizations.of(context)!;
    final screenWidht = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
            leading:
                ArrowBack(route: '/forgotPassword', color: Color(0xFFF08DA2)),
            backgroundColor: Color(0xFFFAE2E1)),
        backgroundColor: Color(0xFFFAE2E1),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: SizedBox(
                    width: screenWidht * 0.80,
                    child: Column(children: [
                      SizedBox(height: 32),
                      Text(texts.confirmation,
                          style: textTheme.bodyLarge!.copyWith(
                              color: Color(0XFFF44565),
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 32),
                      Text(texts.code_sent_to_number,
                          style: textTheme.bodyMedium!.copyWith(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                      SizedBox(height: 32),
                      CustomTextFormFieldWidget(
                          textEditingController: codeController,
                          hintText: texts.enter_code,
                          keyboardType: TextInputType.number),
                      SizedBox(height: 32),
                      BlocBuilder<PasswordBloc, PasswordState>(
                          builder: (context, state) {
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
                                      if (state is PasswordLoaded) {
                                        if (state.code == codeController.text) {
                                          showTopSnackBar(
                                              Overlay.of(context),
                                              CustomSnackBar.success(
                                                  message: texts.right_code));
                                          GoRouter.of(context)
                                              .go('/resetPassword');
                                        } else {
                                          showTopSnackBar(
                                              Overlay.of(context),
                                              CustomSnackBar.error(
                                                  message: texts.wrong_code,
                                                  maxLines: 3));
                                        }
                                      }
                                    },
                                    child: Text(texts.send)));
                      })
                    ])))));
  }
}
