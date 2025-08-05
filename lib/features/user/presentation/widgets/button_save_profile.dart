import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/utils/error_messages_util.dart';
import 'package:antonella/features/user/presentation/bloc/profile_user/profile_user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ButtonSaveProfile extends StatelessWidget {
  final void Function()? onPressed;

  const ButtonSaveProfile(
      {super.key,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;

    return BlocConsumer<ProfileUserBloc, ProfileUserState>(
        listener: (context, state) {
      if (state is ProfileUserLoaded) {
        showTopSnackBar(
            Overlay.of(context),
            const CustomSnackBar.success(
                message: 'Usuario actualizado correctamente'));
        Navigator.pop(context);
      } else if (state is ProfileUserError) {
        showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(
                message: mapFailureToMessage(
                    context: context, failure: state.failure)));
      }
    }, builder: (context, state) {
      final screenWidht = MediaQuery.of(context).size.width;

      return (state is ProfileUserLoading)
          ? const CircularProgressIndicator()
          : SizedBox(
              width: screenWidht * 0.35,
              child: FilledButton(
                  style: ButtonStyle(
                      textStyle: WidgetStateProperty.all(
                          TextStyle(fontWeight: FontWeight.bold)),
                      backgroundColor:
                          WidgetStateProperty.all(Color(0xFFF44565))),
                  onPressed: onPressed,
                  child: Text(texts.save)));
    });
  }
}
