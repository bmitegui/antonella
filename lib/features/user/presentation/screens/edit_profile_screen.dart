import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/arrow_back.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/core/widgets/custom_text_form_field_widget.dart';
import 'package:antonella/features/user/presentation/bloc/profile_user/profile_user_bloc.dart';
import 'package:antonella/features/user/presentation/bloc/user/user_bloc.dart';
import 'package:antonella/features/user/presentation/widgets/button_save_profile.dart';
import 'package:antonella/features/user/presentation/widgets/user_photo_widget.dart';
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
  void initState() {
    super.initState();

    final state = sl<UserBloc>().state;
    if (state is UserAuthenticated) {
      _nameController = TextEditingController(text: state.user.name);
      _emailController = TextEditingController(text: state.user.email);
      _phoneController = TextEditingController(text: state.user.phoneNumber);
      _birthdateController =
          TextEditingController(text: formatDateTime(state.user.birthdate));
      _dniController = TextEditingController(text: state.user.dni);
    }
  }

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    return CustomScaffold(
      text: texts.edit_profile,
      leading: ArrowBack(),
        body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
          return (state is UserAuthenticated)
              ? Padding(
                  padding: EdgeInsets.only(right: 16, left: 16, bottom: 32),
                  child: SingleChildScrollView(
                      child: Center(
                          child: Column(children: [
                    Text(texts.edit_account_information,
                        style: bodyBlack54Style(context)),
                    SizedBox(height: 32),
                    UserPhotoWidget(canEdit: true),
                    SizedBox(height: 32),
                    CustomTextFormFieldWidget(
                        textEditingController: _nameController,
                        title: texts.name),
                    SizedBox(height: 16),
                    CustomTextFormFieldWidget(
                        readOnly: true,
                        textEditingController: _dniController,
                        title: texts.id),
                    SizedBox(height: 16),
                    CustomTextFormFieldWidget(
                        readOnly: true,
                        textEditingController: _emailController,
                        title: texts.email),
                    SizedBox(height: 16),
                    CustomTextFormFieldWidget(
                        textEditingController: _phoneController,
                        title: texts.phone_number),
                    SizedBox(height: 16),
                    CustomTextFormFieldWidget(
                        readOnly: true,
                        textEditingController: _birthdateController,
                        title: texts.birthdate,
                        suffixIcon: Icon(Icons.date_range, color: Colors.grey)),
                    SizedBox(height: 32),
                    ButtonSaveProfile(onPressed: () {
                      context.read<ProfileUserBloc>().add(
                          UpdateUserProfileEvent(
                              userId: state.user.id,
                              base64Photo: null,
                              name: _nameController.text.trim(),
                              phoneNumber: _phoneController.text.trim(),
                              gmail: _emailController.text.trim()));
                    })
                  ]))))
              : const SizedBox.shrink();
        }));
  }
}
