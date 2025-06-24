import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/utils/error_messages_util.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/custom_text_form_field_widget.dart';
import 'package:antonella/core/widgets/dropdown_search_widget.dart';
import 'package:antonella/core/widgets/arrow_back.dart';
import 'package:antonella/features/user/presentation/bloc/bloc.dart';
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
  late TextEditingController _dniController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _phoneController;
  late TextEditingController _birthdateController;

  String? genero;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _dniController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _phoneController = TextEditingController();
    _birthdateController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    final screenWidht = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        backgroundColor: Color(0xFFFAE2E1),
        appBar: AppBar(
            backgroundColor: Color(0xFFFAE2E1),
            leading: ArrowBack(route: '/signIn', color: Color(0xFFF08DA2))),
        body: Center(
            child: BlocConsumer<UserBloc, UserState>(
                listener: (BuildContext context, UserState state) {
          if (state is UserAuthenticated) {
            showTopSnackBar(Overlay.of(context),
                const CustomSnackBar.success(message: 'Registro exitoso'));
          } else if (state is UserError) {
            showTopSnackBar(Overlay.of(context),
                CustomSnackBar.error(message: mapFailureToMessage(context: context, failure: state.failure), maxLines: 5));
          }
        }, builder: (context, state) {
          return (state is UserLoading)
              ? const CircularProgressIndicator()
              : SingleChildScrollView(
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
                                    child: Column(children: [
                                      CustomTextFormFieldWidget(
                                          textEditingController:
                                              _nameController,
                                          title: texts.name),
                                      const SizedBox(height: 16),
                                      CustomTextFormFieldWidget(
                                          textEditingController: _dniController,
                                          title: 'Cédula',
                                          keyboardType: TextInputType.number),
                                      const SizedBox(height: 16),
                                      CustomTextFormFieldWidget(
                                          textEditingController:
                                              _phoneController,
                                          title: 'Celular',
                                          keyboardType: TextInputType.phone),
                                      const SizedBox(height: 16),
                                      CustomTextFormFieldWidget(
                                          textEditingController:
                                              _emailController,
                                          title: 'Correo',
                                          keyboardType:
                                              TextInputType.emailAddress),
                                      const SizedBox(height: 16),
                                      CustomTextFormFieldWidget(
                                          readOnly: true,
                                          onTap: () async {
                                            final DateTime? dateTime =
                                                await selectDate(context);
                                            if (dateTime != null) {
                                              setState(() {
                                                _birthdateController =
                                                    TextEditingController(
                                                        text: formatDateTime(
                                                            dateTime));
                                              });
                                            }
                                          },
                                          textEditingController:
                                              _birthdateController,
                                          title: texts.birthdate,
                                          suffixIcon: Icon(Icons.date_range,
                                              color: Colors.grey)),
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
                                          obscureText: true),
                                      const SizedBox(height: 40),
                                      SizedBox(
                                          width: screenWidht * 0.35,
                                          child: FilledButton(
                                              style: ButtonStyle(
                                                  textStyle:
                                                      WidgetStateProperty.all(
                                                          TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                  backgroundColor:
                                                      WidgetStateProperty.all(
                                                          Color(0xFFF44565))),
                                              onPressed: () {
                                                context.read<UserBloc>().add(
                                                    SignUpEvent(
                                                        dni:
                                                            _dniController.text,
                                                        phoneNumber:
                                                            _phoneController
                                                                .text,
                                                        genero: genero,
                                                        name: _nameController
                                                            .text
                                                            .trim(),
                                                        birthdate:
                                                            _birthdateController
                                                                .text,
                                                        account:
                                                            _emailController
                                                                .text
                                                                .trim(),
                                                        password:
                                                            _passwordController
                                                                .text
                                                                .trim()));
                                              },
                                              child: Text('Registrar')))
                                    ])))
                          ]))));
        })));
  }
}
