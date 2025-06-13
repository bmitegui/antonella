import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/arrow_back.dart';
import 'package:antonella/core/widgets/custom_text_form_field_widget.dart';
import 'package:antonella/features/user/presentation/bloc/user/user_bloc.dart';
import 'package:antonella/features/user/presentation/widgets/settings_photowidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _dniController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _birthdateController;

  @override
  void dispose() {
    _birthdateController.dispose();
    _dniController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    final screenWidht = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
            leading: ArrowBack(color: Color(0XFFF44565)),
            backgroundColor: Color(0xFFF0F0F0),
            title: Text('Editar Perfil',
                style: textTheme.bodyLarge!.copyWith(
                    color: Color(0XFFF44565), fontWeight: FontWeight.bold))),
        backgroundColor: Color(0xFFF0F0F0),
        body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
          if (state is UserAuthenticated) {
            _nameController = TextEditingController(text: state.user.name);
            _emailController = TextEditingController(text: state.user.email);

            _phoneController =
                TextEditingController(text: state.user.phoneNumber);

            _birthdateController = TextEditingController(
                text: formatDateTime(state.user.birthdate));

            _dniController = TextEditingController(text: state.user.dni);
          }
          return (state is UserAuthenticated)
              ? Padding(
                  padding: EdgeInsets.only(right: 16, left: 16, bottom: 32),
                  child: SingleChildScrollView(
                      child: Center(
                          child: Column(children: [
                    Text('Edita la información de la cuenta',
                        style:
                            textTheme.bodyLarge!.copyWith(color: Colors.black)),
                    SizedBox(height: 32),
                    SettingsPhotowidget(),
                    SizedBox(height: 32),
                    CustomTextFormFieldWidget(
                      textEditingController: _nameController,
                      title: 'Nombres'
                    ),
                    SizedBox(height: 16),
                    CustomTextFormFieldWidget(
                      readOnly: true,
                      textEditingController: _dniController,
                      title: 'Cédula'
                    ),
                    SizedBox(height: 16),
                    CustomTextFormFieldWidget(
                      readOnly: true,
                      textEditingController: _emailController,
                      title: 'Correo'
                    ),
                    SizedBox(height: 16),
                    CustomTextFormFieldWidget(
                      textEditingController: _phoneController,
                      title: 'Teléfono',
                    ),
                    SizedBox(height: 16),
                    CustomTextFormFieldWidget(
                        readOnly: true,
                        textEditingController: _birthdateController,
                        title: texts.birthdate,
                        suffixIcon: Icon(Icons.date_range, color: Colors.grey)),
                    SizedBox(height: 32),
                    SizedBox(
                        width: screenWidht * 0.35,
                        child: FilledButton(
                            style: ButtonStyle(
                                textStyle: WidgetStateProperty.all(
                                    TextStyle(fontWeight: FontWeight.bold)),
                                backgroundColor:
                                    WidgetStateProperty.all(Color(0xFFF44565))),
                            onPressed: () {},
                            child: Text('Guardar')))
                  ]))))
              : const SizedBox.shrink();
        }));
  }
}
